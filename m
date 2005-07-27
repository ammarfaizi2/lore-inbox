Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVG0Poq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVG0Poq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVG0Pnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:43:40 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:38858 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262344AbVG0Pkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:40:35 -0400
Date: Wed, 27 Jul 2005 10:40:20 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 11/14] ppc32: Remove board support for SM850
Message-ID: <Pine.LNX.4.61.0507271039460.12237@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the SM850 board is no longer maintained and thus being removed

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit b20e13cbb1c931860275b37d9bf7934974be6309
tree 17ece4e6a04e48ac5e976ed7e63691b6fd8c97ac
parent 7dbed1f92ee7eeaee439e82f7dae6e43c410ef22
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 25 Jul 2005 16:02:49 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 25 Jul 2005 16:02:49 -0500

 arch/ppc/Kconfig                 |   17 -
 arch/ppc/configs/SM850_defconfig |  522 --------------------------------------
 arch/ppc/platforms/tqm8xx.h      |   23 --
 3 files changed, 1 insertions(+), 561 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -355,13 +355,6 @@ config RPXLITE
 	  End of life: -
 	  URL: <http://www.speech-design.de/>
 
-	  SM850:
-	  Service Module (based on TQM850L)
-	  Manufacturer: Dependable Computer Systems, <http://www.decomsys.com/>
-	  Date of Release: end 2000 (?)
-	  End of life: mid 2001 (?)
-	  URL: <http://www.tz-mikroelektronik.de/ServiceModule/index.html>
-
 	  HERMES:
 	  Hermes-Pro ISDN/LAN router with integrated 8 x hub
 	  Manufacturer: Multidata Gesellschaft fur Datentechnik und Informatik
@@ -486,14 +479,6 @@ config IVML24
 	  from Speech Design, released March 2001.  The manufacturer's website
 	  is at <http://www.speech-design.de/>.
 
-config SM850
-	bool "SM850"
-	help
-	  Say Y here to support the Service Module 850 from Dependable
-	  Computer Systems, an SBC based on the TQM850L module by TQ
-	  Components.  This board is no longer in production.  The
-	  manufacturer's website is at <http://www.decomsys.com/>.
-
 config HERMES_PRO
 	bool "HERMES"
 
@@ -712,7 +697,7 @@ config PQ2ADS
 
 config TQM8xxL
 	bool
-	depends on 8xx && (TQM823L || TQM850L || FPS850L || TQM855L || TQM860L || SM850)
+	depends on 8xx && (TQM823L || TQM850L || FPS850L || TQM855L || TQM860L)
 	default y
 
 config EMBEDDEDBOOT
diff --git a/arch/ppc/configs/SM850_defconfig b/arch/ppc/configs/SM850_defconfig
deleted file mode 100644
--- a/arch/ppc/configs/SM850_defconfig
+++ /dev/null
@@ -1,522 +0,0 @@
-#
-# Automatically generated make config: don't edit
-#
-CONFIG_MMU=y
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
-CONFIG_HAVE_DEC_LOCK=y
-
-#
-# Code maturity level options
-#
-CONFIG_EXPERIMENTAL=y
-
-#
-# General setup
-#
-CONFIG_SWAP=y
-CONFIG_SYSVIPC=y
-# CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EMBEDDED=y
-CONFIG_FUTEX=y
-# CONFIG_EPOLL is not set
-
-#
-# Loadable module support
-#
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
-# CONFIG_MODVERSIONS is not set
-CONFIG_KMOD=y
-
-#
-# Platform support
-#
-CONFIG_PPC=y
-CONFIG_PPC32=y
-# CONFIG_6xx is not set
-# CONFIG_40x is not set
-# CONFIG_POWER3 is not set
-CONFIG_8xx=y
-
-#
-# IBM 4xx options
-#
-CONFIG_EMBEDDEDBOOT=y
-CONFIG_SERIAL_CONSOLE=y
-CONFIG_NOT_COHERENT_CACHE=y
-# CONFIG_RPXLITE is not set
-# CONFIG_RPXCLASSIC is not set
-# CONFIG_BSEIP is not set
-# CONFIG_FADS is not set
-# CONFIG_TQM823L is not set
-# CONFIG_TQM850L is not set
-# CONFIG_TQM855L is not set
-# CONFIG_TQM860L is not set
-# CONFIG_FPS850L is not set
-# CONFIG_SPD823TS is not set
-# CONFIG_IVMS8 is not set
-# CONFIG_IVML24 is not set
-CONFIG_SM850=y
-# CONFIG_HERMES_PRO is not set
-# CONFIG_IP860 is not set
-# CONFIG_LWMON is not set
-# CONFIG_PCU_E is not set
-# CONFIG_CCM is not set
-# CONFIG_LANTEC is not set
-# CONFIG_MBX is not set
-# CONFIG_WINCEPT is not set
-CONFIG_TQM8xxL=y
-# CONFIG_SMP is not set
-# CONFIG_PREEMPT is not set
-CONFIG_MATH_EMULATION=y
-# CONFIG_CPU_FREQ is not set
-
-#
-# General setup
-#
-# CONFIG_HIGHMEM is not set
-# CONFIG_PCI is not set
-# CONFIG_PCI_DOMAINS is not set
-# CONFIG_PCI_QSPAN is not set
-CONFIG_KCORE_ELF=y
-CONFIG_BINFMT_ELF=y
-CONFIG_KERNEL_ELF=y
-# CONFIG_BINFMT_MISC is not set
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyCPM1"
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
-# CONFIG_BLK_DEV_FD is not set
-# CONFIG_BLK_DEV_LOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
-# ATA/IDE/MFM/RLL support
-#
-# CONFIG_IDE is not set
-
-#
-# SCSI support
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
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
-# CONFIG_NETFILTER is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-# CONFIG_IP_MULTICAST is not set
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_IP_PNP_BOOTP is not set
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_IPV6 is not set
-# CONFIG_XFRM_USER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-CONFIG_IPV6_SCTP__=y
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_LLC is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
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
-# CONFIG_ETHERTAP is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
-CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_OAKNET is not set
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
-# Token Ring devices (depends on LLC=y)
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
-# Old CD-ROM drivers (not SCSI, not IDE)
-#
-# CONFIG_CD_NO_IDESCSI is not set
-
-#
-# Input device support
-#
-# CONFIG_INPUT is not set
-
-#
-# Userland interfaces
-#
-
-#
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-# CONFIG_SERIO is not set
-
-#
-# Input Device Drivers
-#
-
-#
-# Macintosh device drivers
-#
-
-#
-# Serial drivers
-#
-# CONFIG_SERIAL_8250 is not set
-
-#
-# Non-8250 serial port support
-#
-CONFIG_SERIAL_CORE=y
-CONFIG_SERIAL_CORE_CONSOLE=y
-CONFIG_SERIAL_CPM=y
-CONFIG_SERIAL_CPM_CONSOLE=y
-# CONFIG_SERIAL_CPM_SCC1 is not set
-# CONFIG_SERIAL_CPM_SCC2 is not set
-# CONFIG_SERIAL_CPM_SCC3 is not set
-# CONFIG_SERIAL_CPM_SCC4 is not set
-CONFIG_SERIAL_CPM_SMC1=y
-CONFIG_SERIAL_CPM_SMC2=y
-CONFIG_SERIAL_CPM_ALT_SMC2=y
-CONFIG_UNIX98_PTYS=y
-# CONFIG_LEGACY_PTYS is not set
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# I2C Hardware Sensors Mainboard support
-#
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
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
-# CONFIG_HANGCHECK_TIMER is not set
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
-# CONFIG_EXT2_FS is not set
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
-# CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
-# CONFIG_DEVPTS_FS_XATTR is not set
-CONFIG_TMPFS=y
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
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_ACORN_PARTITION is not set
-# CONFIG_OSF_PARTITION is not set
-# CONFIG_AMIGA_PARTITION is not set
-# CONFIG_ATARI_PARTITION is not set
-# CONFIG_MAC_PARTITION is not set
-# CONFIG_MSDOS_PARTITION is not set
-# CONFIG_LDM_PARTITION is not set
-# CONFIG_NEC98_PARTITION is not set
-# CONFIG_SGI_PARTITION is not set
-# CONFIG_ULTRIX_PARTITION is not set
-# CONFIG_SUN_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
-# MPC8xx CPM Options
-#
-CONFIG_SCC_ENET=y
-# CONFIG_SCC1_ENET is not set
-# CONFIG_SCC2_ENET is not set
-CONFIG_SCC3_ENET=y
-# CONFIG_FEC_ENET is not set
-CONFIG_ENET_BIG_BUFFERS=y
-
-#
-# Generic MPC8xx Options
-#
-CONFIG_8xx_COPYBACK=y
-CONFIG_8xx_CPU6=y
-# CONFIG_UCODE_PATCH is not set
-
-#
-# USB support
-#
-# CONFIG_USB_GADGET is not set
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
-
-#
-# Library routines
-#
-# CONFIG_CRC32 is not set
-
-#
-# Kernel hacking
-#
-# CONFIG_DEBUG_KERNEL is not set
-# CONFIG_KALLSYMS is not set
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
diff --git a/arch/ppc/platforms/tqm8xx.h b/arch/ppc/platforms/tqm8xx.h
--- a/arch/ppc/platforms/tqm8xx.h
+++ b/arch/ppc/platforms/tqm8xx.h
@@ -147,29 +147,6 @@ static __inline__ void ide_led(int on)
 #define SICR_ENET_CLKRT	((uint)0x00002600)
 #endif	/* CONFIG_FPS850L */
 
-/***  SM850  *********************************************************/
-
-/* The SM850 Service Module uses SCC2 for IrDA and SCC3 for Ethernet */
-
-#ifdef CONFIG_SM850
-#define PB_ENET_RXD	((uint)0x00000004)	/* PB 29 */
-#define PB_ENET_TXD	((uint)0x00000002)	/* PB 30 */
-#define PA_ENET_RCLK	((ushort)0x0100)	/* PA  7 */
-#define PA_ENET_TCLK	((ushort)0x0400)	/* PA  5 */
-
-#define PC_ENET_LBK	((ushort)0x0008)	/* PC 12 */
-#define PC_ENET_TENA	((ushort)0x0004)	/* PC 13 */
-
-#define PC_ENET_RENA	((ushort)0x0800)	/* PC  4 */
-#define PC_ENET_CLSN	((ushort)0x0400)	/* PC  5 */
-
-/* Control bits in the SICR to route TCLK (CLK3) and RCLK (CLK1) to
- * SCC3.  Also, make sure GR3 (bit 8) and SC3 (bit 9) are zero.
- */
-#define SICR_ENET_MASK	((uint)0x00FF0000)
-#define SICR_ENET_CLKRT	((uint)0x00260000)
-#endif	/* CONFIG_SM850 */
-
 /* We don't use the 8259.
 */
 #define NR_8259_INTS	0
