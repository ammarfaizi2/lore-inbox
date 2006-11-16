Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424667AbWKPVtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424667AbWKPVtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424708AbWKPVtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:49:41 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:52463 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1424709AbWKPVtj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:49:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Is there any known issue with page allocation in 2.6.18-rc2 ? 
Date: Thu, 16 Nov 2006 14:49:36 -0700
Message-ID: <351763BE49AC8743AFCCF925821FF6BE01477920@az33exm22.fsl.freescale.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is there any known issue with page allocation in 2.6.18-rc2 ? 
Thread-Index: AccJyRvGlRBdFUDIQrWWYSTjTVdUDw==
From: "Kabir Ahsan-r9aahw" <Ahsan.Kabir@freescale.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am running OPENSWAN OCF (branch v3_0ocf of git repository) on my
PowerPC target (MPC8548CDS) patched to my 2.6.18-rc2 kernel. Putting
system under stress test I see the following page allocation problem. I
am trying to debug this problem but running out of ideas. I could trace
the code which is manifesting the problem but not very much comfortable
in interpreting all these information. Can anyone please give me some
clue as to what is happening? Also does anyone know of any page
allocation issue with 2.6.18-rc2 kernel (I obtained it from the netdev
git repo)

Thanks in advance.

-ahsan. 


Kernel page allocation problem : dump at the console:
=======================================================
crypto: page allocation failure. order:0, mode:0x20
crypto: page allocation failure. order:0, mode:0x20 Call Trace:
[DFEE7870] [C0008A80] (unreliable)
[DFEE78A0] [C0046758]
[DFEE78E0] [C005DA88]
[DFEE7910] [C005DED8]
[DFEE7920] [C0155B5C]
[DFEE7940] [C0145A9C]
[DFEE7980] [C0145D60]
[DFEE79C0] [C015D614]
[DFEE79F0] [C0025054]
[DFEE7A20] [C0006704]
[DFEE7A30] [C00250F8]
[DFEE7A40] [C0006668]
[DFEE7A50] [C00029B4]
[DFEE7B10] [C001F968]
[DFEE7BB0] [C001FA98]
[DFEE7C30] [C0046754]
[DFEE7C70] [C00467C4]
[DFEE7C80] [C00E052C]
[DFEE7D10] [C00E05C0]
[DFEE7D40] [C00E0A3C]
[DFEE7D60] [C010824C]
[DFEE7F40] [C0104544]
[DFEE7F70] [C01047A8]
[DFEE7FF0] [C0004AD8]
Mem-info:

DMA per-cpu:
cpu 0 hot: high 186, batch 31 used:31
cpu 0 cold: high 62, batch 15 used:10
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages: 1072kB (0kB HighMem)
Active:1016 inactive:5489 dirty:0 writeback:0 unstable:0 free:268
slab:122220 mapped:503 pagetables:56 DMA free:1072kB min:2896kB
low:3620kB high:4344kB active:4064kB inactive:21956kB present:524288kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB
0*2048kB 0*4096kB = 1072kB
DMA32: empty
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0 Free swap = 0kB Total
swap = 0kB
Free swap: 0kB
131072 pages of RAM
0 pages of HIGHMEM
458 free pages
1792 reserved pages
1926 pages shared
0 pages swap cached  

 

2-Kernel configuration file:
==============================

#

# Automatically generated make config: don't edit # Linux kernel
version: 2.6.18-rc2 # Thu Nov 16 12:13:53 2006 # CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_HWEIGHT=y CONFIG_GENERIC_CALIBRATE_DELAY=y CONFIG_PPC=y
CONFIG_PPC32=y CONFIG_GENERIC_NVRAM=y CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y

CONFIG_ARCH_MAY_HAVE_PC_FDC=y

CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#

# Code maturity level options

#

CONFIG_EXPERIMENTAL=y

CONFIG_BROKEN_ON_SMP=y

CONFIG_INIT_ENV_ARG_LIMIT=32

#

# General setup

#

CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""

# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set CONFIG_EMBEDDED=y #
CONFIG_KALLSYMS is not set # CONFIG_HOTPLUG is not set CONFIG_PRINTK=y
CONFIG_BUG=y CONFIG_ELF_CORE=y CONFIG_BASE_FULL=y CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y # CONFIG_EPOLL is not set CONFIG_SHMEM=y CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y # CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0 # CONFIG_SLOB is not set

#

# Loadable module support

#

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

#
# Block layer

#

# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#

CONFIG_IOSCHED_NOOP=y

CONFIG_IOSCHED_AS=y

CONFIG_IOSCHED_DEADLINE=y

CONFIG_IOSCHED_CFQ=y

# CONFIG_DEFAULT_AS is not set

# CONFIG_DEFAULT_DEADLINE is not set

CONFIG_DEFAULT_CFQ=y

# CONFIG_DEFAULT_NOOP is not set

CONFIG_DEFAULT_IOSCHED="cfq"

#

# Processor

#

# CONFIG_6xx is not set

# CONFIG_40x is not set

# CONFIG_44x is not set

# CONFIG_8xx is not set

# CONFIG_E200 is not set

CONFIG_E500=y

CONFIG_BOOKE=y

CONFIG_FSL_BOOKE=y

# CONFIG_PHYS_64BIT is not set

CONFIG_SPE=y

CONFIG_MATH_EMULATION=y

# CONFIG_KEXEC is not set

# CONFIG_CPU_FREQ is not set

# CONFIG_WANT_EARLY_SERIAL is not set

CONFIG_85xx=y

CONFIG_PPC_INDIRECT_PCI_BE=y

#

# Freescale 85xx options

#

# CONFIG_MPC8540_ADS is not set

CONFIG_MPC8548_CDS=y

# CONFIG_MPC8555_CDS is not set

# CONFIG_MPC8560_ADS is not set

# CONFIG_SBC8560 is not set

# CONFIG_STX_GP3 is not set

# CONFIG_TQM8540 is not set

# CONFIG_TQM8541 is not set

# CONFIG_TQM8555 is not set

# CONFIG_TQM8560 is not set

CONFIG_MPC8548=y

#

# Platform options

#

# CONFIG_HIGHMEM is not set

# CONFIG_HZ_100 is not set

CONFIG_HZ_250=y

# CONFIG_HZ_1000 is not set

CONFIG_HZ=250

CONFIG_PREEMPT_NONE=y

# CONFIG_PREEMPT_VOLUNTARY is not set

# CONFIG_PREEMPT is not set

CONFIG_SELECT_MEMORY_MODEL=y

CONFIG_FLATMEM_MANUAL=y

# CONFIG_DISCONTIGMEM_MANUAL is not set

# CONFIG_SPARSEMEM_MANUAL is not set

CONFIG_FLATMEM=y

CONFIG_FLAT_NODE_MEM_MAP=y

# CONFIG_SPARSEMEM_STATIC is not set

CONFIG_SPLIT_PTLOCK_CPUS=4

# CONFIG_RESOURCES_64BIT is not set

CONFIG_BINFMT_ELF=y

# CONFIG_BINFMT_MISC is not set

# CONFIG_CMDLINE_BOOL is not set

# CONFIG_PM is not set

# CONFIG_SOFTWARE_SUSPEND is not set

CONFIG_SECCOMP=y

CONFIG_ISA_DMA_API=y

#

# Bus options

#

CONFIG_PPC_I8259=y

# CONFIG_PCI is not set

# CONFIG_PCI_DOMAINS is not set

#

# PCCARD (PCMCIA/CardBus) support

#

#

# Advanced setup

#

# CONFIG_ADVANCED_OPTIONS is not set

#

# Default settings for advanced configuration options are used #
CONFIG_HIGHMEM_START=0xfe000000 CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000 CONFIG_TASK_SIZE=0x80000000
CONFIG_BOOT_LOAD=0x00800000

#

# Networking

#

CONFIG_NET=y

#

# Networking options

#

# CONFIG_NETDEBUG is not set

CONFIG_PACKET=y

# CONFIG_PACKET_MMAP is not set

CONFIG_UNIX=y

CONFIG_XFRM=y

# CONFIG_XFRM_USER is not set

# CONFIG_NET_KEY is not set

CONFIG_INET=y

CONFIG_IP_MULTICAST=y

# CONFIG_IP_ADVANCED_ROUTER is not set

CONFIG_IP_FIB_HASH=y

CONFIG_IP_PNP=y

CONFIG_IP_PNP_DHCP=y

CONFIG_IP_PNP_BOOTP=y

# CONFIG_IP_PNP_RARP is not set

# CONFIG_NET_IPIP is not set

# CONFIG_NET_IPGRE is not set

# CONFIG_IP_MROUTE is not set

# CONFIG_ARPD is not set

CONFIG_SYN_COOKIES=y

# CONFIG_IPSEC_NAT_TRAVERSAL is not set

# CONFIG_INET_AH is not set

# CONFIG_INET_ESP is not set

# CONFIG_INET_IPCOMP is not set

# CONFIG_INET_XFRM_TUNNEL is not set

# CONFIG_INET_TUNNEL is not set

CONFIG_INET_XFRM_MODE_TRANSPORT=y

CONFIG_INET_XFRM_MODE_TUNNEL=y

CONFIG_INET_DIAG=y

CONFIG_INET_TCP_DIAG=y

# CONFIG_TCP_CONG_ADVANCED is not set

CONFIG_TCP_CONG_BIC=y

# CONFIG_IPV6 is not set

# CONFIG_INET6_XFRM_TUNNEL is not set

# CONFIG_INET6_TUNNEL is not set

# CONFIG_NETWORK_SECMARK is not set

# CONFIG_NETFILTER is not set

#

# DCCP Configuration (EXPERIMENTAL)

#

# CONFIG_IP_DCCP is not set

#

# SCTP Configuration (EXPERIMENTAL)

#

# CONFIG_IP_SCTP is not set

#

# TIPC Configuration (EXPERIMENTAL)

#

# CONFIG_TIPC is not set

# CONFIG_ATM is not set

# CONFIG_BRIDGE is not set

# CONFIG_VLAN_8021Q is not set

# CONFIG_DECNET is not set

# CONFIG_LLC2 is not set

# CONFIG_IPX is not set

# CONFIG_ATALK is not set

# CONFIG_X25 is not set

# CONFIG_LAPB is not set

# CONFIG_NET_DIVERT is not set

# CONFIG_ECONET is not set

# CONFIG_WAN_ROUTER is not set

#

# QoS and/or fair queueing

#

# CONFIG_NET_SCHED is not set

#

# Network testing

#

# CONFIG_NET_PKTGEN is not set

# CONFIG_HAMRADIO is not set

# CONFIG_IRDA is not set

# CONFIG_BT is not set

# CONFIG_IEEE80211 is not set

CONFIG_KLIPS=y

#

# KLIPS options

#

CONFIG_KLIPS_ESP=y

# CONFIG_KLIPS_AH is not set

CONFIG_KLIPS_AUTH_HMAC_MD5=y

CONFIG_KLIPS_AUTH_HMAC_SHA1=y

CONFIG_KLIPS_ENC_3DES=y

# CONFIG_KLIPS_ENC_AES is not set

# CONFIG_KLIPS_IPCOMP is not set

CONFIG_KLIPS_OCF=y

CONFIG_KLIPS_DEBUG=y

#

# Device Drivers

#

#

# Generic Driver Options

#

CONFIG_STANDALONE=y

CONFIG_PREVENT_FIRMWARE_BUILD=y

# CONFIG_DEBUG_DRIVER is not set

# CONFIG_SYS_HYPERVISOR is not set

#

# Connector - unified userspace <-> kernelspace linker # #
CONFIG_CONNECTOR is not set

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

#

# Block devices

#

# CONFIG_BLK_DEV_FD is not set

# CONFIG_BLK_DEV_COW_COMMON is not set

CONFIG_BLK_DEV_LOOP=y

# CONFIG_BLK_DEV_CRYPTOLOOP is not set

# CONFIG_BLK_DEV_NBD is not set

CONFIG_BLK_DEV_RAM=y

CONFIG_BLK_DEV_RAM_COUNT=16

CONFIG_BLK_DEV_RAM_SIZE=32768

CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024

CONFIG_BLK_DEV_INITRD=y

# CONFIG_CDROM_PKTCDVD is not set

# CONFIG_ATA_OVER_ETH is not set

#

# ATA/ATAPI/MFM/RLL support

#

# CONFIG_IDE is not set

#

# SCSI device support

#

# CONFIG_RAID_ATTRS is not set

# CONFIG_SCSI is not set

#

# Multi-device support (RAID and LVM)

#

# CONFIG_MD is not set

#

# Fusion MPT device support

#

# CONFIG_FUSION is not set

#

# IEEE 1394 (FireWire) support

#

#

# I2O device support

#

#

# Macintosh device drivers

#

# CONFIG_WINDFARM is not set

#

# Network device support

#

CONFIG_NETDEVICES=y

# CONFIG_DUMMY is not set

# CONFIG_BONDING is not set

# CONFIG_EQUALIZER is not set

# CONFIG_TUN is not set

#

# PHY device support

#

CONFIG_PHYLIB=y

#

# MII PHY device drivers

#

# CONFIG_MARVELL_PHY is not set

# CONFIG_DAVICOM_PHY is not set

# CONFIG_QSEMI_PHY is not set

# CONFIG_LXT_PHY is not set

# CONFIG_CICADA_PHY is not set

# CONFIG_VITESSE_PHY is not set

# CONFIG_SMSC_PHY is not set

#

# Ethernet (10 or 100Mbit)

#

CONFIG_NET_ETHERNET=y

CONFIG_MII=y

#

# Ethernet (1000 Mbit)

#

CONFIG_GIANFAR=y

CONFIG_GFAR_NAPI=y

CONFIG_GFAR_SKBUFF_RECYCLING=y

#

# Ethernet (10000 Mbit)

#

#

# Token Ring devices

#

#

# Wireless LAN (non-hamradio)

#

# CONFIG_NET_RADIO is not set

#

# Wan interfaces

#

# CONFIG_WAN is not set

# CONFIG_PPP is not set

# CONFIG_SLIP is not set

# CONFIG_SHAPER is not set

# CONFIG_NETCONSOLE is not set

# CONFIG_NETPOLL is not set

# CONFIG_NET_POLL_CONTROLLER is not set

#

# ISDN subsystem

#

# CONFIG_ISDN is not set

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

# CONFIG_INPUT_MOUSEDEV is not set

# CONFIG_INPUT_JOYDEV is not set

# CONFIG_INPUT_TSDEV is not set

# CONFIG_INPUT_EVDEV is not set

# CONFIG_INPUT_EVBUG is not set

#

# Input Device Drivers

#

# CONFIG_INPUT_KEYBOARD is not set

# CONFIG_INPUT_MOUSE is not set

# CONFIG_INPUT_JOYSTICK is not set

# CONFIG_INPUT_TOUCHSCREEN is not set

# CONFIG_INPUT_MISC is not set

#

# Hardware I/O ports

#

# CONFIG_SERIO is not set

# CONFIG_GAMEPORT is not set

#

# Character devices

#

# CONFIG_VT is not set

# CONFIG_SERIAL_NONSTANDARD is not set

#

# Serial drivers

#

CONFIG_SERIAL_8250=y

CONFIG_SERIAL_8250_CONSOLE=y

CONFIG_SERIAL_8250_NR_UARTS=4

CONFIG_SERIAL_8250_RUNTIME_UARTS=4

# CONFIG_SERIAL_8250_EXTENDED is not set

#

# Non-8250 serial port support

#

CONFIG_SERIAL_CORE=y

CONFIG_SERIAL_CORE_CONSOLE=y

CONFIG_UNIX98_PTYS=y

CONFIG_LEGACY_PTYS=y

CONFIG_LEGACY_PTY_COUNT=256

#

# IPMI

#

# CONFIG_IPMI_HANDLER is not set

#

# Watchdog Cards

#

# CONFIG_WATCHDOG is not set

CONFIG_HW_RANDOM=y

# CONFIG_NVRAM is not set

CONFIG_GEN_RTC=y

# CONFIG_GEN_RTC_X is not set

# CONFIG_DTLK is not set

# CONFIG_R3964 is not set

#

# Ftape, the floppy tape device driver

#

# CONFIG_RAW_DRIVER is not set

#

# TPM devices

#

# CONFIG_TCG_TPM is not set

# CONFIG_TELCLOCK is not set

#

# I2C support

#

CONFIG_I2C=y

CONFIG_I2C_CHARDEV=y

#

# I2C Algorithms

#

# CONFIG_I2C_ALGOBIT is not set

# CONFIG_I2C_ALGOPCF is not set

# CONFIG_I2C_ALGOPCA is not set

#

# I2C Hardware Bus support

#

CONFIG_I2C_MPC=y

# CONFIG_I2C_OCORES is not set

# CONFIG_I2C_PARPORT_LIGHT is not set

# CONFIG_I2C_STUB is not set

# CONFIG_I2C_PCA_ISA is not set

#

# Miscellaneous I2C Chip support

#

# CONFIG_SENSORS_DS1337 is not set

# CONFIG_SENSORS_DS1374 is not set

# CONFIG_SENSORS_EEPROM is not set

# CONFIG_SENSORS_PCF8574 is not set

# CONFIG_SENSORS_PCA9539 is not set

# CONFIG_SENSORS_PCF8591 is not set

# CONFIG_SENSORS_M41T00 is not set

# CONFIG_SENSORS_MAX6875 is not set

# CONFIG_I2C_DEBUG_CORE is not set

# CONFIG_I2C_DEBUG_ALGO is not set

# CONFIG_I2C_DEBUG_BUS is not set

# CONFIG_I2C_DEBUG_CHIP is not set

#

# SPI support

#

# CONFIG_SPI is not set

# CONFIG_SPI_MASTER is not set

#

# Dallas's 1-wire bus

#

#

# Hardware Monitoring support

#

CONFIG_HWMON=y

# CONFIG_HWMON_VID is not set

# CONFIG_SENSORS_ABITUGURU is not set

# CONFIG_SENSORS_ADM1021 is not set

# CONFIG_SENSORS_ADM1025 is not set

# CONFIG_SENSORS_ADM1026 is not set

# CONFIG_SENSORS_ADM1031 is not set

# CONFIG_SENSORS_ADM9240 is not set

# CONFIG_SENSORS_ASB100 is not set

# CONFIG_SENSORS_ATXP1 is not set

# CONFIG_SENSORS_DS1621 is not set

# CONFIG_SENSORS_F71805F is not set

# CONFIG_SENSORS_FSCHER is not set

# CONFIG_SENSORS_FSCPOS is not set

# CONFIG_SENSORS_GL518SM is not set

# CONFIG_SENSORS_GL520SM is not set

# CONFIG_SENSORS_IT87 is not set

# CONFIG_SENSORS_LM63 is not set

# CONFIG_SENSORS_LM75 is not set

# CONFIG_SENSORS_LM77 is not set

# CONFIG_SENSORS_LM78 is not set

# CONFIG_SENSORS_LM80 is not set

# CONFIG_SENSORS_LM83 is not set

# CONFIG_SENSORS_LM85 is not set

# CONFIG_SENSORS_LM87 is not set

# CONFIG_SENSORS_LM90 is not set

# CONFIG_SENSORS_LM92 is not set

# CONFIG_SENSORS_MAX1619 is not set

# CONFIG_SENSORS_PC87360 is not set

# CONFIG_SENSORS_SMSC47M1 is not set

# CONFIG_SENSORS_SMSC47M192 is not set

# CONFIG_SENSORS_SMSC47B397 is not set

# CONFIG_SENSORS_W83781D is not set

# CONFIG_SENSORS_W83791D is not set

# CONFIG_SENSORS_W83792D is not set

# CONFIG_SENSORS_W83L785TS is not set

# CONFIG_SENSORS_W83627HF is not set

# CONFIG_SENSORS_W83627EHF is not set

# CONFIG_HWMON_DEBUG_CHIP is not set

#

# Misc devices

#

#

# Multimedia devices

#

# CONFIG_VIDEO_DEV is not set

CONFIG_VIDEO_V4L2=y

#

# Digital Video Broadcasting Devices

#

# CONFIG_DVB is not set

#

# Graphics support

#

CONFIG_FIRMWARE_EDID=y

# CONFIG_FB is not set

#

# Sound

#

# CONFIG_SOUND is not set

#

# USB support

#

# CONFIG_USB_ARCH_HAS_HCD is not set

# CONFIG_USB_ARCH_HAS_OHCI is not set

# CONFIG_USB_ARCH_HAS_EHCI is not set

#

# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'

#

#

# USB Gadget Support

#

# CONFIG_USB_GADGET is not set

#

# MMC/SD Card support

#

# CONFIG_MMC is not set

#

# LED devices

#

# CONFIG_NEW_LEDS is not set

#

# LED drivers

#

#

# LED Triggers

#

#

# InfiniBand support

#

#

# EDAC - error detection and reporting (RAS) (EXPERIMENTAL) #

#

# Real Time Clock

#

# CONFIG_RTC_CLASS is not set

#

# DMA Engine support

#

# CONFIG_DMA_ENGINE is not set

#

# DMA Clients

#

#

# DMA Devices

#

#

# File systems

#

CONFIG_EXT2_FS=y

# CONFIG_EXT2_FS_XATTR is not set

# CONFIG_EXT2_FS_XIP is not set

CONFIG_EXT3_FS=y

CONFIG_EXT3_FS_XATTR=y

# CONFIG_EXT3_FS_POSIX_ACL is not set

# CONFIG_EXT3_FS_SECURITY is not set

CONFIG_JBD=y

# CONFIG_JBD_DEBUG is not set

CONFIG_FS_MBCACHE=y

# CONFIG_REISERFS_FS is not set

# CONFIG_JFS_FS is not set

# CONFIG_FS_POSIX_ACL is not set

# CONFIG_XFS_FS is not set

# CONFIG_OCFS2_FS is not set

# CONFIG_MINIX_FS is not set

# CONFIG_ROMFS_FS is not set

CONFIG_INOTIFY=y

CONFIG_INOTIFY_USER=y

# CONFIG_QUOTA is not set

CONFIG_DNOTIFY=y

# CONFIG_AUTOFS_FS is not set

# CONFIG_AUTOFS4_FS is not set

# CONFIG_FUSE_FS is not set

#

# CD-ROM/DVD Filesystems

#

# CONFIG_ISO9660_FS is not set

# CONFIG_UDF_FS is not set

#

# DOS/FAT/NT Filesystems

#

# CONFIG_MSDOS_FS is not set

# CONFIG_VFAT_FS is not set

# CONFIG_NTFS_FS is not set

#

# Pseudo filesystems

#

CONFIG_PROC_FS=y

CONFIG_PROC_KCORE=y

CONFIG_SYSFS=y

CONFIG_TMPFS=y

# CONFIG_HUGETLB_PAGE is not set

CONFIG_RAMFS=y

# CONFIG_CONFIGFS_FS is not set

#

# Miscellaneous filesystems

#

# CONFIG_ADFS_FS is not set

# CONFIG_AFFS_FS is not set

# CONFIG_HFS_FS is not set

# CONFIG_HFSPLUS_FS is not set

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

CONFIG_NFS_FS=y

# CONFIG_NFS_V3 is not set

# CONFIG_NFS_V4 is not set

# CONFIG_NFS_DIRECTIO is not set

# CONFIG_NFSD is not set

CONFIG_ROOT_NFS=y

CONFIG_LOCKD=y

CONFIG_NFS_COMMON=y

CONFIG_SUNRPC=y

# CONFIG_RPCSEC_GSS_KRB5 is not set

# CONFIG_RPCSEC_GSS_SPKM3 is not set

# CONFIG_SMB_FS is not set

# CONFIG_CIFS is not set

# CONFIG_NCP_FS is not set

# CONFIG_CODA_FS is not set

# CONFIG_AFS_FS is not set

# CONFIG_9P_FS is not set

#

# Partition Types

#

CONFIG_PARTITION_ADVANCED=y

# CONFIG_ACORN_PARTITION is not set

# CONFIG_OSF_PARTITION is not set

# CONFIG_AMIGA_PARTITION is not set

# CONFIG_ATARI_PARTITION is not set

# CONFIG_MAC_PARTITION is not set

# CONFIG_MSDOS_PARTITION is not set

# CONFIG_LDM_PARTITION is not set

# CONFIG_SGI_PARTITION is not set

# CONFIG_ULTRIX_PARTITION is not set

# CONFIG_SUN_PARTITION is not set

# CONFIG_KARMA_PARTITION is not set

# CONFIG_EFI_PARTITION is not set

#

# Native Language Support

#

# CONFIG_NLS is not set

#

# Library routines

#

# CONFIG_CRC_CCITT is not set

# CONFIG_CRC16 is not set

CONFIG_CRC32=y

CONFIG_LIBCRC32C=y

CONFIG_ZLIB_INFLATE=y

CONFIG_ZLIB_DEFLATE=y

CONFIG_PLIST=y

# CONFIG_PROFILING is not set

#

# Kernel hacking

#

# CONFIG_PRINTK_TIME is not set

# CONFIG_MAGIC_SYSRQ is not set

# CONFIG_UNUSED_SYMBOLS is not set

CONFIG_DEBUG_KERNEL=y

CONFIG_LOG_BUF_SHIFT=14

# CONFIG_DETECT_SOFTLOCKUP is not set

# CONFIG_SCHEDSTATS is not set

# CONFIG_DEBUG_SLAB is not set

# CONFIG_DEBUG_RT_MUTEXES is not set

# CONFIG_RT_MUTEX_TESTER is not set

# CONFIG_DEBUG_SPINLOCK is not set

# CONFIG_DEBUG_MUTEXES is not set

# CONFIG_DEBUG_RWSEMS is not set

# CONFIG_DEBUG_SPINLOCK_SLEEP is not set #
CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set # CONFIG_DEBUG_KOBJECT is
not set CONFIG_DEBUG_INFO=y # CONFIG_DEBUG_FS is not set #
CONFIG_DEBUG_VM is not set CONFIG_FORCED_INLINING=y #
CONFIG_RCU_TORTURE_TEST is not set # CONFIG_XMON is not set #
CONFIG_BDI_SWITCH is not set

#

# Security options

#

# CONFIG_KEYS is not set

# CONFIG_SECURITY is not set

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

CONFIG_CRYPTO_SHA512=y

CONFIG_CRYPTO_WP512=y

CONFIG_CRYPTO_TGR192=y

CONFIG_CRYPTO_DES=y

CONFIG_CRYPTO_BLOWFISH=y

CONFIG_CRYPTO_TWOFISH=y

CONFIG_CRYPTO_SERPENT=y

CONFIG_CRYPTO_AES=y

CONFIG_CRYPTO_CAST5=y

CONFIG_CRYPTO_CAST6=y

CONFIG_CRYPTO_TEA=y

CONFIG_CRYPTO_ARC4=y

CONFIG_CRYPTO_KHAZAD=y

CONFIG_CRYPTO_ANUBIS=y

CONFIG_CRYPTO_DEFLATE=y

CONFIG_CRYPTO_MICHAEL_MIC=y

CONFIG_CRYPTO_CRC32C=y

# CONFIG_CRYPTO_TEST is not set

#

# OCF Configuration

#

CONFIG_OCF_OCF=y

# CONFIG_OCF_FIPS is not set

CONFIG_OCF_CRYPTODEV=y

CONFIG_OCF_CRYPTOSOFT=y

# CONFIG_OCF_SAFE is not set

# CONFIG_OCF_HIFN is not set

# CONFIG_OCF_HIFNHIPP is not set

CONFIG_OCF_TALITOS=y

# CONFIG_OCF_BENCH is not set

#

# Hardware crypto devices

#

