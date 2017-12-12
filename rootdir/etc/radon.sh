#!/sbin/sh
 #
 # Type any shell commands here
 #
 # They will execute on every boot
 #
 # Lines starting with # are just comments
 #
 # Enjoy !
 #
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}
    #Set Low memory killer minfree parameters
    # 64 bit up to 2GB with use 14K, and above 2GB will use 18K
    #
    # Set ALMK parameters (usually above the highest minfree values)
    # 64 bit will have 81K 
    chmod 0660 /sys/module/lowmemorykiller/parameters/minfree

    if [ $MemTotal -gt 2000000 ]; then
        echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
        echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
    else
        echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
        echo "16384,20992,24064,30720,46080,66560" > /sys/module/lowmemorykiller/parameters/minfree
	echo 10 > /proc/sys/vm/dirty_background_ratio
    fi

	Mode=`cat /init.radon.rc | grep zrammode`
	Mo=${Mode:11:1}
	if [ $Mo -eq 1 ] || [ $Mo -eq 3 ]; then
	echo 536870912 > /sys/block/zram0/disksize
	mkswap /dev/block/zram0
	swapon /dev/block/zram0
	fi
#HEADPHONE GAIN
echo "3 3" > sys/kernel/sound_control/headphone_gain


