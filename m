Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTJFFbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 01:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbTJFF3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 01:29:42 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:38601 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263992AbTJFF3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 01:29:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Update v850 Kconfig debugging menu
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031006052905.D1BD837DF@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  6 Oct 2003 14:29:05 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

diff -ruN -X../cludes linux-2.6.0-test6-moo/arch/v850/Kconfig linux-2.6.0-test6-moo-v850-20031006/arch/v850/Kconfig
--- linux-2.6.0-test6-moo/arch/v850/Kconfig	2003-09-29 13:17:57.000000000 +0900
+++ linux-2.6.0-test6-moo-v850-20031006/arch/v850/Kconfig	2003-10-03 18:36:09.000000000 +0900
@@ -326,40 +326,30 @@
 
 menu "Kernel hacking"
 
-config FULLDEBUG
-	bool "Full Symbolic/Source Debugging support"
-	help
-	  Enable debuging symbols on kernel build.
+config DEBUG_KERNEL
+	bool "Kernel debugging"
+
+config DEBUG_INFO
+	bool "Compile the kernel with debug info"
+	depends on DEBUG_KERNEL
+	help
+          If you say Y here the resulting kernel image will include
+	  debugging info resulting in a larger kernel image.
+	  Say Y here only if you plan to use gdb to debug the kernel.
+	  If you don't debug the kernel, you can say N.
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
+	depends on DEBUG_KERNEL
 	help
 	  Enables console device to interprent special characters as
 	  commands to dump state information.
 
-config HIGHPROFILE
-	bool "Use fast second timer for profiling"
-	help
-	  Use a fast secondary clock to produce profiling information.
-
-config DUMPTOFLASH
-	bool "Panic/Dump to FLASH"
-	depends on COLDFIRE
-	help
-	  Dump any panic of trap output into a flash memory segment
-	  for later analysis.
-
 config NO_KERNEL_MSG
 	bool "Suppress Kernel BUG Messages"
 	help
 	  Do not output any debug BUG messages within the kernel.
 
-config BDM_DISABLE
-	bool "Disable BDM signals"
-	depends on (EXPERIMENTAL && COLDFIRE)
-	help
-	  Disable the CPU's BDM signals.
-
 endmenu
 
 source "security/Kconfig"
