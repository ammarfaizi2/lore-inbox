Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVEaQKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVEaQKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEaQKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:10:11 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:18638 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261927AbVEaQDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:03:07 -0400
Date: Tue, 31 May 2005 11:02:48 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Added preliminary support for the MPC8548 CDS board
Message-ID: <Pine.LNX.4.61.0505311101220.29294@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for using the MPC8548 processor on the CDS reference board.
Currently all the major busses (PCI, PCI-X, PCI-Express, sRIO) and eTSEC3
and eTSEC4 are not supported.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 3288959347cb639411c735f97bbfd94e388347ce
tree d0d17af480ce3548879e20bc3f01175390540de3
parent d5cb2a6df9041a0124dee44838c01e4fbca367e6
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 31 May 2005 10:49:55 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 31 May 2005 10:49:55 -0500

 arch/ppc/configs/mpc8548_cds_defconfig       |  659 ++++++++++++++++++++++++++
 arch/ppc/platforms/85xx/Kconfig              |   10 
 arch/ppc/platforms/85xx/Makefile             |    1 
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |   50 +
 arch/ppc/syslib/Makefile                     |    1 
 arch/ppc/syslib/ppc85xx_setup.c              |    6 
 include/asm-ppc/mpc85xx.h                    |    2 
 7 files changed, 713 insertions(+), 16 deletions(-)

diff --git a/arch/ppc/configs/mpc8548_cds_defconfig b/arch/ppc/configs/mpc8548_cds_defconfig
new file mode 100644
--- /dev/null
+++ b/arch/ppc/configs/mpc8548_cds_defconfig
@@ -0,0 +1,659 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12-rc4
+# Tue May 24 22:36:27 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+CONFIG_E500=y
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+# CONFIG_PHYS_64BIT is not set
+CONFIG_SPE=y
+CONFIG_MATH_EMULATION=y
+# CONFIG_CPU_FREQ is not set
+# CONFIG_PM is not set
+CONFIG_85xx=y
+CONFIG_PPC_INDIRECT_PCI_BE=y
+
+#
+# Freescale 85xx options
+#
+# CONFIG_MPC8540_ADS is not set
+CONFIG_MPC8548_CDS=y
+# CONFIG_MPC8555_CDS is not set
+# CONFIG_MPC8560_ADS is not set
+# CONFIG_SBC8560 is not set
+# CONFIG_STX_GP3 is not set
+CONFIG_MPC8548=y
+
+#
+# Platform options
+#
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
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
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
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
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=32768
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
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
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
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
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
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
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+
+#
+# Ethernet (1000 Mbit)
+#
+CONFIG_GIANFAR=y
+CONFIG_GFAR_NAPI=y
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
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
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
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
+CONFIG_SOUND_GAMEPORT=y
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
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
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
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ISA is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Hardware Sensors Chip support
+#
+# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+
+#
+# Other I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
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
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
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
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
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
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
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
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
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
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
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
diff --git a/arch/ppc/platforms/85xx/Kconfig b/arch/ppc/platforms/85xx/Kconfig
--- a/arch/ppc/platforms/85xx/Kconfig
+++ b/arch/ppc/platforms/85xx/Kconfig
@@ -21,6 +21,11 @@ config MPC8540_ADS
 	help
 	  This option enables support for the MPC 8540 ADS evaluation board.
 
+config MPC8548_CDS
+	bool "Freescale MPC8548 CDS"
+	help
+	  This option enablese support for the MPC8548 CDS evaluation board.
+
 config MPC8555_CDS
 	bool "Freescale MPC8555 CDS"
 	help
@@ -51,6 +56,11 @@ endchoice
 config MPC8540
 	bool
 	depends on MPC8540_ADS
+	default y
+
+config MPC8548
+	bool
+	depends on MPC8548_CDS
 	default y
 
 config MPC8555
diff --git a/arch/ppc/platforms/85xx/Makefile b/arch/ppc/platforms/85xx/Makefile
--- a/arch/ppc/platforms/85xx/Makefile
+++ b/arch/ppc/platforms/85xx/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the PowerPC 85xx linux kernel.
 #
 obj-$(CONFIG_MPC8540_ADS)	+= mpc85xx_ads_common.o mpc8540_ads.o
+obj-$(CONFIG_MPC8548_CDS)	+= mpc85xx_cds_common.o
 obj-$(CONFIG_MPC8555_CDS)	+= mpc85xx_cds_common.o
 obj-$(CONFIG_MPC8560_ADS)	+= mpc85xx_ads_common.o mpc8560_ads.o
 obj-$(CONFIG_SBC8560)		+= sbc85xx.o sbc8560.o
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -480,21 +480,47 @@ mpc85xx_cds_setup_arch(void)
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 0;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 0;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 1;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 1;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	}
 
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_eTSEC1);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 0;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	}
+
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_eTSEC2);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 1;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	}
+
+	ppc_sys_device_remove(MPC85xx_eTSEC3);
+	ppc_sys_device_remove(MPC85xx_eTSEC4);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_83xx)		+= ipic.o ppc83xx_se
 ifeq ($(CONFIG_83xx),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
+obj-$(CONFIG_MPC8548_CDS)	+= todc_time.o
 obj-$(CONFIG_MPC8555_CDS)	+= todc_time.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o \
 					mpc52xx_sys.o mpc52xx_devices.o ppc_sys.o
diff --git a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
--- a/arch/ppc/syslib/ppc85xx_setup.c
+++ b/arch/ppc/syslib/ppc85xx_setup.c
@@ -133,7 +133,7 @@ mpc85xx_halt(void)
 
 #ifdef CONFIG_PCI
 
-#if defined(CONFIG_MPC8555_CDS)
+#if defined(CONFIG_MPC8555_CDS) || defined(CONFIG_MPC8548_CDS)
 extern void mpc85xx_cds_enable_via(struct pci_controller *hose);
 extern void mpc85xx_cds_fixup_via(struct pci_controller *hose);
 #endif
@@ -308,14 +308,14 @@ mpc85xx_setup_hose(void)
 
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 
-#if defined(CONFIG_MPC8555_CDS)
+#if defined(CONFIG_MPC8555_CDS) || defined(CONFIG_MPC8548_CDS)
 	/* Pre pciauto_bus_scan VIA init */
 	mpc85xx_cds_enable_via(hose_a);
 #endif
 
 	hose_a->last_busno = pciauto_bus_scan(hose_a, hose_a->first_busno);
 
-#if defined(CONFIG_MPC8555_CDS)
+#if defined(CONFIG_MPC8555_CDS) || defined(CONFIG_MPC8548_CDS)
 	/* Post pciauto_bus_scan VIA fixup */
 	mpc85xx_cds_fixup_via(hose_a);
 #endif
diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h
+++ b/include/asm-ppc/mpc85xx.h
@@ -25,7 +25,7 @@
 #ifdef CONFIG_MPC8540_ADS
 #include <platforms/85xx/mpc8540_ads.h>
 #endif
-#ifdef CONFIG_MPC8555_CDS
+#if defined(CONFIG_MPC8555_CDS) || defined(CONFIG_MPC8548_CDS)
 #include <platforms/85xx/mpc8555_cds.h>
 #endif
 #ifdef CONFIG_MPC8560_ADS
