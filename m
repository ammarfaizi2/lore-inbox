Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTELJGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbTELJGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:06:16 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:55242 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262011AbTELJFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:05:50 -0400
Subject: Re: eth0: Too much work in interrupt, status e401
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3EBEEF38.1070008@pobox.com>
References: <1052699512.662.3.camel@teapot.felipe-alfaro.com>
	 <3EBEEF38.1070008@pobox.com>
Content-Type: multipart/mixed; boundary="=-qPLxIk7ZSUATUS4zdShy"
Message-Id: <1052731089.576.8.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 12 May 2003 11:18:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qPLxIk7ZSUATUS4zdShy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-05-12 at 02:47, Jeff Garzik wrote:
> Felipe Alfaro Solana wrote:
> > Hi!
> > 
> > I'm having severe hardlocks with 2.5.69-mm3 when mounting an NFS volume
> > from one of my NFS servers. I think this is related to iptables, but
> > while investigating, I found the following messages on my dmesg ring:
> > 
> > spurious 8259A interrupt: IRQ7.
> > eth0: Setting full-duplex based on MII #0 link partner capability of
> > 01e1.
> > eth0: Transmit error, Tx status register 90.
> 
> 
> Check out REPORTING-BUGS file in the kernel source code.  It describes 
> the information we find useful in bug reports.  In particularly, you did 
> not give us any information on your network hardware (network card, and 
> what it is connected to) or what drivers you have loaded.

Well, that wasn't a bug report in itself... I was simply asking what
does the message mean?

Anyways, the machine is a NEC Chrom@ laptop (Pentium III Coppermine +
440BX chipset), 256MB RAM, ATI RAGE Mobility M1 AGP, an the network card
is a 3CCFE575CT Cyclone CardBus. The machine is running Red Hat Linux 9,
is connected to an 8-port 100Mbps switch, and is talking to another
machine which I use mainly as my NFS server, running on Red Hat Linux 9,
2.5.69-bk6 and using a 3Com Etherlink III XL Pro (3c59x) NIC.

Attached are "lspci", "dmesg" and "config" used to build the kernel.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

--=-qPLxIk7ZSUATUS4zdShy
Content-Disposition: attachment; filename=config
Content-Type: text/plain; name=config; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_025GB is not set
# CONFIG_05GB is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
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
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_LIMIT is not set
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
# CONFIG_IP_NF_TARGET_REJECT is not set
# CONFIG_IP_NF_TARGET_MIRROR is not set
# CONFIG_IP_NF_NAT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_TARGET_LOG is not set
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
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
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_YMFPCI=y
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# SCSI support is needed for USB Storage
#

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
CONFIG_USB_SERIAL_IPAQ=m
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_KALLSYMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_DEBUG_INFO=y
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--=-qPLxIk7ZSUATUS4zdShy
Content-Disposition: attachment; filename=lspci
Content-Type: text/plain; name=lspci; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: dc800000-dc8fffff
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
	Subsystem: NEC Corporation: Unknown device 80b5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at ef00 [size=64]
	Region 2: I/O ports at efe4 [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 000002c0-000002c3
	I/O window 1: 00001000-000010ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00001800-000018ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0c.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8011 (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at febff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at febf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: NEC Corporation: Unknown device 80a8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febfff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at eff0 [size=8]
	Region 2: I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=160mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: NEC Corporation: Unknown device 80b7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus (rev 10)
	Subsystem: 3Com Corporation FE575C-3Com 10/100 LAN CardBus-Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at 11000000 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at 11000080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 10c00000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


--=-qPLxIk7ZSUATUS4zdShy
Content-Disposition: attachment; filename=dmesg
Content-Type: application/octet-stream; name=dmesg
Content-Transfer-Encoding: 8bit

May 12 02:26:35 teapot kernel: Linux version 2.5.69-mm3 (root@teapot.felipe-alfaro.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-4)) #1 Sun May 11 19:21:16 CEST 2003
May 12 02:26:35 teapot kernel: Video mode to be used for restore is f00
May 12 02:26:35 teapot kernel: BIOS-provided physical RAM map:
May 12 02:26:35 teapot kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
May 12 02:26:35 teapot kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
May 12 02:26:35 teapot kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
May 12 02:26:35 teapot kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
May 12 02:26:35 teapot kernel:  BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
May 12 02:26:35 teapot kernel:  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
May 12 02:26:35 teapot kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
May 12 02:26:35 teapot kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
May 12 02:26:35 teapot syslog: klogd startup succeeded
May 12 02:26:35 teapot kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
May 12 02:26:35 teapot kernel: 255MB LOWMEM available.
May 12 02:26:35 teapot kernel: On node 0 totalpages: 65520
May 12 02:26:36 teapot kernel:   DMA zone: 4096 pages, LIFO batch:1
May 12 02:26:36 teapot kernel:   Normal zone: 61424 pages, LIFO batch:14
May 12 02:26:36 teapot kernel:   HighMem zone: 0 pages, LIFO batch:1
May 12 02:26:36 teapot kernel: Building zonelist for node : 0
May 12 02:26:36 teapot kernel: Kernel command line: ro root=/dev/hda3 pci=usepirqmask
May 12 02:26:36 teapot kernel: Initializing CPU#0
May 12 02:26:36 teapot kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
May 12 02:26:36 teapot kernel: Detected 697.126 MHz processor.
May 12 02:26:36 teapot portmap: portmap startup succeeded
May 12 02:26:36 teapot kernel: Console: colour VGA+ 80x25
May 12 02:26:36 teapot kernel: Calibrating delay loop... 1376.25 BogoMIPS
May 12 02:26:36 teapot keytable: Loading keymap: 
May 12 02:26:36 teapot kernel: Memory: 256336k/262080k available (1625k kernel code, 5016k reserved, 508k data, 108k init, 0k highmem)
May 12 02:26:36 teapot kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
May 12 02:26:36 teapot keytable: 
May 12 02:26:36 teapot kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
May 12 02:26:36 teapot keytable: Loading system font: 
May 12 02:26:36 teapot kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
May 12 02:26:36 teapot keytable: plus before ntilde ignored
May 12 02:26:36 teapot kernel: -> /dev
May 12 02:26:36 teapot keytable: plus before Ntilde ignored
May 12 02:26:36 teapot kernel: -> /dev/console
May 12 02:26:36 teapot keytable: plus before ccedilla ignored
May 12 02:26:36 teapot kernel: -> /root
May 12 02:26:36 teapot keytable: plus before Ccedilla ignored
May 12 02:26:36 teapot kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 12 02:26:36 teapot kernel: CPU: L2 cache: 256K
May 12 02:26:36 teapot keytable: 
May 12 02:26:36 teapot rc: Starting keytable:  succeeded
May 12 02:26:36 teapot kernel: CPU: Intel Pentium III (Coppermine) stepping 06
May 12 02:26:36 teapot kernel: Enabling fast FPU save and restore... done.
May 12 02:26:36 teapot kernel: Enabling unmasked SIMD FPU exception support... done.
May 12 02:26:36 teapot kernel: Checking 'hlt' instruction... OK.
May 12 02:26:36 teapot kernel: POSIX conformance testing by UNIFIX
May 12 02:26:36 teapot random: Initializing random number generator:  succeeded
May 12 02:26:36 teapot kernel: mtrr: v2.0 (20020519)
May 12 02:26:36 teapot kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
May 12 02:26:36 teapot kernel: PCI: Using configuration type 1
May 12 02:26:36 teapot kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
May 12 02:26:36 teapot kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
May 12 02:26:36 teapot kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
May 12 02:26:37 teapot kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
May 12 02:26:37 teapot kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
May 12 02:26:37 teapot kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
May 12 02:26:37 teapot kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
May 12 02:26:37 teapot kernel: block request queues:
May 12 02:26:37 teapot kernel:  4/1024 requests per read queue
May 12 02:26:37 teapot modprobe: FATAL: Module snd_card_1 not found. 
May 12 02:26:37 teapot kernel:  4/1024 requests per write queue
May 12 02:26:37 teapot kernel:  enter congestion at 127
May 12 02:26:37 teapot modprobe: FATAL: Module snd_card_2 not found. 
May 12 02:26:37 teapot kernel:  exit congestion at 129
May 12 02:26:37 teapot modprobe: FATAL: Module snd_card_3 not found. 
May 12 02:26:37 teapot kernel: Linux Kernel Card Services 3.1.22
May 12 02:26:37 teapot kernel:   options:  [pci] [cardbus] [pm]
May 12 02:26:37 teapot kernel: drivers/usb/core/usb.c: registered new driver usbfs
May 12 02:26:37 teapot kernel: drivers/usb/core/usb.c: registered new driver hub
May 12 02:26:37 teapot kernel: PCI: Probing PCI hardware
May 12 02:26:37 teapot kernel: PCI: Probing PCI hardware (bus 00)
May 12 02:26:37 teapot kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
May 12 02:26:37 teapot kernel: PCI: Found IRQ 10 for device 00:0c.0
May 12 02:26:37 teapot kernel: PCI: Found IRQ 5 for device 00:0c.1
May 12 02:26:37 teapot kernel: PCI: Sharing IRQ 5 with 00:09.0
May 12 02:26:37 teapot rc: Starting alsasound:  succeeded
May 12 02:26:37 teapot kernel: Initializing RT netlink socket
May 12 02:26:37 teapot kernel: SBF: Simple Boot Flag extension found and enabled.
May 12 02:26:37 teapot kernel: SBF: Setting boot flags 0x1
May 12 02:26:37 teapot kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
May 12 02:26:37 teapot kernel: Enabling SEP on CPU 0
May 12 02:26:37 teapot kernel: Limiting direct PCI/PCI transfers.
May 12 02:26:37 teapot kernel: pty: 256 Unix98 ptys configured
May 12 02:26:37 teapot kernel: Real Time Clock Driver v1.11
May 12 02:26:37 teapot kernel: Linux agpgart interface v0.100 (c) Dave Jones
May 12 02:26:37 teapot kernel: agpgart: Detected Intel 440BX chipset
May 12 02:26:37 teapot kernel: agpgart: Maximum main memory to use for agp memory: 203M
May 12 02:26:37 teapot kernel: agpgart: AGP aperture is 256M @ 0xe0000000
May 12 02:26:37 teapot kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
May 12 02:26:37 teapot kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 12 02:26:37 teapot kernel: PIIX4: IDE controller at PCI slot 00:07.1
May 12 02:26:37 teapot kernel: PIIX4: chipset revision 1
May 12 02:26:37 teapot kernel: PIIX4: not 100%% native mode: will probe irqs later
May 12 02:26:37 teapot kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
May 12 02:26:37 teapot kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
May 12 02:26:37 teapot kernel: hda: HITACHI_DK23BA-20, ATA DISK drive
May 12 02:26:37 teapot kernel: anticipatory scheduling elevator
May 12 02:26:37 teapot kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 12 02:26:37 teapot kernel: hdc: MATSHITADVD-ROM SR-8185, ATAPI CD/DVD-ROM drive
May 12 02:26:37 teapot kernel: anticipatory scheduling elevator
May 12 02:26:37 teapot kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 12 02:26:37 teapot kernel: hda: host protected area => 1
May 12 02:26:37 teapot kernel: hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
May 12 02:26:31 teapot rc.sysinit: -e 
May 12 02:26:38 teapot kernel:  hda: hda1 hda2 hda3 hda4
May 12 02:26:31 teapot rc.sysinit: Mounting proc filesystem:  succeeded 
May 12 02:26:38 teapot kernel: hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
May 12 02:26:31 teapot sysctl: net.ipv4.ip_forward = 0 
May 12 02:26:39 teapot kernel: Uniform CD-ROM driver Revision: 3.12
May 12 02:26:31 teapot sysctl: net.ipv4.conf.default.rp_filter = 1 
May 12 02:26:39 teapot kernel: end_request: I/O error, dev hdc, sector 0
May 12 02:26:31 teapot sysctl: kernel.core_uses_pid = 1 
May 12 02:26:39 teapot kernel: PCI: Found IRQ 10 for device 00:0c.0
May 12 02:26:31 teapot rc.sysinit: Configuring kernel parameters:  succeeded 
May 12 02:26:39 teapot kernel: yenta 00:0c.0: Preassigned resource 3 busy, reconfiguring...
May 12 02:26:31 teapot date: Mon May 12 02:26:31 CEST 2003 
May 12 02:26:39 teapot kernel: Yenta IRQ list 08d8, PCI irq10
May 12 02:26:31 teapot rc.sysinit: Setting clock  (localtime): Mon May 12 02:26:31 CEST 2003 succeeded 
May 12 02:26:39 teapot kernel: Socket status: 30000006
May 12 02:26:31 teapot rc.sysinit: Loading default keymap succeeded 
May 12 02:26:39 teapot kernel: PCI: Found IRQ 5 for device 00:0c.1
May 12 02:26:31 teapot rc.sysinit: Setting hostname teapot.felipe-alfaro.com:  succeeded 
May 12 02:26:39 teapot kernel: PCI: Sharing IRQ 5 with 00:09.0
May 12 02:26:31 teapot rc.sysinit: Mounting USB filesystem:  succeeded 
May 12 02:26:39 teapot kernel: yenta 00:0c.1: Preassigned resource 2 busy, reconfiguring...
May 12 02:26:31 teapot fsck: /: clean, 115258/749248 files, 564831/1498061 blocks 
May 12 02:26:39 teapot kernel: yenta 00:0c.1: Preassigned resource 3 busy, reconfiguring...
May 12 02:26:31 teapot rc.sysinit: Checking root filesystem succeeded 
May 12 02:26:39 teapot kernel: Yenta IRQ list 08d8, PCI irq5
May 12 02:26:31 teapot rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
May 12 02:26:39 teapot kernel: Socket status: 30000020
May 12 02:26:31 teapot rc.sysinit: Activating swap partitions:  succeeded 
May 12 02:26:40 teapot kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
May 12 02:26:31 teapot fsck: /dev/hda4: clean, 1684/1651552 files, 1405626/3299349 blocks 
May 12 02:26:40 teapot kernel: PCI: Found IRQ 9 for device 00:07.2
May 12 02:26:31 teapot rc.sysinit: Checking filesystems succeeded 
May 12 02:26:40 teapot kernel: uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 
May 12 02:26:31 teapot rc.sysinit: Mounting local filesystems:  failed 
May 12 02:26:40 teapot kernel: uhci-hcd 00:07.2: irq 9, io base 0000ef80
May 12 02:26:32 teapot rc.sysinit: Enabling swap space:  succeeded 
May 12 02:26:40 teapot kernel: Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
May 12 02:26:32 teapot hdparm:  setting unmaskirq to 1 (on) 
May 12 02:26:40 teapot kernel: uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
May 12 02:26:32 teapot hdparm:  unmaskirq    =  1 (on) 
May 12 02:26:40 teapot kernel: hub 1-0:0: USB hub found
May 12 02:26:32 teapot rc.sysinit: Setting hard drive parameters for hda:  succeeded 
May 12 02:26:40 teapot kernel: hub 1-0:0: 2 ports detected
May 12 02:26:32 teapot hdparm:  HDIO_SET_MULTCOUNT failed: Inappropriate ioctl for device 
May 12 02:26:40 teapot kernel: drivers/usb/core/usb.c: registered new driver hiddev
May 12 02:26:32 teapot hdparm:  setting unmaskirq to 1 (on) 
May 12 02:26:40 teapot kernel: drivers/usb/core/usb.c: registered new driver hid
May 12 02:26:32 teapot hdparm:  unmaskirq    =  1 (on) 
May 12 02:26:40 teapot kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
May 12 02:26:32 teapot hdparm:  HDIO_DRIVE_CMD(setreadahead) failed: Input/output error 
May 12 02:26:40 teapot kernel: mice: PS/2 mouse device common for all mice
May 12 02:26:32 teapot rc.sysinit: Setting hard drive parameters for hdc:  succeeded 
May 12 02:26:40 teapot kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
May 12 02:26:33 teapot init: Entering runlevel: 5 
May 12 02:26:40 teapot kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
May 12 02:26:34 teapot sysctl: net.ipv4.ip_forward = 0 
May 12 02:26:40 teapot kernel: input: AT Set 2 keyboard on isa0060/serio0
May 12 02:26:34 teapot sysctl: net.ipv4.conf.default.rp_filter = 1 
May 12 02:26:40 teapot kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
May 12 02:26:34 teapot sysctl: kernel.core_uses_pid = 1 
May 12 02:26:40 teapot kernel: Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
May 12 02:26:34 teapot network: Setting network parameters:  succeeded 
May 12 02:26:40 teapot kernel: PCI: Found IRQ 5 for device 00:09.0
May 12 02:26:34 teapot network: Bringing up loopback interface:  succeeded 
May 12 02:26:40 teapot kernel: PCI: Sharing IRQ 5 with 00:0c.1
May 12 02:26:35 teapot network: Bringing up interface eth0:  succeeded 
May 12 02:26:40 teapot kernel: ALSA device list:
May 12 02:26:35 teapot ntptimeset[279]: ntpdate 4.1.1c-rc1@1.836 Thu Feb 13 12:17:20 EST 2003 (1) 
May 12 02:26:40 teapot kernel:   #0: Yamaha DS-XG PCI (YMF754) at 0xd084a000, irq 5
May 12 02:26:40 teapot kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May 12 02:26:40 teapot kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
May 12 02:26:40 teapot kernel: TCP: Hash tables configured (established 16384 bind 32768)
May 12 02:26:40 teapot kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
May 12 02:26:40 teapot kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
May 12 02:26:40 teapot kernel: VFS: Mounted root (ext2 filesystem) readonly.
May 12 02:26:40 teapot kernel: Freeing unused kernel memory: 108k freed
May 12 02:26:40 teapot kernel: hub 1-0:0: new USB device on port 1, assigned address 2
May 12 02:26:40 teapot kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-00:07.2-1
May 12 02:26:40 teapot kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
May 12 02:26:40 teapot kernel: hub 1-0:0: new USB device on port 2, assigned address 3
May 12 02:26:40 teapot kernel: hub 1-2:0: USB hub found
May 12 02:26:40 teapot kernel: hub 1-2:0: 2 ports detected
May 12 02:26:40 teapot kernel: Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1
May 12 02:26:40 teapot kernel: blk: queue c0344f7c, I/O limit 4095Mb (mask 0xffffffff)
May 12 02:26:40 teapot kernel: end_request: I/O error, dev hdc, sector 0
May 12 02:26:40 teapot kernel: end_request: I/O error, dev hdc, sector 0
May 12 02:26:40 teapot kernel: hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
May 12 02:26:40 teapot kernel: hdc: drive_cmd: error=0x04Aborted Command 
May 12 02:26:40 teapot kernel: ip_tables: (C) 2000-2002 Netfilter core team
May 12 02:26:40 teapot kernel: ip_tables: (C) 2000-2002 Netfilter core team
May 12 02:26:40 teapot kernel: PCI: Enabling device 06:00.0 (0000 -> 0003)
May 12 02:26:40 teapot kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
May 12 02:26:40 teapot kernel: 06:00.0: 3Com PCI 3CCFE575CT Tornado CardBus at 0x1400. Vers LK1.1.19
May 12 02:26:40 teapot kernel: ip_tables: (C) 2000-2002 Netfilter core team
May 12 02:26:40 teapot kernel: spurious 8259A interrupt: IRQ7.
May 12 02:26:40 teapot kernel: eth0: Setting full-duplex based on MII #0 link partner capability of 01e1.
May 12 02:26:55 teapot kde(pam_unix)[372]: authentication failure; logname= uid=0 euid=0 tty=:0 ruser= rhost=  user=falfaro
May 12 02:26:55 teapot [372]: pam_krb5: authentication succeeds for `falfaro'
May 12 02:26:55 teapot kde(pam_unix)[372]: session opened for user falfaro by (uid=0)
May 12 02:27:06 teapot modprobe: FATAL: Module sound_slot_1 not found. 
May 12 02:27:06 teapot modprobe: FATAL: Module sound_service_1_0 not found. 
May 12 02:27:06 teapot modprobe: FATAL: Module sound_slot_1 not found. 
May 12 02:27:06 teapot modprobe: FATAL: Module sound_service_1_0 not found. 
May 12 02:27:29 teapot kernel: eth0: Transmit error, Tx status register 90.
May 12 02:27:29 teapot kernel:   Flags; bus-master 1, dirty 923(11) current 927(15)
May 12 02:27:29 teapot kernel:   Transmit list 0f37f980 vs. cf37f8e0.
May 12 02:27:29 teapot kernel:   0: @cf37f200  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   1: @cf37f2a0  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   2: @cf37f340  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   3: @cf37f3e0  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   4: @cf37f480  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   5: @cf37f520  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   6: @cf37f5c0  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   7: @cf37f660  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   8: @cf37f700  length 80000036 status 80010036
May 12 02:27:29 teapot kernel:   9: @cf37f7a0  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   10: @cf37f840  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   11: @cf37f8e0  length 80000036 status 00010036
May 12 02:27:29 teapot kernel:   12: @cf37f980  length 80000036 status 00000036
May 12 02:27:29 teapot kernel:   13: @cf37fa20  length 80000036 status 00000036
May 12 02:27:29 teapot kernel:   14: @cf37fac0  length 80000036 status 80000036
May 12 02:27:29 teapot kernel:   15: @cf37fb60  length 80000036 status 00010036
May 12 02:27:29 teapot kernel: eth0: Too much work in interrupt, status e401.
May 12 02:27:40 teapot kernel: Module lockd cannot be unloaded due to unsafe usage in include/linux/module.h:457
May 12 02:28:33 teapot gconfd (falfaro-664): starting (version 2.2.0), pid 664 user 'falfaro'
May 12 02:28:33 teapot gconfd (falfaro-664): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at position 0
May 12 02:28:33 teapot gconfd (falfaro-664): Resolved address "xml:readwrite:/home/falfaro/.gconf" to a writable config source at position 1
May 12 02:28:33 teapot gconfd (falfaro-664): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at position 2
May 12 02:28:37 teapot modprobe: FATAL: Module net_pf_10 not found. 
May 12 02:30:01 teapot su(pam_unix)[692]: session opened for user root by falfaro(uid=500)
May 12 02:30:13 teapot su(pam_unix)[692]: session closed for user root
May 12 02:30:19 teapot su(pam_unix)[739]: session opened for user root by falfaro(uid=500)
May 12 02:35:52 teapot modprobe: FATAL: Module net_pf_10 not found. 
May 12 02:36:14 teapot last message repeated 2 times
May 12 02:36:15 teapot kernel: atkbd.c: Unknown key (set 2, scancode 0x19, on isa0060/serio0) pressed.
May 12 02:36:15 teapot kernel: atkbd.c: Unknown key (set 2, scancode 0x19, on isa0060/serio0) released.
May 12 02:36:19 teapot modprobe: FATAL: Module net_pf_10 not found. 
May 12 02:36:19 teapot modprobe: FATAL: Module net_pf_10 not found. 
May 12 02:36:23 teapot kernel: atkbd.c: Unknown key (set 2, scancode 0x28, on isa0060/serio0) released.
May 12 02:36:43 teapot modprobe: FATAL: Module net_pf_10 not found. 
May 12 02:37:14 teapot last message repeated 2 times
May 12 02:38:47 teapot last message repeated 3 times
May 12 02:38:52 teapot last message repeated 2 times
May 12 02:51:11 teapot su(pam_unix)[739]: session closed for user root
May 12 02:52:30 teapot su(pam_unix)[1238]: session opened for user root by falfaro(uid=500)
May 12 03:11:17 teapot kernel: EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
May 12 03:21:47 teapot kernel: loop: loaded (max 8 devices)
May 12 03:26:55 teapot init: Switching to runlevel: 6
May 12 03:26:55 teapot su(pam_unix)[1238]: session closed for user root
May 12 03:26:55 teapot gconfd (falfaro-664): Received signal 1, shutting down cleanly
May 12 03:26:55 teapot gconfd (falfaro-664): Exiting
May 12 03:26:56 teapot kde(pam_unix)[372]: session closed for user falfaro
May 12 03:26:56 teapot rc: Stopping keytable:  succeeded
May 12 03:26:57 teapot dd: 1+0 records in
May 12 03:26:57 teapot dd: 1+0 records out
May 12 03:26:57 teapot random: Saving random seed:  succeeded
May 12 03:26:57 teapot portmap: portmap shutdown succeeded
May 12 03:26:57 teapot kernel: Kernel logging (proc) stopped.
May 12 03:26:57 teapot kernel: Kernel log daemon terminating.
May 12 03:26:58 teapot syslog: klogd shutdown succeeded
May 12 03:26:59 teapot exiting on signal 15
May 12 11:04:04 teapot syslogd 1.4.1: restart.
May 12 11:04:04 teapot syslog: syslogd startup succeeded
May 12 11:04:04 teapot kernel: klogd 1.4.1, log source = /proc/kmsg started.

--=-qPLxIk7ZSUATUS4zdShy--

