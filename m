Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUA2JKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 04:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUA2JKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 04:10:45 -0500
Received: from pop.gmx.de ([213.165.64.20]:41176 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263526AbUA2JKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 04:10:04 -0500
X-Authenticated: #12437197
Date: Thu, 29 Jan 2004 11:10:00 +0200
From: Dan Aloni <da-x@gmx.net>
To: Paul Zimmerman <paulsnosp_macct@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cooperative Linux
Message-ID: <20040129091000.GA11064@callisto.yi.org>
References: <BAY1-F17SORWNIfuDg10001da54@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-F17SORWNIfuDg10001da54@hotmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 09:57:41PM -0800, Paul Zimmerman wrote:
> For fun, I though I would try building this, so I downloaded the source 
> tarball from sourceforge. But it seems the makefile for building the host 
> OS support code (src/colinux/os/winnt/build/Makefile, mentioned in 
> doc/building) is missing. Is this just an oversight, or do you intend that 
> it not be buildable at this time?

A few files were missing when I packed it.
Here's the patch I sent on the colinux-devel mailing list against that tarball.

diff -urN colinux-20040119/ChangeLog colinux-20040128/ChangeLog
--- colinux-20040119/ChangeLog	1970-01-01 02:00:00.000000000 +0200
+++ colinux-20040128/ChangeLog	2004-01-27 01:01:26.000000000 +0200
@@ -0,0 +1,4 @@
+Version 0.5.2
+ * Added some missing files to the build tree
+ * doc/cygwin-cross-build - How to build a cygwin cross compilation tools
+   on Linux.
diff -urN colinux-20040119/conf/README colinux-20040128/conf/README
--- colinux-20040119/conf/README	1970-01-01 02:00:00.000000000 +0200
+++ colinux-20040128/conf/README	2004-01-19 17:42:07.000000000 +0200
@@ -0,0 +1,4 @@
+This directory contains example configuration files for the coLinux daemon.
+
+It also contain a configuration file that can be used as a .config for
+compling the cooperative Linux kernel.
\ No newline at end of file
diff -urN colinux-20040119/conf/default.colinux.xml colinux-20040128/conf/default.colinux.xml
--- colinux-20040119/conf/default.colinux.xml	1970-01-01 02:00:00.000000000 +0200
+++ colinux-20040128/conf/default.colinux.xml	2004-01-19 17:22:03.000000000 +0200
@@ -0,0 +1,8 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<colinux>
+    <block_device index="0" path="\DosDevices\c:\colinux\root_fs" enabled="true">
+    <block_device index="1" path="\DosDevices\c:\colinux\swap_device" enabled="true">
+    </block_device>
+    <bootparams>init=/bin/bash</bootparams>
+    <image path="vmlinux"></image>
+</colinux>
diff -urN colinux-20040119/conf/linux-config colinux-20040128/conf/linux-config
--- colinux-20040119/conf/linux-config	1970-01-01 02:00:00.000000000 +0200
+++ colinux-20040128/conf/linux-config	2004-01-26 23:13:01.000000000 +0200
@@ -0,0 +1,515 @@
+#
+# Automatically generated make config: don't edit
+#
+CONFIG_X86=y
+# CONFIG_SBUS is not set
+CONFIG_UID16=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
+CONFIG_KMOD=y
+
+#
+# Processor type and features
+#
+CONFIG_M386=y
+# CONFIG_M486 is not set
+# CONFIG_M586 is not set
+# CONFIG_M586TSC is not set
+# CONFIG_M586MMX is not set
+# CONFIG_M686 is not set
+# CONFIG_MPENTIUMIII is not set
+# CONFIG_MPENTIUM4 is not set
+# CONFIG_MK6 is not set
+# CONFIG_MK7 is not set
+# CONFIG_MK8 is not set
+# CONFIG_MELAN is not set
+# CONFIG_MCRUSOE is not set
+# CONFIG_MWINCHIPC6 is not set
+# CONFIG_MWINCHIP2 is not set
+# CONFIG_MWINCHIP3D is not set
+# CONFIG_MCYRIXIII is not set
+# CONFIG_MVIAC3_2 is not set
+# CONFIG_X86_CMPXCHG is not set
+# CONFIG_X86_XADD is not set
+CONFIG_X86_L1_CACHE_SHIFT=4
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_X86_PPRO_FENCE=y
+# CONFIG_X86_F00F_WORKS_OK is not set
+# CONFIG_X86_MCE is not set
+# CONFIG_TOSHIBA is not set
+# CONFIG_I8K is not set
+# CONFIG_MICROCODE is not set
+# CONFIG_X86_MSR is not set
+# CONFIG_X86_CPUID is not set
+# CONFIG_EDD is not set
+CONFIG_NOHIGHMEM=y
+# CONFIG_HIGHMEM4G is not set
+# CONFIG_HIGHMEM64G is not set
+# CONFIG_HIGHMEM is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_MTRR is not set
+# CONFIG_SMP is not set
+CONFIG_X86_UP_COPIC=y
+CONFIG_X86_COPIC=y
+# CONFIG_X86_TSC_DISABLE is not set
+CONFIG_X86_TSC=y
+
+#
+# General setup
+#
+CONFIG_NET=y
+# CONFIG_PCI is not set
+# CONFIG_ISA is not set
+# CONFIG_EISA is not set
+# CONFIG_MCA is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
+# CONFIG_HOTPLUG_PCI is not set
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+CONFIG_KCORE_ELF=y
+# CONFIG_KCORE_AOUT is not set
+CONFIG_BINFMT_AOUT=y
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+# CONFIG_PM is not set
+# CONFIG_APM_IGNORE_USER_SUSPEND is not set
+# CONFIG_APM_DO_ENABLE is not set
+# CONFIG_APM_CPU_IDLE is not set
+# CONFIG_APM_DISPLAY_BLANK is not set
+# CONFIG_APM_RTC_IS_GMT is not set
+# CONFIG_APM_ALLOW_INTS is not set
+# CONFIG_APM_REAL_MODE_POWER_OFF is not set
+CONFIG_COOPERATIVE=y
+
+#
+# ACPI Support
+#
+# CONFIG_ACPI is not set
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
+# Plug and Play configuration
+#
+# CONFIG_PNP is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_BLK_DEV_PBD=y
+CONFIG_BLK_STATS=y
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_NETLINK_DEV=y
+# CONFIG_NETFILTER is not set
+# CONFIG_FILTER is not set
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_INET_ECN is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_IPV6 is not set
+# CONFIG_KHTTPD is not set
+
+#
+#    SCTP Configuration (EXPERIMENTAL)
+#
+CONFIG_IPV6_SCTP__=y
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+
+#
+#  
+#
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+
+#
+# Appletalk devices
+#
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_LLC is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_FASTROUTE is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
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
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# ATA/IDE/MFM/RLL support
+#
+# CONFIG_IDE is not set
+# CONFIG_BLK_DEV_IDE_MODES is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI support
+#
+# CONFIG_SCSI is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION_BOOT is not set
+# CONFIG_FUSION_ISENSE is not set
+# CONFIG_FUSION_CTL is not set
+# CONFIG_FUSION_LAN is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_ETHERTAP is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC_OMIT_TIGON_I is not set
+# CONFIG_E1000_NAPI is not set
+CONFIG_COOPERATIVE_CONET=y
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+
+#
+# Amateur Radio support
+#
+# CONFIG_HAMRADIO is not set
+
+#
+# IrDA (infrared) support
+#
+# CONFIG_IRDA is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Input core support
+#
+# CONFIG_INPUT is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+# CONFIG_SERIAL is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_UNIX98_PTY_COUNT=256
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Mice
+#
+# CONFIG_BUSMOUSE is not set
+# CONFIG_MOUSE is not set
+
+#
+# Joysticks
+#
+# CONFIG_INPUT_GAMEPORT is not set
+
+#
+# Input core support is needed for gameports
+#
+
+#
+# Input core support is needed for joysticks
+#
+# CONFIG_QIC02_TAPE is not set
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_SCx200_GPIO is not set
+# CONFIG_NVRAM is not set
+# CONFIG_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+
+#
+# Direct Rendering Manager (XFree86 DRI support)
+#
+# CONFIG_DRM is not set
+# CONFIG_MWAVE is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# File systems
+#
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+CONFIG_EXT3_FS=y
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+# CONFIG_UMSDOS_FS is not set
+CONFIG_VFAT_FS=m
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+CONFIG_TMPFS=y
+CONFIG_RAMFS=y
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+# CONFIG_JFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_NTFS_FS is not set
+# CONFIG_HPFS_FS is not set
+CONFIG_PROC_FS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_EXT2_FS=y
+# CONFIG_SYSV_FS is not set
+# CONFIG_UDF_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
+# CONFIG_NFS_FS is not set
+# CONFIG_NFSD is not set
+# CONFIG_SUNRPC is not set
+# CONFIG_LOCKD is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_NCP_FS is not set
+CONFIG_ZISOFS_FS=m
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_SMB_NLS is not set
+CONFIG_NLS=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Console drivers
+#
+CONFIG_COOPERATIVE_CONSOLE=y
+# CONFIG_VIDEO_SELECT is not set
+# CONFIG_MDA_CONSOLE is not set
+
+#
+# Frame-buffer support
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
+
+#
+# Support for USB gadgets
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# Bluetooth support
+#
+# CONFIG_BLUEZ is not set
+
+#
+# Kernel hacking
+#
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_HIGHMEM is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_IOVIRT is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+CONFIG_FRAME_POINTER=y
+CONFIG_LOG_BUF_SHIFT=0
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Library routines
+#
+CONFIG_CRC32=m
+CONFIG_ZLIB_INFLATE=m
+CONFIG_ZLIB_DEFLATE=m
diff -urN colinux-20040119/doc/cygwin-cross-build colinux-20040128/doc/cygwin-cross-build
--- colinux-20040119/doc/cygwin-cross-build	1970-01-01 02:00:00.000000000 +0200
+++ colinux-20040128/doc/cygwin-cross-build	2004-01-27 01:29:39.000000000 +0200
@@ -0,0 +1,51 @@
+Building Cygwin cross compilation tools for Linux
+=================================================
+
+First, choose an installation directory, for example: /usr/local/w32build.
+I'd refer to that directory as $PREFIX from this point in the document.
+
+Download the latest base cygwin tarball from cygwin.com, for example, 
+http://mirrors.xmission.com/cygwin/release/cygwin/cygwin-1.5.7-1.tar.bz2
+
+Extract that tarball to the installation directory in this manner:
+
+    tar -xjf cygwin-1.5.7-1.tar.bz2 
+    rename usr i686-pc-cygwin
+
+Now you have a ready $PREFIX/i686-pc-cygwin directory.
+
+
+Download binutils from GNU's website. Configure, build and install with:
+
+   ./configure --target=i686-pc-cygwin --prefix=$PREFIX
+   make 
+   make install
+  
+
+Download the latest gcc sources, both the gcc-core and gcc-g++ parts. Extract
+those in a separate directory, and build gcc using this procedure:
+
+   ./configure --prefix=$PREFIX -host=i686-pc-linux-gnu --target=i686-pc-cygwin --enable-languages=c,c++
+
+Run make, but it would fail at some point:
+   
+   make
+
+It's a chicken and egg problem. It fails because the i686-pc-cygwin-* compiler 
+is not installed yet in $PREFIX (and accessable from $PATH). Run (with the 
+proper privlieges):
+   
+   make install
+
+Make sure that i686-pc-cygwin-gcc is accessable from $PATH. In gcc's build 
+directory, run again:
+
+   make 
+
+It should now properly build the standard libs with the start object files.
+And then again run (with the proper privlieges):
+ 
+   make install
+
+To test it, try to produce a .exe file from a 'void main(){}' C program, 
+using i686-pc-cygwin-gcc.
diff -urN colinux-20040119/patch/linux colinux-20040128/patch/linux
--- colinux-20040119/patch/linux	2004-01-19 18:25:41.000000000 +0200
+++ colinux-20040128/patch/linux	2004-01-27 00:04:02.000000000 +0200
@@ -3326,7 +3326,7 @@
  #define __TSS(n) (((n)<<2) + __FIRST_TSS_ENTRY)
 diff -X bin/dontdiff -urN linux/include/asm-i386/dma.h linux/include/asm-i386/dma.h
 --- linux/include/asm-i386/dma.h	2004-01-05 05:39:23.000000000 +0200
-+++ linux/include/asm-i386/dma.h	2003-12-20 03:01:30.000000000 +0200
++++ linux/include/asm-i386/dma.h	2004-01-26 23:39:36.000000000 +0200
 @@ -268,6 +268,8 @@
   *
   * Assumes DMA flip-flop is clear.
@@ -3347,7 +3347,7 @@
  extern int request_dma(unsigned int dmanr, const char * device_id);	/* reserve a DMA channel */
 diff -X bin/dontdiff -urN linux/include/asm-i386/io.h linux/include/asm-i386/io.h
 --- linux/include/asm-i386/io.h	2004-01-05 05:39:23.000000000 +0200
-+++ linux/include/asm-i386/io.h	2003-12-26 18:28:26.000000000 +0200
++++ linux/include/asm-i386/io.h	2004-01-27 00:00:07.000000000 +0200
 @@ -2,6 +2,7 @@
  #define _ASM_IO_H
  
@@ -3356,18 +3356,15 @@
  
  /*
   * This file contains the definitions for the x86 IO instructions
-@@ -46,6 +47,10 @@
+@@ -45,6 +46,7 @@
+ #ifdef __KERNEL__
  
  #include <linux/vmalloc.h>
++#include <linux/cooperative.h>
  
-+#ifdef CONFIG_COOPERATIVE
-+#include <linux/colinux.h>
-+#endif
-+
  /*
   * Temporary debugging check to catch old code using
-  * unmapped ISA addresses. Will be removed in 2.4.
-@@ -121,6 +126,10 @@
+@@ -121,6 +123,10 @@
   
  static inline void * ioremap (unsigned long offset, unsigned long size)
  {
@@ -3378,7 +3375,7 @@
  	return __ioremap(offset, size, 0);
  }
  
-@@ -146,6 +155,10 @@
+@@ -146,6 +152,10 @@
   
  static inline void * ioremap_nocache (unsigned long offset, unsigned long size)
  {
@@ -3389,7 +3386,7 @@
          return __ioremap(offset, size, _PAGE_PCD);
  }
  
-@@ -308,6 +321,8 @@
+@@ -308,6 +318,8 @@
  
  #endif /* __KERNEL__ */
  
@@ -3398,7 +3395,7 @@
  #ifdef SLOW_IO_BY_JUMPING
  #define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
  #else
-@@ -427,4 +442,19 @@
+@@ -427,4 +439,19 @@
  __OUTS(w)
  __OUTS(l)
  
@@ -3443,7 +3440,7 @@
  #define NR_IRQS 16
 diff -X bin/dontdiff -urN linux/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
 --- linux/include/asm-i386/mmu_context.h	2004-01-05 05:37:17.000000000 +0200
-+++ linux/include/asm-i386/mmu_context.h	2003-12-20 02:42:52.000000000 +0200
++++ linux/include/asm-i386/mmu_context.h	2004-01-26 23:39:35.000000000 +0200
 @@ -41,6 +41,7 @@
  #endif
  		set_bit(cpu, &next->cpu_vm_mask);
@@ -3521,7 +3518,7 @@
  #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 diff -X bin/dontdiff -urN linux/include/asm-i386/pgalloc.h linux/include/asm-i386/pgalloc.h
 --- linux/include/asm-i386/pgalloc.h	2004-01-05 05:37:14.000000000 +0200
-+++ linux/include/asm-i386/pgalloc.h	2003-12-20 02:42:48.000000000 +0200
++++ linux/include/asm-i386/pgalloc.h	2004-01-26 23:39:33.000000000 +0200
 @@ -11,8 +11,13 @@
  #define pte_quicklist (current_cpu_data.pte_quick)
  #define pgtable_cache_size (current_cpu_data.pgtable_cache_sz)
@@ -3558,7 +3555,7 @@
  #endif /* _I386_PGTABLE_2LEVEL_H */
 diff -X bin/dontdiff -urN linux/include/asm-i386/pgtable.h linux/include/asm-i386/pgtable.h
 --- linux/include/asm-i386/pgtable.h	2004-01-05 05:37:14.000000000 +0200
-+++ linux/include/asm-i386/pgtable.h	2003-12-20 02:42:48.000000000 +0200
++++ linux/include/asm-i386/pgtable.h	2004-01-26 23:39:33.000000000 +0200
 @@ -320,8 +320,13 @@
  
  #define page_pte(page) page_pte_prot(page, __pgprot(0))
@@ -3576,7 +3573,7 @@
  #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 diff -X bin/dontdiff -urN linux/include/asm-i386/processor.h linux/include/asm-i386/processor.h
 --- linux/include/asm-i386/processor.h	2004-01-05 05:37:14.000000000 +0200
-+++ linux/include/asm-i386/processor.h	2003-12-13 17:17:01.000000000 +0200
++++ linux/include/asm-i386/processor.h	2004-01-26 23:39:33.000000000 +0200
 @@ -181,8 +181,18 @@
  #define X86_CR4_OSFXSR		0x0200	/* enable fast FPU save and restore */
  #define X86_CR4_OSXMMEXCPT	0x0400	/* enable unmasked SSE exceptions */
@@ -3625,7 +3622,7 @@
  #endif
 diff -X bin/dontdiff -urN linux/include/linux/console.h linux/include/linux/console.h
 --- linux/include/linux/console.h	2004-01-05 05:37:20.000000000 +0200
-+++ linux/include/linux/console.h	2003-12-13 17:33:48.000000000 +0200
++++ linux/include/linux/console.h	2004-01-26 23:39:38.000000000 +0200
 @@ -55,6 +55,7 @@
  extern const struct consw dummy_con;	/* dummy console buffer */
  extern const struct consw fb_con;	/* frame buffer based console */
@@ -3636,7 +3633,7 @@
  
 diff -X bin/dontdiff -urN linux/include/linux/cooperative.h linux/include/linux/cooperative.h
 --- linux/include/linux/cooperative.h	1970-01-01 02:00:00.000000000 +0200
-+++ linux/include/linux/cooperative.h	2003-12-27 11:46:21.000000000 +0200
++++ linux/include/linux/cooperative.h	2004-01-24 10:19:19.000000000 +0200
 @@ -0,0 +1,173 @@
 +#ifndef __LINUX_COOPERATIVE_H__
 +#define __LINUX_COOPERATIVE_H__
diff -urN colinux-20040119/src/colinux/os/winnt/build/Makefile colinux-20040128/src/colinux/os/winnt/build/Makefile
--- colinux-20040119/src/colinux/os/winnt/build/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ colinux-20040128/src/colinux/os/winnt/build/Makefile	2004-01-19 18:33:28.000000000 +0200
@@ -0,0 +1,85 @@
+# Standard Makefile header
+ifeq ($(BUILD_ROOT),)
+BUILD_ROOT=../../../..
+include $(BUILD_ROOT)/Makefile
+else
+BUILD_PATH := $(BUILD_PATH)/build
+#-----------------------------------------------------------------
+
+LOCAL_TARGETS = $(BUILD_PATH)/driver.o
+
+$(BUILD_PATH)/driver.o : \
+	$(BUILD_ROOT)/colinux/common/common.o \
+	$(BUILD_ROOT)/colinux/kernel/kernel.o \
+	$(BUILD_ROOT)/colinux/os/current/kernel/kernel.o \
+	$(BUILD_ROOT)/colinux/arch/current/arch.o \
+
+	$(TOOL_LD_RELOC)
+
+DRIVER_TARGET := $(BUILD_PATH)/linux.sys 
+
+WINDIR=$(WINUSER)@$(WINBOX):$(WINREMOTEDIR)
+WINBOX_SCP=scp -i ~/.ssh/locallan 
+WINBOX_SSH=ssh -X -l $(WINUSER) -i ~/.ssh/locallan $(WINBOX)
+WINLINK=$(WINBOX_SSH) /cygdrive/c/NTDDK/bin/link.exe
+
+WINLINK_FLAGS= \
+    /machine:ix86 \
+    /STACK:262144,4096 \
+    /MERGE:_PAGE=PAGE \
+    /MERGE:_TEXT=.text \
+    /SECTION:INIT,d \
+    /OPT:REF \
+    /OPT:ICF \
+    /IGNORE:4001,4037,4039,4044,4065,4070,4078,4087,4089,4198 \
+    /INCREMENTAL:NO \
+    /FULLBUILD \
+    /FORCE:MULTIPLE \
+    /NOCOMMENT \
+    /release \
+    /NODEFAULTLIB \
+    /debug:FULL \
+    /debugtype:cv \
+    /version:5.00 \
+    /osversion:5.00 \
+    /optidata \
+    /driver \
+    /align:0x1000 \
+    /filealign:0x1000 \
+    /subsystem:native,5.00 \
+    /base:0x10000 \
+    /entry:DriverEntry@8 \
+
+WINLINK_LIBS= \
+    C:\\\\NTDDK\\\\libfre\\\\i386\\\\ntoskrnl.lib \
+    C:\\\\NTDDK\\\\libfre\\\\i386\\\\hal.lib \
+    C:\\\\NTDDK\\\\libfre\\\\i386\\\\wmilib.lib \
+
+$(DRIVER_TARGET): $(BUILD_PATH)/driver.o
+	$(WINBOX_SCP) $^ $(WINDIR)
+	$(WINLINK) /out:$(notdir $@) $(WINLINK_FLAGS) $(notdir $^) $(WINLINK_LIBS)
+	$(WINBOX_SCP) $(WINDIR)$(notdir $@) $@
+
+LOCAL_TARGET += $(DRIVER_TARGET)
+LOCAL_FILES = \
+	$(DRIVER_TARGET) \
+	$(BUILD_ROOT)/../../linux/vmlinux \
+	$(BUILD_ROOT)/colinux/os/current/user/daemon/colinux-daemon.exe \
+	$(BUILD_ROOT)/colinux/os/current/user/console/colinux-console.exe \
+
+colinux: $(LOCAL_FILES)
+
+upload: $(LOCAL_FILES)
+	$(WINBOX_SCP) $^ $(WINDIR)
+
+upload_console: $(BUILD_ROOT)/colinux/os/current/user/console/colinux-console.exe
+	$(WINBOX_SCP) $^ $(WINDIR)
+
+driver : $(BUILD_PATH)/driver.o
+
+CLEAN_FILES := $(CLEAN_FILES) \
+	$(LOCAL_TARGETS) $(BUILD_PATH)/kernel.o
+
+#-----------------------------------------------------------------
+BUILD_PATH := $(shell dirname $(BUILD_PATH))
+endif


-- 
Dan Aloni
da-x@gmx.net
