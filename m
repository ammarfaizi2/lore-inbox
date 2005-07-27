Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVG0QkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVG0QkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 12:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVG0QiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 12:38:23 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:20938 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262389AbVG0PkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:40:10 -0400
Date: Wed, 27 Jul 2005 10:39:44 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 10/14] ppc32: Remove board support for REDWOOD
Message-ID: <Pine.LNX.4.61.0507271038520.12237@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the REDWOOD board is no longer maintained and thus being removed

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 7dbed1f92ee7eeaee439e82f7dae6e43c410ef22
tree 9cdb6db7eedd12a58007466e3193800c46a414ba
parent 82101a77550f5cd9c35efe787c5eaa8f82672c36
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 25 Jul 2005 16:00:04 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 25 Jul 2005 16:00:04 -0500

 arch/ppc/boot/simple/Makefile      |    2 
 arch/ppc/boot/simple/head.S        |    9 -
 arch/ppc/configs/redwood_defconfig |  540 ------------------------------------
 include/asm-ppc/ibm4xx.h           |    4 
 4 files changed, 0 insertions(+), 555 deletions(-)

diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -148,8 +148,6 @@ zimageinitrd-$(CONFIG_LITE5200)		:= zIma
 
 # This is a treeboot that needs init functions until the
 # boot rom is sorted out (i.e. this is short lived)
-extra-aflags-$(CONFIG_REDWOOD_4)	:= -Wa,-m405
-extra.o-$(CONFIG_REDWOOD_4)		:= rw4/rw4_init.o rw4/rw4_init_brd.o
 EXTRA_AFLAGS := $(extra-aflags-y)
 # head.o needs to get the cacheflags defined.
 AFLAGS_head.o				+= $(cacheflag-y)
diff --git a/arch/ppc/boot/simple/head.S b/arch/ppc/boot/simple/head.S
--- a/arch/ppc/boot/simple/head.S
+++ b/arch/ppc/boot/simple/head.S
@@ -120,15 +120,6 @@ haveOF:
 	mtspr	SPRN_DER,r4
 #endif
 
-#ifdef CONFIG_REDWOOD_4
-	/* All of this Redwood 4 stuff will soon disappear when the
-	 * boot rom is straightened out.
-	 */
-	mr	r29, r3		/* Easier than changing the other code */
-	bl	HdwInit
-	mr	r3, r29
-#endif
-
 #if defined(CONFIG_MBX) || defined(CONFIG_RPX8260) || defined(CONFIG_PPC_PREP)
 	mr	r4,r29	/* put the board info pointer where the relocate
 			 * routine will find it
diff --git a/arch/ppc/configs/redwood_defconfig b/arch/ppc/configs/redwood_defconfig
deleted file mode 100644
--- a/arch/ppc/configs/redwood_defconfig
+++ /dev/null
@@ -1,540 +0,0 @@
-#
-# Automatically generated make config: don't edit
-#
-CONFIG_MMU=y
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
-CONFIG_HAVE_DEC_LOCK=y
-CONFIG_PPC=y
-CONFIG_PPC32=y
-
-#
-# Code maturity level options
-#
-CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
-# CONFIG_STANDALONE is not set
-CONFIG_BROKEN_ON_SMP=y
-
-#
-# General setup
-#
-CONFIG_SWAP=y
-CONFIG_SYSVIPC=y
-# CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_IKCONFIG is not set
-CONFIG_EMBEDDED=y
-# CONFIG_KALLSYMS is not set
-CONFIG_FUTEX=y
-# CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-
-#
-# Loadable module support
-#
-CONFIG_MODULES=y
-# CONFIG_MODULE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
-# CONFIG_MODVERSIONS is not set
-CONFIG_KMOD=y
-
-#
-# Processor
-#
-# CONFIG_6xx is not set
-CONFIG_40x=y
-# CONFIG_44x is not set
-# CONFIG_POWER3 is not set
-# CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
-# CONFIG_MATH_EMULATION is not set
-# CONFIG_CPU_FREQ is not set
-CONFIG_4xx=y
-
-#
-# IBM 4xx options
-#
-# CONFIG_ASH is not set
-# CONFIG_BEECH is not set
-# CONFIG_CEDAR is not set
-# CONFIG_CPCI405 is not set
-# CONFIG_EP405 is not set
-# CONFIG_OAK is not set
-CONFIG_REDWOOD_4=y
-# CONFIG_REDWOOD_5 is not set
-# CONFIG_REDWOOD_6 is not set
-# CONFIG_SYCAMORE is not set
-# CONFIG_TIVO is not set
-# CONFIG_WALNUT is not set
-CONFIG_IBM405_ERR77=y
-CONFIG_IBM405_ERR51=y
-CONFIG_IBM_OCP=y
-CONFIG_STB03xxx=y
-CONFIG_IBM_OPENBIOS=y
-# CONFIG_405_DMA is not set
-# CONFIG_PM is not set
-CONFIG_UART0_TTYS0=y
-# CONFIG_UART0_TTYS1 is not set
-# CONFIG_SERIAL_SICC is not set
-CONFIG_NOT_COHERENT_CACHE=y
-
-#
-# Platform options
-#
-# CONFIG_PC_KEYBOARD is not set
-# CONFIG_SMP is not set
-# CONFIG_PREEMPT is not set
-# CONFIG_HIGHMEM is not set
-CONFIG_KERNEL_ELF=y
-CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
-# CONFIG_CMDLINE_BOOL is not set
-
-#
-# Bus options
-#
-# CONFIG_PCI is not set
-# CONFIG_PCI_DOMAINS is not set
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
-
-#
-# Advanced setup
-#
-# CONFIG_ADVANCED_OPTIONS is not set
-
-#
-# Default settings for advanced configuration options are used
-#
-CONFIG_HIGHMEM_START=0xfe000000
-CONFIG_LOWMEM_SIZE=0x30000000
-CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
-CONFIG_BOOT_LOAD=0x00400000
-
-#
-# Generic Driver Options
-#
-
-#
-# Memory Technology Devices (MTD)
-#
-# CONFIG_MTD is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNP is not set
-
-#
-# Block devices
-#
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_LBD is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
-# CONFIG_IDE is not set
-
-#
-# SCSI device support
-#
-# CONFIG_SCSI is not set
-
-#
-# Fusion MPT device support
-#
-
-#
-# I2O device support
-#
-
-#
-# Networking support
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-# CONFIG_PACKET is not set
-# CONFIG_NETLINK_DEV is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_IPV6 is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_NETFILTER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-CONFIG_IPV6_SCTP__=y
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-CONFIG_NETDEVICES=y
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_OAKNET=y
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Token Ring devices
-#
-# CONFIG_SHAPER is not set
-
-#
-# Wan interfaces
-#
-# CONFIG_WAN is not set
-
-#
-# Amateur Radio support
-#
-# CONFIG_HAMRADIO is not set
-
-#
-# IrDA (infrared) support
-#
-# CONFIG_IRDA is not set
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
-
-#
-# ISDN subsystem
-#
-# CONFIG_ISDN_BOOL is not set
-
-#
-# Graphics support
-#
-# CONFIG_FB is not set
-
-#
-# Input device support
-#
-CONFIG_INPUT=y
-
-#
-# Userland interfaces
-#
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
-# CONFIG_INPUT_EVBUG is not set
-
-#
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-# CONFIG_SERIO_SERPORT is not set
-# CONFIG_SERIO_CT82C710 is not set
-
-#
-# Input Device Drivers
-#
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
-
-#
-# Macintosh device drivers
-#
-
-#
-# Character devices
-#
-# CONFIG_VT is not set
-# CONFIG_SERIAL_NONSTANDARD is not set
-
-#
-# Serial drivers
-#
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
-
-#
-# Non-8250 serial port support
-#
-CONFIG_SERIAL_CORE=y
-CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_UNIX98_PTYS is not set
-
-#
-# I2C support
-#
-CONFIG_I2C=y
-# CONFIG_I2C_CHARDEV is not set
-
-#
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-
-#
-# I2C Hardware Bus support
-#
-# CONFIG_I2C_AMD756 is not set
-# CONFIG_I2C_AMD8111 is not set
-CONFIG_I2C_IBM_IIC=y
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-# CONFIG_SENSORS_ADM1021 is not set
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_IT87 is not set
-# CONFIG_SENSORS_LM75 is not set
-# CONFIG_SENSORS_LM78 is not set
-# CONFIG_SENSORS_LM85 is not set
-# CONFIG_SENSORS_VIA686A is not set
-# CONFIG_SENSORS_W83781D is not set
-
-#
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
-# CONFIG_QIC02_TAPE is not set
-
-#
-# IPMI
-#
-# CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
-# CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
-# CONFIG_FTAPE is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
-# CONFIG_RAW_DRIVER is not set
-
-#
-# Multimedia devices
-#
-# CONFIG_VIDEO_DEV is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
-
-#
-# File systems
-#
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-# CONFIG_EXT3_FS_SECURITY is not set
-CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-# CONFIG_XFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
-# CONFIG_QUOTA is not set
-# CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
-
-#
-# CD-ROM/DVD Filesystems
-#
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
-
-#
-# DOS/FAT/NT Filesystems
-#
-# CONFIG_FAT_FS is not set
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
-# CONFIG_DEVFS_FS is not set
-CONFIG_TMPFS=y
-# CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_ADFS_FS is not set
-# CONFIG_AFFS_FS is not set
-# CONFIG_HFS_FS is not set
-# CONFIG_BEFS_FS is not set
-# CONFIG_BFS_FS is not set
-# CONFIG_EFS_FS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
-CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
-# CONFIG_NFS_V4 is not set
-# CONFIG_NFSD is not set
-CONFIG_ROOT_NFS=y
-CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
-CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
-# CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
-# CONFIG_NCP_FS is not set
-# CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
-# CONFIG_AFS_FS is not set
-
-#
-# Partition Types
-#
-# CONFIG_PARTITION_ADVANCED is not set
-CONFIG_MSDOS_PARTITION=y
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
-# IBM 40x options
-#
-
-#
-# USB support
-#
-# CONFIG_USB_GADGET is not set
-
-#
-# Library routines
-#
-CONFIG_CRC32=y
-
-#
-# Kernel hacking
-#
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_SERIAL_TEXT_DEBUG=y
-CONFIG_OCP=y
-
-#
-# Security options
-#
-# CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-# CONFIG_CRYPTO is not set
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -31,10 +31,6 @@
 #include <platforms/4xx/ep405.h>
 #endif
 
-#if defined(CONFIG_REDWOOD_4)
-#include <platforms/4xx/redwood.h>
-#endif
-
 #if defined(CONFIG_REDWOOD_5)
 #include <platforms/4xx/redwood5.h>
 #endif
