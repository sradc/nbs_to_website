#!/bin/bash

# Remove the old website files
rm index.html script.js stylesheet.css
rm -rf posts
# Convert the nb to a script
jupyter nbconvert --to script _notebooks/nbs-to-website.ipynb
[ $? -ne 0 ] && echo "Failed to convert notebook to script. Aborting post-commit hook." && exit 1
# Use the script to build the website
ipython _notebooks/nbs-to-website.py
[ $? -ne 0 ] && echo "Failed to build site. Aborting post-commit hook." && exit 1
# Delete the script
rm _notebooks/nbs-to-website.py
