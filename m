Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130190AbRARDHB>; Wed, 17 Jan 2001 22:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131049AbRARDGv>; Wed, 17 Jan 2001 22:06:51 -0500
Received: from mail.cybermesa.com ([198.59.109.2]:62947 "EHLO
	mail.cybermesa.com") by vger.kernel.org with ESMTP
	id <S130190AbRARDGj>; Wed, 17 Jan 2001 22:06:39 -0500
Message-ID: <3A665DE5.BF9AC8E4@cybermesa.com>
Date: Wed, 17 Jan 2001 20:07:17 -0700
From: Markus Berndt <berndt@cybermesa.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops report (2.4.1-pre7)
Content-Type: multipart/mixed;
 boundary="------------6E310F5E9471711C2DACBCE0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6E310F5E9471711C2DACBCE0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

My hardware:
    AMD Athlon K7 550
    Shuttle AI61 (AMD750 based main board)
    Diamond A200 Graphics card (Savage4 based)
    Aopen Realtec 8139 based ethernet card

The Oops happens every time I do a cold boot.
Most of the time, a warm start (pressing the reset button)
makes the machine boot o.k.

Here's the output of the Oops after running it through
ksymoops...


ksymoops 2.3.7 on i686 2.4.1-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre7/ (default)
     -m /home/scratch/linux/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
Warning (compare_maps): ksyms_base symbol
machine_real_restart_R__ver_machine_real_restart not found in
System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address
0000003b printing eip:
c01d3a2c
*pde = 00000000
Oops: 0000
CPU:    0
EIP: 0010:[<c01d3a2c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
ds: 0018  es: 0018  ss: 0018
Stack: 0000001f 00000007 f7fbf000 c1effd2c f7fbf000 c02a992d f7fbf000
00000000
       00000000 c1effd2c 70061022 c02a99a0 c1effd2c 00000000 c1effd2c
00000000
       00000000 00000000 00000000 c1ef8540 80000000 c02a9a62 c1effd2c
c1ef8540
Call Trace: [<c0105000>] [<c0107007>] [<c01074f3>]
Code: 0f b6 40 3c 50 68 d6 fe 25 c0 8d b3 64 02 00 00 56 e8 fe 07

>>EIP; c01d3a2c <pci_setup_device+1c/150>   <=====
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0107007 <init+7/150>
Trace; c01074f3 <kernel_thread+23/30>
Code;  c01d3a2c <pci_setup_device+1c/150>
00000000 <_EIP>:
Code;  c01d3a2c <pci_setup_device+1c/150>   <=====
   0:   0f b6 40 3c               movzbl 0x3c(%eax),%eax   <=====
Code;  c01d3a30 <pci_setup_device+20/150>
   4:   50                        push   %eax
Code;  c01d3a31 <pci_setup_device+21/150>
   5:   68 d6 fe 25 c0            push   $0xc025fed6
Code;  c01d3a36 <pci_setup_device+26/150>
   a:   8d b3 64 02 00 00         lea    0x264(%ebx),%esi
Code;  c01d3a3c <pci_setup_device+2c/150>
  10:   56                        push   %esi
Code;  c01d3a3d <pci_setup_device+2d/150>
  11:   e8 fe 07 00 00            call   814 <_EIP+0x814> c01d4240
<proc_bus_pci_read+50/1b0>

Kernel panic: Attempting to kill init!

2 warnings issued.  Results may not be reliable.



The kernel configuration file is included as an attachment. I also
included the output of dmesg for when the kernel boots after a warm
start
and the contents of /proc/pci in the same case.

Please CC me on responses to this oops report as I am not subscribed
to the kernel-list.

Thanks,
        Markus




--------------6E310F5E9471711C2DACBCE0
Content-Type: text/plain; charset=us-ascii;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

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
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
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
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
# CONFIG_IP_NF_FTP is not set
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_STATE is not set
CONFIG_IP_NF_FILTER=y
# CONFIG_IP_NF_TARGET_REJECT is not set
# CONFIG_IP_NF_NAT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_TARGET_LOG is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

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
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD7409=y
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_BLK_DEV_OSB4 is not set
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
# SCSI support
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
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
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
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
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

#
# I2O device support
#
# CONFIG_I2O is not set

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
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139TOO=y
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
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
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#

#
# Game port support
#

#
# Gameport joysticks
#

#
# Serial port support
#

#
# Serial port joysticks
#

#
# Parallel port joysticks
#

#
#   Parport support is needed for parallel port joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
CONFIG_AGP_AMD=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

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
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
CONFIG_SOUND_ES1371=y
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI_ALT=y
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=y
# CONFIG_USB_SCANNER is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set

--------------6E310F5E9471711C2DACBCE0
Content-Type: text/plain; charset=us-ascii;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.1-pre7 (root@werner) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Tue Jan 16 16:12:18 MST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000017ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000017ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000017ff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01667000)
Kernel command line: BOOT_IMAGE=linux ro root=302 ide0=ata66 hdc=ide-scsi hdd=ide-scsi mem=384M
ide_setup: ide0=ata66
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 548.943 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1094.45 BogoMIPS
Memory: 384204k/393216k available (1182k kernel code, 8624k reserved, 430k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0081f9ff c0c1f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: After generic, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: Common caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: AMD-K7(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb620, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router default [1022/7006] at 00:00.0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.2 present.
39 structures occupying 976 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.00 PG
BIOS Release: 03/27/00
Board Vendor: Shuttle Inc..
Board Name: AMD-75X-W977.
Board Version: 6A6S2H29.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 255098kB/124026kB, 768 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
AMD7409: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD307AA-00BAA0, ATA DISK drive
hdc: SONY CD-ROM CDU4821, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=3739/255/63, UDMA(66)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139too Fast Ethernet driver 0.9.13 loaded
eth0: RealTek RTL8139 Fast Ethernet at 0xd8800000, 00:48:54:65:86:ec, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139B'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 322M
agpgart: Detected AMD Irongate chipset
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] AGP 0.99 on AMD Irongate @ 0xd0000000 128MB
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
es1371: version v0.27 time 16:14:23 Jan 16 2001
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xe800 irq 5
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
usb.c: registered new driver hub
usb.c: registered new driver dc2xx
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack (3072 buckets, 24576 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 530104k swap-space (priority -1)
PPP: VJ decompression error
PPP: VJ decompression error

--------------6E310F5E9471711C2DACBCE0
Content-Type: text/plain; charset=us-ascii;
 name="proc.pci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.pci"

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 37).
      Master Capable.  Latency=32.  
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].
      Prefetchable 32 bit memory at 0xe2000000 [0xe2000fff].
      I/O at 0xe000 [0xe003].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 1).
      Master Capable.  Latency=32.  Min Gnt=14.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 1).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 3).
      Master Capable.  Latency=32.  
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 3).
      Master Capable.  Latency=32.  
  Bus  0, device   7, function  4:
    USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB (rev 6).
      IRQ 9.
      Master Capable.  Latency=16.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe2001000 [0xe2001fff].
  Bus  0, device   8, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xe2002000 [0xe20020ff].
  Bus  0, device  10, function  0:
    Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xe800 [0xe83f].
  Bus  1, device   5, function  0:
    VGA compatible controller: S3 Inc. Savage 4 (rev 3).
      IRQ 10.
      Master Capable.  Latency=248.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe107ffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].

--------------6E310F5E9471711C2DACBCE0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
