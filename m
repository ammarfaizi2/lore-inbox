Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263873AbSJHVMQ>; Tue, 8 Oct 2002 17:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263875AbSJHVMQ>; Tue, 8 Oct 2002 17:12:16 -0400
Received: from smtp1.libero.it ([193.70.192.51]:11449 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S263873AbSJHVLz>;
	Tue, 8 Oct 2002 17:11:55 -0400
Message-ID: <3DA34A9B.4471DDE4@inwind.it>
Date: Tue, 08 Oct 2002 23:14:03 +0200
From: Luca Montecchiani <cbm64@inwind.it>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.41] Call Trace on boot, oops on shutdown, no linux-logo
Content-Type: multipart/mixed;
 boundary="------------DD9F31EB24C7A3AD62188B27"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DD9F31EB24C7A3AD62188B27
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've got the attached call trace ( __might_sleep ) early on boot.

Rebooting the PC I've got an oops after umount (EIP: driverfs-removefile)
anyway the filesystem status seem to be properly cleaned.

Another minimal noise is the lack of the vesa linux-logo vga=0x305
and the KDE sysmonitor breakage ;)

I'm using a vanilla RH 7.3 with the attached kernel config

ciao,
luca
--------------DD9F31EB24C7A3AD62188B27
Content-Type: text/plain; charset=us-ascii;
 name="config.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config.txt"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=y
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_MCE is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_PM=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_SCx200 is not set
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set

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
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NFORCE is not set
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
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old non-SCSI/ATAPI CD-ROM drives
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
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
# CONFIG_IPV6 is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_IPX_INTERN is not set
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
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
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
CONFIG_ISDN_BOOL=y

#
# Old ISDN4Linux
#
CONFIG_ISDN=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
# CONFIG_ISDN_MPP is not set
CONFIG_ISDN_PPP_BSDCOMP=y
# CONFIG_ISDN_AUDIO is not set

#
# ISDN feature submodules
#
# CONFIG_ISDN_DRV_LOOP is not set
# CONFIG_ISDN_DIVERSION is not set

#
# CAPI subsystem
#
# CONFIG_ISDN_CAPI is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=y

#
#   D-channel protocol features
#
# CONFIG_HISAX_EURO is not set
# CONFIG_HISAX_1TR6 is not set
# CONFIG_HISAX_NI1 is not set
CONFIG_HISAX_MAX_CARDS=8

#
#   HiSax supported cards
#
# CONFIG_HISAX_16_0 is not set
# CONFIG_HISAX_16_3 is not set
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
# CONFIG_HISAX_AVM_A1 is not set
# CONFIG_HISAX_FRITZPCI is not set
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
CONFIG_HISAX_ELSA=y
# CONFIG_HISAX_IX1MICROR2 is not set
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_ASUSCOM is not set
# CONFIG_HISAX_TELEINT is not set
# CONFIG_HISAX_HFCS is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_SPORTSTER is not set
# CONFIG_HISAX_MIC is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
# CONFIG_HISAX_ISURF is not set
# CONFIG_HISAX_HSTSAPHIR is not set
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
# CONFIG_HISAX_GAZEL is not set
# CONFIG_HISAX_HFC_PCI is not set
# CONFIG_HISAX_W6692 is not set
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_ENTERNOW_PCI is not set
# CONFIG_HISAX_DEBUG is not set
# CONFIG_HISAX_ST5481 is not set
# CONFIG_HISAX_FRITZ_PCIPNP is not set
# CONFIG_HISAX_FRITZ_CLASSIC is not set
# CONFIG_HISAX_HFCPCI is not set

#
# Active cards
#
# CONFIG_ISDN_DRV_ICN is not set
# CONFIG_ISDN_DRV_PCBIT is not set
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
# CONFIG_ISDN_DRV_EICON is not set
# CONFIG_ISDN_DRV_TPAM is not set
# CONFIG_HYSDN is not set

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
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_VORTEX=m
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

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
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
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
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_RNG is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
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
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_ACCEL=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=y

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_RTCTIMER is not set
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
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

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
CONFIG_SND_TRIDENT=m
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_LONG_TIMEOUT=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD_ALT=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

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
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY_CAPABILITIES=y

#
# Library routines
#
CONFIG_CRC32=m
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set
CONFIG_X86_BIOS_REBOOT=y



--------------DD9F31EB24C7A3AD62188B27
Content-Type: text/plain; charset=us-ascii;
 name="dmesg_call_trace.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_call_trace.txt"

Oct  8 21:43:43 localhost kernel: Linux version 2.5.41 (root@localhost.localdomain) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #6 Tue Oct 8 21:23:56 CEST 2002
Oct  8 21:43:43 localhost kernel: Video mode to be used for restore is 305
Oct  8 21:43:43 localhost kernel: BIOS-provided physical RAM map:
Oct  8 21:43:43 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Oct  8 21:43:43 localhost kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Oct  8 21:43:43 localhost kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Oct  8 21:43:43 localhost kernel:  BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
Oct  8 21:43:43 localhost kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Oct  8 21:43:43 localhost kernel: 128MB LOWMEM available.
Oct  8 21:43:43 localhost kernel: On node 0 totalpages: 32768
Oct  8 21:43:43 localhost kernel:   DMA zone: 4096 pages
Oct  8 21:43:43 localhost kernel:   Normal zone: 28672 pages
Oct  8 21:43:43 localhost kernel:   HighMem zone: 0 pages
Oct  8 21:43:43 localhost kernel: Building zonelist for node : 0
Oct  8 21:43:43 localhost kernel: Kernel command line: ro root=/dev/hdb2 hdd=ide-scsi vga=0x305 pci=usepirqmask
Oct  8 21:43:43 localhost kernel: ide_setup: hdd=ide-scsi
Oct  8 21:43:43 localhost kernel: No local APIC present or hardware disabled
Oct  8 21:43:43 localhost kernel: Initializing CPU#0
Oct  8 21:43:43 localhost kernel: Detected 400.772 MHz processor.
Oct  8 21:43:43 localhost kernel: Console: colour dummy device 80x25
Oct  8 21:43:43 localhost kernel: Calibrating delay loop... 794.62 BogoMIPS
Oct  8 21:43:43 localhost kernel: Memory: 126316k/131072k available (1447k kernel code, 4368k reserved, 361k data, 288k init, 0k highmem)
Oct  8 21:43:43 localhost kernel: Security Scaffold v1.0.0 initialized
Oct  8 21:43:43 localhost kernel: Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Oct  8 21:43:43 localhost kernel: Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Oct  8 21:43:43 localhost kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct  8 21:43:43 localhost kernel: CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
Oct  8 21:43:43 localhost kernel: CPU: AMD-K6(tm) 3D processor stepping 0c
Oct  8 21:43:43 localhost kernel: Checking 'hlt' instruction... OK.
Oct  8 21:43:43 localhost kernel: POSIX conformance testing by UNIFIX
Oct  8 21:43:43 localhost kernel: Linux NET4.0 for Linux 2.4
Oct  8 21:43:43 localhost kernel: Based upon Swansea University Computer Society NET3.039
Oct  8 21:43:43 localhost kernel: Initializing RT netlink socket
Oct  8 21:43:43 localhost kernel: mtrr: v2.0 (20020519)
Oct  8 21:43:43 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
Oct  8 21:43:43 localhost kernel: PCI: Using configuration type 1
Oct  8 21:43:43 localhost kernel: PCI: Probing PCI hardware
Oct  8 21:43:43 localhost kernel: PCI: Probing PCI hardware (bus 00)
Oct  8 21:43:43 localhost kernel: PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
Oct  8 21:43:43 localhost keytable: Loading keymap:  succeeded
Oct  8 21:43:43 localhost kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Oct  8 21:43:43 localhost kernel: Starting kswapd
Oct  8 21:43:43 localhost kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Oct  8 21:43:43 localhost kernel: biovec pool[0]:   1 bvecs: 244 entries (12 bytes)
Oct  8 21:43:43 localhost kernel: biovec pool[1]:   4 bvecs: 244 entries (48 bytes)
Oct  8 21:43:43 localhost kernel: biovec pool[2]:  16 bvecs: 244 entries (192 bytes)
Oct  8 21:43:43 localhost kernel: biovec pool[3]:  64 bvecs: 244 entries (768 bytes)
Oct  8 21:43:43 localhost kernel: biovec pool[4]: 128 bvecs: 122 entries (1536 bytes)
Oct  8 21:43:43 localhost kernel: biovec pool[5]: 256 bvecs:  61 entries (3072 bytes)
Oct  8 21:43:43 localhost kernel: aio_setup: sizeof(struct page) = 40
Oct  8 21:43:43 localhost kernel: Capability LSM initialized
Oct  8 21:43:43 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Oct  8 21:43:43 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct  8 21:43:43 localhost kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Oct  8 21:43:43 localhost kernel: parport0: PC-style at 0x378 [PCSPP,EPP]
Oct  8 21:43:43 localhost kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xc8800000, size 4096k
Oct  8 21:43:43 localhost kernel: vesafb: mode is 1024x768x8, linelength=1024, pages=3
Oct  8 21:43:43 localhost kernel: vesafb: protected mode interface info at c000:7560
Oct  8 21:43:43 localhost kernel: vesafb: scrolling: redraw
Oct  8 21:43:43 localhost kernel: Console: switching to colour frame buffer device 128x48
Oct  8 21:43:43 localhost kernel: fb0: VESA VGA frame buffer device
Oct  8 21:43:43 localhost kernel: pty: 256 Unix98 ptys configured
Oct  8 21:43:43 localhost kernel: lp0: using parport0 (polling).
Oct  8 21:43:43 localhost kernel: block request queues:
Oct  8 21:43:43 localhost kernel:  128 requests per read queue
Oct  8 21:43:43 localhost kernel:  128 requests per write queue
Oct  8 21:43:43 localhost kernel:  8 requests per batch
Oct  8 21:43:43 localhost kernel:  enter congestion at 31
Oct  8 21:43:43 localhost kernel:  exit congestion at 33
Oct  8 21:43:43 localhost kernel: Floppy drive(s): fd0 is 1.44M
Oct  8 21:43:43 localhost kernel: FDC 0 is a post-1991 82077
Oct  8 21:43:43 localhost kernel: loop: loaded (max 8 devices)
Oct  8 21:43:43 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct  8 21:43:43 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct  8 21:43:43 localhost kernel: ALI15X3: IDE controller at PCI slot 00:0f.0
Oct  8 21:43:43 localhost kernel: PCI: Assigned IRQ 5 for device 00:0f.0
Oct  8 21:43:43 localhost kernel: ALI15X3: chipset revision 32
Oct  8 21:43:43 localhost kernel: ALI15X3: not 100%% native mode: will probe irqs later
Oct  8 21:43:43 localhost kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Oct  8 21:43:43 localhost kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:DMA
Oct  8 21:43:43 localhost kernel: hdb: C/H/S=19710/16/255 from BIOS ignored
Oct  8 21:43:43 localhost kernel: hda: WDC WD300BB-32AUA1, ATA DISK drive
Oct  8 21:43:43 localhost kernel: hdb: IC35L040AVER07-0, ATA DISK drive
Oct  8 21:43:43 localhost kernel: Debug: sleeping function called from illegal context at mm/slab.c:1374
Oct  8 21:43:43 localhost kernel: Call Trace:
Oct  8 21:43:43 localhost kernel:  [<c01169f2>] __might_sleep+0x52/0x60
Oct  8 21:43:43 localhost kernel:  [<c01330c6>] kmem_cache_alloc+0x26/0x1b0
Oct  8 21:43:43 localhost kernel:  [<c01bd23f>] ide_config_drive_speed+0x22f/0x3e0
Oct  8 21:43:43 localhost kernel:  [<c01ad37a>] blk_init_free_list+0x4a/0xf0
Oct  8 21:43:43 localhost kernel:  [<c01ad42c>] blk_init_queue+0xc/0xe0
Oct  8 21:43:43 localhost kernel:  [<c01bb5c8>] ide_init_queue+0x28/0x70
Oct  8 21:43:43 localhost kernel:  [<c01c1ce0>] do_ide_request+0x0/0x20
Oct  8 21:43:43 localhost kernel:  [<c01bb890>] init_irq+0x280/0x330
Oct  8 21:43:43 localhost kernel:  [<c01bbc10>] hwif_init+0x100/0x230
Oct  8 21:43:43 localhost kernel:  [<c01bb4ec>] probe_hwif_init+0x1c/0x70
Oct  8 21:43:43 localhost kernel:  [<c01cc17a>] ide_setup_pci_device+0x3a/0x70
Oct  8 21:43:43 localhost kernel:  [<c010509b>] init+0x3b/0x1a0
Oct  8 21:43:43 localhost kernel:  [<c0105060>] init+0x0/0x1a0
Oct  8 21:43:43 localhost kernel:  [<c01054fd>] kernel_thread_helper+0x5/0x18
Oct  8 21:43:43 localhost kernel: 
Oct  8 21:43:43 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct  8 21:43:43 localhost kernel: hdd: PCRW404, ATAPI CD/DVD-ROM drive
Oct  8 21:43:43 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct  8 21:43:43 localhost kernel: hda: host protected area => 1
Oct  8 21:43:43 localhost keytable: Loading system font:  succeeded
Oct  8 21:43:43 localhost kernel: hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, (U)DMA
Oct  8 21:43:43 localhost kernel:  hda: hda1 hda2 hda3 hda4
Oct  8 21:43:43 localhost kernel: hdb: host protected area => 1
Oct  8 21:43:43 localhost kernel: hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, (U)DMA
Oct  8 21:43:43 localhost kernel:  hdb: hdb1 hdb2
Oct  8 21:43:43 localhost kernel: mice: PS/2 mouse device common for all mice
Oct  8 21:43:43 localhost kernel: input: PS2++ Logitech Wheel Mouse on isa0060/serio1
Oct  8 21:43:43 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct  8 21:43:43 localhost kernel: input: AT Set 2 keyboard on isa0060/serio0
Oct  8 21:43:43 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct  8 21:43:43 localhost kernel: ISDN subsystem Rev: 1.114.6.16/1.94.6.9/1.140.6.11/1.85.6.9/none/1.5.6.4
Oct  8 21:43:43 localhost kernel: PPP BSD Compression module registered
Oct  8 21:43:43 localhost kernel: HiSax: Linux Driver for passive ISDN cards
Oct  8 21:43:43 localhost kernel: HiSax: Version 3.5 (kernel)
Oct  8 21:43:43 localhost kernel: HiSax: Layer1 Revision 2.41.6.5
Oct  8 21:43:43 localhost kernel: HiSax: Layer2 Revision 2.25.6.4
Oct  8 21:43:43 localhost kernel: HiSax: TeiMgr Revision 2.17.6.3
Oct  8 21:43:43 localhost kernel: HiSax: Layer3 Revision 2.17.6.5
Oct  8 21:43:43 localhost kernel: HiSax: LinkLayer Revision 2.51.6.6
Oct  8 21:43:43 localhost kernel: HiSax: Approval certification failed because of
Oct  8 21:43:43 localhost kernel: HiSax: unauthorized source code changes
Oct  8 21:43:43 localhost kernel: HiSax: Card 1 Protocol NONE Id=HiSax (0)
Oct  8 21:43:43 localhost kernel: HiSax: Elsa driver Rev. 2.26.6.6
Oct  8 21:43:43 localhost kernel: Elsa: Microlink IO probing
Oct  8 21:43:43 localhost kernel: Elsa: Probing IO 0x160 failed
Oct  8 21:43:43 localhost kernel: Elsa: Probing Port 0x170: already in use
Oct  8 21:43:43 localhost kernel: Elsa: Probing IO 0x260 failed
Oct  8 21:43:43 localhost kernel: Elsa: Probing IO 0x360 failed
Oct  8 21:43:43 localhost kernel: No Elsa Microlink found
Oct  8 21:43:44 localhost kernel: HiSax: Card Elsa ML not installed !
Oct  8 21:43:44 localhost kernel: Advanced Linux Sound Architecture Driver Version 0.9.0rc3 (Fri Oct 04 13:09:13 2002 UTC).
Oct  8 21:43:44 localhost kernel: ALSA device list:
Oct  8 21:43:44 localhost kernel:   No soundcards found.
Oct  8 21:43:44 localhost kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct  8 21:43:44 localhost kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Oct  8 21:43:44 localhost kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
Oct  8 21:43:44 localhost kernel: TCP: Hash tables configured (established 8192 bind 8192)
Oct  8 21:43:44 localhost kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Oct  8 21:43:44 localhost kernel: VFS: Mounted root (ext2 filesystem) readonly.
Oct  8 21:43:44 localhost kernel: Freeing unused kernel memory: 288k freed
Oct  8 21:43:44 localhost kernel: Real Time Clock Driver v1.11
Oct  8 21:43:44 localhost kernel: Adding 264592k swap on /dev/hda4.  Priority:-1 extents:1
Oct  8 21:43:44 localhost kernel: drivers/usb/core/usb.c: registered new driver usbfs
Oct  8 21:43:44 localhost kernel: drivers/usb/core/usb.c: registered new driver hub
Oct  8 21:43:44 localhost kernel: SCSI subsystem driver Revision: 1.00
Oct  8 21:43:44 localhost kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Oct  8 21:43:44 localhost kernel:   Vendor: PHILIPS   Model: PCRW404           Rev: 1.5B
Oct  8 21:43:44 localhost kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct  8 21:43:44 localhost kernel: hdd: DMA disabled


--------------DD9F31EB24C7A3AD62188B27--



