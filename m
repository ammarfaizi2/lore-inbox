Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130695AbQLGCEe>; Wed, 6 Dec 2000 21:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130690AbQLGCEY>; Wed, 6 Dec 2000 21:04:24 -0500
Received: from [64.16.10.150] ([64.16.10.150]:31236 "EHLO cougar.intrinsyc.com")
	by vger.kernel.org with ESMTP id <S130663AbQLGCEK>;
	Wed, 6 Dec 2000 21:04:10 -0500
Message-ID: <3A2F91F4.9000000@intrinsyc.com>
Date: Thu, 07 Dec 2000 05:34:44 -0800
From: Daniel Chemko <dchemko@intrinsyc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.14-5.0 i686; en-US; m18) Gecko/20001010
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multicast problems on 2.4.0?
Content-Type: multipart/mixed;
 boundary="------------030401010607080400060908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401010607080400060908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I am doing development work on the 2.4.0 kernel, and can not seem to get 
multicasting to work.

I have included two test files which I attempted to run, one as a 
sender, and another as the receiver.  The
code worked as expected on a stock redhat 6.2 - linux 2.2.14-5.0 kernel. 
I have found from tcpdump that the
IGMP packets that are supposed to be sent when (un)subscribing to a 
group are not being sent. I am using an
ARM build for the application, but I don't believe that the problem 
resides in ARM specific code, since I also
tested this feature on a 2.4.0test11 - i386 as well.

Also included is the ethernet driver modified by us for the 2.4 kernel. 
I have not seen anything that would
affect this problem, but it is included just in case.

Any help would be much appreciated.

BTW: I may be doing something really stupid, please be gentle ;-)

Kernel Build Information:
Linux 2.4.0 test 6 w/patches(ARMlinux - rmk1 -np2)


Thanks,
Daniel Chemko


#
# Automatically generated make config: don't edit
#
CONFIG_ARM=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_OBSOLETE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# System Type
#
# CONFIG_ARCH_ARCA5K is not set
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_RPC is not set
CONFIG_ARCH_SA1100=y

#
# SA11x0 Implementations
#
# CONFIG_SA1100_ASSABET is not set
# CONFIG_SA1100_BRUTUS is not set
CONFIG_SA1100_CERF=y
CONFIG_SA1100_CERF_32MB=y
# CONFIG_SA1100_BITSY is not set
# CONFIG_SA1100_LART is not set
# CONFIG_SA1100_THINCLIENT is not set
# CONFIG_SA1100_GRAPHICSCLIENT is not set
# CONFIG_SA1100_NANOENGINE is not set
# CONFIG_SA1100_VICTOR is not set
# CONFIG_SA1100_XP860 is not set
# CONFIG_ANGELBOOT is not set
# CONFIG_SA1100_FREQUENCY_SCALE is not set
# CONFIG_SA1100_VOLTAGE_SCALE is not set
# CONFIG_ARCH_ACORN is not set
# CONFIG_FOOTBRIDGE is not set
# CONFIG_FOOTBRIDGE_HOST is not set
# CONFIG_FOOTBRIDGE_ADDIN is not set
CONFIG_CPU_32=y
# CONFIG_CPU_26 is not set
CONFIG_CPU_32v4=y
CONFIG_CPU_SA1100=y
CONFIG_DISCONTIGMEM=y
# CONFIG_PCI is not set
# CONFIG_ISA is not set
# CONFIG_ISA_DMA is not set
CONFIG_PC_KEYMAP=y

#
# General setup
#
# CONFIG_SA1100_CERF_CMDLINE is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_SA1100_PCMCIA=y
CONFIG_VIRTUAL_BUS=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_NWFPE=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ARTHUR is not set
CONFIG_CMDLINE="console=ttyS0,38400"
CONFIG_LEDS=y
CONFIG_LEDS_TIMER=y
CONFIG_LEDS_CPU=y
CONFIG_ALIGNMENT_TRAP=y

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_FLASH=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_CERF_CS8900A=y
# CONFIG_ARM_AM79C961A is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_YELLOWFIN is not set
# CONFIG_ACENIC is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECS=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Character devices
#
CONFIG_VT=y
# CONFIG_VT_CONSOLE is not set
CONFIG_SERIAL_SA1100=y
CONFIG_SERIAL_SA1100_CONSOLE=y
CONFIG_TOUCHSCREEN_UCB1200=y
# CONFIG_TOUCHSCREEN_BITSY is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_PCMCIA_SERIAL is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Console drivers
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_FB=y
CONFIG_CERF_LCD_38_A=y
# CONFIG_CERF_LCD_57_A is not set
# CONFIG_CERF_LCD_72_A is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_SA1100=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_ERRORS=y
CONFIG_DEBUG_USER=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_LL is not setHello,
I am doing development work on the 2.4.0 kernel, and can not seem to get 
multicasting to work.

I have included two test files which I attempted to run, one as a 
sender, and another as the receiver.  The
code worked as expected on a stock redhat 6.2 - linux 2.2.14-5.0 kernel. 
I have found from tcpdump that the
IGMP packets that are supposed to be sent when (un)subscribing to a 
group are not being sent. I am using an
ARM build for the application, but I don't believe that the problem 
resides in ARM specific code, since I also
tested this feature on a 2.4.0test11 - i386 as well.

Also included is the ethernet driver modified by us for the 2.4 kernel. 
I have not seen anything that would
affect this problem, but it is included just in case.

Any help would be much appreciated.

BTW: I may be doing something really stupid, please be gentle ;-)

Kernel Build Information:
Linux 2.4.0 test 6 w/patches(ARMlinux - rmk1 -np2)


Thanks,
Daniel Chemko


#
# Automatically generated make config: don't edit
#
CONFIG_ARM=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_OBSOLETE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# System Type
#
# CONFIG_ARCH_ARCA5K is not set
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_RPC is not set
CONFIG_ARCH_SA1100=y

#
# SA11x0 Implementations
#
# CONFIG_SA1100_ASSABET is not set
# CONFIG_SA1100_BRUTUS is not set
CONFIG_SA1100_CERF=y
CONFIG_SA1100_CERF_32MB=y
# CONFIG_SA1100_BITSY is not set
# CONFIG_SA1100_LART is not set
# CONFIG_SA1100_THINCLIENT is not set
# CONFIG_SA1100_GRAPHICSCLIENT is not set
# CONFIG_SA1100_NANOENGINE is not set
# CONFIG_SA1100_VICTOR is not set
# CONFIG_SA1100_XP860 is not set
# CONFIG_ANGELBOOT is not set
# CONFIG_SA1100_FREQUENCY_SCALE is not set
# CONFIG_SA1100_VOLTAGE_SCALE is not set
# CONFIG_ARCH_ACORN is not set
# CONFIG_FOOTBRIDGE is not set
# CONFIG_FOOTBRIDGE_HOST is not set
# CONFIG_FOOTBRIDGE_ADDIN is not set
CONFIG_CPU_32=y
# CONFIG_CPU_26 is not set
CONFIG_CPU_32v4=y
CONFIG_CPU_SA1100=y
CONFIG_DISCONTIGMEM=y
# CONFIG_PCI is not set
# CONFIG_ISA is not set
# CONFIG_ISA_DMA is not set
CONFIG_PC_KEYMAP=y

#
# General setup
#
# CONFIG_SA1100_CERF_CMDLINE is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_SA1100_PCMCIA=y
CONFIG_VIRTUAL_BUS=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_NWFPE=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ARTHUR is not set
CONFIG_CMDLINE="console=ttyS0,38400"
CONFIG_LEDS=y
CONFIG_LEDS_TIMER=y
CONFIG_LEDS_CPU=y
CONFIG_ALIGNMENT_TRAP=y

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_FLASH=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_CERF_CS8900A=y
# CONFIG_ARM_AM79C961A is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_YELLOWFIN is not set
# CONFIG_ACENIC is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECS=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Character devices
#
CONFIG_VT=y
# CONFIG_VT_CONSOLE is not set
CONFIG_SERIAL_SA1100=y
CONFIG_SERIAL_SA1100_CONSOLE=y
CONFIG_TOUCHSCREEN_UCB1200=y
# CONFIG_TOUCHSCREEN_BITSY is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_PCMCIA_SERIAL is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Console drivers
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_FB=y
CONFIG_CERF_LCD_38_A=y
# CONFIG_CERF_LCD_57_A is not set
# CONFIG_CERF_LCD_72_A is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_SA1100=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_ERRORS=y
CONFIG_DEBUG_USER=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_LL is not setHello,
I am doing development work on the 2.4.0 kernel, and can not seem to get 
multicasting to work.

I have included two test files which I attempted to run, one as a 
sender, and another as the receiver.  The
code worked as expected on a stock redhat 6.2 - linux 2.2.14-5.0 kernel. 
I have found from tcpdump that the
IGMP packets that are supposed to be sent when (un)subscribing to a 
group are not being sent. I am using an
ARM build for the application, but I don't believe that the problem 
resides in ARM specific code, since I also
tested this feature on a 2.4.0test11 - i386 as well.

Also included is the ethernet driver modified by us for the 2.4 kernel. 
I have not seen anything that would
affect this problem, but it is included just in case.

Any help would be much appreciated.

BTW: I may be doing something really stupid, please be gentle ;-)

Kernel Build Information:
Linux 2.4.0 test 6 w/patches(ARMlinux - rmk1 -np2)


Thanks,
Daniel Chemko


#
# Automatically generated make config: don't edit
#
CONFIG_ARM=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_OBSOLETE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# System Type
#
# CONFIG_ARCH_ARCA5K is not set
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_RPC is not set
CONFIG_ARCH_SA1100=y

#
# SA11x0 Implementations
#
# CONFIG_SA1100_ASSABET is not set
# CONFIG_SA1100_BRUTUS is not set
CONFIG_SA1100_CERF=y
CONFIG_SA1100_CERF_32MB=y
# CONFIG_SA1100_BITSY is not set
# CONFIG_SA1100_LART is not set
# CONFIG_SA1100_THINCLIENT is not set
# CONFIG_SA1100_GRAPHICSCLIENT is not set
# CONFIG_SA1100_NANOENGINE is not set
# CONFIG_SA1100_VICTOR is not set
# CONFIG_SA1100_XP860 is not set
# CONFIG_ANGELBOOT is not set
# CONFIG_SA1100_FREQUENCY_SCALE is not set
# CONFIG_SA1100_VOLTAGE_SCALE is not set
# CONFIG_ARCH_ACORN is not set
# CONFIG_FOOTBRIDGE is not set
# CONFIG_FOOTBRIDGE_HOST is not set
# CONFIG_FOOTBRIDGE_ADDIN is not set
CONFIG_CPU_32=y
# CONFIG_CPU_26 is not set
CONFIG_CPU_32v4=y
CONFIG_CPU_SA1100=y
CONFIG_DISCONTIGMEM=y
# CONFIG_PCI is not set
# CONFIG_ISA is not set
# CONFIG_ISA_DMA is not set
CONFIG_PC_KEYMAP=y

#
# General setup
#
# CONFIG_SA1100_CERF_CMDLINE is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_SA1100_PCMCIA=y
CONFIG_VIRTUAL_BUS=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_NWFPE=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ARTHUR is not set
CONFIG_CMDLINE="console=ttyS0,38400"
CONFIG_LEDS=y
CONFIG_LEDS_TIMER=y
CONFIG_LEDS_CPU=y
CONFIG_ALIGNMENT_TRAP=y

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_FLASH=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_CERF_CS8900A=y
# CONFIG_ARM_AM79C961A is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_YELLOWFIN is not set
# CONFIG_ACENIC is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECS=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Character devices
#
CONFIG_VT=y
# CONFIG_VT_CONSOLE is not set
CONFIG_SERIAL_SA1100=y
CONFIG_SERIAL_SA1100_CONSOLE=y
CONFIG_TOUCHSCREEN_UCB1200=y
# CONFIG_TOUCHSCREEN_BITSY is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_PCMCIA_SERIAL is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Console drivers
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_FB=y
CONFIG_CERF_LCD_38_A=y
# CONFIG_CERF_LCD_57_A is not set
# CONFIG_CERF_LCD_72_A is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_SA1100=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_ERRORS=y
CONFIG_DEBUG_USER=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_LL is not setHello,
I am doing development work on the 2.4.0 kernel, and can not seem to get 
multicasting to work.

I have included two test files which I attempted to run, one as a 
sender, and another as the receiver.  The
code worked as expected on a stock redhat 6.2 - linux 2.2.14-5.0 kernel. 
I have found from tcpdump that the
IGMP packets that are supposed to be sent when (un)subscribing to a 
group are not being sent. I am using an
ARM build for the application, but I don't believe that the problem 
resides in ARM specific code, since I also
tested this feature on a 2.4.0test11 - i386 as well.

Also included is the ethernet driver modified by us for the 2.4 kernel. 
I have not seen anything that would
affect this problem, but it is included just in case.

Any help would be much appreciated.

BTW: I may be doing something really stupid, please be gentle ;-)

Kernel Build Information:
Linux 2.4.0 test 6 w/patches(ARMlinux - rmk1 -np2)


Thanks,
Daniel Chemko


#
# Automatically generated make config: don't edit
#
CONFIG_ARM=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_OBSOLETE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# System Type
#
# CONFIG_ARCH_ARCA5K is not set
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_RPC is not set
CONFIG_ARCH_SA1100=y

#
# SA11x0 Implementations
#
# CONFIG_SA1100_ASSABET is not set
# CONFIG_SA1100_BRUTUS is not set
CONFIG_SA1100_CERF=y
CONFIG_SA1100_CERF_32MB=y
# CONFIG_SA1100_BITSY is not set
# CONFIG_SA1100_LART is not set
# CONFIG_SA1100_THINCLIENT is not set
# CONFIG_SA1100_GRAPHICSCLIENT is not set
# CONFIG_SA1100_NANOENGINE is not set
# CONFIG_SA1100_VICTOR is not set
# CONFIG_SA1100_XP860 is not set
# CONFIG_ANGELBOOT is not set
# CONFIG_SA1100_FREQUENCY_SCALE is not set
# CONFIG_SA1100_VOLTAGE_SCALE is not set
# CONFIG_ARCH_ACORN is not set
# CONFIG_FOOTBRIDGE is not set
# CONFIG_FOOTBRIDGE_HOST is not set
# CONFIG_FOOTBRIDGE_ADDIN is not set
CONFIG_CPU_32=y
# CONFIG_CPU_26 is not set
CONFIG_CPU_32v4=y
CONFIG_CPU_SA1100=y
CONFIG_DISCONTIGMEM=y
# CONFIG_PCI is not set
# CONFIG_ISA is not set
# CONFIG_ISA_DMA is not set
CONFIG_PC_KEYMAP=y

#
# General setup
#
# CONFIG_SA1100_CERF_CMDLINE is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_SA1100_PCMCIA=y
CONFIG_VIRTUAL_BUS=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_NWFPE=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ARTHUR is not set
CONFIG_CMDLINE="console=ttyS0,38400"
CONFIG_LEDS=y
CONFIG_LEDS_TIMER=y
CONFIG_LEDS_CPU=y
CONFIG_ALIGNMENT_TRAP=y

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_FLASH=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_CERF_CS8900A=y
# CONFIG_ARM_AM79C961A is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_YELLOWFIN is not set
# CONFIG_ACENIC is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECS=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Character devices
#
CONFIG_VT=y
# CONFIG_VT_CONSOLE is not set
CONFIG_SERIAL_SA1100=y
CONFIG_SERIAL_SA1100_CONSOLE=y
CONFIG_TOUCHSCREEN_UCB1200=y
# CONFIG_TOUCHSCREEN_BITSY is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_PCMCIA_SERIAL is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Console drivers
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_FB=y
CONFIG_CERF_LCD_38_A=y
# CONFIG_CERF_LCD_57_A is not set
# CONFIG_CERF_LCD_72_A is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_SA1100=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_ERRORS=y
CONFIG_DEBUG_USER=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_LL is not setHello,
I am doing development work on the 2.4.0 kernel, and can not seem to get 
multicasting to work.

I have included two test files which I attempted to run, one as a 
sender, and another as the receiver.  The
code worked as expected on a stock redhat 6.2 - linux 2.2.14-5.0 kernel. 
I have found from tcpdump that the
IGMP packets that are supposed to be sent when (un)subscribing to a 
group are not being sent. I am using an
ARM build for the application, but I don't believe that the problem 
resides in ARM specific code, since I also
tested this feature on a 2.4.0test11 - i386 as well.

Also included is the ethernet driver modified by us for the 2.4 kernel. 
I have not seen anything that would
affect this problem, but it is included just in case.

Any help would be much appreciated.

BTW: I may be doing something really stupid, please be gentle ;-)

Kernel Build Information:
Linux 2.4.0 test 6 w/patches(ARMlinux - rmk1 -np2)


Thanks,
Daniel Chemko


#
# Automatically generated make config: don't edit
#
CONFIG_ARM=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_OBSOLETE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# System Type
#
# CONFIG_ARCH_ARCA5K is not set
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_RPC is not set
CONFIG_ARCH_SA1100=y

#
# SA11x0 Implementations
#
# CONFIG_SA1100_ASSABET is not set
# CONFIG_SA1100_BRUTUS is not set
CONFIG_SA1100_CERF=y
CONFIG_SA1100_CERF_32MB=y
# CONFIG_SA1100_BITSY is not set
# CONFIG_SA1100_LART is not set
# CONFIG_SA1100_THINCLIENT is not set
# CONFIG_SA1100_GRAPHICSCLIENT is not set
# CONFIG_SA1100_NANOENGINE is not set
# CONFIG_SA1100_VICTOR is not set
# CONFIG_SA1100_XP860 is not set
# CONFIG_ANGELBOOT is not set
# CONFIG_SA1100_FREQUENCY_SCALE is not set
# CONFIG_SA1100_VOLTAGE_SCALE is not set
# CONFIG_ARCH_ACORN is not set
# CONFIG_FOOTBRIDGE is not set
# CONFIG_FOOTBRIDGE_HOST is not set
# CONFIG_FOOTBRIDGE_ADDIN is not set
CONFIG_CPU_32=y
# CONFIG_CPU_26 is not set
CONFIG_CPU_32v4=y
CONFIG_CPU_SA1100=y
CONFIG_DISCONTIGMEM=y
# CONFIG_PCI is not set
# CONFIG_ISA is not set
# CONFIG_ISA_DMA is not set
CONFIG_PC_KEYMAP=y

#
# General setup
#
# CONFIG_SA1100_CERF_CMDLINE is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_SA1100_PCMCIA=y
CONFIG_VIRTUAL_BUS=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_NWFPE=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ARTHUR is not set
CONFIG_CMDLINE="console=ttyS0,38400"
CONFIG_LEDS=y
CONFIG_LEDS_TIMER=y
CONFIG_LEDS_CPU=y
CONFIG_ALIGNMENT_TRAP=y

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_FLASH=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_CERF_CS8900A=y
# CONFIG_ARM_AM79C961A is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_YELLOWFIN is not set
# CONFIG_ACENIC is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECS=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Character devices
#
CONFIG_VT=y
# CONFIG_VT_CONSOLE is not set
CONFIG_SERIAL_SA1100=y
CONFIG_SERIAL_SA1100_CONSOLE=y
CONFIG_TOUCHSCREEN_UCB1200=y
# CONFIG_TOUCHSCREEN_BITSY is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_PCMCIA_SERIAL is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Console drivers
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_FB=y
CONFIG_CERF_LCD_38_A=y
# CONFIG_CERF_LCD_57_A is not set
# CONFIG_CERF_LCD_72_A is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_SA1100=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_ERRORS=y
CONFIG_DEBUG_USER=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_LL is not set

--------------030401010607080400060908
Content-Type: text/plain;
 name="getmcast.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="getmcast.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <netinet/in.h> 

#define TEST_PORT 12345
#define BUFSIZE 512
#define USAGE_STMT "Usage: argv[0] <address>\n"

int main(int argc, char* argv[])
{
	int i, s, duh;
	struct sockaddr_in saddr;
	char buf[BUFSIZE];
	struct ip_mreq mreq;

	if (argc != 2)
	{
		printf(USAGE_STMT);
		return -1;
	}

	if((s = socket(PF_INET, SOCK_DGRAM, 0)) == -1)
	{
		printf("argv[0]: cannot get socket descriptor\n");
		return -1;
	}
	
	saddr.sin_family = AF_INET;
	saddr.sin_port = htons(TEST_PORT);
	saddr.sin_addr.s_addr = htonl(INADDR_ANY);
	
	if(bind(s, &saddr, sizeof(struct sockaddr_in)) == -1)
	{
		printf("%s: could not name socket\n", argv[0]);
		return -1;
	}

	if(inet_aton(argv[1], &(mreq.imr_multiaddr)) == 0)
	{
		printf("You have specified an invalid address to join.\n");
		return -1;
	}
	if(inet_aton("192.168.1.7", &(mreq.imr_interface)) == 0)
	{
		printf("You have specified an invalid interface address.\n");
		return -1;
	}
	
	setsockopt(s, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mreq, sizeof(struct ip_mreq));
	memset(&saddr, 0, sizeof(struct sockaddr_in));
	duh = sizeof(struct sockaddr_in);
	
	while (recvfrom(s, buf, BUFSIZE, 0, &saddr, &duh) > 0)
	{
		printf("%s says: %s\n", inet_ntoa(saddr.sin_addr.s_addr), buf);
		memset(&saddr, 0, sizeof(struct sockaddr_in));	
	}
} 

--------------030401010607080400060908
Content-Type: text/plain;
 name="udpsend.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="udpsend.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <netinet/in.h> 

#define TEST_PORT 12345
#define SEND_PORT 12345
#define BUFSIZE 512
#define USAGE_STMT "Usage: argv[0] <address> <message>\n"

int main(int argc, char* argv[])
{
	int i, s, duh;
	struct sockaddr_in saddr;
	char buf[BUFSIZE];

	if (argc != 3) 
	{
		printf(USAGE_STMT);
		return -1;
	}
	
	s = socket(PF_INET, SOCK_DGRAM, 0);
	if (s == -1)
	{
		printf("argv[0]: cannot get socket descriptor\n");
		return -1;
	}
	
	saddr.sin_family = AF_INET;
	saddr.sin_port = htons(SEND_PORT);
	saddr.sin_addr.s_addr = INADDR_ANY; 
	
	/*if (bind(s, &saddr, sizeof(struct sockaddr_in)) == -1)
	{
		printf("argv[0]: could not name socket\n");
		return -1;
	}*/

	saddr.sin_port = htons(TEST_PORT);
	saddr.sin_addr.s_addr = inet_addr(argv[1]);
	strcpy(buf, argv[2]);
	duh = sizeof(struct sockaddr_in);	
	sendto(s, buf, strlen(buf)+1, 0, &saddr, duh);	
} 

--------------030401010607080400060908
Content-Type: application/octet-stream;
 name="cerf89x0.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cerf89x0.c"

LyogY3M4OXgwLmM6IEEgQ3J5c3RhbCBTZW1pY29uZHVjdG9yIChOb3cgQ2lycnVzIExvZ2lj
KSBDUzg5WzAyXTAKICogIGRyaXZlciBmb3IgbGludXguCiAqLwoKLyoKCVdyaXR0ZW4gMTk5
NiBieSBSdXNzZWxsIE5lbHNvbiwgd2l0aCByZWZlcmVuY2UgdG8gc2tlbGV0b24uYwoJd3Jp
dHRlbiAxOTkzLTE5OTQgYnkgRG9uYWxkIEJlY2tlci4KCglUaGlzIHNvZnR3YXJlIG1heSBi
ZSB1c2VkIGFuZCBkaXN0cmlidXRlZCBhY2NvcmRpbmcgdG8gdGhlIHRlcm1zCglvZiB0aGUg
R05VIFB1YmxpYyBMaWNlbnNlLCBpbmNvcnBvcmF0ZWQgaGVyZWluIGJ5IHJlZmVyZW5jZS4K
CiAgICAgICAgVGhlIGF1dGhvciBtYXkgYmUgcmVhY2hlZCBhdCBuZWxzb25AY3J5bndyLmNv
bSwgQ3J5bndyCiAgICAgICAgU29mdHdhcmUsIDUyMSBQbGVhc2FudCBWYWxsZXkgUmQuLCBQ
b3RzZGFtLCBOWSAxMzY3NgoKICBDaGFuZ2Vsb2c6CgogIE1pa2UgQ3J1c2UgICAgICAgIDog
bWNydXNlQGN0aS1sdGQuY29tCiAgICAgICAgICAgICAgICAgICAgOiBDaGFuZ2VzIGZvciBM
aW51eCAyLjAgY29tcGF0aWJpbGl0eS4gCiAgICAgICAgICAgICAgICAgICAgOiBBZGRlZCBk
ZXZfaWQgcGFyYW1ldGVyIGluIG5ldF9pbnRlcnJ1cHQoKSwKICAgICAgICAgICAgICAgICAg
ICA6IHJlcXVlc3RfaXJxKCkgYW5kIGZyZWVfaXJxKCkuIEp1c3QgTlVMTCBmb3Igbm93LgoK
ICBNaWtlIENydXNlICAgICAgICA6IEFkZGVkIE1PRF9JTkNfVVNFX0NPVU5UIGFuZCBNT0Rf
REVDX1VTRV9DT1VOVCBtYWNyb3MKICAgICAgICAgICAgICAgICAgICA6IGluIG5ldF9vcGVu
KCkgYW5kIG5ldF9jbG9zZSgpIHNvIGtlcm5lbGQgd291bGQga25vdwogICAgICAgICAgICAg
ICAgICAgIDogdGhhdCB0aGUgbW9kdWxlIGlzIGluIHVzZSBhbmQgd291bGRuJ3QgZWplY3Qg
dGhlIAogICAgICAgICAgICAgICAgICAgIDogZHJpdmVyIHByZW1hdHVyZWx5LgoKICBNaWtl
IENydXNlICAgICAgICA6IFJld3JvdGUgaW5pdF9tb2R1bGUoKSBhbmQgY2xlYW51cF9tb2R1
bGUgdXNpbmcgODM5MC5jCiAgICAgICAgICAgICAgICAgICAgOiBhcyBhbiBleGFtcGxlLiBE
aXNhYmxlZCBhdXRvcHJvYmluZyBpbiBpbml0X21vZHVsZSgpLAogICAgICAgICAgICAgICAg
ICAgIDogbm90IGEgZ29vZCB0aGluZyB0byBkbyB0byBvdGhlciBkZXZpY2VzIHdoaWxlIExp
bnV4CiAgICAgICAgICAgICAgICAgICAgOiBpcyBydW5uaW5nIGZyb20gYWxsIGFjY291bnRz
LgoKICBSdXNzIE5lbHNvbiAgICAgICA6IEp1bCAxMyAxOTk4LiAgQWRkZWQgUnhPbmx5IERN
QSBzdXBwb3J0LgoKICBNZWxvZHkgTGVlICAgICAgICA6IEF1ZyAxMCAxOTk5LiAgQ2hhbmdl
cyBmb3IgTGludXggMi4yLjUgY29tcGF0aWJpbGl0eS4gCiAgICAgICAgICAgICAgICAgICAg
OiBlbWFpbDogZXRoZXJuZXRAY3J5c3RhbC5jaXJydXMuY29tCgogIEFsYW4gQ294ICAgICAg
ICAgIDogUmVtb3ZlZCAxLjIgc3VwcG9ydCwgYWRkZWQgMi4xIGV4dHJhIGNvdW50ZXJzLgoK
ICBBbmRyZXcgTW9ydG9uICAgICA6IGFuZHJld21AdW93LmVkdS5hdQogICAgICAgICAgICAg
ICAgICAgIDogS2VybmVsIDIuMy40OAogICAgICAgICAgICAgICAgICAgIDogSGFuZGxlIGtt
YWxsb2MoKSBmYWlsdXJlcwogICAgICAgICAgICAgICAgICAgIDogT3RoZXIgcmVzb3VyY2Ug
YWxsb2NhdGlvbiBmaXhlcwogICAgICAgICAgICAgICAgICAgIDogQWRkIFNNUCBsb2Nrcwog
ICAgICAgICAgICAgICAgICAgIDogSW50ZWdyYXRlIFJ1c3MgTmVsc29uJ3MgQUxMT1dfRE1B
IGZ1bmN0aW9uYWxpdHkgYmFjayBpbi4KICAgICAgICAgICAgICAgICAgICA6IElmIEFMTE9X
X0RNQSBpcyB0cnVlLCBtYWtlIERNQSBydW50aW1lIHNlbGVjdGFibGUKICAgICAgICAgICAg
ICAgICAgICA6IEZvbGRlZCBpbiBjaGFuZ2VzIGZyb20gQ2lycnVzIChNZWxvZHkgTGVlCiAg
ICAgICAgICAgICAgICAgICAgOiA8a2xlZUBjcnlzdGFsLmNpcnJ1cy5jb20+KQogICAgICAg
ICAgICAgICAgICAgIDogRG9uJ3QgY2FsbCBuZXRpZl93YWtlX3F1ZXVlKCkgaW4gbmV0X3Nl
bmRfcGFja2V0KCkKICAgICAgICAgICAgICAgICAgICA6IEZpeGVkIGFuIG91dC1vZi1tZW0g
YnVnIGluIGRtYV9yeCgpCiAgICAgICAgICAgICAgICAgICAgOiBVcGRhdGVkIERvY3VtZW50
YXRpb24vY3M4OXgwLnR4dAoqLwoKc3RhdGljIGNoYXIgKnZlcnNpb24gPQoiY2VyZjg5eDAu
YzogKGtlcm5lbCAyLjMuOTkpIFJ1c3NlbGwgTmVsc29uLCBBbmRyZXcgTW9ydG9uXG4iOwoK
LyogPT09PT09PT09PT09PT09PT09PT09PT0gZW5kIG9mIGNvbmZpZ3VyYXRpb24gPT09PT09
PT09PT09PT09PT09PT09PT0gKi8KCgovKiBBbHdheXMgaW5jbHVkZSAnY29uZmlnLmgnIGZp
cnN0IGluIGNhc2UgdGhlIHVzZXIgd2FudHMgdG8gdHVybiBvbgogICBvciBvdmVycmlkZSBz
b21ldGhpbmcuICovCiNpZmRlZiBNT0RVTEUKI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgoj
aW5jbHVkZSA8bGludXgvdmVyc2lvbi5oPgojZWxzZQojZGVmaW5lIE1PRF9JTkNfVVNFX0NP
VU5UCiNkZWZpbmUgTU9EX0RFQ19VU0VfQ09VTlQKI2VuZGlmCgovKgogKiBTZXQgdGhpcyB0
byB6ZXJvIHRvIHJlbW92ZSBhbGwgdGhlIGRlYnVnIHN0YXRlbWVudHMgdmlhCiAqIGRlYWQg
Y29kZSBlbGltaW5hdGlvbgogKi8KI2RlZmluZSBERUJVR0dJTkcJMAoKLyoKICBTb3VyY2Vz
OgoKCUNyeW53ciBwYWNrZXQgZHJpdmVyIGVwa3Rpc2EuCgoJQ3J5c3RhbCBTZW1pY29uZHVj
dG9yIGRhdGEgc2hlZXRzLgoKKi8KCiNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KI2luY2x1
ZGUgPGxpbnV4L3NjaGVkLmg+CiNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgojaW5jbHVkZSA8
bGludXgvZmNudGwuaD4KI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgojaW5jbHVkZSA8
bGludXgvcHRyYWNlLmg+CiNpbmNsdWRlIDxsaW51eC9pb3BvcnQuaD4KI2luY2x1ZGUgPGxp
bnV4L2luLmg+CiNpbmNsdWRlIDxsaW51eC9tYWxsb2MuaD4KI2luY2x1ZGUgPGxpbnV4L3N0
cmluZy5oPgojaW5jbHVkZSA8YXNtL3N5c3RlbS5oPgojaW5jbHVkZSA8YXNtL2JpdG9wcy5o
PgojaW5jbHVkZSA8YXNtL2lvLmg+CiNpbmNsdWRlIDxsaW51eC9lcnJuby5oPgojaW5jbHVk
ZSA8bGludXgvaW5pdC5oPgojaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KCiNpbmNsdWRl
IDxsaW51eC9uZXRkZXZpY2UuaD4KI2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNlLmg+CiNp
bmNsdWRlIDxsaW51eC9za2J1ZmYuaD4KCiNpbmNsdWRlIDxhc20vaXJxLmg+CiNpbmNsdWRl
IDxhc20vaGFyZHdhcmUuaD4KCiNpbmNsdWRlICJjczg5eDAuaCIKCi8qIEZpcnN0LCBhIGZl
dyBkZWZpbml0aW9ucyB0aGF0IHRoZSBicmF2ZSBtaWdodCBjaGFuZ2UuICovCi8qIEEgemVy
by10ZXJtaW5hdGVkIGxpc3Qgb2YgSS9PIGFkZHJlc3NlcyB0byBiZSBwcm9iZWQuICovCnN0
YXRpYyB1bnNpZ25lZCBpbnQgbmV0Y2FyZF9wb3J0bGlzdFtdIF9faW5pdGRhdGEgPQogICB7
IDB4ZDgwMDAzMDAsIDB9OwoKI2lmIERFQlVHR0lORwpzdGF0aWMgdW5zaWduZWQgaW50IG5l
dF9kZWJ1ZyA9IDQ7CiNlbHNlCiNkZWZpbmUgbmV0X2RlYnVnIDAJLyogZ2NjIHdpbGwgcmVt
b3ZlIGFsbCB0aGUgZGVidWcgY29kZSBmb3IgdXMgKi8KI2VuZGlmCgovKiBUaGUgbnVtYmVy
IG9mIGxvdyBJL08gcG9ydHMgdXNlZCBieSB0aGUgZXRoZXJjYXJkLiAqLwojZGVmaW5lIE5F
VENBUkRfSU9fRVhURU5UCTE2CgovKiBJbmZvcm1hdGlvbiB0aGF0IG5lZWQgdG8gYmUga2Vw
dCBmb3IgZWFjaCBib2FyZC4gKi8Kc3RydWN0IG5ldF9sb2NhbCB7CglzdHJ1Y3QgbmV0X2Rl
dmljZV9zdGF0cyBzdGF0czsKCWludCBjaGlwX3R5cGU7CQkvKiBvbmUgb2Y6IENTODkwMCwg
Q1M4OTIwLCBDUzg5MjBNICovCgljaGFyIGNoaXBfcmV2aXNpb247CS8qIHJldmlzaW9uIGxl
dHRlciBvZiB0aGUgY2hpcCAoJ0EnLi4uKSAqLwoJaW50IHNlbmRfY21kOwkJLyogdGhlIHBy
b3BlciBzZW5kIGNvbW1hbmQ6IFRYX05PVywgVFhfQUZURVJfMzgxLCBvciBUWF9BRlRFUl9B
TEwgKi8KCWludCBhdXRvX25lZ19jbmY7CS8qIGF1dG8tbmVnb3RpYXRpb24gd29yZCBmcm9t
IEVFUFJPTSAqLwoJaW50IGFkYXB0ZXJfY25mOwkvKiBhZGFwdGVyIGNvbmZpZ3VyYXRpb24g
ZnJvbSBFRVBST00gKi8KCWludCBpc2FfY29uZmlnOwkJLyogSVNBIGNvbmZpZ3VyYXRpb24g
ZnJvbSBFRVBST00gKi8KCWludCBpcnFfbWFwOwkJLyogSVJRIG1hcCBmcm9tIEVFUFJPTSAq
LwoJaW50IHJ4X21vZGU7CQkvKiB3aGF0IG1vZGUgYXJlIHdlIGluPyAwLCBSWF9NVUxUQ0FT
VF9BQ0NFUFQsIG9yIFJYX0FMTF9BQ0NFUFQgKi8KCWludCBjdXJyX3J4X2NmZzsJLyogYSBj
b3B5IG9mIFBQX1J4Q0ZHICovCglpbnQgbGluZWN0bDsJCS8qIGVpdGhlciAwIG9yIExPV19S
WF9TUVVFTENILCBkZXBlbmRpbmcgb24gY29uZmlndXJhdGlvbi4gKi8KCWludCBzZW5kX3Vu
ZGVycnVuOwkvKiBrZWVwIHRyYWNrIG9mIGhvdyBtYW55IHVuZGVycnVucyBpbiBhIHJvdyB3
ZSBnZXQgKi8KCXNwaW5sb2NrX3QgbG9jazsKfTsKCi8qIEluZGV4IHRvIGZ1bmN0aW9ucywg
YXMgZnVuY3Rpb24gcHJvdG90eXBlcy4gKi8KCmV4dGVybiBpbnQgY2VyZjg5eDBfcHJvYmUo
c3RydWN0IG5ldF9kZXZpY2UgKmRldik7CgpzdGF0aWMgaW50IGNlcmY4OXgwX3Byb2JlMShz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBpbnQgaW9hZGRyKTsKc3RhdGljIGludCBuZXRfb3Bl
bihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTsKc3RhdGljIGludCBuZXRfc2VuZF9wYWNrZXQo
c3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldik7CnN0YXRpYyB2
b2lkIG5ldF9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkLCBzdHJ1Y3QgcHRfcmVn
cyAqcmVncyk7CnN0YXRpYyB2b2lkIHNldF9tdWx0aWNhc3RfbGlzdChzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KTsKc3RhdGljIHZvaWQgbmV0X3RpbWVvdXQoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldik7CnN0YXRpYyB2b2lkIG5ldF9yeChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTsKc3Rh
dGljIGludCBuZXRfY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldik7CnN0YXRpYyBzdHJ1
Y3QgbmV0X2RldmljZV9zdGF0cyAqbmV0X2dldF9zdGF0cyhzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2KTsKc3RhdGljIHZvaWQgcmVzZXRfY2hpcChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTsK
c3RhdGljIGludCBnZXRfZWVwcm9tX2RhdGEoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50
IG9mZiwgaW50IGxlbiwgdTE2ICpidWZmZXIpOwpzdGF0aWMgaW50IHNldF9tYWNfYWRkcmVz
cyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB2b2lkICphZGRyKTsKc3RhdGljIHZvaWQgY291
bnRfcnhfZXJyb3JzKGludCBzdGF0dXMsIHN0cnVjdCBuZXRfbG9jYWwgKmxwKTsKCi8qIEV4
YW1wbGUgcm91dGluZXMgeW91IG11c3Qgd3JpdGUgOy0+LiAqLwojZGVmaW5lIHR4X2RvbmUo
ZGV2KSAxCgojZGVmaW5lIENSWVNUQUxfSVJRCSgxIDw8IDI2KQojZGVmaW5lIENSWVNUQUxf
U0xFRVAJKDEgPDwgMjcpCgoMCi8qIENoZWNrIGZvciBhIG5ldHdvcmsgY2hpcCBvZiB0aGlz
IHR5cGUsIGFuZCByZXR1cm4gJzAnIGlmIG9uZSBleGlzdHMuCiAqIFJldHVybiBFTk9ERVYg
b24gRmFpbHVyZS4KICovCgppbnQgX19pbml0IGNlcmY4OXgwX3Byb2JlKHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpCnsKCXN0YXRpYyBpbnQgaW5pdGlhbGlzZWQgPSAwOwoJaW50IGk7CgoJ
aWYgKGluaXRpYWxpc2VkKQoJCXJldHVybiAtRU5PREVWOwoJaW5pdGlhbGlzZWQgPSAxOwoK
CWlmIChuZXRfZGVidWcpCgkJcHJpbnRrKCJjZXJmODl4MDpjZXJmODl4MF9wcm9iZSgpXG4i
KTsKCQkKCWZvciAoaSA9IDA7IG5ldGNhcmRfcG9ydGxpc3RbaV07IGkrKykgewoJCWludCBp
b2FkZHIgPSBuZXRjYXJkX3BvcnRsaXN0W2ldOwoJCWlmIChjZXJmODl4MF9wcm9iZTEoZGV2
LCBpb2FkZHIpID09IDApCgkJCXJldHVybiAwOwoJfQoJcHJpbnRrKEtFUk5fV0FSTklORyAi
Y2VyZjg5eDA6IG5vIGNzODkwMCBkZXRlY3RlZC5cbiIpOwoJcmV0dXJuIEVOT0RFVjsKfQoK
ZXh0ZXJuIHU4IGlubGluZQpyYXdfcmVhZGIodTMyIGFkZHIpCnsKCXJldHVybiAoKih2b2xh
dGlsZSB1OCAqKShhZGRyKSk7Cn0KCmV4dGVybiB1MTYgaW5saW5lCnJhd19yZWFkdyh1MzIg
YWRkcikKewoJcmV0dXJuICgqKHZvbGF0aWxlIHUxNiAqKShhZGRyKSk7Cn0KCmV4dGVybiB2
b2lkIGlubGluZQpyYXdfd3JpdGViKHU4IHZhbHVlLCB1MzIgYWRkcikKewoJKCoodm9sYXRp
bGUgdTggKikoYWRkcikpID0gdmFsdWU7Cn0KCmV4dGVybiB2b2lkIGlubGluZQpyYXdfd3Jp
dGV3KHUxNiB2YWx1ZSwgdTMyIGFkZHIpCnsKCSgqKHZvbGF0aWxlIHUxNiAqKShhZGRyKSkg
PSB2YWx1ZTsKfQoKZXh0ZXJuIHUxNiBpbmxpbmUKcmVhZHJlZyhzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2LCBpbnQgcG9ydG5vKQp7CglyYXdfd3JpdGV3KHBvcnRubywgZGV2LT5iYXNlX2Fk
ZHIgKyBBRERfUE9SVCk7CglyZXR1cm4gcmF3X3JlYWR3KGRldi0+YmFzZV9hZGRyICsgREFU
QV9QT1JUKTsKfQoKZXh0ZXJuIHZvaWQgaW5saW5lCndyaXRlcmVnKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsIGludCBwb3J0bm8sIHUxNiB2YWx1ZSkKewoJcmF3X3dyaXRldyhwb3J0bm8s
IGRldi0+YmFzZV9hZGRyICsgQUREX1BPUlQpOwoJcmF3X3dyaXRldyh2YWx1ZSwgIGRldi0+
YmFzZV9hZGRyICsgREFUQV9QT1JUKTsKfQoKZXh0ZXJuIHUxNiBpbmxpbmUKcmVhZHdvcmQo
c3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50IHBvcnRubykKewoJcmV0dXJuIHJhd19yZWFk
dyhkZXYtPmJhc2VfYWRkciArIHBvcnRubyk7Cn0KCmV4dGVybiB2b2lkIGlubGluZQp3cml0
ZXdvcmQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50IHBvcnRubywgdTE2IHZhbHVlKQp7
CglyYXdfd3JpdGV3KHZhbHVlLCAgZGV2LT5iYXNlX2FkZHIgKyBwb3J0bm8pOwp9CgpzdGF0
aWMgdm9pZCB3cml0ZWJsb2NrKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGNoYXIgKnBEYXRh
LCBpbnQgTGVuZ3RoKQp7CglpbnQgaTsKCQoJZm9yIChpID0gMCA7IGkgPCAoTGVuZ3RoIC8g
Mik7IGkrKykKCXsgICAKCQl3cml0ZXdvcmQoZGV2LCBUWF9GUkFNRV9QT1JULCAqKHUxNiAq
KXBEYXRhICk7CgkJcERhdGEgKz0gMjsKCX0KICAgCglpZiAoTGVuZ3RoICUgMikgCgl7CgkJ
dTE2IE9kZFdvcmRWYWx1ZSA9ICpwRGF0YTsKCQl3cml0ZXdvcmQoZGV2LCBUWF9GUkFNRV9Q
T1JULCBPZGRXb3JkVmFsdWUpOwoJfQp9CgpzdGF0aWMgdm9pZCByZWFkYmxvY2soc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwgY2hhciAqcERhdGEsIGludCBMZW5ndGgpCnsKCXUxNiB3T2Rk
V29yZDsKCWludCBpOwogICAJCgl1MTYgU3RhcnRPZmZzZXQgPSBQUF9SeEZyYW1lIHwgQVVU
T0lOQ1JFTUVOVDsKCiAgIAl3cml0ZXdvcmQoZGV2LCBBRERfUE9SVCwgU3RhcnRPZmZzZXQp
OwoKCWlmICgodTMyKSBwRGF0YSAlIDIpCgl7CgkJZm9yIChpPTA7IGkgPCAoTGVuZ3RoLzIp
OyBpKyspIAoJCXsKCQkJd09kZFdvcmQgPSByZWFkd29yZChkZXYsIERBVEFfUE9SVCk7CiAg
ICAgICAgICAgICAgIAoJCQkqKHU4KilwRGF0YSsrID0gKHU4KSB3T2RkV29yZCAmIDB4RkY7
CgkJCSoodTgqKXBEYXRhKysgPSAodTgpICh3T2RkV29yZCA+PiA4KSAmIDB4RkY7CgkJfQoJ
fQoJZWxzZQoJewoJCWZvciAoaT0wOyBpIDwgKExlbmd0aC8yKTsgaSsrKSAKCQl7CgkJCSoo
dTE2KikgcERhdGEgPSByZWFkd29yZChkZXYsIERBVEFfUE9SVCk7CgkJCXBEYXRhICs9IDI7
CgkJfQoJfQoKCXN3aXRjaCAoTGVuZ3RoICUgMikgCiAgIAl7CgkJY2FzZSAxOgoJCQkqcERh
dGEgPSAodTgpIChyZWFkd29yZChkZXYsIERBVEFfUE9SVCkgJiAweGZmKTsKCX0KfQoKc3Rh
dGljIGludCBfX2luaXQKd2FpdF9lZXByb21fcmVhZHkoc3RydWN0IG5ldF9kZXZpY2UgKmRl
dikKewoJaW50IHRpbWVvdXQgPSBqaWZmaWVzOwoJLyogY2hlY2sgdG8gc2VlIGlmIHRoZSBF
RVBST00gaXMgcmVhZHksIGEgdGltZW91dCBpcyB1c2VkIC0KCSAgIGp1c3QgaW4gY2FzZSBF
RVBST00gaXMgcmVhZHkgd2hlbiBTSV9CVVNZIGluIHRoZQoJICAgUFBfU2VsZlNUIGlzIGNs
ZWFyICovCgl3aGlsZSAocmVhZHJlZyhkZXYsIFBQX1NlbGZTVCkgJiBTSV9CVVNZKQoJCWlm
IChqaWZmaWVzIC0gdGltZW91dCA+PSA0MCkKCQkJcmV0dXJuIC0xOwoJcmV0dXJuIDA7Cn0K
CnN0YXRpYyBpbnQgX19pbml0CmdldF9lZXByb21fZGF0YShzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LCBpbnQgb2ZmLCBpbnQgbGVuLCB1MTYgKmJ1ZmZlcikKewoJaW50IGk7CgoJaWYgKG5l
dF9kZWJ1ZyA+IDIpCgkJcHJpbnRrKCJFRVBST00gZGF0YSBmcm9tICV4IGZvciAleDpcbiIs
b2ZmLGxlbik7CgoJZm9yIChpID0gMDsgaSA8IGxlbjsgaSsrKSB7CgkJaWYgKHdhaXRfZWVw
cm9tX3JlYWR5KGRldikgPCAwKQoJCQlyZXR1cm4gLTE7CgoJCS8qIE5vdyBzZW5kIHRoZSBF
RVBST00gcmVhZCBjb21tYW5kIGFuZCBsb2NhdGlvbiB0byByZWFkICovCgkJd3JpdGVyZWco
ZGV2LCBQUF9FRUNNRCwgKG9mZiArIGkpIHwgRUVQUk9NX1JFQURfQ01EKTsKCQlpZiAod2Fp
dF9lZXByb21fcmVhZHkoZGV2KSA8IDApCgkJCXJldHVybiAtMTsKCgkJYnVmZmVyW2ldID0g
cmVhZHJlZyhkZXYsIFBQX0VFRGF0YSk7CgkJaWYgKG5ldF9kZWJ1ZyA+IDMpCgkJCXByaW50
aygiJTA0eCAiLCBidWZmZXJbaV0pOwoJfQoJaWYgKG5ldF9kZWJ1ZyA+IDMpIHByaW50aygi
XG4iKTsKICAgICAgICByZXR1cm4gMDsKfQoKc3RhdGljIGludCBfX2luaXQKcmVhZF9lZXBy
b20oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdTE2IG9mZiwgdTE2ICp2YWx1ZSkKewoJaWYg
KHdhaXRfZWVwcm9tX3JlYWR5KGRldikgPCAwKQoJCXJldHVybiAwOwoKCS8qIE5vdyBzZW5k
IHRoZSBFRVBST00gcmVhZCBjb21tYW5kIGFuZCBsb2NhdGlvbiB0byByZWFkICovCgl3cml0
ZXJlZyhkZXYsIFBQX0VFQ01ELCBvZmYgfCBFRVBST01fUkVBRF9DTUQpOwoKCWlmICh3YWl0
X2VlcHJvbV9yZWFkeShkZXYpIDwgMCkKCQlyZXR1cm4gMDsKCQoJLyogR2V0IHRoZSBFRVBS
T00gZGF0YSBmcm9tIHRoZSBFRVBST00gRGF0YSByZWdpc3RlciAqLwoJKnZhbHVlID0gcmVh
ZHJlZyhkZXYsIFBQX0VFRGF0YSk7CiAgICAgICAgcmV0dXJuIDE7Cn0KCi8qIFRoaXMgaXMg
dGhlIHJlYWwgcHJvYmUgcm91dGluZS4gIExpbnV4IGhhcyBhIGhpc3Rvcnkgb2YgZnJpZW5k
bHkgZGV2aWNlCiAgIHByb2JlcyBvbiB0aGUgSVNBIGJ1cy4gIEEgZ29vZCBkZXZpY2UgcHJv
YmVzIGF2b2lkcyBkb2luZyB3cml0ZXMsIGFuZAogICB2ZXJpZmllcyB0aGF0IHRoZSBjb3Jy
ZWN0IGRldmljZSBleGlzdHMgYW5kIGZ1bmN0aW9ucy4KICAgUmV0dXJuIDAgb24gc3VjY2Vz
cy4KICovCgpzdGF0aWMgaW50IF9faW5pdApjZXJmODl4MF9wcm9iZTEoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwgaW50IGlvYWRkcikKewoJc3RydWN0IG5ldF9sb2NhbCAqbHA7CglzdGF0
aWMgdW5zaWduZWQgdmVyc2lvbl9wcmludGVkID0gMDsKCWludCBpOwoJdW5zaWduZWQgcmV2
X3R5cGUgPSAwOwoJdTE2IE1hY0FkZHJbM10gPSB7MCwwLDB9OwoJaW50IHJldHZhbDsKCXVu
c2lnbmVkIHNob3J0IHdEYXRhOwoKCS8qIEluaXRpYWxpemUgdGhlIGRldmljZSBzdHJ1Y3R1
cmUuICovCglpZiAoZGV2LT5wcml2ID09IE5VTEwpCgl7CgkJZGV2LT5wcml2ID0ga21hbGxv
YyhzaXplb2Yoc3RydWN0IG5ldF9sb2NhbCksIEdGUF9LRVJORUwpOwoJCWlmIChkZXYtPnBy
aXYgPT0gMCkKCQl7CgkJCXJldHZhbCA9IEVOT01FTTsKCQkJZ290byBvdXQ7CgkJfQoJCW1l
bXNldChkZXYtPnByaXYsIDAsIHNpemVvZihzdHJ1Y3QgbmV0X2xvY2FsKSk7Cgl9CglscCA9
IChzdHJ1Y3QgbmV0X2xvY2FsICopZGV2LT5wcml2OwoKCXdEYXRhID0gcmF3X3JlYWR3KGlv
YWRkciArIEFERF9QT1JUKTsKCWlmICgod0RhdGEgJiAweEYwMDApICE9IDB4MzAwMCApCgl7
CgkJaWYgKG5ldF9kZWJ1ZykKCQkJcHJpbnRrKCJjZXJmODl4MDpjZXJmODl4MF9wcm9iZTEo
KSAweCUwOFhcbiIsIHdEYXRhKTsKCQkJCgkJcmV0dmFsID0gRU5PREVWOwoJCWdvdG8gb3V0
MTsKCX0KCgkvKiBGaWxsIGluIHRoZSAnZGV2JyBmaWVsZHMuICovCglkZXYtPmJhc2VfYWRk
ciA9IGlvYWRkcjsKCgkvKiBnZXQgdGhlIGNoaXAgdHlwZSAqLwoJcmV2X3R5cGUgPSByZWFk
cmVnKGRldiwgUFJPRFVDVF9JRF9BREQpOwoJbHAtPmNoaXBfdHlwZSA9IHJldl90eXBlICZ+
IFJFVklTT05fQklUUzsKCWxwLT5jaGlwX3JldmlzaW9uID0gKChyZXZfdHlwZSAmIFJFVklT
T05fQklUUykgPj4gOCkgKyAnQSc7CgoJLyogQ2hlY2sgdGhlIGNoaXAgdHlwZSBhbmQgcmV2
aXNpb24gaW4gb3JkZXIgdG8gc2V0IHRoZSBjb3JyZWN0IHNlbmQgY29tbWFuZAoJICAgQ1M4
OTIwIHJldmlzaW9uIEMgYW5kIENTODkwMCByZXZpc2lvbiBGIGNhbiB1c2UgdGhlIGZhc3Rl
ciBzZW5kLgoJKi8KCWxwLT5zZW5kX2NtZCA9IFRYX0FGVEVSXzM4MTsKCWlmIChscC0+Y2hp
cF90eXBlID09IENTODkwMCAmJiBscC0+Y2hpcF9yZXZpc2lvbiA+PSAnRicpCgkJbHAtPnNl
bmRfY21kID0gVFhfTk9XOwoKCWlmIChscC0+Y2hpcF90eXBlICE9IENTODkwMCAmJiBscC0+
Y2hpcF9yZXZpc2lvbiA+PSAnQycpCgkJbHAtPnNlbmRfY21kID0gVFhfTk9XOwoKCXJlc2V0
X2NoaXAoZGV2KTsKCglpZiAobmV0X2RlYnVnICAmJiAgdmVyc2lvbl9wcmludGVkKysgPT0g
MCkKCQlwcmludGsodmVyc2lvbik7CgoJcHJpbnRrKEtFUk5fSU5GTyAiJXM6IGNzODklYzAl
cyByZXYgJWMgQmFzZSAweCUwOFgiLAoJICAgICAgIGRldi0+bmFtZSwKCSAgICAgICBscC0+
Y2hpcF90eXBlPT1DUzg5MDAgPyAnMCcgOiAnMicsCgkgICAgICAgbHAtPmNoaXBfdHlwZT09
Q1M4OTIwTSA/ICJNIiA6ICIiLAoJICAgICAgIGxwLT5jaGlwX3JldmlzaW9uLAoJICAgICAg
IGRldi0+YmFzZV9hZGRyKTsKCgkvKgoJICogUmVhZCBNQUMgYWRkcmVzcyBmcm9tIEVFUFJP
TQoJICovICAgIAoJaWYgKCFyZWFkX2VlcHJvbShkZXYsIDB4MWMsICZNYWNBZGRyWzBdKSkK
CQlwcmludGsoS0VSTl9XQVJOSU5HICJcbmNzODl4MDogRUVQUk9NWzBdIHJlYWQgZmFpbGVk
LlxuIik7CglpZiAoIXJlYWRfZWVwcm9tKGRldiwgMHgxZCwgJk1hY0FkZHJbMV0pKQoJCXBy
aW50ayhLRVJOX1dBUk5JTkcgIlxuY3M4OXgwOiBFRVBST01bMV0gcmVhZCBmYWlsZWQuXG4i
KTsKCWlmICghcmVhZF9lZXByb20oZGV2LCAweDFlLCAmTWFjQWRkclsyXSkpCgkJcHJpbnRr
KEtFUk5fV0FSTklORyAiXG5jczg5eDA6IEVFUFJPTVsyXSByZWFkIGZhaWxlZC5cbiIpOwoJ
CiAgIAoJZm9yIChpID0gMDsgaSA8IEVUSF9BTEVOLzI7IGkrKykKCXsKCQlkZXYtPmRldl9h
ZGRyW2kqMl0gICA9IE1hY0FkZHJbaV07CgkJZGV2LT5kZXZfYWRkcltpKjIrMV0gPSBNYWNB
ZGRyW2ldID4+IDg7Cgl9CgoJZGV2LT5pcnEgPSBJUlFfR1BJTzI2OwoKCXByaW50ayhLRVJO
X0lORk8gIiwgSVJRICVkIiwgZGV2LT5pcnEpOwoKCS8qIHByaW50IHRoZSBldGhlcm5ldCBh
ZGRyZXNzLiAqLwoJcHJpbnRrKCIsIE1BQyAiKTsKCWZvciAoaSA9IDA7IGkgPCBFVEhfQUxF
TjsgaSsrKQoJewoJCXByaW50aygiJXMlMDJYIiwgaSA/ICI6IiA6ICIiLCBkZXYtPmRldl9h
ZGRyW2ldKTsKCX0KCXByaW50aygiXG4iKTsKCglkZXYtPm9wZW4JCT0gbmV0X29wZW47Cglk
ZXYtPnN0b3AJCT0gbmV0X2Nsb3NlOwoJZGV2LT50eF90aW1lb3V0CQk9IG5ldF90aW1lb3V0
OwoJZGV2LT53YXRjaGRvZ190aW1lbwk9IEhaOwoJZGV2LT5oYXJkX3N0YXJ0X3htaXQgCT0g
bmV0X3NlbmRfcGFja2V0OwoJZGV2LT5nZXRfc3RhdHMJCT0gbmV0X2dldF9zdGF0czsKCWRl
di0+c2V0X211bHRpY2FzdF9saXN0ID0gc2V0X211bHRpY2FzdF9saXN0OwoJZGV2LT5zZXRf
bWFjX2FkZHJlc3MgCT0gc2V0X21hY19hZGRyZXNzOwoKCS8qIEZpbGwgaW4gdGhlIGZpZWxk
cyBvZiB0aGUgZGV2aWNlIHN0cnVjdHVyZSB3aXRoIGV0aGVybmV0IHZhbHVlcy4gKi8KCWV0
aGVyX3NldHVwKGRldik7CgoJcmV0dXJuIDA7Cm91dDE6CglrZnJlZShkZXYtPnByaXYpOwoJ
ZGV2LT5wcml2ID0gMDsKb3V0OgoJcmV0dXJuIHJldHZhbDsKfQoKCnZvaWQgIF9faW5pdCBy
ZXNldF9jaGlwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCnsKCWludCByZXNldF9zdGFydF90
aW1lOwoKCXdyaXRlcmVnKGRldiwgUFBfU2VsZkNUTCwgcmVhZHJlZyhkZXYsIFBQX1NlbGZD
VEwpIHwgUE9XRVJfT05fUkVTRVQpOwoKCS8qIHdhaXQgMzAgbXMgKi8KCWN1cnJlbnQtPnN0
YXRlID0gVEFTS19JTlRFUlJVUFRJQkxFOwoJc2NoZWR1bGVfdGltZW91dCgzMCpIWi8xMDAw
KTsKCgkvKiBXYWl0IHVudGlsIHRoZSBjaGlwIGlzIHJlc2V0ICovCglyZXNldF9zdGFydF90
aW1lID0gamlmZmllczsKCXdoaWxlKCAocmVhZHJlZyhkZXYsIFBQX1NlbGZTVCkgJiBJTklU
X0RPTkUpID09IDAgJiYKCQlqaWZmaWVzIC0gcmVzZXRfc3RhcnRfdGltZSA8IDQpCgkJOwp9
CgoMCi8qIE9wZW4vaW5pdGlhbGl6ZSB0aGUgYm9hcmQuICBUaGlzIGlzIGNhbGxlZCAoaW4g
dGhlIGN1cnJlbnQga2VybmVsKQogICBzb21ldGltZSBhZnRlciBib290aW5nIHdoZW4gdGhl
ICdpZmNvbmZpZycgcHJvZ3JhbSBpcyBydW4uCgogICBUaGlzIHJvdXRpbmUgc2hvdWxkIHNl
dCBldmVyeXRoaW5nIHVwIGFuZXcgYXQgZWFjaCBvcGVuLCBldmVuCiAgIHJlZ2lzdGVycyB0
aGF0ICJzaG91bGQiIG9ubHkgbmVlZCB0byBiZSBzZXQgb25jZSBhdCBib290LCBzbyB0aGF0
CiAgIHRoZXJlIGlzIG5vbi1yZWJvb3Qgd2F5IHRvIHJlY292ZXIgaWYgc29tZXRoaW5nIGdv
ZXMgd3JvbmcuCiAgICovCgovKiBBS1BNOiBkbyB3ZSBuZWVkIHRvIGRvIGFueSBsb2NraW5n
IGhlcmU/ICovCgpzdGF0aWMgaW50Cm5ldF9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYp
CnsKCXN0cnVjdCBuZXRfbG9jYWwgKmxwID0gKHN0cnVjdCBuZXRfbG9jYWwgKilkZXYtPnBy
aXY7CglpbnQgaTsKCgkvLyBJbnRlcnJ1cHQgc3R1ZmYKICAgICAgICBHUkVSIHw9IENSWVNU
QUxfSVJROwkvLyBTZXQgUmlzaW5nIGVkZ2UgdHJpZ2VyLgogICAgICAgIEdGRVIgJj0gfkNS
WVNUQUxfSVJROwkvLyBDbGVhciBmYWxsaW5nIGVkZ2UgdHJpZ2VyLgoKCUdQRFIgfD0gQ1JZ
U1RBTF9TTEVFUDsJLy8gU2xlZXAgTW9kZSBQaW4gaXMgYSBPVVRQVVQuCglHUFNSIHw9IENS
WVNUQUxfU0xFRVA7CS8vIFNldCBTbGVlcCBNb2RlIE9GRi4KCgkvKiBQcmV2ZW50IHRoZSBj
cnlzdGFsIGNoaXAgZnJvbSBnZW5lcmF0aW5nIGludGVycnVwdHMgKi8KCXdyaXRlcmVnKGRl
diwgUFBfQnVzQ1RMLCByZWFkcmVnKGRldiwgUFBfQnVzQ1RMKSAmIH5FTkFCTEVfSVJRKTsK
CgkvKiBHcmFiIHRoZSBpbnRlcnJ1cHQgKi8KCWlmIChyZXF1ZXN0X2lycShkZXYtPmlycSwg
Jm5ldF9pbnRlcnJ1cHQsIFNBX1NISVJRLCAiY3M4OXgwIiwgZGV2KSkKCXsKCQlpZiAobmV0
X2RlYnVnKQoJCQlwcmludGsoImNlcmY4OXgwOiByZXF1ZXN0X2lycSglZCkgZmFpbGVkXG4i
LCBkZXYtPmlycSk7CgkJcmV0dXJuIC1FQUdBSU47Cgl9CgoJLyogU2V0IHVwIHRoZSBJUlEg
LSBBcHBhcmVudGx5IG1hZ2ljICovCglpZiAobHAtPmNoaXBfdHlwZSA9PSBDUzg5MDApCgkJ
d3JpdGVyZWcoZGV2LCBQUF9DUzg5MDBfSVNBSU5ULCAwKTsKCWVsc2UKCQl3cml0ZXJlZyhk
ZXYsIFBQX0NTODkyMF9JU0FJTlQsIDApOwoJCgkvKiBzZXQgdGhlIEV0aGVybmV0IGFkZHJl
c3MgKi8KCWZvciAoaT0wOyBpIDwgRVRIX0FMRU4vMjsgaSsrKQoJCXdyaXRlcmVnKGRldiwg
UFBfSUEraSoyLCBkZXYtPmRldl9hZGRyW2kqMl0gfCAoZGV2LT5kZXZfYWRkcltpKjIrMV0g
PDwgOCkpOwoKCS8qIFJlY2VpdmUgb25seSBlcnJvciBmcmVlIHBhY2tldHMgYWRkcmVzc2Vk
IHRvIHRoaXMgY2FyZCAqLwoJbHAtPnJ4X21vZGUgPSAwOy8vUlhfT0tfQUNDRVBUIHwgUlhf
SUFfQUNDRVBUOwoJbHAtPmN1cnJfcnhfY2ZnID0gUlhfT0tfRU5CTCB8IFJYX0NSQ19FUlJP
Ul9FTkJMOwoJCgl3cml0ZXJlZyhkZXYsIFBQX1J4Q1RMLCBERUZfUlhfQUNDRVBUKTsKCiAJ
d3JpdGVyZWcoZGV2LCBQUF9SeENGRywgbHAtPmN1cnJfcnhfY2ZnKTsKCgl3cml0ZXJlZyhk
ZXYsIFBQX1R4Q0ZHLAoJCVRYX0xPU1RfQ1JTX0VOQkwgfAoJCVRYX1NRRV9FUlJPUl9FTkJM
IHwKCQlUWF9PS19FTkJMIHwKCQlUWF9MQVRFX0NPTF9FTkJMIHwKCQlUWF9KQlJfRU5CTCB8
CgkJVFhfQU5ZX0NPTF9FTkJMIHwKCQlUWF8xNl9DT0xfRU5CTCk7CgoJd3JpdGVyZWcoZGV2
LCBQUF9CdWZDRkcsCgkJUkVBRFlfRk9SX1RYX0VOQkwgfAoJCVJYX01JU1NfQ09VTlRfT1ZS
RkxPV19FTkJMIHwKCQlUWF9DT0xfQ09VTlRfT1ZSRkxPV19FTkJMIHwKCQlUWF9VTkRFUlJV
Tl9FTkJMKTsKCgkvKiBUdXJuIG9uIGJvdGggcmVjZWl2ZSBhbmQgdHJhbnNtaXQgb3BlcmF0
aW9ucyAqLwoJd3JpdGVyZWcoZGV2LCBQUF9MaW5lQ1RMLCByZWFkcmVnKGRldiwgUFBfTGlu
ZUNUTCkgfAoJCQlTRVJJQUxfUlhfT04gfAoJCQlTRVJJQUxfVFhfT04pOwoKCS8qIG5vdyB0
aGF0IHdlJ3ZlIGdvdCBvdXIgYWN0IHRvZ2V0aGVyLCBlbmFibGUgZXZlcnl0aGluZyAqLwoJ
d3JpdGVyZWcoZGV2LCBQUF9CdXNDVEwsIHJlYWRyZWcoZGV2LCBQUF9CdXNDVEwpIHwgSU9f
Q0hBTk5FTF9SRUFEWV9PTik7Cgl3cml0ZXJlZyhkZXYsIFBQX0J1c0NUTCwgcmVhZHJlZyhk
ZXYsIFBQX0J1c0NUTCkgfCBFTkFCTEVfSVJRKTsKCgkvKiBlbmFibGUgSVJRIC0gbXVzdCBh
bHNvIGVuYWJsZSBmYWxsaW5nIGVkZ2UgY2xvY2sgKi8KCXNldF9HUElPX0lSUV9lZGdlICgx
IDw8IFNBMTEwMF9JUlFfVE9fR1BJTyAoZGV2LT5pcnEpLCBHUElPX1JJU0lOR19FREdFKTsK
CWVuYWJsZV9pcnEoZGV2LT5pcnEpOwoKCU1PRF9JTkNfVVNFX0NPVU5UOwoJbmV0aWZfc3Rh
cnRfcXVldWUoZGV2KTsKCglyZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQgbmV0X3RpbWVvdXQo
c3RydWN0IG5ldF9kZXZpY2UgKmRldikKewoJLyogSWYgd2UgZ2V0IGhlcmUsIHNvbWUgaGln
aGVyIGxldmVsIGhhcyBkZWNpZGVkIHdlIGFyZSBicm9rZW4uCgkgICBUaGVyZSBzaG91bGQg
cmVhbGx5IGJlIGEgImtpY2sgbWUiIGZ1bmN0aW9uIGNhbGwgaW5zdGVhZC4gKi8KCWlmIChu
ZXRfZGVidWcgPiAwKQoJCXByaW50aygiJXM6IHRyYW5zbWl0IHRpbWVkIG91dCwgJXM/XG4i
LCBkZXYtPm5hbWUsCgkgICAJdHhfZG9uZShkZXYpID8gIklSUSBjb25mbGljdCA/IiA6ICJu
ZXR3b3JrIGNhYmxlIHByb2JsZW0iKTsKCS8qIFRyeSB0byByZXN0YXJ0IHRoZSBhZGFwdG9y
LiAqLwoJbmV0aWZfd2FrZV9xdWV1ZShkZXYpOwp9CgpzdGF0aWMgaW50IG5ldF9zZW5kX3Bh
Y2tldChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQp7Cglz
dHJ1Y3QgbmV0X2xvY2FsICpscCA9IChzdHJ1Y3QgbmV0X2xvY2FsICopZGV2LT5wcml2OwoK
CWlmIChuZXRfZGVidWcgPiA0KQoJewoJCXByaW50aygiJXM6IHNlbnQgJWQgYnl0ZSBwYWNr
ZXQgb2YgdHlwZSAleFxuIiwKCQkJZGV2LT5uYW1lLCBza2ItPmxlbiwKCQkJKHNrYi0+ZGF0
YVtFVEhfQUxFTitFVEhfQUxFTl0gPDwgOCkgfCBza2ItPmRhdGFbRVRIX0FMRU4rRVRIX0FM
RU4rMV0pOwoJfQoKCS8qIGtlZXAgdGhlIHVwbG9hZCBmcm9tIGJlaW5nIGludGVycnVwdGVk
LCBzaW5jZSB3ZQogICAgICAgICAgICAgICAgICBhc2sgdGhlIGNoaXAgdG8gc3RhcnQgdHJh
bnNtaXR0aW5nIGJlZm9yZSB0aGUKICAgICAgICAgICAgICAgICAgd2hvbGUgcGFja2V0IGhh
cyBiZWVuIGNvbXBsZXRlbHkgdXBsb2FkZWQuICovCgoJc3Bpbl9sb2NrX2lycSgmbHAtPmxv
Y2spOwoJbmV0aWZfc3RvcF9xdWV1ZShkZXYpOwoKCS8qIGluaXRpYXRlIGEgdHJhbnNtaXQg
c2VxdWVuY2UgKi8KCXdyaXRlcmVnKGRldiwgUFBfVHhDTUQsIGxwLT5zZW5kX2NtZCk7Cgl3
cml0ZXJlZyhkZXYsIFBQX1R4TGVuZ3RoLCBza2ItPmxlbik7CgoJLyogVGVzdCB0byBzZWUg
aWYgdGhlIGNoaXAgaGFzIGFsbG9jYXRlZCBtZW1vcnkgZm9yIHRoZSBwYWNrZXQgKi8KCWlm
ICgocmVhZHJlZyhkZXYsIFBQX0J1c1NUKSAmIFJFQURZX0ZPUl9UWF9OT1cpID09IDApCgl7
CgkJLyoKCQkgKiBHYXNwISAgSXQgaGFzbid0LiAgQnV0IHRoYXQgc2hvdWxkbid0IGhhcHBl
biBzaW5jZQoJCSAqIHdlJ3JlIHdhaXRpbmcgZm9yIFR4T2ssIHNvIHJldHVybiAxIGFuZCBy
ZXF1ZXVlIHRoaXMgcGFja2V0LgoJCSAqLwoJCQoJCXNwaW5fdW5sb2NrX2lycSgmbHAtPmxv
Y2spOwoJCWlmIChuZXRfZGVidWcpCgkJCXByaW50aygiY3M4OXgwOiBUeCBidWZmZXIgbm90
IGZyZWUhXG4iKTsKCQkJCgkJcmV0dXJuIDE7Cgl9CgkvKiBXcml0ZSB0aGUgY29udGVudHMg
b2YgdGhlIHBhY2tldCAqLwoJd3JpdGVibG9jayhkZXYsIHNrYi0+ZGF0YSwgc2tiLT5sZW4p
OwkKCQoJc3Bpbl91bmxvY2tfaXJxKCZscC0+bG9jayk7CglkZXYtPnRyYW5zX3N0YXJ0ID0g
amlmZmllczsKCWRldl9rZnJlZV9za2Ioc2tiKTsKCgkvKgoJICogV2UgRE8gTk9UIGNhbGwg
bmV0aWZfd2FrZV9xdWV1ZSgpIGhlcmUuCgkgKiBXZSBhbHNvIERPIE5PVCBjYWxsIG5ldGlm
X3N0YXJ0X3F1ZXVlKCkuCgkgKgoJICogRWl0aGVyIG9mIHRoZXNlIHdvdWxkIGNhdXNlIGFu
b3RoZXIgYm90dG9tIGhhbGYgcnVuIHRocm91Z2gKCSAqIG5ldF9zZW5kX3BhY2tldCgpIGJl
Zm9yZSB0aGlzIHBhY2tldCBoYXMgZnVsbHkgZ29uZSBvdXQuICBUaGF0IGNhdXNlcwoJICog
dXMgdG8gaGl0IHRoZSAiR2FzcCEiIGFib3ZlIGFuZCB0aGUgc2VuZCBpcyByZXNjaGVkdWxl
ZC4gIGl0IHJ1bnMgbGlrZQoJICogYSBkb2cuICBXZSBqdXN0IHJldHVybiBhbmQgd2FpdCBm
b3IgdGhlIFR4IGNvbXBsZXRpb24gaW50ZXJydXB0IGhhbmRsZXIKCSAqIHRvIHJlc3RhcnQg
dGhlIG5ldGRldmljZSBsYXllcgoJICovCgoJcmV0dXJuIDA7Cn0KCgwKLyogVGhlIHR5cGlj
YWwgd29ya2xvYWQgb2YgdGhlIGRyaXZlcjoKICAgSGFuZGxlIHRoZSBuZXR3b3JrIGludGVy
ZmFjZSBpbnRlcnJ1cHRzLiAqLwogICAKc3RhdGljIHZvaWQgbmV0X2ludGVycnVwdChpbnQg
aXJxLCB2b2lkICpkZXZfaWQsIHN0cnVjdCBwdF9yZWdzICogcmVncykKewoJc3RydWN0IG5l
dF9kZXZpY2UgKmRldiA9IGRldl9pZDsKCXN0cnVjdCBuZXRfbG9jYWwgKmxwOwoJaW50IGlv
YWRkciwgc3RhdHVzOwoKCWlvYWRkciA9IGRldi0+YmFzZV9hZGRyOwoJbHAgPSAoc3RydWN0
IG5ldF9sb2NhbCAqKWRldi0+cHJpdjsKCgkvKiB3ZSBNVVNUIHJlYWQgYWxsIHRoZSBldmVu
dHMgb3V0IG9mIHRoZSBJU1EsIG90aGVyd2lzZSB3ZSdsbCBuZXZlcgoJCWdldCBpbnRlcnJ1
cHRlZCBhZ2Fpbi4gIEFzIGEgY29uc2VxdWVuY2UsIHdlIGNhbid0IGhhdmUgYW55IGxpbWl0
CgkJb24gdGhlIG51bWJlciBvZiB0aW1lcyB3ZSBsb29wIGluIHRoZSBpbnRlcnJ1cHQgaGFu
ZGxlci4gIFRoZQoJCWhhcmR3YXJlIGd1YXJhbnRlZXMgdGhhdCBldmVudHVhbGx5IHdlJ2xs
IHJ1biBvdXQgb2YgZXZlbnRzLiAgT2YKCQljb3Vyc2UsIGlmIHlvdSdyZSBvbiBhIHNsb3cg
bWFjaGluZSwgYW5kIHBhY2tldHMgYXJlIGFycml2aW5nCgkJZmFzdGVyIHRoYW4geW91IGNh
biByZWFkIHRoZW0gb2ZmLCB5b3UncmUgc2NyZXdlZC4gIEhhc3RhIGxhCgkJdmlzdGEsIGJh
YnkhCgkqLwoJd2hpbGUgKChzdGF0dXMgPSByZWFkd29yZChkZXYsIElTUV9QT1JUKSkpCgl7
CgkJaWYgKG5ldF9kZWJ1ZyA+IDQpCgkJCXByaW50aygiJXM6IGV2ZW50PSUwNHhcbiIsIGRl
di0+bmFtZSwgc3RhdHVzKTsKCQkJCgkJc3dpdGNoKHN0YXR1cyAmIElTUV9FVkVOVF9NQVNL
KQoJCXsKCQkJY2FzZSBJU1FfUkVDRUlWRVJfRVZFTlQ6CgkJCQkvKiBHb3QgYSBwYWNrZXQo
cykuICovCgkJCQluZXRfcngoZGV2KTsKCQkJCWJyZWFrOwoJCQkKCQkJY2FzZSBJU1FfVFJB
TlNNSVRURVJfRVZFTlQ6CgkJCQlscC0+c3RhdHMudHhfcGFja2V0cysrOwoJCQkJbmV0aWZf
d2FrZV9xdWV1ZShkZXYpOwkvKiBJbmZvcm0gdXBwZXIgbGF5ZXJzLiAqLwoJCQkJaWYgKChz
dGF0dXMgJiAoCVRYX09LIHwKCQkJCQkJVFhfTE9TVF9DUlMgfAoJCQkJCQlUWF9TUUVfRVJS
T1IgfAoJCQkJCQlUWF9MQVRFX0NPTCB8CgkJCQkJCVRYXzE2X0NPTCkpICE9IFRYX09LKQoJ
CQkJewoJCQkJCWlmICgoc3RhdHVzICYgVFhfT0spID09IDApIGxwLT5zdGF0cy50eF9lcnJv
cnMrKzsKCQkJCQlpZiAoc3RhdHVzICYgVFhfTE9TVF9DUlMpIGxwLT5zdGF0cy50eF9jYXJy
aWVyX2Vycm9ycysrOwoJCQkJCWlmIChzdGF0dXMgJiBUWF9TUUVfRVJST1IpIGxwLT5zdGF0
cy50eF9oZWFydGJlYXRfZXJyb3JzKys7CgkJCQkJaWYgKHN0YXR1cyAmIFRYX0xBVEVfQ09M
KSBscC0+c3RhdHMudHhfd2luZG93X2Vycm9ycysrOwoJCQkJCWlmIChzdGF0dXMgJiBUWF8x
Nl9DT0wpIGxwLT5zdGF0cy50eF9hYm9ydGVkX2Vycm9ycysrOwoJCQkJfQoJCQkJYnJlYWs7
CgkJCQoJCQljYXNlIElTUV9CVUZGRVJfRVZFTlQ6CgkJCQlpZiAoc3RhdHVzICYgUkVBRFlf
Rk9SX1RYKQoJCQkJewoJCQkJCS8qIHdlIHRyaWVkIHRvIHRyYW5zbWl0IGEgcGFja2V0IGVh
cmxpZXIsIGJ1dCBpbmV4cGxpY2FibHkgcmFuIG91dCBvZiBidWZmZXJzLgoJCQkJCSAqIFRo
YXQgc2hvdWxkbid0IGhhcHBlbiBzaW5jZSB3ZSBvbmx5IGV2ZXIgbG9hZCBvbmUgcGFja2V0
LgoJCQkJCSAqCVNocnVnLiBEbyB0aGUgcmlnaHQgdGhpbmcgYW55d2F5LgoJCQkJCSAqLwoJ
CQkJCW5ldGlmX3dha2VfcXVldWUoZGV2KTsJLyogSW5mb3JtIHVwcGVyIGxheWVycy4gKi8K
CQkJCX0KCQkJCWlmIChzdGF0dXMgJiBUWF9VTkRFUlJVTikKCQkJCXsKCQkJCQlpZiAobmV0
X2RlYnVnID4gMCkKCQkJCQkJcHJpbnRrKCIlczogdHJhbnNtaXQgdW5kZXJydW5cbiIsIGRl
di0+bmFtZSk7CgkJCQkJbHAtPnNlbmRfdW5kZXJydW4rKzsKCQkJCQlpZiAobHAtPnNlbmRf
dW5kZXJydW4gPT0gMykKCQkJCQkJbHAtPnNlbmRfY21kID0gVFhfQUZURVJfMzgxOwoJCQkJ
CWVsc2UgaWYgKGxwLT5zZW5kX3VuZGVycnVuID09IDYpCgkJCQkJCWxwLT5zZW5kX2NtZCA9
IFRYX0FGVEVSX0FMTDsKCQkJCQkvKgoJCQkJCSAqIHRyYW5zbWl0IGN5Y2xlIGlzIGRvbmUs
IGFsdGhvdWdoCWZyYW1lIHdhc24ndCB0cmFuc21pdHRlZCAtIHRoaXMKCQkJCSAJICogYXZv
aWRzIGhhdmluZyB0byB3YWl0IGZvciB0aGUgdXBwZXIJbGF5ZXJzIHRvIHRpbWVvdXQgb24g
dXMsCgkJCQkgCSAqIGluIHRoZSBldmVudCBvZiBhIHR4IHVuZGVycnVuCgkJCQkgCSAqLwoJ
CQkJCW5ldGlmX3dha2VfcXVldWUoZGV2KTsJLyogSW5mb3JtIHVwcGVyIGxheWVycy4gKi8K
CQkJCX0KCQkJCWJyZWFrOwoJCQkKCQkJY2FzZSBJU1FfUlhfTUlTU19FVkVOVDoKCQkJCWxw
LT5zdGF0cy5yeF9taXNzZWRfZXJyb3JzICs9IChzdGF0dXMgPj42KTsKCQkJCWJyZWFrOwoJ
CQkKCQkJY2FzZSBJU1FfVFhfQ09MX0VWRU5UOgoJCQkJbHAtPnN0YXRzLmNvbGxpc2lvbnMg
Kz0gKHN0YXR1cyA+PjYpOwoJCQkJYnJlYWs7CgkJCWRlZmF1bHQ6CgkJCQlpZiAobmV0X2Rl
YnVnID4gMykKCQkJCQlwcmludGsoIiVzOiBldmVudD0lMDR4XG4iLCBkZXYtPm5hbWUsIHN0
YXR1cyk7CgkJfQoJfQp9CgpzdGF0aWMgdm9pZApjb3VudF9yeF9lcnJvcnMoaW50IHN0YXR1
cywgc3RydWN0IG5ldF9sb2NhbCAqbHApCnsKCWxwLT5zdGF0cy5yeF9lcnJvcnMrKzsKCWlm
IChzdGF0dXMgJiBSWF9SVU5UKSBscC0+c3RhdHMucnhfbGVuZ3RoX2Vycm9ycysrOwoJaWYg
KHN0YXR1cyAmIFJYX0VYVFJBX0RBVEEpIGxwLT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7
CglpZiAoc3RhdHVzICYgUlhfQ1JDX0VSUk9SKQoJCWlmICghKHN0YXR1cyAmIChSWF9FWFRS
QV9EQVRBfFJYX1JVTlQpKSkKCQkJLyogcGVyIHN0ciAxNzIgKi8KCQkJbHAtPnN0YXRzLnJ4
X2NyY19lcnJvcnMrKzsKCWlmIChzdGF0dXMgJiBSWF9EUklCQkxFKSBscC0+c3RhdHMucnhf
ZnJhbWVfZXJyb3JzKys7CglyZXR1cm47Cn0KCi8qIFdlIGhhdmUgYSBnb29kIHBhY2tldChz
KSwgZ2V0IGl0L3RoZW0gb3V0IG9mIHRoZSBidWZmZXJzLiAqLwpzdGF0aWMgdm9pZApuZXRf
cngoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKewoJc3RydWN0IG5ldF9sb2NhbCAqbHAgPSAo
c3RydWN0IG5ldF9sb2NhbCAqKWRldi0+cHJpdjsKCXN0cnVjdCBza19idWZmICpza2I7Cglp
bnQgc3RhdHVzID0gMCwgbGVuZ3RoID0gMDsKCWludCBpOwoKCXN0YXR1cyA9IHJlYWRyZWco
ZGV2LCBQUF9SeFN0YXR1cyk7CglpZiAoKHN0YXR1cyAmIFJYX09LKSA9PSAwKSB7CgkJY291
bnRfcnhfZXJyb3JzKHN0YXR1cywgbHApOwoJCXJldHVybjsKCX0KCglsZW5ndGggPSByZWFk
cmVnKGRldiwgUFBfUnhMZW5ndGgpOwoKCS8qIE1hbGxvYyB1cCBuZXcgYnVmZmVyLiAqLwoJ
c2tiID0gYWxsb2Nfc2tiKGxlbmd0aCsyLCBHRlBfQVRPTUlDKTsKCXNrYl9yZXNlcnZlKHNr
YiwgMik7CgoJaWYgKHNrYiA9PSBOVUxMKQoJewoJCWxwLT5zdGF0cy5yeF9kcm9wcGVkKys7
CgkJcmV0dXJuOwoJfQoJc2tiLT5sZW4gPSBsZW5ndGg7Cglza2ItPmRldiA9IGRldjsKCgly
ZWFkYmxvY2soZGV2LCBza2ItPmRhdGEsIHNrYi0+bGVuKTsKCglpZiAobmV0X2RlYnVnID4g
NCkKCXsKCQlwcmludGsoIiVzOiByZWNlaXZlZCAlZCBieXRlIHBhY2tldCBvZiB0eXBlICV4
XG4iLAoJCQlkZXYtPm5hbWUsIGxlbmd0aCwKCQkJKHNrYi0+ZGF0YVtFVEhfQUxFTitFVEhf
QUxFTl0gPDwgOCkgfCBza2ItPmRhdGFbRVRIX0FMRU4rRVRIX0FMRU4rMV0pOwoJfQoKCXNr
Yi0+cHJvdG9jb2w9ZXRoX3R5cGVfdHJhbnMoc2tiLGRldik7CgluZXRpZl9yeChza2IpOwoJ
bHAtPnN0YXRzLnJ4X3BhY2tldHMrKzsKCWxwLT5zdGF0cy5yeF9ieXRlcys9c2tiLT5sZW47
CglyZXR1cm47Cn0KCi8qIFRoZSBpbnZlcnNlIHJvdXRpbmUgdG8gbmV0X29wZW4oKS4gKi8K
c3RhdGljIGludApuZXRfY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKewoJbmV0aWZf
c3RvcF9xdWV1ZShkZXYpOwoJCgl3cml0ZXJlZyhkZXYsIFBQX1J4Q0ZHLCAwKTsKCXdyaXRl
cmVnKGRldiwgUFBfVHhDRkcsIDApOwoJd3JpdGVyZWcoZGV2LCBQUF9CdWZDRkcsIDApOwoJ
d3JpdGVyZWcoZGV2LCBQUF9CdXNDVEwsIDApOwoKCWZyZWVfaXJxKGRldi0+aXJxLCBkZXYp
OwoKCS8qIFVwZGF0ZSB0aGUgc3RhdGlzdGljcyBoZXJlLiAqLwoJTU9EX0RFQ19VU0VfQ09V
TlQ7CglyZXR1cm4gMDsKfQoKLyogR2V0IHRoZSBjdXJyZW50IHN0YXRpc3RpY3MuCVRoaXMg
bWF5IGJlIGNhbGxlZCB3aXRoIHRoZSBjYXJkIG9wZW4gb3IKICAgY2xvc2VkLiAqLwpzdGF0
aWMgc3RydWN0IG5ldF9kZXZpY2Vfc3RhdHMgKgpuZXRfZ2V0X3N0YXRzKHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpCnsKCXN0cnVjdCBuZXRfbG9jYWwgKmxwID0gKHN0cnVjdCBuZXRfbG9j
YWwgKilkZXYtPnByaXY7Cgl1bnNpZ25lZCBsb25nIGZsYWdzOwoKCXNwaW5fbG9ja19pcnFz
YXZlKCZscC0+bG9jaywgZmxhZ3MpOwoJLyogVXBkYXRlIHRoZSBzdGF0aXN0aWNzIGZyb20g
dGhlIGRldmljZSByZWdpc3RlcnMuICovCglscC0+c3RhdHMucnhfbWlzc2VkX2Vycm9ycyAr
PSAocmVhZHJlZyhkZXYsIFBQX1J4TWlzcykgPj4gNik7CglscC0+c3RhdHMuY29sbGlzaW9u
cyArPSAocmVhZHJlZyhkZXYsIFBQX1R4Q29sKSA+PiA2KTsKCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmxwLT5sb2NrLCBmbGFncyk7CgoJcmV0dXJuICZscC0+c3RhdHM7Cn0KCnN0YXRp
YyB2b2lkIHNldF9tdWx0aWNhc3RfbGlzdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQp7Cglz
dHJ1Y3QgbmV0X2xvY2FsICpscCA9IChzdHJ1Y3QgbmV0X2xvY2FsICopZGV2LT5wcml2OwoJ
dW5zaWduZWQgbG9uZyBmbGFnczsKCglzcGluX2xvY2tfaXJxc2F2ZSgmbHAtPmxvY2ssIGZs
YWdzKTsKCWlmKGRldi0+ZmxhZ3MmSUZGX1BST01JU0MpCgl7CgkJbHAtPnJ4X21vZGUgPSBS
WF9BTExfQUNDRVBUOwoJfQoJZWxzZSBpZigoZGV2LT5mbGFncyZJRkZfQUxMTVVMVEkpfHxk
ZXYtPm1jX2xpc3QpCgl7CgkJLyogVGhlIG11bHRpY2FzdC1hY2NlcHQgbGlzdCBpcyBpbml0
aWFsaXplZCB0byBhY2NlcHQtYWxsLCBhbmQgd2UKCQkgICByZWx5IG9uIGhpZ2hlci1sZXZl
bCBmaWx0ZXJpbmcgZm9yIG5vdy4gKi8KCQlscC0+cnhfbW9kZSA9IFJYX01VTFRDQVNUX0FD
Q0VQVDsKCX0gCgllbHNlCgkJbHAtPnJ4X21vZGUgPSAwOwoKCXdyaXRlcmVnKGRldiwgUFBf
UnhDVEwsIERFRl9SWF9BQ0NFUFQgfCBscC0+cnhfbW9kZSk7CgoJLyogaW4gcHJvbWlzY3Vv
dXMgbW9kZSwgd2UgYWNjZXB0IGVycm9yZWQgcGFja2V0cywgc28gd2UgaGF2ZSB0byBlbmFi
bGUgaW50ZXJydXB0cyBvbiB0aGVtIGFsc28gKi8KCXdyaXRlcmVnKGRldiwgUFBfUnhDRkcs
IGxwLT5jdXJyX3J4X2NmZyB8CgkgICAgIChscC0+cnhfbW9kZSA9PSBSWF9BTExfQUNDRVBU
PyAoUlhfQ1JDX0VSUk9SX0VOQkx8UlhfUlVOVF9FTkJMfFJYX0VYVFJBX0RBVEFfRU5CTCkg
OiAwKSk7CglzcGluX3VubG9ja19pcnFyZXN0b3JlKCZscC0+bG9jaywgZmxhZ3MpOwp9CgoK
c3RhdGljIGludCBzZXRfbWFjX2FkZHJlc3Moc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdm9p
ZCAqYWRkcikKewoJaW50IGk7CgoJaWYgKG5ldGlmX3J1bm5pbmcoZGV2KSkKCQlyZXR1cm4g
LUVCVVNZOwoJaWYgKG5ldF9kZWJ1ZykKCXsKCQlwcmludGsoIiVzOiBTZXR0aW5nIE1BQyBh
ZGRyZXNzIHRvICIsIGRldi0+bmFtZSk7CgkJZm9yIChpID0gMDsgaSA8IDY7IGkrKykKCQkJ
cHJpbnRrKCIgJTIuMngiLCBkZXYtPmRldl9hZGRyW2ldID0gKCh1bnNpZ25lZCBjaGFyICop
YWRkcilbaV0pOwoJCXByaW50aygiLlxuIik7Cgl9CgkvKiBzZXQgdGhlIEV0aGVybmV0IGFk
ZHJlc3MgKi8KCWZvciAoaT0wOyBpIDwgRVRIX0FMRU4vMjsgaSsrKQoJCXdyaXRlcmVnKGRl
diwgUFBfSUEraSoyLCBkZXYtPmRldl9hZGRyW2kqMl0gfCAoZGV2LT5kZXZfYWRkcltpKjIr
MV0gPDwgOCkpOwoKCXJldHVybiAwOwp9CgojaWZkZWYgTU9EVUxFCgpzdGF0aWMgY2hhciBu
YW1lc3BhY2VbMTZdID0gIiI7CnN0YXRpYyBzdHJ1Y3QgbmV0X2RldmljZSBkZXZfY3M4OXgw
ID0gewogICAgICAgIE5VTEwsCiAgICAgICAgMCwgMCwgMCwgMCwKICAgICAgICAwLCAwLAog
ICAgICAgIDAsIDAsIDAsIE5VTEwsIE5VTEwgfTsKCi8qCiAqIFN1cHBvcnQgdGhlICdkZWJ1
ZycgbW9kdWxlIHBhcm0gZXZlbiBpZiB3ZSdyZSBjb21waWxlZCBmb3Igbm9uLWRlYnVnIHRv
IAogKiBhdm9pZCBicmVha2luZyBzb21lb25lJ3Mgc3RhcnR1cCBzY3JpcHRzIAogKi8KCnN0
YXRpYyBpbnQgaW89MHhkODAwMDMwMDsKc3RhdGljIGludCBpcnE9SVJRX0dQSU8xMV8yNzsK
c3RhdGljIGludCBkZWJ1Zz0wOwpzdGF0aWMgY2hhciBtZWRpYVs4XTsKc3RhdGljIGludCBk
dXBsZXg9LTE7CgpzdGF0aWMgaW50IHVzZV9kbWEgPSAwOwkJCS8qIFRoZXNlIGdlbmVyYXRl
IHVudXNlZCB2YXIgd2FybmluZ3MgaWYgQUxMT1dfRE1BID0gMCAqLwpzdGF0aWMgaW50IGRt
YT0wOwpzdGF0aWMgaW50IGRtYXNpemU9MTY7CQkJLyogb3IgNjQgKi8KCk1PRFVMRV9QQVJN
KGlvLCAiaSIpOwpNT0RVTEVfUEFSTShpcnEsICJpIik7Ck1PRFVMRV9QQVJNKGRlYnVnLCAi
aSIpOwpNT0RVTEVfUEFSTShtZWRpYSwgInMiKTsKTU9EVUxFX1BBUk0oZHVwbGV4LCAiaSIp
OwpNT0RVTEVfUEFSTShkbWEgLCAiaSIpOwpNT0RVTEVfUEFSTShkbWFzaXplICwgImkiKTsK
TU9EVUxFX1BBUk0odXNlX2RtYSAsICJpIik7CgpNT0RVTEVfQVVUSE9SKCJNaWtlIENydXNl
LCBSdXNzd2xsIE5lbHNvbiA8bmVsc29uQGNyeW53ci5jb20+LCBBbmRyZXcgTW9ydG9uIDxh
bmRyZXdtQHVvdy5lZHUuYXU+Iik7CgpFWFBPUlRfTk9fU1lNQk9MUzsKCi8qCiogbWVkaWE9
dCAgICAgICAgICAgICAtIHNwZWNpZnkgbWVkaWEgdHlwZQogICBvciBtZWRpYT0yCiAgIG9y
IG1lZGlhPWF1aQogICBvciBtZWRhaT1hdXRvCiogZHVwbGV4PTAgICAgICAgICAgICAtIHNw
ZWNpZnkgZm9yY2VkIGhhbGYvZnVsbC9hdXRvbmVnb3RpYXRlIGR1cGxleAoqIGRlYnVnPSMg
ICAgICAgICAgICAgLSBkZWJ1ZyBsZXZlbAoKCiogRGVmYXVsdCBDaGlwIENvbmZpZ3VyYXRp
b246CiAgKiBETUEgQnVyc3QgPSBlbmFibGVkCiAgKiBJT0NIUkRZIEVuYWJsZWQgPSBlbmFi
bGVkCiAgICAqIFVzZVNBID0gZW5hYmxlZAogICAgKiBDUzg5MDAgZGVmYXVsdHMgdG8gaGFs
Zi1kdXBsZXggaWYgbm90IHNwZWNpZmllZCBvbiBjb21tYW5kLWxpbmUKICAgICogQ1M4OTIw
IGRlZmF1bHRzIHRvIGF1dG9uZWcgaWYgbm90IHNwZWNpZmllZCBvbiBjb21tYW5kLWxpbmUK
ICAgICogVXNlIHJlc2V0IGRlZmF1bHRzIGZvciBvdGhlciBjb25maWcgcGFyYW1ldGVycwoK
KiBBc3N1bXB0aW9uczoKICAqIG1lZGlhIHR5cGUgc3BlY2lmaWVkIGlzIHN1cHBvcnRlZCAo
Y2lyY3VpdHJ5IGlzIHByZXNlbnQpCiAgKiBpZiBtZW1vcnkgYWRkcmVzcyBpcyA+IDFNQiwg
dGhlbiByZXF1aXJlZCBtZW0gZGVjb2RlIGh3IGlzIHByZXNlbnQKICAqIGlmIDEwQi0yLCB0
aGVuIGFnZW50IG90aGVyIHRoYW4gZHJpdmVyIHdpbGwgZW5hYmxlIERDL0RDIGNvbnZlcnRl
cgogICAgKGh3IG9yIHNvZnR3YXJlIHV0aWwpCgoKKi8KCmludAppbml0X21vZHVsZSh2b2lk
KQp7CglzdHJ1Y3QgbmV0X2xvY2FsICpscDsKCiNpZiBERUJVR0dJTkcKCW5ldF9kZWJ1ZyA9
IGRlYnVnOwojZW5kaWYKCWRldl9jczg5eDAubmFtZSA9IG5hbWVzcGFjZTsKCWRldl9jczg5
eDAuaXJxID0gaXJxOwoJZGV2X2NzODl4MC5iYXNlX2FkZHIgPSBpbzsKCglkZXZfY3M4OXgw
LmluaXQgPSBjZXJmODl4MF9wcm9iZTsKCWRldl9jczg5eDAucHJpdiA9IGttYWxsb2Moc2l6
ZW9mKHN0cnVjdCBuZXRfbG9jYWwpLCBHRlBfS0VSTkVMKTsKCWlmIChkZXZfY3M4OXgwLnBy
aXYgPT0gMCkKCXsKCQlwcmludGsoS0VSTl9FUlIgImNzODl4MC5jOiBPdXQgb2YgbWVtb3J5
LlxuIik7CgkJcmV0dXJuIC1FTk9NRU07Cgl9CgltZW1zZXQoZGV2X2NzODl4MC5wcml2LCAw
LCBzaXplb2Yoc3RydWN0IG5ldF9sb2NhbCkpOwoJbHAgPSAoc3RydWN0IG5ldF9sb2NhbCAq
KWRldl9jczg5eDAucHJpdjsKCglzcGluX2xvY2tfaW5pdCgmbHAtPmxvY2spOwoKCWlmIChy
ZWdpc3Rlcl9uZXRkZXYoJmRldl9jczg5eDApICE9IDApIHsKCQlwcmludGsoS0VSTl9FUlIg
ImNlcmY4OXgwLmM6IE5vIGNoaXAgZm91bmQgYXQgMHgleFxuIiwgaW8pOwoJCXJldHVybiAt
RU5YSU87Cgl9CglyZXR1cm4gMDsKfQoKdm9pZApjbGVhbnVwX21vZHVsZSh2b2lkKQp7Cgl3
cml0ZXdvcmQoZGV2LCBBRERfUE9SVCwgUFBfQ2hpcElEKTsKCWlmIChkZXZfY3M4OXgwLnBy
aXYgIT0gTlVMTCkgewoJCS8qIEZyZWUgdXAgdGhlIHByaXZhdGUgc3RydWN0dXJlLCBvciBs
ZWFrIG1lbW9yeSA6LSkgICovCgkJdW5yZWdpc3Rlcl9uZXRkZXYoJmRldl9jczg5eDApOwoJ
CWtmcmVlKGRldl9jczg5eDAucHJpdik7CgkJZGV2X2NzODl4MC5wcml2ID0gTlVMTDsJLyog
Z2V0cyByZS1hbGxvY2F0ZWQgYnkgY2VyZjg5eDBfcHJvYmUxICovCgkJLyogSWYgd2UgZG9u
J3QgZG8gdGhpcywgd2UgY2FuJ3QgcmUtaW5zbW9kIGl0IGxhdGVyLiAqLwoJCXJlbGVhc2Vf
cmVnaW9uKGRldl9jczg5eDAuYmFzZV9hZGRyLCBORVRDQVJEX0lPX0VYVEVOVCk7Cgl9Cn0K
I2VuZGlmIC8qIE1PRFVMRSAqLwoMCi8qCiAqIExvY2FsIHZhcmlhYmxlczoKICogIGNvbXBp
bGUtY29tbWFuZDogImdjYyAtRF9fS0VSTkVMX18gLUkvdXNyL3NyYy9saW51eC9pbmNsdWRl
IC1JL3Vzci9zcmMvbGludXgvbmV0L2luZXQgLVdhbGwgLVdzdHJpY3QtcHJvdG90eXBlcyAt
TzIgLWZvbWl0LWZyYW1lLXBvaW50ZXIgLURNT0RVTEUgLURDT05GSUdfTU9EVkVSU0lPTlMg
LWMgY3M4OXgwLmMiCiAqICB2ZXJzaW9uLWNvbnRyb2w6IHQKICogIGtlcHQtbmV3LXZlcnNp
b25zOiA1CiAqICBjLWluZGVudC1sZXZlbDogOAogKiAgdGFiLXdpZHRoOiA4CiAqIEVuZDoK
ICoKICovCgo=
--------------030401010607080400060908--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
