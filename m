Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTCBVvX>; Sun, 2 Mar 2003 16:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTCBVvX>; Sun, 2 Mar 2003 16:51:23 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:12675
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S261456AbTCBVvA>; Sun, 2 Mar 2003 16:51:00 -0500
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SCSI emulation causes kernel panic
Date: Sun, 2 Mar 2003 16:01:24 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_08nY+ZxBtBM7zFF"
Message-Id: <200303021601.24433.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_08nY+ZxBtBM7zFF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings. I haven't been able to find a single version yet in 
the 2.5.x series that allows me to use SCSI emulation without a 
kernel panic...until I tried a strange trick today. Even under 
2.5.63, I still received the panic documented below, until I 
turned on all the options under "Kernel Hacking". Then SCSI 
emulation seems to work fine!

Some details: I have a dual Athlon MP2000 on an ASUS A7M266-D, 
with a new IDE-ATAPI Plexwriter. I have attached the dmesg/klogd 
output, the kernel panic that I painstakingly transcribed by 
hand, and the kernel configuration I used. If there is anything 
else needed...let me know!
---scott
--Boundary-00=_08nY+ZxBtBM7zFF
Content-Type: text/plain;
  charset="us-ascii";
  name="linux-2.5.63-config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.5.63-config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NR_CPUS=2
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_APM is not set

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
# CONFIG_SCx200 is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set

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
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_CARD is not set
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_PNPBIOS is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=10240
CONFIG_BLK_DEV_INITRD=y
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
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
# CONFIG_BLK_DEV_IDEPCI is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

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
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_DM is not set

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
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_XFRM_USER is not set
# CONFIG_IPV6 is not set

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
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
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
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
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
CONFIG_I2C=y
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y

#
# I2C Hardware Sensors Mainboard support
#
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD8111=y

#
# I2C Hardware Sensors Chip support
#
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_LM75=y

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
# CONFIG_INTEL_RNG is not set
CONFIG_AMD_RNG=y
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
# CONFIG_AGP3 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_VIA is not set
CONFIG_AGP_AMD=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=y

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
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
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
# CONFIG_EXPORTFS is not set
# CONFIG_CIFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
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
# CONFIG_NLS_ISO8859_1 is not set
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
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_3DFX=y
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
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
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=y
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
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_STORAGE is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
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
# Video4Linux support is needed for USB Multimedia device support
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
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_CAPABILITIES is not set
# CONFIG_SECURITY_ROOTPLUG is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y

--Boundary-00=_08nY+ZxBtBM7zFF
Content-Type: text/plain;
  charset="us-ascii";
  name="messages.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="messages.txt"

Linux version 2.5.63 (root@schwing.thomasons.org) (gcc version 3.2.1 20021207 (Gentoo Linux 3.2.1-20021207)) #9 SMP Sun Mar 2 14:30:37 CST 2003
Video mode to be used for restore is 30b
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7d40
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
On node 0 totalpages: 262124
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32748 pages, LIFO batch:7
ACPI: RSDP (v000 ASUS                       ) @ 0x000f8490
ACPI: RSDT (v001 ASUS   A7M266-D 12336.12337) @ 0x3ffec000
ACPI: FADT (v001 ASUS   A7M266-D 12336.12337) @ 0x3ffec100
ACPI: BOOT (v001 ASUS   A7M266-D 12336.12337) @ 0x3ffec040
ACPI: MADT (v001 ASUS   A7M266-D 12336.12337) @ 0x3ffec080
ACPI: DSDT (v001   ASUS A7M266-D 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda5 vga=9 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1624.229 MHz processor.
Console: colour VGA+ 132x50
Calibrating delay loop... 3194.88 BogoMIPS
Memory: 1033712k/1048496k available (2197k kernel code, 13888k reserved, 615k data, 348k init, 130992k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Athlon(TM) MP 2000+ stepping 02
per-CPU timeslice cutoff: 731.45 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3244.03 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(TM) MP 2000+ stepping 02
Total of 2 processors activated (6438.91 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1624.0313 MHz.
..... host bus clock speed is 259.0890 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
PCI: PCI BIOS revision 2.10 entry at 0xf1dd0, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030122
    ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.UAR2._STA] (Node c1a6678c), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Linux Plug and Play Support v0.95 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting balanced_irq
Enabling SEP on CPU 0
Enabling SEP on CPU 1
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
fb: 3Dfx Voodoo5 memory = 32768K
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
amd768_rng: AMD768 system management I/O registers at 0xE400.
amd768_rng hardware driver 0.1.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 760MP chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 32M @ 0xfc000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:06.0: 3Com PCI 3c905C Tornado at 0xa000. Vers LK1.1.19
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth1: Intel Corp. 82557/8/9 [Ethernet , 00:A0:C9:3E:D6:7D, IRQ 18.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 661949-004, Physical connectors present: RJ45
  Primary interface chip DP83840A PHY #1.
  DP83840 specific setup, setting register 23 to 8462.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: Maxtor 5T030H3, ATA DISK drive
hdc: IBM-DTLA-307030, ATA DISK drive
hdd: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
hdc: host protected area => 1
hdc: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
 /dev/ide/host1/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W4824A  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ohci-hcd 02:00.0: Advanced Micro Devic AMD-768 [Opus] USB
ohci-hcd 02:00.0: irq 19, pci mem fe83a000
ohci-hcd 02:00.0: new USB bus registered, assigned bus number 1
usb usb1: Product: Advanced Micro Devic AMD-768 [Opus] USB
usb usb1: Manufacturer: Linux 2.5.63 ohci-hcd
usb usb1: SerialNumber: 02:00.0
hub 1-0:0: USB hub found
hub 1-0:0: 4 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 2003 UTC).
es1968: not attempting power management.
hub 1-0:0: new USB device on port 2, assigned address 2
usb 1-2: Product: USB-PS/2 Optical Mouse
usb 1-2: Manufacturer: Logitech
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-02:00.0-2
es1968: clocking to 48000
ALSA device list:
  #0: ESS ES1978 (Maestro 2E) at 0x9800, irq 19
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
md: Autodetecting RAID arrays.
md: autorun ...
md: considering ide/host1/bus0/target0/lun0/part6 ...
md:  adding ide/host1/bus0/target0/lun0/part6 ...
md: ide/host1/bus0/target0/lun0/part5 has different UUID to ide/host1/bus0/target0/lun0/part6
md: ide/host1/bus0/target0/lun0/part3 has different UUID to ide/host1/bus0/target0/lun0/part6
md:  adding ide/host0/bus0/target0/lun0/part7 ...
md: ide/host0/bus0/target0/lun0/part6 has different UUID to ide/host1/bus0/target0/lun0/part6
md: ide/host0/bus0/target0/lun0/part2 has different UUID to ide/host1/bus0/target0/lun0/part6
md: created md2
md: bind<ide/host0/bus0/target0/lun0/part7>
md: bind<ide/host1/bus0/target0/lun0/part6>
md: running: <ide/host1/bus0/target0/lun0/part6><ide/host0/bus0/target0/lun0/part7>
md2: max total readahead window set to 2048k
md2: 2 data-disks, max readahead per data-disk: 1024k
md2: setting max_sectors to 512, segment boundary to 131071
raid0: looking at ide/host1/bus0/target0/lun0/part6
raid0:   comparing ide/host1/bus0/target0/lun0/part6(3076352) with ide/host1/bus0/target0/lun0/part6(3076352)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at ide/host0/bus0/target0/lun0/part7
raid0:   comparing ide/host0/bus0/target0/lun0/part7(3076352) with ide/host1/bus0/target0/lun0/part6(3076352)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 6152704 blocks.
raid0 : conf->smallest->size is 6152704 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: marking sb clean...
md: marking sb clean...
md: updating md2 RAID superblock on device (in sync 1)
md: ide/host1/bus0/target0/lun0/part6 <6>(write) ide/host1/bus0/target0/lun0/part6's sb offset: 3076352
md: ide/host0/bus0/target0/lun0/part7 <6>(write) ide/host0/bus0/target0/lun0/part7's sb offset: 3076352
md: considering ide/host1/bus0/target0/lun0/part5 ...
md:  adding ide/host1/bus0/target0/lun0/part5 ...
md: ide/host1/bus0/target0/lun0/part3 has different UUID to ide/host1/bus0/target0/lun0/part5
md:  adding ide/host0/bus0/target0/lun0/part6 ...
md: ide/host0/bus0/target0/lun0/part2 has different UUID to ide/host1/bus0/target0/lun0/part5
md: created md1
md: bind<ide/host0/bus0/target0/lun0/part6>
md: bind<ide/host1/bus0/target0/lun0/part5>
md: running: <ide/host1/bus0/target0/lun0/part5><ide/host0/bus0/target0/lun0/part6>
md1: max total readahead window set to 2048k
md1: 2 data-disks, max readahead per data-disk: 1024k
md1: setting max_sectors to 512, segment boundary to 131071
raid0: looking at ide/host1/bus0/target0/lun0/part5
raid0:   comparing ide/host1/bus0/target0/lun0/part5(3076352) with ide/host1/bus0/target0/lun0/part5(3076352)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at ide/host0/bus0/target0/lun0/part6
raid0:   comparing ide/host0/bus0/target0/lun0/part6(3076352) with ide/host1/bus0/target0/lun0/part5(3076352)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 6152704 blocks.
raid0 : conf->smallest->size is 6152704 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: marking sb clean...
md: marking sb clean...
md: updating md1 RAID superblock on device (in sync 1)
md: ide/host1/bus0/target0/lun0/part5 <6>(write) ide/host1/bus0/target0/lun0/part5's sb offset: 3076352
md: ide/host0/bus0/target0/lun0/part6 <6>(write) ide/host0/bus0/target0/lun0/part6's sb offset: 3076352
md: considering ide/host1/bus0/target0/lun0/part3 ...
md:  adding ide/host1/bus0/target0/lun0/part3 ...
md:  adding ide/host0/bus0/target0/lun0/part2 ...
md: created md0
md: bind<ide/host0/bus0/target0/lun0/part2>
md: bind<ide/host1/bus0/target0/lun0/part3>
md: running: <ide/host1/bus0/target0/lun0/part3><ide/host0/bus0/target0/lun0/part2>
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at ide/host1/bus0/target0/lun0/part3
raid0:   comparing ide/host1/bus0/target0/lun0/part3(8193024) with ide/host1/bus0/target0/lun0/part3(8193024)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at ide/host0/bus0/target0/lun0/part2
raid0:   comparing ide/host0/bus0/target0/lun0/part2(8193024) with ide/host1/bus0/target0/lun0/part3(8193024)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 16386048 blocks.
raid0 : conf->smallest->size is 16386048 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: marking sb clean...
md: marking sb clean...
md: updating md0 RAID superblock on device (in sync 1)
md: ide/host1/bus0/target0/lun0/part3 <6>(write) ide/host1/bus0/target0/lun0/part3's sb offset: 8193024
md: ide/host0/bus0/target0/lun0/part2 <6>(write) ide/host0/bus0/target0/lun0/part2's sb offset: 8193024
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 348k freed
Adding 1020116k swap on /dev/hdc2.  Priority:-1 extents:1
Adding 1020116k swap on /dev/hda3.  Priority:-2 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on md(9,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on md(9,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--Boundary-00=_08nY+ZxBtBM7zFF
Content-Type: text/plain;
  charset="us-ascii";
  name="panic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="panic.txt"

Unable to handle kernel NULL pointer dereference at virtual address 00000000 printing eip: 00000000
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0060: [<00000000>] Not tainted
EFLAGS: 00010246
eax: c03fb628  ebx: c03fb9c8  ecx: f7c50040  edx: 00000174
esi: f7d14780  edi: f7d50040  ebp: 00000001  esp: c037dea8
ds: 007b  es: 007b  ss: 0068
Process swapper (pid: 0, threadinfo= c037c000,  task= c0356680)
Stack: c023bae3 c03fb9c8 00000174 f7d147c0
       c03fb9c8 f7d506a4 c03fb9c8 00000000
       f7d500c0 0000000f c021ca99 c03fb9c8
       f7d14780 00000000 00000088 0000001e
       c1b0ecc0 f7d500c0 c03fb9c8 c1b0ecc0
       c021cca0 c03fb9c8 f7d500c0 c03fbb0c
Call trace: c023bae3 c021ca99 c021cca0 c021d2cd
            c023b530 c010d158 c010d41b c0108b70 
	    c0108b70 c010bbdc c0108b70 c0108b70 
	    c0108b9a c0108c2a c0105000
Code: Bad EIP value
<0>Kernel Panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--Boundary-00=_08nY+ZxBtBM7zFF--

