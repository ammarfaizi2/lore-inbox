Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUB1K3j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 05:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUB1K3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 05:29:39 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34248 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261261AbUB1K3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 05:29:08 -0500
Date: Sat, 28 Feb 2004 11:28:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove a few remaining "make dep"
Message-ID: <20040228102843.GM5499@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below is an updated version of the patch that removes some 
remaining mentionings of "make dep".

diffstat output:

 Documentation/networking/arcnet.txt            |    1 -
 arch/arm/kernel/Makefile                       |    2 +-
 arch/arm26/mm/Makefile                         |    7 -------
 arch/h8300/mm/Makefile                         |    5 -----
 arch/h8300/platform/h8300h/Makefile            |    4 ----
 arch/h8300/platform/h8300h/aki3068net/Makefile |    4 ----
 arch/h8300/platform/h8300h/generic/Makefile    |    4 ----
 arch/h8300/platform/h8300h/h8max/Makefile      |    4 ----
 arch/h8300/platform/h8s/Makefile               |    4 ----
 arch/h8300/platform/h8s/edosk2674/Makefile     |    4 ----
 arch/h8300/platform/h8s/generic/Makefile       |    4 ----
 arch/i386/mach-voyager/Makefile                |    5 -----
 arch/mips/au1000/csb250/Makefile               |    4 ----
 arch/mips/au1000/hydrogen3/Makefile            |    4 ----
 arch/mips/au1000/mtx-1/Makefile                |    4 ----
 arch/mips/au1000/pb1550/Makefile               |    4 ----
 arch/mips/au1000/xxs1500/Makefile              |    4 ----
 arch/mips/kernel/gdb-stub.c                    |    2 +-
 arch/mips/momentum/jaguar_atx/Makefile         |    4 ----
 arch/mips/tx4927/common/Makefile               |    4 ----
 arch/sh/boards/adx/Makefile                    |    4 ----
 arch/sh/boards/bigsur/Makefile                 |    4 ----
 arch/sh/boards/cat68701/Makefile               |    4 ----
 arch/sh/boards/cqreek/Makefile                 |    4 ----
 arch/sh/boards/dmida/Makefile                  |    4 ----
 arch/sh/boards/dreamcast/Makefile              |    4 ----
 arch/sh/boards/ec3104/Makefile                 |    4 ----
 arch/sh/boards/harp/Makefile                   |    4 ----
 arch/sh/boards/hp6xx/hp620/Makefile            |    4 ----
 arch/sh/boards/hp6xx/hp680/Makefile            |    4 ----
 arch/sh/boards/hp6xx/hp690/Makefile            |    4 ----
 arch/sh/boards/mpc1211/Makefile                |    4 ----
 arch/sh/boards/overdrive/Makefile              |    4 ----
 arch/sh/boards/saturn/Makefile                 |    4 ----
 arch/sh/boards/se/770x/Makefile                |    4 ----
 arch/sh/boards/se/7751/Makefile                |    4 ----
 arch/sh/boards/sh2000/Makefile                 |    4 ----
 arch/sh/boards/snapgear/Makefile               |    4 ----
 arch/sh/boards/systemh/Makefile                |    4 ----
 arch/sh/boards/unknown/Makefile                |    4 ----
 arch/sh/cchips/hd6446x/hd64461/Makefile        |    4 ----
 arch/sh/cchips/hd6446x/hd64465/Makefile        |    4 ----
 drivers/video/i810/Makefile                    |    6 ------
 drivers/video/kyro/Makefile                    |    5 -----
 fs/befs/Makefile                               |    6 ------
 net/ipv4/ipvs/Makefile                         |    7 -------
 46 files changed, 2 insertions(+), 188 deletions(-)


Please apply
Adrian


--- linux-2.6.0-test3.orig/Documentation/networking/arcnet.txt	Sat Aug  9 00:31:44 2003
+++ linux-2.6.0-test3/Documentation/networking/arcnet.txt	Mon Aug 11 00:35:29 2003
@@ -186,7 +186,6 @@
 to the chipset support if you wish.
 
 	make config
-	make dep
 	make clean	
 	make zImage
 	make modules
--- linux-2.6.0-test3.orig/arch/arm/kernel/Makefile	Sat Aug  9 00:40:56 2003
+++ linux-2.6.0-test3/arch/arm/kernel/Makefile	Mon Aug 11 00:29:32 2003
@@ -32,7 +32,7 @@
 
 extra-y := $(head-y) init_task.o
 
-# Spell out some dependencies that `make dep' doesn't spot
+# Spell out some dependencies that aren't automatically figured out
 $(obj)/entry-armv.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
 $(obj)/entry-armo.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
 $(obj)/entry-common.o: 	$(obj)/entry-header.S include/asm-arm/constants.h \
--- linux-2.6.1-mm4/arch/arm26/mm/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/arm26/mm/Makefile	2004-01-18 18:59:52.000000000 +0100
@@ -1,12 +1,5 @@
 #
 # Makefile for the linux arm26-specific parts of the memory manager.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definition is now in the main makefile...
-
-# Object file lists.
 
 obj-y		:= init.o extable.o proc-funcs.o mm-memc.o fault.o
--- linux-2.6.1-mm4/arch/h8300/mm/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/h8300/mm/Makefile	2004-01-18 18:59:58.000000000 +0100
@@ -1,10 +1,5 @@
 #
 # Makefile for the linux m68k-specific parts of the memory manager.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definition is now in the main makefile...
 
 obj-y	 := init.o fault.o memory.o kmap.o extable.o
--- linux-2.6.1-mm4/arch/h8300/platform/h8300h/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/h8300/platform/h8300h/Makefile	2004-01-18 19:00:06.000000000 +0100
@@ -6,10 +6,6 @@
 
 #VPATH := $(VPATH):$(BOARD)
 
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 .S.o:
 	$(CC) -D__ASSEMBLY__ $(AFLAGS) -I. -c $< -o $*.o
 
--- linux-2.6.1-mm4/arch/h8300/platform/h8300h/aki3068net/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/h8300/platform/h8300h/aki3068net/Makefile	2004-01-18 19:00:12.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 extra-y := crt0_ram.o
 obj-y := timer.o
--- linux-2.6.1-mm4/arch/h8300/platform/h8300h/generic/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/h8300/platform/h8300h/generic/Makefile	2004-01-18 19:00:16.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y := timer.o
 extra-y =  crt0_$(MODEL).o
--- linux-2.6.1-mm4/arch/h8300/platform/h8300h/h8max/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/h8300/platform/h8300h/h8max/Makefile	2004-01-18 19:00:20.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 extra-y := crt0_ram.o
 obj-y := timer.o
--- linux-2.6.1-mm4/arch/h8300/platform/h8s/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/h8300/platform/h8s/Makefile	2004-01-18 19:00:27.000000000 +0100
@@ -6,10 +6,6 @@
 
 #VPATH := $(VPATH):$(BOARD)
 
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 .S.o:
 	$(CC) -D__ASSEMBLY__ $(AFLAGS) -I. -c $< -o $*.o
 
--- linux-2.6.1-mm4/arch/h8300/platform/h8s/edosk2674/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/h8300/platform/h8s/edosk2674/Makefile	2004-01-18 19:00:33.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 extra-y := crt0_ram.o
 obj-y := timer.o
--- linux-2.6.1-mm4/arch/h8300/platform/h8s/generic/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/h8300/platform/h8s/generic/Makefile	2004-01-18 19:00:38.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 extra-y =  crt0_$(MODEL).o
 obj-y := timer.o
--- linux-2.6.1-mm4/arch/i386/mach-voyager/Makefile.old	2004-01-18 18:59:31.000000000 +0100
+++ linux-2.6.1-mm4/arch/i386/mach-voyager/Makefile	2004-01-18 19:00:43.000000000 +0100
@@ -1,11 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definitions are now in the main makefile...
 
 EXTRA_CFLAGS	+= -I../kernel
 obj-y			:= setup.o voyager_basic.o voyager_thread.o
--- linux-2.6.0-test3.orig/arch/mips/kernel/gdb-stub.c	Sat Aug  9 00:42:17 2003
+++ linux-2.6.0-test3/arch/mips/kernel/gdb-stub.c	Mon Aug 11 00:29:16 2003
@@ -95,7 +95,7 @@
  *  Example:
  *    $ cd ~/linux
  *    $ make menuconfig <go to "Kernel Hacking" and turn on remote debugging>
- *    $ make dep; make vmlinux
+ *    $ make
  *
  *  Step 3:
  *  Download the kernel to the remote target and start
--- linux-2.6.1-mm4/arch/mips/tx4927/common/Makefile.old	2004-01-18 19:03:57.000000000 +0100
+++ linux-2.6.1-mm4/arch/mips/tx4927/common/Makefile	2004-01-18 19:04:25.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for common code for Toshiba TX4927 based systems
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	:= tx4927_prom.o
 obj-y	+= tx4927_setup.o
--- linux-2.6.1-mm4/arch/sh/boards/adx/Makefile.old	2004-01-18 19:03:57.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/adx/Makefile	2004-01-18 19:04:37.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for ADX boards
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o irq.o irq_maskreq.o
 
--- linux-2.6.1-mm4/arch/sh/boards/bigsur/Makefile.old	2004-01-18 19:03:57.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/bigsur/Makefile	2004-01-18 19:04:46.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the BigSur specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o io.o irq.o led.o
 
--- linux-2.6.1-mm4/arch/sh/boards/cat68701/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/cat68701/Makefile	2004-01-18 19:04:50.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the CAT-68701 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o irq.o
 
--- linux-2.6.1-mm4/arch/sh/boards/cqreek/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/cqreek/Makefile	2004-01-18 19:04:54.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the CqREEK specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o irq.o
 
--- linux-2.6.1-mm4/arch/sh/boards/dmida/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/dmida/Makefile	2004-01-18 19:04:58.000000000 +0100
@@ -2,10 +2,6 @@
 # Makefile for the DataMyte Industrial Digital Assistant(tm) specific parts
 # of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := mach.o
 
--- linux-2.6.1-mm4/arch/sh/boards/dreamcast/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/dreamcast/Makefile	2004-01-18 19:05:02.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the Sega Dreamcast specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o irq.o rtc.o
 
--- linux-2.6.1-mm4/arch/sh/boards/ec3104/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/ec3104/Makefile	2004-01-18 19:05:07.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the EC3104 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o io.o irq.o
 
--- linux-2.6.1-mm4/arch/sh/boards/harp/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/harp/Makefile	2004-01-18 19:05:11.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for STMicroelectronics board specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y := irq.o setup.o mach.o led.o
 
--- linux-2.6.1-mm4/arch/sh/boards/hp6xx/hp620/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/hp6xx/hp620/Makefile	2004-01-18 19:05:15.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the HP620 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := mach.o
 
--- linux-2.6.1-mm4/arch/sh/boards/hp6xx/hp680/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/hp6xx/hp680/Makefile	2004-01-18 19:05:19.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the HP680 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := mach.o
 
--- linux-2.6.1-mm4/arch/sh/boards/hp6xx/hp690/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/hp6xx/hp690/Makefile	2004-01-18 19:05:25.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the HP690 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := mach.o
 
--- linux-2.6.1-mm4/arch/sh/boards/mpc1211/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/mpc1211/Makefile	2004-01-18 19:05:28.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the Interface (CTP/PCI/MPC-SH02) specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o rtc.o led.o
 
--- linux-2.6.1-mm4/arch/sh/boards/overdrive/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/overdrive/Makefile	2004-01-18 19:05:32.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the STMicroelectronics Overdrive specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := mach.o setup.o io.o irq.o led.o time.o
 
--- linux-2.6.1-mm4/arch/sh/boards/saturn/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/saturn/Makefile	2004-01-18 19:05:36.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the Sega Saturn specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o io.o irq.o
 
--- linux-2.6.1-mm4/arch/sh/boards/se/770x/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/se/770x/Makefile	2004-01-18 19:05:40.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the 770x SolutionEngine specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := mach.o setup.o io.o irq.o led.o
 
--- linux-2.6.1-mm4/arch/sh/boards/se/7751/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/se/7751/Makefile	2004-01-18 19:05:44.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the 7751 SolutionEngine specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := mach.o setup.o io.o irq.o led.o
 
--- linux-2.6.1-mm4/arch/sh/boards/sh2000/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/sh2000/Makefile	2004-01-18 19:05:47.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the SH2000 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o
 
--- linux-2.6.1-mm4/arch/sh/boards/unknown/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/boards/unknown/Makefile	2004-01-18 19:05:51.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for unknown SH boards 
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := mach.o io.o setup.o
 
--- linux-2.6.1-mm4/arch/sh/cchips/hd6446x/hd64461/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/cchips/hd6446x/hd64461/Makefile	2004-01-18 19:05:54.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the HD64461 
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o io.o
 
--- linux-2.6.1-mm4/arch/sh/cchips/hd6446x/hd64465/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/arch/sh/cchips/hd6446x/hd64465/Makefile	2004-01-18 19:05:58.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the HD64465
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o io.o gpio.o
 
--- linux-2.6.1-mm4/drivers/video/i810/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/drivers/video/i810/Makefile	2004-01-18 19:06:04.000000000 +0100
@@ -1,12 +1,6 @@
 #
 # Makefile for the Intel 810/815 framebuffer driver
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definitions are now in the main makefile...
-
 
 obj-$(CONFIG_FB_I810)		+= i810fb.o
 
--- linux-2.6.1-mm4/fs/befs/Makefile.old	2004-01-18 19:03:58.000000000 +0100
+++ linux-2.6.1-mm4/fs/befs/Makefile	2004-01-18 19:06:08.000000000 +0100
@@ -1,12 +1,6 @@
 #
 # Makefile for the linux BeOS filesystem routines.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definitions are now in the main makefile...
-
  
 obj-$(CONFIG_BEFS_FS) += befs.o
 
--- linux-2.6.1-mm4/net/ipv4/ipvs/Makefile.old	2004-01-18 19:03:59.000000000 +0100
+++ linux-2.6.1-mm4/net/ipv4/ipvs/Makefile	2004-01-18 19:06:45.000000000 +0100
@@ -1,12 +1,6 @@
 #
 # Makefile for the IPVS modules on top of IPv4.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definition is now in the main makefile...
-
 
 # IPVS transport protocol load balancing support
 ip_vs_proto-objs-y :=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--- linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/csb250/Makefile.old	2004-02-28 11:18:00.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/csb250/Makefile	2004-02-28 11:18:07.000000000 +0100
@@ -4,10 +4,6 @@
 #
 # Makefile for the Cogent CSB250 Au1500 board.  Copied from Pb1500.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 USE_STANDARD_AS_RULE := true
 
--- linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/hydrogen3/Makefile.old	2004-02-28 11:18:48.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/hydrogen3/Makefile	2004-02-28 11:18:55.000000000 +0100
@@ -5,10 +5,6 @@
 #
 # Makefile for the Alchemy Semiconductor PB1000 board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 .S.s:
 	$(CPP) $(CFLAGS) $< -o $*.s
--- linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/mtx-1/Makefile.old	2004-02-28 11:19:20.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/mtx-1/Makefile	2004-02-28 11:19:26.000000000 +0100
@@ -6,9 +6,5 @@
 #
 # Makefile for 4G Systems MTX-1 board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 lib-y := init.o board_setup.o irqmap.o
--- linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/pb1550/Makefile.old	2004-02-28 11:19:53.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/pb1550/Makefile	2004-02-28 11:19:59.000000000 +0100
@@ -5,10 +5,6 @@
 #
 # Makefile for the Alchemy Semiconductor PB1000 board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 .S.s:
 	$(CPP) $(CFLAGS) $< -o $*.s
--- linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/xxs1500/Makefile.old	2004-02-28 11:21:03.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/arch/mips/au1000/xxs1500/Makefile	2004-02-28 11:21:26.000000000 +0100
@@ -5,9 +5,5 @@
 #
 # Makefile for MyCable XXS1500 board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 lib-y := init.o board_setup.o irqmap.o
--- linux-2.6.4-rc1-full-no-smp/arch/mips/momentum/jaguar_atx/Makefile.old	2004-02-28 11:21:57.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/arch/mips/momentum/jaguar_atx/Makefile	2004-02-28 11:22:05.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for Momentum Computer's Jaguar-ATX board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 		+= mv-irq.o int-handler.o irq.o pci-irq.o prom.o reset.o setup.o
 obj-$(CONFIG_PCI)	+= pci.o
--- linux-2.6.4-rc1-full-no-smp/arch/sh/boards/snapgear/Makefile.old	2004-02-28 11:22:42.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/arch/sh/boards/snapgear/Makefile	2004-02-28 11:22:47.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the SnapGear specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o io.o rtc.o
 
--- linux-2.6.4-rc1-full-no-smp/arch/sh/boards/systemh/Makefile.old	2004-02-28 11:23:32.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/arch/sh/boards/systemh/Makefile	2004-02-28 11:23:37.000000000 +0100
@@ -1,10 +1,6 @@
 #
 # Makefile for the SystemH specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
 
 obj-y	 := setup.o irq.o io.o
 
--- linux-2.6.4-rc1-full-no-smp/drivers/video/kyro/Makefile.old	2004-02-28 11:24:07.000000000 +0100
+++ linux-2.6.4-rc1-full-no-smp/drivers/video/kyro/Makefile	2004-02-28 11:24:15.000000000 +0100
@@ -1,11 +1,6 @@
 #
 # Makefile for the Kyro framebuffer driver
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definitions are now in the main makefile...
 
 obj-$(CONFIG_FB_KYRO)	+= kyrofb.o
 
