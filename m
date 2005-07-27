Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVG0Por@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVG0Por (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVG0Pnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:43:35 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:52426 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262383AbVG0PlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:41:00 -0400
Date: Wed, 27 Jul 2005 10:40:46 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 12/14] ppc32: Remove board support for SPD823TS
Message-ID: <Pine.LNX.4.61.0507271040210.12237@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the SPD823TS board is no longer maintained and thus being removed

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 16f6a37ad9d92a4dbb9ac12dfc5e713480a7c9d0
tree 1b6b9cdd190c8eb590596c7b0decc5c00f5dfe9b
parent b20e13cbb1c931860275b37d9bf7934974be6309
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 25 Jul 2005 16:06:08 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 25 Jul 2005 16:06:08 -0500

 arch/ppc/Kconfig                    |   15 -
 arch/ppc/configs/SPD823TS_defconfig |  520 -----------------------------------
 arch/ppc/platforms/spd8xx.h         |   92 ------
 include/asm-ppc/mpc8xx.h            |    4 
 4 files changed, 0 insertions(+), 631 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -331,14 +331,6 @@ config RPXLITE
 	  End of life: end 2000 ?
 	  URL: see TQM850L
 
-	  SPD823TS:
-	  MPC823 based board used in the "Tele Server" product
-	  Manufacturer: Speech Design, <http://www.speech-design.de/>
-	  Date of Release: Mid 2000 (?)
-	  End of life: -
-	  URL: <http://www.speech-design.de/>
-	  select "English", then "Teleteam Solutions", then "TeleServer"
-
 	  IVMS8:
 	  MPC860 based board used in the "Integrated Voice Mail System",
 	  Small Version (8 voice channels)
@@ -457,13 +449,6 @@ config TQM860L
 
 config FPS850L
 	bool "FPS850L"
-
-config SPD823TS
-	bool "SPD823TS"
-	help
-	  Say Y here to support the Speech Design 823 Tele-Server from Speech
-	  Design, released in 2000.  The manufacturer's website is at
-	  <http://www.speech-design.de/>.
 
 config IVMS8
 	bool "IVMS8"
diff --git a/arch/ppc/configs/SPD823TS_defconfig b/arch/ppc/configs/SPD823TS_defconfig
deleted file mode 100644
--- a/arch/ppc/configs/SPD823TS_defconfig
+++ /dev/null
@@ -1,520 +0,0 @@
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
-CONFIG_SPD823TS=y
-# CONFIG_IVMS8 is not set
-# CONFIG_IVML24 is not set
-# CONFIG_SM850 is not set
-# CONFIG_HERMES_PRO is not set
-# CONFIG_IP860 is not set
-# CONFIG_LWMON is not set
-# CONFIG_PCU_E is not set
-# CONFIG_CCM is not set
-# CONFIG_LANTEC is not set
-# CONFIG_MBX is not set
-# CONFIG_WINCEPT is not set
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
-# CONFIG_CMDLINE_BOOL is not set
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
-# CONFIG_SERIAL_CPM_SMC2 is not set
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
-CONFIG_SCC2_ENET=y
-# CONFIG_SCC3_ENET is not set
-# CONFIG_FEC_ENET is not set
-CONFIG_ENET_BIG_BUFFERS=y
-
-#
-# Generic MPC8xx Options
-#
-CONFIG_8xx_COPYBACK=y
-# CONFIG_8xx_CPU6 is not set
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
diff --git a/arch/ppc/platforms/spd8xx.h b/arch/ppc/platforms/spd8xx.h
deleted file mode 100644
--- a/arch/ppc/platforms/spd8xx.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * Speech Design SPD8xxTS board specific definitions
- *
- * Copyright (c) 2000,2001 Wolfgang Denk (wd@denx.de)
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_SPD8XX_H__
-#define __ASM_SPD8XX_H__
-
-#include <linux/config.h>
-
-#include <asm/ppcboot.h>
-
-#ifndef __ASSEMBLY__
-#define SPD_IMMR_BASE	0xFFF00000	/* phys. addr of IMMR */
-#define SPD_IMAP_SIZE	(64 * 1024)	/* size of mapped area */
-
-#define IMAP_ADDR	SPD_IMMR_BASE	/* physical base address of IMMR area */
-#define IMAP_SIZE	SPD_IMAP_SIZE	/* mapped size of IMMR area */
-
-#define PCMCIA_MEM_ADDR	((uint)0xFE100000)
-#define PCMCIA_MEM_SIZE	((uint)(64 * 1024))
-
-#define IDE0_INTERRUPT	10		/* = IRQ5 */
-#define IDE1_INTERRUPT	12		/* = IRQ6 */
-#define CPM_INTERRUPT	13		/* = SIU_LEVEL6 (was: SIU_LEVEL2) */
-
-/* override the default number of IDE hardware interfaces */
-#define MAX_HWIFS	2
-
-/*
- * Definitions for IDE0 Interface
- */
-#define IDE0_BASE_OFFSET		0x0000	/* Offset in PCMCIA memory */
-#define IDE0_DATA_REG_OFFSET		0x0000
-#define IDE0_ERROR_REG_OFFSET		0x0081
-#define IDE0_NSECTOR_REG_OFFSET		0x0082
-#define IDE0_SECTOR_REG_OFFSET		0x0083
-#define IDE0_LCYL_REG_OFFSET		0x0084
-#define IDE0_HCYL_REG_OFFSET		0x0085
-#define IDE0_SELECT_REG_OFFSET		0x0086
-#define IDE0_STATUS_REG_OFFSET		0x0087
-#define IDE0_CONTROL_REG_OFFSET		0x0106
-#define IDE0_IRQ_REG_OFFSET		0x000A	/* not used */
-
-/*
- * Definitions for IDE1 Interface
- */
-#define IDE1_BASE_OFFSET		0x0C00	/* Offset in PCMCIA memory */
-#define IDE1_DATA_REG_OFFSET		0x0000
-#define IDE1_ERROR_REG_OFFSET		0x0081
-#define IDE1_NSECTOR_REG_OFFSET		0x0082
-#define IDE1_SECTOR_REG_OFFSET		0x0083
-#define IDE1_LCYL_REG_OFFSET		0x0084
-#define IDE1_HCYL_REG_OFFSET		0x0085
-#define IDE1_SELECT_REG_OFFSET		0x0086
-#define IDE1_STATUS_REG_OFFSET		0x0087
-#define IDE1_CONTROL_REG_OFFSET		0x0106
-#define IDE1_IRQ_REG_OFFSET		0x000A	/* not used */
-
-/* CPM Ethernet through SCCx.
- *
- * Bits in parallel I/O port registers that have to be set/cleared
- * to configure the pins for SCC2 use.
- */
-#define PA_ENET_MDC	((ushort)0x0001)	/* PA 15 !!! */
-#define PA_ENET_MDIO	((ushort)0x0002)	/* PA 14 !!! */
-#define PA_ENET_RXD	((ushort)0x0004)	/* PA 13 */
-#define PA_ENET_TXD	((ushort)0x0008)	/* PA 12 */
-#define PA_ENET_RCLK	((ushort)0x0200)	/* PA  6 */
-#define PA_ENET_TCLK	((ushort)0x0400)	/* PA  5 */
-
-#define PB_ENET_TENA	((uint)0x00002000)	/* PB 18 */
-
-#define PC_ENET_CLSN	((ushort)0x0040)	/* PC  9 */
-#define PC_ENET_RENA	((ushort)0x0080)	/* PC  8 */
-#define PC_ENET_RESET	((ushort)0x0100)	/* PC  7 !!! */
-
-/* Control bits in the SICR to route TCLK (CLK3) and RCLK (CLK2) to
- * SCC2.  Also, make sure GR2 (bit 16) and SC2 (bit 17) are zero.
- */
-#define SICR_ENET_MASK	((uint)0x0000ff00)
-#define SICR_ENET_CLKRT	((uint)0x00002E00)
-
-/* We don't use the 8259.
-*/
-#define NR_8259_INTS	0
-
-#endif /* !__ASSEMBLY__ */
-#endif /* __ASM_SPD8XX_H__ */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -36,10 +36,6 @@
 #include <platforms/tqm8xx.h>
 #endif
 
-#if defined(CONFIG_SPD823TS)
-#include <platforms/spd8xx.h>
-#endif
-
 #if defined(CONFIG_IVMS8) || defined(CONFIG_IVML24)
 #include <platforms/ivms8.h>
 #endif
