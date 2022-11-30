#  _      _______          _______    ___  ___     _____ _      _____  
# | |    |_   _\ \        / / ____|  |__ \|__ \   / ____| |    |_   _| 
# | |      | |  \ \  /\  / | |   ______ ) |  ) | | |    | |      | |   
# | |      | |   \ \/  \/ /| |  |______/ /  / /  | |    | |      | |   
# | |____ _| |_   \  /\  / | |____    / /_ / /_  | |____| |____ _| |_  
# |______|_____|   \/  \/   \_____|  |____|____|  \_____|______|_____| 
#  ______                           _                                  
# |  ____|                         | |                                 
# | |__  __  ____ _ _ __ ___  _ __ | | ___ ___                         
# |  __| \ \/ / _` | '_ ` _ \| '_ \| |/ _ / __|                        
# | |____ >  | (_| | | | | | | |_) | |  __\__ \                        
# |______/_/\_\__,_|_| |_| |_| .__/|_|\___|___/                        
#                            | |                                       
#                            |_|                                       
#
#
# Adapted from work by the incomprable Ryan L. Boyd
#   
#
#
#
#
#    This is an example script that demonstrates how to make a call to the LIWC-22 command line interface (CLI)
#    from R. Briefly described, what we want to do is launch the CLI application as a separate process, then
#    pick back up from there.
#
#    This is a very crude example script, so please feel free to improve/innovate on this code :)
#
#
#    Make sure that you have the LIWC-22.exe GUI running - it is required for the CLI to function correctly :)
#    Make sure that you have the LIWC-22.exe GUI running - it is required for the CLI to function correctly :)
#    Make sure that you have the LIWC-22.exe GUI running - it is required for the CLI to function correctly :)
#    Make sure that you have the LIWC-22.exe GUI running - it is required for the CLI to function correctly :)
# Also want to reiterate that I just adapted this from Ryan to work for Mac's and don't take credit for this in any way shape or form :) 


# This specifies what type of cmd we're calling. For the shell() function, we can
# use cmd, cmd2, csh, and sh - the one that you choose will vary based on your OS.
shellType <- "cmd" #cmd will work for mac



#  ______    _     _                      _ _   _       _________   _________   ______ _ _
# |  ____|  | |   | |                    (_| | | |     |__   __\ \ / |__   __| |  ____(_| |
# | |__ ___ | | __| | ___ _ __  __      ___| |_| |__      | |   \ V /   | |    | |__   _| | ___ ___
# |  __/ _ \| |/ _` |/ _ | '__| \ \ /\ / | | __| '_ \     | |    > <    | |    |  __| | | |/ _ / __|
# | | | (_) | | (_| |  __| |     \ V  V /| | |_| | | |    | |   / . \   | |    | |    | | |  __\__ \
# |_|  \___/|_|\__,_|\___|_|      \_/\_/ |_|\__|_| |_|    |_|  /_/ \_\  |_|    |_|    |_|_|\___|___/




#you can get these paths a numnber of ways. the idiot-proof method is to drag and drop them into your terminal, which will generate the path for you 
inputFolderTXT <- "/Users/stevenmesquiti/Desktop/Yoona\'s\ Files/transcription" #specify the path to the file(s)
outputLocation <- "/Users/stevenmesquiti/Desktop/Yoona\'s\ Files/LIWC\ CLI - Analyzed.csv" #Specify where you want to drop the output and what it should be named


# This command will read texts from a folder, analyze them using the standard "Word Count" LIWC analysis,
# then save our output to a specified location. It is important that we use shQuote() to make sure that
# we are not accidentally passing 
cmd_to_execute <- paste("LIWC-22-cli",
                        "--mode", "wc",
                        "--input", shQuote(inputFolderTXT, type=shellType),
                        "--output", shQuote(outputLocation, type=shellType),
                        sep = ' ')


# Let's go ahead and run this analysis: NOTE this is for a mac. Please refer to ryan's original script for running this on a PC

system(command = cmd_to_execute, #specify the command that we want to run
      intern=FALSE,       #specify that we do *not* want the output to be returned as an R object
      wait=TRUE)         #specify that we do, in fact, want to wait for the shell command to finish running before we continue      #we want to halt execution of this R script if something about our call to the shell fails




# Now, we can take that output file and read it in to R to do with as we wish:
liwc.data <- read.csv(outputLocation, fileEncoding = 'UTF-8')

df <- as.data.frame(liwc.data)#can save it as a data frame in R too
#note that it'll keep the name of our files WITH the path name



# A thing of beauty, to be sure. What if we want to process our texts using an older LIWC dictionary,
# or an external dictionary file? This can be done easily as well.


# We can specify whether we want to use the LIWC2001, LIWC2007, LIWC2015,
# or LIWC22 dictionary with the --dictionary argument. these are located here: https://www.liwc.app/dictionaries
 liwcDict <- "LIWC2015" #to change to the old LIWC

# Alternatively, you can specify the absolute path to an external dictionary
# file that you would like to use, and LIWC will load this dictionary for processing.
#liwcDict <- "C:/Users/stevenmesquiti/Dictionaries/Personal Values Dictionary.dicx"


###

# Let's update our output location as well so that we don't overwrite our previous file.
outputLocation = "C:/Users/Ryan/Datasets/TED Talk TXT Files - Analyzed (LIWC2015).csv"

cmd_to_execute <- paste("LIWC-22-cli",
                        "--mode", "wc",
                        "--dictionary", shQuote(liwcDict, type=shellType),
                        "--input", shQuote(inputFolderTXT, type=shellType),
                        "--output", shQuote(outputLocation, type=shellType),
                        sep = ' ')


# Let's go ahead and run this analysis:
system(command = cmd_to_execute, #specify the command that we want to run
       intern=FALSE,       #specify that we do *not* want the output to be returned as an R object
       wait=TRUE)   








#   _____  _______      __  ______ _ _
#  / ____|/ ____\ \    / / |  ____(_| |
# | |    | (___  \ \  / /  | |__   _| | ___
# | |     \___ \  \ \/ /   |  __| | | |/ _ \
# | |____ ____) |  \  /    | |    | | |  __/
#  \_____|_____/    \/     |_|    |_|_|\___|



# Beautiful. Now, let's do the same thing, but analyzing a CSV file full of the some other texts.
inputFileCSV <- '/Users/stevenmesquiti/Desktop/CEO\ Project/Masterdatasets/Merged_data.csv' 

outputLocation <- '/Users/stevenmesquiti/Desktop/CEO\ Project/Masterdatasets/CLI_analyzed.csv'


# We're going to use a variation on the command above. Since this is a CSV file, we want to include the indices of
#     1) the columns that include the text identifiers (although this is not required, it makes our data easier to merge later)
#     2) the columns that include the actual text that we want to analyze
#
# In my CSV file, the first column has the text identifiers, and the second column contains the text.
# For more complex datasets, please use the --help argument with LIWC-22 to learn more about how to process your text.


cmd_to_execute <- paste("LIWC-22-cli",
                        "--mode", "wc",
                        "--row-id-indices", "1",
                        "--column-indices", "6", #you'll need to know how your data is formatted. That is, know the column your text is in
                        "--input", shQuote(inputFileCSV, type=shellType),
                        "--output", shQuote(outputLocation, type=shellType),
                        sep = ' ')


# Let's go ahead and run this analysis:
system(command = cmd_to_execute, #specify the command that we want to run
       intern=FALSE,       #specify that we do *not* want the output to be returned as an R object
       wait=TRUE)  

liwc.data <- read.csv(outputLocation, fileEncoding = 'UTF-8') #saving our output 

# We will see the following in the terminal as LIWC does its magic:
#   Processing:
#- [file] /Users/stevenmesquiti/Desktop/CEO Project/Masterdatasets/Merged_data.csv

#[========================================] 100.00%; Number of Rows Analyzed: 11.0K; Total Words Analyzed: 2.49M

#Done. Please examine results in /Users/stevenmesquiti/Desktop/CEO Project/Masterdatasets/CLI_analyzed.csv















