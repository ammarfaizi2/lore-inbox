Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271032AbTHKE7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271118AbTHKE7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:59:45 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:5014 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S271032AbTHKE7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:59:13 -0400
Date: Mon, 11 Aug 2003 00:49:39 -0400
From: James Manning <jmm@sublogic.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.6.0-test3 - remove a few remaining "make dep" references
Message-ID: <20030811044938.GA7802@sublogic.dyndns.org>
Mail-Followup-To: James Manning <jmm@sublogic.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A few places will still be left in revision logs, this is mainly
Makefile's that now incorrectly say deps are done with "make dep"

None of the changes are to code, just in comments.
-- 
James Manning <http://www.sublogic.com/james/>
GPG Key fingerprint = B913 2FBD 14A9 CE18 B2B7  9C8E A0BF B026 EEBB F6E4

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.0-test3-makedep.patch"

diff -ruN linux-2.6.0-test3.orig/Documentation/networking/arcnet.txt linux-2.6.0-test3/Documentation/networking/arcnet.txt
--- linux-2.6.0-test3.orig/Documentation/networking/arcnet.txt	Sat Aug  9 00:31:44 2003
+++ linux-2.6.0-test3/Documentation/networking/arcnet.txt	Mon Aug 11 00:35:29 2003
@@ -186,7 +186,6 @@
 to the chipset support if you wish.
 
 	make config
-	make dep
 	make clean	
 	make zImage
 	make modules
diff -ruN linux-2.6.0-test3.orig/arch/arm/kernel/Makefile linux-2.6.0-test3/arch/arm/kernel/Makefile
--- linux-2.6.0-test3.orig/arch/arm/kernel/Makefile	Sat Aug  9 00:40:56 2003
+++ linux-2.6.0-test3/arch/arm/kernel/Makefile	Mon Aug 11 00:29:32 2003
@@ -32,7 +32,7 @@
 
 extra-y := $(head-y) init_task.o
 
-# Spell out some dependencies that `make dep' doesn't spot
+# Spell out some dependencies that aren't automatically figured out
 $(obj)/entry-armv.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
 $(obj)/entry-armo.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
 $(obj)/entry-common.o: 	$(obj)/entry-header.S include/asm-arm/constants.h \
diff -ruN linux-2.6.0-test3.orig/arch/arm26/mm/Makefile linux-2.6.0-test3/arch/arm26/mm/Makefile
--- linux-2.6.0-test3.orig/arch/arm26/mm/Makefile	Sat Aug  9 00:33:22 2003
+++ linux-2.6.0-test3/arch/arm26/mm/Makefile	Mon Aug 11 00:26:48 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux arm26-specific parts of the memory manager.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 # Note 2! The CFLAGS definition is now in the main makefile...
diff -ruN linux-2.6.0-test3.orig/arch/h8300/kernel/Makefile linux-2.6.0-test3/arch/h8300/kernel/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/kernel/Makefile	Sat Aug  9 00:37:25 2003
+++ linux-2.6.0-test3/arch/h8300/kernel/Makefile	Mon Aug 11 00:27:34 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 # Note 2! The CFLAGS definitions are now in the main makefile...
diff -ruN linux-2.6.0-test3.orig/arch/h8300/mm/Makefile linux-2.6.0-test3/arch/h8300/mm/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/mm/Makefile	Sat Aug  9 00:41:47 2003
+++ linux-2.6.0-test3/arch/h8300/mm/Makefile	Mon Aug 11 00:27:39 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux m68k-specific parts of the memory manager.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 # Note 2! The CFLAGS definition is now in the main makefile...
diff -ruN linux-2.6.0-test3.orig/arch/h8300/platform/h8300h/Makefile linux-2.6.0-test3/arch/h8300/platform/h8300h/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/platform/h8300h/Makefile	Sat Aug  9 00:39:31 2003
+++ linux-2.6.0-test3/arch/h8300/platform/h8300h/Makefile	Mon Aug 11 00:27:21 2003
@@ -6,8 +6,7 @@
 
 #VPATH := $(VPATH):$(BOARD)
 
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 .S.o:
diff -ruN linux-2.6.0-test3.orig/arch/h8300/platform/h8300h/aki3068net/Makefile linux-2.6.0-test3/arch/h8300/platform/h8300h/aki3068net/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/platform/h8300h/aki3068net/Makefile	Sat Aug  9 00:36:02 2003
+++ linux-2.6.0-test3/arch/h8300/platform/h8300h/aki3068net/Makefile	Mon Aug 11 00:27:16 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/h8300/platform/h8300h/generic/Makefile linux-2.6.0-test3/arch/h8300/platform/h8300h/generic/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/platform/h8300h/generic/Makefile	Sat Aug  9 00:32:47 2003
+++ linux-2.6.0-test3/arch/h8300/platform/h8300h/generic/Makefile	Mon Aug 11 00:27:13 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/h8300/platform/h8300h/h8max/Makefile linux-2.6.0-test3/arch/h8300/platform/h8300h/h8max/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/platform/h8300h/h8max/Makefile	Sat Aug  9 00:30:38 2003
+++ linux-2.6.0-test3/arch/h8300/platform/h8300h/h8max/Makefile	Mon Aug 11 00:26:59 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/h8300/platform/h8s/Makefile linux-2.6.0-test3/arch/h8300/platform/h8s/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/platform/h8s/Makefile	Sat Aug  9 00:40:42 2003
+++ linux-2.6.0-test3/arch/h8300/platform/h8s/Makefile	Mon Aug 11 00:27:31 2003
@@ -6,8 +6,7 @@
 
 #VPATH := $(VPATH):$(BOARD)
 
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 .S.o:
diff -ruN linux-2.6.0-test3.orig/arch/h8300/platform/h8s/edosk2674/Makefile linux-2.6.0-test3/arch/h8300/platform/h8s/edosk2674/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/platform/h8s/edosk2674/Makefile	Sat Aug  9 00:38:11 2003
+++ linux-2.6.0-test3/arch/h8300/platform/h8s/edosk2674/Makefile	Mon Aug 11 00:27:24 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/h8300/platform/h8s/generic/Makefile linux-2.6.0-test3/arch/h8300/platform/h8s/generic/Makefile
--- linux-2.6.0-test3.orig/arch/h8300/platform/h8s/generic/Makefile	Sat Aug  9 00:36:46 2003
+++ linux-2.6.0-test3/arch/h8300/platform/h8s/generic/Makefile	Mon Aug 11 00:27:27 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/i386/mach-voyager/Makefile linux-2.6.0-test3/arch/i386/mach-voyager/Makefile
--- linux-2.6.0-test3.orig/arch/i386/mach-voyager/Makefile	Sat Aug  9 00:32:37 2003
+++ linux-2.6.0-test3/arch/i386/mach-voyager/Makefile	Mon Aug 11 00:24:57 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 # Note 2! The CFLAGS definitions are now in the main makefile...
diff -ruN linux-2.6.0-test3.orig/arch/mips/au1000/common/Makefile linux-2.6.0-test3/arch/mips/au1000/common/Makefile
--- linux-2.6.0-test3.orig/arch/mips/au1000/common/Makefile	Sat Aug  9 00:41:46 2003
+++ linux-2.6.0-test3/arch/mips/au1000/common/Makefile	Mon Aug 11 00:25:05 2003
@@ -5,8 +5,7 @@
 #
 # Makefile for the Alchemy Au1000 CPU, generic files.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/mips/au1000/db1x00/Makefile linux-2.6.0-test3/arch/mips/au1000/db1x00/Makefile
--- linux-2.6.0-test3.orig/arch/mips/au1000/db1x00/Makefile	Sat Aug  9 00:39:26 2003
+++ linux-2.6.0-test3/arch/mips/au1000/db1x00/Makefile	Mon Aug 11 00:25:13 2003
@@ -5,8 +5,7 @@
 #
 # Makefile for the Alchemy Semiconductor PB1000 board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/mips/au1000/pb1000/Makefile linux-2.6.0-test3/arch/mips/au1000/pb1000/Makefile
--- linux-2.6.0-test3.orig/arch/mips/au1000/pb1000/Makefile	Sat Aug  9 00:39:34 2003
+++ linux-2.6.0-test3/arch/mips/au1000/pb1000/Makefile	Mon Aug 11 00:25:17 2003
@@ -5,8 +5,7 @@
 #
 # Makefile for the Alchemy Semiconductor PB1000 board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/mips/au1000/pb1100/Makefile linux-2.6.0-test3/arch/mips/au1000/pb1100/Makefile
--- linux-2.6.0-test3.orig/arch/mips/au1000/pb1100/Makefile	Sat Aug  9 00:36:55 2003
+++ linux-2.6.0-test3/arch/mips/au1000/pb1100/Makefile	Mon Aug 11 00:25:22 2003
@@ -5,8 +5,7 @@
 #
 # Makefile for the Alchemy Semiconductor Pb1100 board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/mips/au1000/pb1500/Makefile linux-2.6.0-test3/arch/mips/au1000/pb1500/Makefile
--- linux-2.6.0-test3.orig/arch/mips/au1000/pb1500/Makefile	Sat Aug  9 00:31:18 2003
+++ linux-2.6.0-test3/arch/mips/au1000/pb1500/Makefile	Mon Aug 11 00:25:09 2003
@@ -5,8 +5,7 @@
 #
 # Makefile for the Alchemy Semiconductor Pb1500 board.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/mips/kernel/gdb-stub.c linux-2.6.0-test3/arch/mips/kernel/gdb-stub.c
--- linux-2.6.0-test3.orig/arch/mips/kernel/gdb-stub.c	Sat Aug  9 00:42:17 2003
+++ linux-2.6.0-test3/arch/mips/kernel/gdb-stub.c	Mon Aug 11 00:29:16 2003
@@ -95,7 +95,7 @@
  *  Example:
  *    $ cd ~/linux
  *    $ make menuconfig <go to "Kernel Hacking" and turn on remote debugging>
- *    $ make dep; make vmlinux
+ *    $ make vmlinux
  *
  *  Step 3:
  *  Download the kernel to the remote target and start
diff -ruN linux-2.6.0-test3.orig/arch/mips/tx4927/common/Makefile linux-2.6.0-test3/arch/mips/tx4927/common/Makefile
--- linux-2.6.0-test3.orig/arch/mips/tx4927/common/Makefile	Sat Aug  9 00:33:20 2003
+++ linux-2.6.0-test3/arch/mips/tx4927/common/Makefile	Mon Aug 11 00:25:26 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for common code for Toshiba TX4927 based systems
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/adx/Makefile linux-2.6.0-test3/arch/sh/boards/adx/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/adx/Makefile	Sat Aug  9 00:40:12 2003
+++ linux-2.6.0-test3/arch/sh/boards/adx/Makefile	Mon Aug 11 00:25:47 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for ADX boards
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/bigsur/Makefile linux-2.6.0-test3/arch/sh/boards/bigsur/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/bigsur/Makefile	Sat Aug  9 00:36:56 2003
+++ linux-2.6.0-test3/arch/sh/boards/bigsur/Makefile	Mon Aug 11 00:26:37 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the BigSur specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/cat68701/Makefile linux-2.6.0-test3/arch/sh/boards/cat68701/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/cat68701/Makefile	Sat Aug  9 00:31:58 2003
+++ linux-2.6.0-test3/arch/sh/boards/cat68701/Makefile	Mon Aug 11 00:26:05 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the CAT-68701 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/cqreek/Makefile linux-2.6.0-test3/arch/sh/boards/cqreek/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/cqreek/Makefile	Sat Aug  9 00:33:19 2003
+++ linux-2.6.0-test3/arch/sh/boards/cqreek/Makefile	Mon Aug 11 00:26:22 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the CqREEK specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/dmida/Makefile linux-2.6.0-test3/arch/sh/boards/dmida/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/dmida/Makefile	Sat Aug  9 00:32:02 2003
+++ linux-2.6.0-test3/arch/sh/boards/dmida/Makefile	Mon Aug 11 00:26:09 2003
@@ -2,8 +2,7 @@
 # Makefile for the DataMyte Industrial Digital Assistant(tm) specific parts
 # of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/dreamcast/Makefile linux-2.6.0-test3/arch/sh/boards/dreamcast/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/dreamcast/Makefile	Sat Aug  9 00:34:05 2003
+++ linux-2.6.0-test3/arch/sh/boards/dreamcast/Makefile	Mon Aug 11 00:25:58 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the Sega Dreamcast specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/ec3104/Makefile linux-2.6.0-test3/arch/sh/boards/ec3104/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/ec3104/Makefile	Sat Aug  9 00:38:54 2003
+++ linux-2.6.0-test3/arch/sh/boards/ec3104/Makefile	Mon Aug 11 00:26:26 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the EC3104 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/harp/Makefile linux-2.6.0-test3/arch/sh/boards/harp/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/harp/Makefile	Sat Aug  9 00:32:42 2003
+++ linux-2.6.0-test3/arch/sh/boards/harp/Makefile	Mon Aug 11 00:26:19 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for STMicroelectronics board specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/hp6xx/hp620/Makefile linux-2.6.0-test3/arch/sh/boards/hp6xx/hp620/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/hp6xx/hp620/Makefile	Sat Aug  9 00:42:12 2003
+++ linux-2.6.0-test3/arch/sh/boards/hp6xx/hp620/Makefile	Mon Aug 11 00:25:37 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the HP620 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/hp6xx/hp680/Makefile linux-2.6.0-test3/arch/sh/boards/hp6xx/hp680/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/hp6xx/hp680/Makefile	Sat Aug  9 00:38:51 2003
+++ linux-2.6.0-test3/arch/sh/boards/hp6xx/hp680/Makefile	Mon Aug 11 00:25:40 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the HP680 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/hp6xx/hp690/Makefile linux-2.6.0-test3/arch/sh/boards/hp6xx/hp690/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/hp6xx/hp690/Makefile	Sat Aug  9 00:30:02 2003
+++ linux-2.6.0-test3/arch/sh/boards/hp6xx/hp690/Makefile	Mon Aug 11 00:25:34 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the HP690 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/mpc1211/Makefile linux-2.6.0-test3/arch/sh/boards/mpc1211/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/mpc1211/Makefile	Sat Aug  9 00:30:04 2003
+++ linux-2.6.0-test3/arch/sh/boards/mpc1211/Makefile	Mon Aug 11 00:25:43 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the Interface (CTP/PCI/MPC-SH02) specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/overdrive/Makefile linux-2.6.0-test3/arch/sh/boards/overdrive/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/overdrive/Makefile	Sat Aug  9 00:40:55 2003
+++ linux-2.6.0-test3/arch/sh/boards/overdrive/Makefile	Mon Aug 11 00:26:29 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the STMicroelectronics Overdrive specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/saturn/Makefile linux-2.6.0-test3/arch/sh/boards/saturn/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/saturn/Makefile	Sat Aug  9 00:36:41 2003
+++ linux-2.6.0-test3/arch/sh/boards/saturn/Makefile	Mon Aug 11 00:26:33 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the Sega Saturn specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/se/770x/Makefile linux-2.6.0-test3/arch/sh/boards/se/770x/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/se/770x/Makefile	Sat Aug  9 00:39:30 2003
+++ linux-2.6.0-test3/arch/sh/boards/se/770x/Makefile	Mon Aug 11 00:25:51 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the 770x SolutionEngine specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/se/7751/Makefile linux-2.6.0-test3/arch/sh/boards/se/7751/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/se/7751/Makefile	Sat Aug  9 00:41:42 2003
+++ linux-2.6.0-test3/arch/sh/boards/se/7751/Makefile	Mon Aug 11 00:25:54 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the 7751 SolutionEngine specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/sh2000/Makefile linux-2.6.0-test3/arch/sh/boards/sh2000/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/sh2000/Makefile	Sat Aug  9 00:40:56 2003
+++ linux-2.6.0-test3/arch/sh/boards/sh2000/Makefile	Mon Aug 11 00:26:16 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the SH2000 specific parts of the kernel
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/boards/unknown/Makefile linux-2.6.0-test3/arch/sh/boards/unknown/Makefile
--- linux-2.6.0-test3.orig/arch/sh/boards/unknown/Makefile	Sat Aug  9 00:39:26 2003
+++ linux-2.6.0-test3/arch/sh/boards/unknown/Makefile	Mon Aug 11 00:26:01 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for unknown SH boards 
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/cchips/hd6446x/hd64461/Makefile linux-2.6.0-test3/arch/sh/cchips/hd6446x/hd64461/Makefile
--- linux-2.6.0-test3.orig/arch/sh/cchips/hd6446x/hd64461/Makefile	Sat Aug  9 00:38:39 2003
+++ linux-2.6.0-test3/arch/sh/cchips/hd6446x/hd64461/Makefile	Mon Aug 11 00:26:44 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the HD64461 
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/arch/sh/cchips/hd6446x/hd64465/Makefile linux-2.6.0-test3/arch/sh/cchips/hd6446x/hd64465/Makefile
--- linux-2.6.0-test3.orig/arch/sh/cchips/hd6446x/hd64465/Makefile	Sat Aug  9 00:40:57 2003
+++ linux-2.6.0-test3/arch/sh/cchips/hd6446x/hd64465/Makefile	Mon Aug 11 00:26:40 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the HD64465
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 
diff -ruN linux-2.6.0-test3.orig/drivers/video/i810/Makefile linux-2.6.0-test3/drivers/video/i810/Makefile
--- linux-2.6.0-test3.orig/drivers/video/i810/Makefile	Sat Aug  9 00:34:37 2003
+++ linux-2.6.0-test3/drivers/video/i810/Makefile	Mon Aug 11 00:24:47 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the Intel 810/815 framebuffer driver
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 # Note 2! The CFLAGS definitions are now in the main makefile...
diff -ruN linux-2.6.0-test3.orig/fs/befs/Makefile linux-2.6.0-test3/fs/befs/Makefile
--- linux-2.6.0-test3.orig/fs/befs/Makefile	Sat Aug  9 00:42:31 2003
+++ linux-2.6.0-test3/fs/befs/Makefile	Mon Aug 11 00:28:00 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux BeOS filesystem routines.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 # Note 2! The CFLAGS definitions are now in the main makefile...
diff -ruN linux-2.6.0-test3.orig/fs/hfs/INSTALL.txt linux-2.6.0-test3/fs/hfs/INSTALL.txt
--- linux-2.6.0-test3.orig/fs/hfs/INSTALL.txt	Sat Aug  9 00:36:06 2003
+++ linux-2.6.0-test3/fs/hfs/INSTALL.txt	Mon Aug 11 00:33:17 2003
@@ -40,9 +40,8 @@
   directories containing the header files for the kernel you wish to use
   hfs_fs with.
 
-  If gcc complains about not finding linux/version.h, then you will need
-  to run ``make dep'' in the kernel source directory to build it.  Under
-  MkLinux, run ``make include/linux/version.h'' instead.
+  If gcc complains about not finding linux/version.h under
+  MkLinux, run ``make include/linux/version.h''.
 
   If gcc complains about not finding the files linux/config.h or
   linux/autoconf.h, then you will need to run ``make config'' and ``make
diff -ruN linux-2.6.0-test3.orig/net/ipv4/ipvs/Makefile linux-2.6.0-test3/net/ipv4/ipvs/Makefile
--- linux-2.6.0-test3.orig/net/ipv4/ipvs/Makefile	Sat Aug  9 00:40:39 2003
+++ linux-2.6.0-test3/net/ipv4/ipvs/Makefile	Mon Aug 11 00:28:04 2003
@@ -1,8 +1,7 @@
 #
 # Makefile for the IPVS modules on top of IPv4.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
+# Note! DON'T put your own dependencies here
 # unless it's something special (ie not a .c file).
 #
 # Note 2! The CFLAGS definition is now in the main makefile...

--envbJBWh7q8WU6mo--
