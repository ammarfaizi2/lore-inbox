Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWDDVPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWDDVPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWDDVPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:15:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:20634 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750879AbWDDVPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:15:36 -0400
Date: Tue, 4 Apr 2006 16:14:04 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Paul Mackerras <paulus@samba.org>
cc: linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>,
       <afleming@freescale.com>
Subject: Please pull from 'for_paulus' branch of powerpc
Message-ID: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for_paulus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/configs/mpc85xx_cds_defconfig |  846 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/ppc_ksyms.c            |    1 
 arch/powerpc/platforms/85xx/Kconfig        |    9 
 arch/powerpc/platforms/85xx/Makefile       |    1 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |  359 ++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_cds.h  |   43 +
 arch/ppc/kernel/ppc_ksyms.c                |    1 
 include/asm-ppc/mpc85xx.h                  |    3 
 8 files changed, 1262 insertions(+), 1 deletion(-)

Andy Fleming:
      Add 85xx CDS to arch/powerpc

Kumar Gala:
      powerpc/ppc: export strncasecmp

diff --git a/arch/powerpc/configs/mpc85xx_cds_defconfig b/arch/powerpc/configs/mpc85xx_cds_defconfig
new file mode 100644
index 0000000..9bb022a
--- /dev/null
+++ b/arch/powerpc/configs/mpc85xx_cds_defconfig
@@ -0,0 +1,846 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.16
+# Sun Apr  2 11:23:42 2006
+#
+# CONFIG_PPC64 is not set
+CONFIG_PPC32=y
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+# CONFIG_DEFAULT_UIMAGE is not set
+
+#
+# Processor support
+#
+# CONFIG_CLASSIC32 is not set
+# CONFIG_PPC_52xx is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+CONFIG_PPC_85xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+CONFIG_85xx=y
+CONFIG_E500=y
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+# CONFIG_PHYS_64BIT is not set
+CONFIG_SPE=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_MPIC=y
+# CONFIG_WANT_EARLY_SERIAL is not set
+
+#
+# Platform support
+#
+# CONFIG_MPC8540_ADS is not set
+CONFIG_MPC85xx_CDS=y
+CONFIG_MPC8540=y
+CONFIG_PPC_INDIRECT_PCI_BE=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_MATH_EMULATION=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_PPC_I8259=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_FSL_SOC=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_DEBUG is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=32768
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+# CONFIG_BLK_DEV_IDEDISK is not set
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+# CONFIG_BLK_DEV_OFFBOARD is not set
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_SL82C105 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+CONFIG_BLK_DEV_VIA82CXXX=y
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+# CONFIG_WINDFARM is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# PHY device support
+#
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+CONFIG_E1000=y
+CONFIG_E1000_NAPI=y
+# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+CONFIG_GIANFAR=y
+CONFIG_GFAR_NAPI=y
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
+# CONFIG_RTC_CLASS is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Instrumentation Support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_UNWIND_INFO is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
+# CONFIG_PPC_EARLY_DEBUG_G5 is not set
+# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
+# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
+# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index dfa5398..4b052ae 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -81,6 +81,7 @@ EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strcasecmp);
+EXPORT_SYMBOL(strncasecmp);
 
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 06e3712..454fc53 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -11,13 +11,20 @@ config MPC8540_ADS
 	help
 	  This option enables support for the MPC 8540 ADS board
 
+config MPC85xx_CDS
+	bool "Freescale MPC85xx CDS"
+	select DEFAULT_UIMAGE
+	select PPC_I8259 if PCI
+	help
+	  This option enables support for the MPC85xx CDS board
+
 endchoice
 
 config MPC8540
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC8540_ADS
+	default y if MPC8540_ADS || MPC85xx_CDS
 
 config PPC_INDIRECT_PCI_BE
 	bool
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index ffc4139..7615aa5 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_PPC_85xx)	+= misc.o pci.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
+obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
new file mode 100644
index 0000000..18e6e11
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -0,0 +1,359 @@
+/*
+ * MPC85xx setup and early boot code plus other random bits.
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/bootinfo.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc85xx.h>
+#include <asm/irq.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <asm/i8259.h>
+
+#include <sysdev/fsl_soc.h>
+#include "mpc85xx.h"
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+#endif
+
+static int cds_pci_slot = 2;
+static volatile u8 *cadmus;
+
+/*
+ * Internal interrupts are all Level Sensitive, and Positive Polarity
+ *
+ * Note:  Likely, this table and the following function should be
+ *        obtained and derived from the OF Device Tree.
+ */
+static u_char mpc85xx_cds_openpic_initsenses[] __initdata = {
+	MPC85XX_INTERNAL_IRQ_SENSES,
+#if defined(CONFIG_PCI)
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Ext 0: PCI slot 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 1: PCI slot 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 2: PCI slot 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 3 */
+#else
+	0x0,				/* External  0: */
+	0x0,				/* External  1: */
+	0x0,				/* External  2: */
+	0x0,				/* External  3: */
+#endif
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
+	0x0,				/* External  6: */
+	0x0,				/* External  7: */
+	0x0,				/* External  8: */
+	0x0,				/* External  9: */
+	0x0,				/* External 10: */
+#ifdef CONFIG_PCI
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),    /* Ext 11: PCI2 slot 0 */
+#else
+	0x0,				/* External 11: */
+#endif
+};
+
+
+#ifdef CONFIG_PCI
+/*
+ * interrupt routing
+ */
+int
+mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+
+	if (!hose->index)
+	{
+		/* Handle PCI1 interrupts */
+		char pci_irq_table[][4] =
+			/*
+			 *      PCI IDSEL/INTPIN->INTLINE
+			 *        A      B      C      D
+			 */
+
+			/* Note IRQ assignment for slots is based on which slot the elysium is
+			 * in -- in this setup elysium is in slot #2 (this PIRQA as first
+			 * interrupt on slot */
+		{
+			{ 0, 1, 2, 3 }, /* 16 - PMC */
+			{ 0, 1, 2, 3 }, /* 17 P2P (Tsi320) */
+			{ 0, 1, 2, 3 }, /* 18 - Slot 1 */
+			{ 1, 2, 3, 0 }, /* 19 - Slot 2 */
+			{ 2, 3, 0, 1 }, /* 20 - Slot 3 */
+			{ 3, 0, 1, 2 }, /* 21 - Slot 4 */
+		};
+
+		const long min_idsel = 16, max_idsel = 21, irqs_per_slot = 4;
+		int i, j;
+
+		for (i = 0; i < 6; i++)
+			for (j = 0; j < 4; j++)
+				pci_irq_table[i][j] =
+					((pci_irq_table[i][j] + 5 -
+					  cds_pci_slot) & 0x3) + PIRQ0A;
+
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else {
+		/* Handle PCI2 interrupts (if we have one) */
+		char pci_irq_table[][4] =
+		{
+			/*
+			 * We only have one slot and one interrupt
+			 * going to PIRQA - PIRQD */
+			{ PIRQ1A, PIRQ1A, PIRQ1A, PIRQ1A }, /* 21 - slot 0 */
+		};
+
+		const long min_idsel = 21, max_idsel = 21, irqs_per_slot = 4;
+
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
+}
+
+#define ARCADIA_HOST_BRIDGE_IDSEL	17
+#define ARCADIA_2ND_BRIDGE_IDSEL	3
+
+extern int mpc85xx_pci2_busno;
+
+int
+mpc85xx_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (mpc85xx_pci2_busno)
+		if (bus == (mpc85xx_pci2_busno) && PCI_SLOT(devfn) == 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	/* We explicitly do not go past the Tundra 320 Bridge */
+	if ((bus == 1) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if ((bus == 0) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+void __init
+mpc85xx_cds_pcibios_fixup(void)
+{
+	struct pci_dev *dev;
+	u_char		c;
+
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
+					PCI_DEVICE_ID_VIA_82C586_1, NULL))) {
+		/*
+		 * U-Boot does not set the enable bits
+		 * for the IDE device. Force them on here.
+		 */
+		pci_read_config_byte(dev, 0x40, &c);
+		c |= 0x03; /* IDE: Chip Enable Bits */
+		pci_write_config_byte(dev, 0x40, c);
+
+		/*
+		 * Since only primary interface works, force the
+		 * IDE function to standard primary IDE interrupt
+		 * w/ 8259 offset
+		 */
+		dev->irq = 14;
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		pci_dev_put(dev);
+	}
+
+	/*
+	 * Force legacy USB interrupt routing
+	 */
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
+					PCI_DEVICE_ID_VIA_82C586_2, NULL))) {
+		dev->irq = 10;
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 10);
+		pci_dev_put(dev);
+	}
+
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
+					PCI_DEVICE_ID_VIA_82C586_2, dev))) {
+		dev->irq = 11;
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+		pci_dev_put(dev);
+	}
+}
+#endif /* CONFIG_PCI */
+
+void __init mpc85xx_cds_pic_init(void)
+{
+	struct mpic *mpic1;
+	phys_addr_t OpenPIC_PAddr;
+
+	/* Determine the Physical Address of the OpenPIC regs */
+	OpenPIC_PAddr = get_immrbase() + MPC85xx_OPENPIC_OFFSET;
+
+	mpic1 = mpic_alloc(OpenPIC_PAddr,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
+			mpc85xx_cds_openpic_initsenses,
+			sizeof(mpc85xx_cds_openpic_initsenses), " OpenPIC  ");
+	BUG_ON(mpic1 == NULL);
+	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
+	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10280);
+	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10300);
+	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10380);
+	mpic_assign_isu(mpic1, 4, OpenPIC_PAddr + 0x10400);
+	mpic_assign_isu(mpic1, 5, OpenPIC_PAddr + 0x10480);
+	mpic_assign_isu(mpic1, 6, OpenPIC_PAddr + 0x10500);
+	mpic_assign_isu(mpic1, 7, OpenPIC_PAddr + 0x10580);
+
+	/* dummy mappings to get to 48 */
+	mpic_assign_isu(mpic1, 8, OpenPIC_PAddr + 0x10600);
+	mpic_assign_isu(mpic1, 9, OpenPIC_PAddr + 0x10680);
+	mpic_assign_isu(mpic1, 10, OpenPIC_PAddr + 0x10700);
+	mpic_assign_isu(mpic1, 11, OpenPIC_PAddr + 0x10780);
+
+	/* External ints */
+	mpic_assign_isu(mpic1, 12, OpenPIC_PAddr + 0x10000);
+	mpic_assign_isu(mpic1, 13, OpenPIC_PAddr + 0x10080);
+	mpic_assign_isu(mpic1, 14, OpenPIC_PAddr + 0x10100);
+
+	mpic_init(mpic1);
+
+#ifdef CONFIG_PCI
+	mpic_setup_cascade(PIRQ0A, i8259_irq_cascade, NULL);
+
+	i8259_init(0,0);
+#endif
+}
+
+
+/*
+ * Setup the architecture
+ */
+static void __init
+mpc85xx_cds_setup_arch(void)
+{
+	struct device_node *cpu;
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc85xx_cds_setup_arch()", 0);
+
+	cpu = of_find_node_by_type(NULL, "cpu");
+	if (cpu != 0) {
+		unsigned int *fp;
+
+		fp = (int *)get_property(cpu, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 500000000 / HZ;
+		of_node_put(cpu);
+	}
+
+	cadmus = ioremap(CADMUS_BASE, CADMUS_SIZE);
+	cds_pci_slot = ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
+
+	if (ppc_md.progress) {
+		char buf[40];
+		snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n",
+				cadmus[CM_VER], cds_pci_slot);
+		ppc_md.progress(buf, 0);
+	}
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		add_bridge(np);
+
+	ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = mpc85xx_map_irq;
+	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
+#endif
+
+#ifdef  CONFIG_ROOT_NFS
+	ROOT_DEV = Root_NFS;
+#else
+	ROOT_DEV = Root_HDA1;
+#endif
+}
+
+
+void
+mpc85xx_cds_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "Machine\t\t: MPC85xx CDS (0x%x)\n", cadmus[CM_VER]);
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc85xx_cds_probe(void)
+{
+	/* We always match for now, eventually we should look at
+	 * the flat dev tree to ensure this is the board we are
+	 * supposed to run on
+	 */
+	return 1;
+}
+
+define_machine(mpc85xx_cds) {
+	.name		= "MPC85xx CDS",
+	.probe		= mpc85xx_cds_probe,
+	.setup_arch	= mpc85xx_cds_setup_arch,
+	.init_IRQ	= mpc85xx_cds_pic_init,
+	.show_cpuinfo	= mpc85xx_cds_show_cpuinfo,
+	.get_irq	= mpic_get_irq,
+	.restart	= mpc85xx_restart,
+	.calibrate_decr = generic_calibrate_decr,
+	.progress	= udbg_progress,
+};
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.h b/arch/powerpc/platforms/85xx/mpc85xx_cds.h
new file mode 100644
index 0000000..671f54f
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.h
@@ -0,0 +1,43 @@
+/*
+ * arch/ppc/platforms/85xx/mpc85xx_cds_common.h
+ *
+ * MPC85xx CDS board definitions
+ *
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __MACH_MPC85XX_CDS_H__
+#define __MACH_MPC85XX_CDS_H__
+
+/* CADMUS info */
+#define CADMUS_BASE (0xf8004000)
+#define CADMUS_SIZE (256)
+#define CM_VER	(0)
+#define CM_CSR	(1)
+#define CM_RST	(2)
+
+/* CDS NVRAM/RTC */
+#define CDS_RTC_ADDR	(0xf8000000)
+#define CDS_RTC_SIZE	(8 * 1024)
+
+/* PCI interrupt controller */
+#define PIRQ0A			MPC85xx_IRQ_EXT0
+#define PIRQ0B			MPC85xx_IRQ_EXT1
+#define PIRQ0C			MPC85xx_IRQ_EXT2
+#define PIRQ0D			MPC85xx_IRQ_EXT3
+#define PIRQ1A			MPC85xx_IRQ_EXT11
+
+#define NR_8259_INTS		16
+#define CPM_IRQ_OFFSET		NR_8259_INTS
+
+#define MPC85xx_OPENPIC_IRQ_OFFSET	80
+
+#endif /* __MACH_MPC85XX_CDS_H__ */
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 865ba74..b250b1b 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -94,6 +94,7 @@ EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strcasecmp);
+EXPORT_SYMBOL(strncasecmp);
 EXPORT_SYMBOL(__div64_32);
 
 EXPORT_SYMBOL(csum_partial);
diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
index f47002a..4f844eb 100644
--- a/include/asm-ppc/mpc85xx.h
+++ b/include/asm-ppc/mpc85xx.h
@@ -28,6 +28,9 @@
 #if defined(CONFIG_MPC8555_CDS) || defined(CONFIG_MPC8548_CDS)
 #include <platforms/85xx/mpc8555_cds.h>
 #endif
+#ifdef CONFIG_MPC85xx_CDS
+#include <platforms/85xx/mpc85xx_cds.h>
+#endif
 #ifdef CONFIG_MPC8560_ADS
 #include <platforms/85xx/mpc8560_ads.h>
 #endif

