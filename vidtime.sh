#!/bin/bash
#
# Description: Loops through all .mp4 files in a folder to find total length of time

function show_time () {
    num=$1
    min=0
    hour=0
    day=0
    if((num>59));then
        ((sec=num%60))
        ((num=num/60))
        if((num>59));then
            ((min=num%60))
            ((num=num/60))
            if((num>23));then
                ((hour=num%24))
                ((day=num/24))
            else
                ((hour=num))
            fi
        else
            ((min=num))
        fi
    else
        ((sec=num))
    fi
    echo "Total recorded video time is: $day"d "$hour"h "$min"m "$sec"s
}

# Requires FFmpeg installed
# Go through videos with .mp4 extension and add up the number of total seconds
VIDSECS=`find . -maxdepth 1 -iname '*.mp4' -exec ffprobe -v quiet -of csv=p=0 -show_entries format=duration {} \; | paste -sd+ -| bc`

# Shave off decimal point
VIDSECS=${VIDSECS%.*}

# Convert seconds into Days, Hours, Minutes, Seconds
show_time "$VIDSECS"