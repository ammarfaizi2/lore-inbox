Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSLIJsw>; Mon, 9 Dec 2002 04:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbSLIJsw>; Mon, 9 Dec 2002 04:48:52 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:42976 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265012AbSLIJsa>;
	Mon, 9 Dec 2002 04:48:30 -0500
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: BUG in 2.5.50
Date: Mon, 9 Dec 2002 10:56:08 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_KLJUUUQMWXZKMERBRP8G"
Message-Id: <200212091056.08860.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_KLJUUUQMWXZKMERBRP8G
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi

installed 2.5.50 and got an OOPS after a short while. .
config is attached as tonjeconfig
/var/log/messages including dmesg and oops is attached as tonje_messages

thanks

roy

Dec  8 17:52:06 tonje kernel: ------------[ cut here ]------------
Dec  8 17:52:06 tonje kernel: kernel BUG at drivers/ide/ide-dma.c:705!
Dec  8 17:52:06 tonje kernel: invalid operand: 0000
Dec  8 17:52:06 tonje kernel: CPU:    0
Dec  8 17:52:06 tonje kernel: EIP:    0060:[__ide_dma_read+94/224]    Not=
=20
tainted
Dec  8 17:52:06 tonje kernel: EFLAGS: 00010286
Dec  8 17:52:06 tonje kernel: eax: c151ee80   ebx: c04b270c   ecx: 000010=
00  =20
edx: 0000c002
Dec  8 17:52:06 tonje kernel: esi: c04b2660   edi: df59da80   ebp: c04b27=
0c  =20
esp: d5e7dd24
Dec  8 17:52:06 tonje kernel: ds: 0068   es: 0068   ss: 0068
Dec  8 17:52:06 tonje kernel: Process cp (pid: 1203, threadinfo=3Dd5e7c00=
0=20
task=3Dde78a1c0)
Dec  8 17:52:06 tonje kernel: Stack: 00000001 c04b2660 df590008 000001f4=20
c02b3223 c04b270c c04b270c 0105d598
Dec  8 17:52:06 tonje kernel:        df59e200 d5e7ddd8 0105d598 df59e200=20
00e7ddd8 4088271c c02a8e0d d5e7dd84
Dec  8 17:52:06 tonje kernel:        c04b270c c02a8e68 c04b270c df59e200=20
0105d598 df59e200 c04b2660 c04b270c
Dec  8 17:52:06 tonje kernel: Call Trace: [do_rw_disk+1091/1776] =20
[start_request+157/352]  [start_request+248/352]  [ide_do_request+872/960=
] =20
[do_ide_request
+18/32]  [generic_unplug_device+58/96]  [blk_run_queues+136/192] =20
[do_page_cache_readahead+304/336]  [page_cache_readahead+210/304] =20
[do_generic_mapping_read
+104/880]  [__generic_file_aio_read+445/480]  [file_read_actor+0/256] =20
[generic_file_read+123/160]  [sys_fstat64+37/48]  [vfs_read+194/352] =20
[sys_read+42/64]
  [syscall_call+7/11]
Dec  8 17:52:06 tonje kernel: Code: 0f 0b c1 02 78 b8 3b c0 68 80 62 2b c=
0 68=20
20 4e 00 00 68 10
Dec  8 17:52:09 tonje kernel:  <7>evbug.c: Event. Dev: usb-00:07.3-1/inpu=
t0,=20
Type: 1, Code: 42, Value: 1

--=20
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

--------------Boundary-00=_KLJUUUQMWXZKMERBRP8G
Content-Type: text/plain;
  charset="us-ascii";
  name="tonjeconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tonjeconfig"

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
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
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
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
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
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_24_API=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_SPEEDSTEP is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
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
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_PROCESSOR_PERF=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PM=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
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
# CONFIG_ISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNP_DEBUG=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
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
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
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
CONFIG_BLK_DEV_VIA82CXXX=y
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
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
# CONFIG_I2O_LAN is not set
CONFIG_I2O_PROC=m

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
# CONFIG_NETFILTER is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_XFRM_USER=m
# CONFIG_IPV6 is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
CONFIG_IP_SCTP=y
# CONFIG_SCTP_ADLER32 is not set
CONFIG_SCTP_DBG_MSG=y
CONFIG_SCTP_DBG_OBJCNT=y
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

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_SMC=y
CONFIG_NET_VENDOR_RACAL=y

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=y
CONFIG_WINBOND_840=y
CONFIG_DM9102=y
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=y
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
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
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=m
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
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y

#
# Mice
#
CONFIG_BUSMOUSE=y
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_SOFT_WATCHDOG=y
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_RNG is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
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
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
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
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_CIFS=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="iso8859-15"
# CONFIG_NCP_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_ZISOFS_FS=m
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y

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
CONFIG_NLS_DEFAULT="iso8859-15"
# CONFIG_NLS_CODEPAGE_437 is not set
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
CONFIG_NLS_CODEPAGE_865=m
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
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

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
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set

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
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

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
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_KALLSYMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_CAPABILITIES=y

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TEST=y

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--------------Boundary-00=_KLJUUUQMWXZKMERBRP8G
Content-Type: text/plain;
  charset="us-ascii";
  name="tonje_messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tonje_messages"

Dec  8 17:39:29 tonje syslogd 1.4.1#10: restart.
Dec  8 17:39:29 tonje kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Dec  8 17:39:29 tonje kernel: Inspecting /boot/System.map-2.5.50
Dec  8 17:39:30 tonje kernel: Loaded 22711 symbols from /boot/System.map-2.5.50.
Dec  8 17:39:30 tonje kernel: Symbols match kernel version 2.5.50.
Dec  8 17:39:30 tonje kernel: No module symbols loaded - kernel modules not enabled. 
Dec  8 17:39:30 tonje kernel:  experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Dec  8 17:39:30 tonje kernel: aio_setup: sizeof(struct page) = 40
Dec  8 17:39:30 tonje kernel: [df6be040] eventpoll: successfully initialized.
Dec  8 17:39:30 tonje kernel: VFS: Disk quotas vdquot_6.5.1
Dec  8 17:39:30 tonje kernel: Journalled Block Device driver loaded
Dec  8 17:39:30 tonje kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Dec  8 17:39:30 tonje kernel: Capability LSM initialized
Dec  8 17:39:30 tonje kernel: Initializing Cryptographic API
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing md5
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: d41d8cd98f00b204e9800998ecf8427e
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: 0cc175b9c0f1b6a831c399e269772661
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: 900150983cd24fb0d6963f7d28e17f72
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4:
Dec  8 17:39:30 tonje kernel: f96b697d7cb7938d525a2f31aaf161d0
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 5:
Dec  8 17:39:30 tonje kernel: c3fcd3d76192e4007dfb496cca67e13b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 6:
Dec  8 17:39:30 tonje kernel: d174ab98d277d9f5a5611c2c9f419d9f
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 7:
Dec  8 17:39:30 tonje kernel: 57edf4a22be3c955ac49da2e2107b67a
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing md5 across pages
Dec  8 17:39:30 tonje kernel: c3fcd3d76192e4007dfb496cca67e13b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing sha1
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: a9993e364706816aba3e25717850c26c9cd0d89d
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: 84983e441c3bd26ebaae4aa1f95129e5e54670f1
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing sha1 across pages
Dec  8 17:39:30 tonje kernel: 84983e441c3bd26ebaae4aa1f95129e5e54670f1
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des encryption
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: c95744256a5ed31d
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: f79c892a338f4a8b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: 690f5b0d9a26939b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4:
Dec  8 17:39:30 tonje kernel: c95744256a5ed31df79c892a338f4a8bb49926f71fe1d490
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 5:
Dec  8 17:39:30 tonje kernel: setkey() failed flags=100100
Dec  8 17:39:30 tonje kernel: c95744256a5ed31d
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des ecb encryption across pages
Dec  8 17:39:30 tonje kernel: 0123456789abcdef
Dec  8 17:39:30 tonje kernel: page 1
Dec  8 17:39:30 tonje kernel: c95744256a5ed31d
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 2
Dec  8 17:39:30 tonje kernel: f79c892a338f4a8b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des ecb encryption chunking scenario A
Dec  8 17:39:30 tonje kernel: page 1
Dec  8 17:39:30 tonje kernel: c95744256a5ed31df79c892a338f
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 2
Dec  8 17:39:30 tonje kernel: 4a8bb49926f71fe1d490
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 3
Dec  8 17:39:30 tonje kernel: f79c892a338f4a8b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des ecb encryption chunking scenario B
Dec  8 17:39:30 tonje kernel: page 1
Dec  8 17:39:30 tonje kernel: c957
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 2
Dec  8 17:39:30 tonje kernel: 44
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 3
Dec  8 17:39:30 tonje kernel: 256a5e
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 4
Dec  8 17:39:30 tonje kernel: d31df79c892a338f4a8bb49926f71fe1d490
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des ecb encryption chunking scenario C
Dec  8 17:39:30 tonje kernel: page 1
Dec  8 17:39:30 tonje kernel: c957
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 2
Dec  8 17:39:30 tonje kernel: 4425
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 3
Dec  8 17:39:30 tonje kernel: 6a5e
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 4
Dec  8 17:39:30 tonje kernel: d31d
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 5
Dec  8 17:39:30 tonje kernel: f79c892a338f4a8b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des ecb encryption chunking scenario D
Dec  8 17:39:30 tonje kernel: c95744256a5ed31d
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des decryption
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: 0123456789abcde7
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: 01a1d6d039776742
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des ecb decryption across pages
Dec  8 17:39:30 tonje kernel: page 1
Dec  8 17:39:30 tonje kernel: 0123456789abcde7
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 2
Dec  8 17:39:30 tonje kernel: 2233445566778899
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des ecb decryption chunking scenario E
Dec  8 17:39:30 tonje kernel: page 1
Dec  8 17:39:30 tonje kernel: 012345
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 2
Dec  8 17:39:30 tonje kernel: 6789abcde7a3997bcaaf69a0
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 3
Dec  8 17:39:30 tonje kernel: f5
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des cbc encryption
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: ccd173ffab2039f4acd8aefddfd8a1eb468e91157888ba68
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: e5c7cdde872bf27c
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: 43e934008c389c0f
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4:
Dec  8 17:39:30 tonje kernel: 683788499a7c05f6
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des cbc encryption chunking scenario F
Dec  8 17:39:30 tonje kernel: page 1
Dec  8 17:39:30 tonje kernel: ccd173ffab2039f4acd8aefddf
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 2
Dec  8 17:39:30 tonje kernel: d8a1eb468e91157888ba68
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des cbc decryption
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: e5c7cdde872bf27c
Dec  8 17:39:30 tonje kernel: 4e6f772069732074
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: 43e934008c389c0f
Dec  8 17:39:30 tonje kernel: 68652074696d6520
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: 683788499a7c05f6
Dec  8 17:39:30 tonje kernel: 666f7220616c6c20
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des cbc decryption chunking scenario G
Dec  8 17:39:30 tonje kernel: page 1
Dec  8 17:39:30 tonje kernel: 666f7220
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: page 2
Dec  8 17:39:30 tonje kernel: 616c6c20
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des3 ede encryption
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: 18d748e563620572
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: c07d2a0fa566fa30
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: e1ef62c332fe825b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing des3 ede decryption
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: 736f6d6564617461
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: 7371756967676c65
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: 0000000000000000
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing md4
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: 31d6cfe0d16ae931b73c59d7e0c089c0
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: bde52cb31de33e46245e05fbdbd6fb24
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: a448017aaf21d8525fc10ae87aa6729d
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4:
Dec  8 17:39:30 tonje kernel: d9130a8164549fe818874806e1c7014b
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 5:
Dec  8 17:39:30 tonje kernel: d79e1c308aa5bbcdeea8ed63df412da9
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 6:
Dec  8 17:39:30 tonje kernel: 043f8582f241db351ce627e153e7f0e4
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 7:
Dec  8 17:39:30 tonje kernel: e33b4ddc9c38f2199c3e7b164fcc0536
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing sha256
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: 248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing sha256 across pages
Dec  8 17:39:30 tonje kernel: 248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing blowfish encryption
Dec  8 17:39:30 tonje kernel: test 1 (64 bit key):
Dec  8 17:39:30 tonje kernel: 4ef997456198dd78
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2 (64 bit key):
Dec  8 17:39:30 tonje kernel: a790795108ea3cae
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3 (64 bit key):
Dec  8 17:39:30 tonje kernel: e87a244e2cc85e82
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4 (128 bit key):
Dec  8 17:39:30 tonje kernel: 93142887ee3be15c
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 5 (168 bit key):
Dec  8 17:39:30 tonje kernel: e6f51ed79b9db21f
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 6 (448 bit key):
Dec  8 17:39:30 tonje kernel: c04504012e4e1f53
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing blowfish decryption
Dec  8 17:39:30 tonje kernel: test 1 (64 bit key):
Dec  8 17:39:30 tonje kernel: 0000000000000000
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2 (64 bit key):
Dec  8 17:39:30 tonje kernel: 0123456789abcdef
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3 (64 bit key):
Dec  8 17:39:30 tonje kernel: fedcba9876543210
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4 (128 bit key):
Dec  8 17:39:30 tonje kernel: fedcba9876543210
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 5 (168 bit key):
Dec  8 17:39:30 tonje kernel: fedcba9876543210
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 6 (448 bit key):
Dec  8 17:39:30 tonje kernel: fedcba9876543210
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing blowfish cbc encryption
Dec  8 17:39:30 tonje kernel: test 1 (128 bit key):
Dec  8 17:39:30 tonje kernel: 6b77b4d63006dee605b156e27403979358deb9e7154616d959f1652bd5ff92cc
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing blowfish cbc decryption
Dec  8 17:39:30 tonje kernel: test 1 (128 bit key):
Dec  8 17:39:30 tonje kernel: 37363534333231204e6f77206973207468652074696d6520666f722000000000
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing hmac_md5
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: 9294727a3638bb1c13f48ef8158bfc9d
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: 750c783e6ab0b503eaa86e310a5db738
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: 56be34521d144c88dbb8c733f0e8b3f6
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4:
Dec  8 17:39:30 tonje kernel: 697eaf0aca3a3aea3a75164746ffaa79
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 5:
Dec  8 17:39:30 tonje kernel: 56461ef2342edc00f9bab995690efd4c
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 6:
Dec  8 17:39:30 tonje kernel: 6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 7:
Dec  8 17:39:30 tonje kernel: 6f630fad67cda0ee1fb1f562db3aa53e
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing hmac_md5 across pages
Dec  8 17:39:30 tonje kernel: 750c783e6ab0b503eaa86e310a5db738
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing hmac_sha1
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: b617318655057264e28bc0b6fb378c8ef146be00
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: 125d7342b9ac11cd91a39af48aa17b4f63f175d3
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4:
Dec  8 17:39:30 tonje kernel: 4c9007f4026250c6bc8414f9bf50c86c2d7235da
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 5:
Dec  8 17:39:30 tonje kernel: 4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 6:
Dec  8 17:39:30 tonje kernel: aa4ae5e15272d00e95705637ce8a3b55ed402112
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 7:
Dec  8 17:39:30 tonje kernel: e8e99d0f45237d786d6bbaa7965c7808bbff1a91
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing hmac_sha1 across pages
Dec  8 17:39:30 tonje kernel: effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: 
Dec  8 17:39:30 tonje kernel: testing hmac_sha256
Dec  8 17:39:30 tonje kernel: test 1:
Dec  8 17:39:30 tonje kernel: 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20
Dec  8 17:39:30 tonje kernel: a21b1f5d4cf4f73a4dd939750f7a066a7f98cc131cb16a6692759021cfab8181
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 2:
Dec  8 17:39:30 tonje kernel: 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20
Dec  8 17:39:30 tonje kernel: 104fdc1257328f08184ba73131c53caee698e36119421149ea8c712456697d30
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 3:
Dec  8 17:39:30 tonje kernel: 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20
Dec  8 17:39:30 tonje kernel: 470305fc7e40fe34d3eeb3e773d95aab73acf0fd060447a5eb4595bf33a9d1a3
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 4:
Dec  8 17:39:30 tonje kernel: 0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b
Dec  8 17:39:30 tonje kernel: 198a607eb44bfbc69903a0f1cf2bbdc5ba0aa3f3d9ae3c1c7a3b1696a0b68cf7
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 5:
Dec  8 17:39:30 tonje kernel: 4a656665
Dec  8 17:39:30 tonje kernel: 5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 6:
Dec  8 17:39:30 tonje kernel: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
Dec  8 17:39:30 tonje kernel: cdcb1220d1ecccea91e53aba3092f962e549fe6ce9ed7fdc43191fbde45c30b0
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 7:
Dec  8 17:39:30 tonje kernel: 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f202122232425
Dec  8 17:39:30 tonje kernel: d4633c17f6fb8d744c66dee0f8f074556ec4af55ef07998541468eb49bd2e917
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 8:
Dec  8 17:39:30 tonje kernel: 0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c
Dec  8 17:39:30 tonje kernel: 7546af01841fc09b1ab9c3749a5f1c17d4f589668a587b2700a9c97c1193cf42
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 9:
Dec  8 17:39:30 tonje kernel: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
Dec  8 17:39:30 tonje kernel: 6953025ed96f0c09f80a96f78e6538dbe2e7b820e3dd970e7ddd39091b32352f
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: test 10:
Dec  8 17:39:30 tonje kernel: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
Dec  8 17:39:30 tonje kernel: 6355ac22e890d0a3c8481a5ca4825bc884d3e7a1ff98a2fc2ac7d8e064c3b2e6
Dec  8 17:39:30 tonje kernel: pass
Dec  8 17:39:30 tonje kernel: Applying VIA southbridge workaround.
Dec  8 17:39:30 tonje kernel: PCI: Disabling Via external APIC routing
Dec  8 17:39:30 tonje kernel: ACPI: Power Button (FF) [PWRF]
Dec  8 17:39:30 tonje kernel: ACPI: Sleep Button (CM) [SLPB]
Dec  8 17:39:30 tonje kernel: ACPI: Processor [CPU0] (supports C1)
Dec  8 17:39:30 tonje kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
Dec  8 17:39:30 tonje kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec  8 17:39:30 tonje kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec  8 17:39:30 tonje kernel: i2c-core.o: i2c core module version 2.6.4 (20020719)
Dec  8 17:39:30 tonje kernel: i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
Dec  8 17:39:30 tonje kernel: i2c-algo-bit.o: i2c bit algorithm module version 2.6.4 (20020719)
Dec  8 17:39:30 tonje kernel: i2c-proc.o version 2.6.4 (20020719)
Dec  8 17:39:30 tonje kernel: pty: 256 Unix98 ptys configured
Dec  8 17:39:30 tonje kernel: Real Time Clock Driver v1.11
Dec  8 17:39:30 tonje kernel: Non-volatile memory driver v1.2
Dec  8 17:39:30 tonje kernel: Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 1
Dec  8 17:39:30 tonje kernel: Intel(R) PRO/1000 Network Driver - version 4.4.12-k1
Dec  8 17:39:30 tonje kernel: Copyright (c) 1999-2002 Intel Corporation.
Dec  8 17:39:30 tonje kernel: pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
Dec  8 17:39:30 tonje kernel: 8139cp: 10/100 PCI Ethernet driver v0.3.0 (Sep 29, 2002)
Dec  8 17:39:30 tonje kernel: 8139too Fast Ethernet driver 0.9.26
Dec  8 17:39:30 tonje kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xe0006000, 00:50:22:c8:03:23, IRQ 11
Dec  8 17:39:30 tonje kernel: dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Dec  8 17:39:30 tonje kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Dec  8 17:39:30 tonje kernel: eth1: ADMtek Comet rev 17 at 0xe0008000, 00:10:DC:5B:D1:DC, IRQ 12.
Dec  8 17:39:30 tonje kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Dec  8 17:39:30 tonje kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  8 17:39:30 tonje kernel: VP_IDE: IDE controller at PCI slot 00:07.1
Dec  8 17:39:30 tonje kernel: VP_IDE: chipset revision 6
Dec  8 17:39:30 tonje kernel: VP_IDE: not 100%% native mode: will probe irqs later
Dec  8 17:39:30 tonje kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  8 17:39:30 tonje kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
Dec  8 17:39:30 tonje kernel:     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
Dec  8 17:39:30 tonje kernel:     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
Dec  8 17:39:30 tonje kernel: hda: IC35L060AVVA07-0, ATA DISK drive
Dec  8 17:39:30 tonje kernel: hda: IRQ probe failed (0xfffffef2)
Dec  8 17:39:30 tonje kernel: hda: DMA disabled
Dec  8 17:39:30 tonje kernel: hda: tagged command queueing enabled, command queue depth 32
Dec  8 17:39:30 tonje kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  8 17:39:30 tonje kernel: hdc: IRQ probe failed (0xffffbef2)
Dec  8 17:39:30 tonje kernel: hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
Dec  8 17:39:30 tonje kernel: hdc: DMA disabled
Dec  8 17:39:30 tonje kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec  8 17:39:30 tonje kernel: hda: host protected area => 1
Dec  8 17:39:30 tonje kernel: hda: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=7476/255/63, UDMA(100)
Dec  8 17:39:30 tonje kernel:  hda: hda1 hda2 < hda5 hda6 >
Dec  8 17:39:30 tonje kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.2, VIA Technologies, In USB
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hcd-pci.c: irq 12, io base 0000c400
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
Dec  8 17:39:30 tonje kernel: drivers/usb/host/uhci-hcd.c: detected 2 ports
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hub.c: USB hub found at 0
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hub.c: 2 ports detected
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.3, VIA Technologies, In USB (#2)
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hcd-pci.c: irq 12, io base 0000c800
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 2
Dec  8 17:39:30 tonje kernel: drivers/usb/host/uhci-hcd.c: detected 2 ports
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hub.c: USB hub found at 0
Dec  8 17:39:30 tonje kernel: drivers/usb/core/hub.c: 2 ports detected
Dec  8 17:39:30 tonje kernel: drivers/usb/core/usb.c: registered new driver hiddev
Dec  8 17:39:30 tonje kernel: drivers/usb/core/usb.c: registered new driver hid
Dec  8 17:39:30 tonje kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Dec  8 17:39:30 tonje kernel: mice: PS/2 mouse device common for all mice
Dec  8 17:39:30 tonje kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec  8 17:39:30 tonje kernel: i2c-core.o: i2c core module version 2.6.4 (20020719)
Dec  8 17:39:30 tonje kernel: i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
Dec  8 17:39:30 tonje kernel: i2c-proc.o version 2.6.4 (20020719)
Dec  8 17:39:30 tonje kernel: oprofile: using NMI interrupt.
Dec  8 17:39:30 tonje kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec  8 17:39:30 tonje kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Dec  8 17:39:30 tonje kernel: TCP: Hash tables configured (established 32768 bind 32768)
Dec  8 17:39:30 tonje kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Dec  8 17:39:30 tonje kernel: BIOS EDD facility v0.07 2002-Oct-24, 1 devices found
Dec  8 17:39:30 tonje kernel: found reiserfs format "3.6" with standard journal
Dec  8 17:39:30 tonje kernel: Reiserfs journal params: device ide0(3,6), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Dec  8 17:39:30 tonje kernel: reiserfs: checking transaction log (ide0(3,6)) for (ide0(3,6))
Dec  8 17:39:30 tonje kernel: Using r5 hash to sort names
Dec  8 17:39:30 tonje kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Dec  8 17:39:30 tonje kernel: Freeing unused kernel memory: 112k freed
Dec  8 17:39:30 tonje kernel: Adding 995988k swap on /dev/hda5.  Priority:-1 extents:1
Dec  8 17:39:30 tonje kernel: kjournald starting.  Commit interval 5 seconds
Dec  8 17:39:30 tonje kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Dec  8 17:39:30 tonje kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec  8 17:40:28 tonje kernel: drivers/usb/core/hub.c: new USB device 00:07.3-1, assigned address 2
Dec  8 17:40:28 tonje kernel: Product: USB MINI-Keyboard
Dec  8 17:40:28 tonje kernel: Manufacturer:           
Dec  8 17:40:28 tonje kernel: drivers/usb/input/hid-core.c: ctrl urb status -32 received
Dec  8 17:40:28 tonje kernel: input: USB HID v1.00 Keyboard [           USB MINI-Keyboard] on usb-00:07.3-1
Dec  8 17:41:32 tonje kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
Dec  8 17:52:06 tonje kernel: ------------[ cut here ]------------
Dec  8 17:52:06 tonje kernel: kernel BUG at drivers/ide/ide-dma.c:705!
Dec  8 17:52:06 tonje kernel: invalid operand: 0000
Dec  8 17:52:06 tonje kernel: CPU:    0
Dec  8 17:52:06 tonje kernel: EIP:    0060:[__ide_dma_read+94/224]    Not tainted
Dec  8 17:52:06 tonje kernel: EFLAGS: 00010286
Dec  8 17:52:06 tonje kernel: eax: c151ee80   ebx: c04b270c   ecx: 00001000   edx: 0000c002
Dec  8 17:52:06 tonje kernel: esi: c04b2660   edi: df59da80   ebp: c04b270c   esp: d5e7dd24
Dec  8 17:52:06 tonje kernel: ds: 0068   es: 0068   ss: 0068
Dec  8 17:52:06 tonje kernel: Process cp (pid: 1203, threadinfo=d5e7c000 task=de78a1c0)
Dec  8 17:52:06 tonje kernel: Stack: 00000001 c04b2660 df590008 000001f4 c02b3223 c04b270c c04b270c 0105d598 
Dec  8 17:52:06 tonje kernel:        df59e200 d5e7ddd8 0105d598 df59e200 00e7ddd8 4088271c c02a8e0d d5e7dd84 
Dec  8 17:52:06 tonje kernel:        c04b270c c02a8e68 c04b270c df59e200 0105d598 df59e200 c04b2660 c04b270c 
Dec  8 17:52:06 tonje kernel: Call Trace: [do_rw_disk+1091/1776]  [start_request+157/352]  [start_request+248/352]  [ide_do_request+872/960]  [do_ide_request+18/32]  [generic_unplug_device+58/96]  [blk_run_queues+136/192]  [do_page_cache_readahead+304/336]  [page_cache_readahead+210/304]  [do_generic_mapping_read+104/880]  [__generic_file_aio_read+445/480]  [file_read_actor+0/256]  [generic_file_read+123/160]  [sys_fstat64+37/48]  [vfs_read+194/352]  [sys_read+42/64]  [syscall_call+7/11] 
Dec  8 17:52:06 tonje kernel: Code: 0f 0b c1 02 78 b8 3b c0 68 80 62 2b c0 68 20 4e 00 00 68 10 
Dec  8 17:52:09 tonje kernel:  <7>evbug.c: Event. Dev: usb-00:07.3-1/input0, Type: 1, Code: 42, Value: 1
Dec  8 17:52:12 tonje kernel: hda: invalidating tag queue (11 commands)
Dec  8 17:52:12 tonje kernel: hda: status error: status=0x48 { DriveReady DataRequest }
Dec  8 17:52:12 tonje kernel: 
Dec  8 17:52:12 tonje kernel: hda: status error: status=0x48 { DriveReady DataRequest }
Dec  8 17:52:12 tonje kernel: 

--------------Boundary-00=_KLJUUUQMWXZKMERBRP8G--

