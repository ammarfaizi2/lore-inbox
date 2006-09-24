Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWIXWQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWIXWQa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWIXWQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:16:30 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1751258AbWIXWQU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:16:20 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:9618 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932149AbWIXVNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:12 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 24/28] kbuild: fixup Documentation/kbuild/modules.txt
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:20 +0200
Message-Id: <11591327063733-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327063625-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org> <115913
 2706423-git-send-email-sam@ravnborg.org> <115913270694-git-send-email-sam@ravnborg.org> <1159132706126-git-send-email-sam@ravnborg.org> <11591327063625-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert P. J. Day <rpjday@mindspring.com>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/kbuild/modules.txt |   46 +++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
index a2a178d..2e7702e 100644
--- a/Documentation/kbuild/modules.txt
+++ b/Documentation/kbuild/modules.txt
@@ -24,7 +24,7 @@ In this document you will find informati
 	   --- 6.1 INSTALL_MOD_PATH
 	   --- 6.2 INSTALL_MOD_DIR
 	=== 7. Module versioning & Module.symvers
-	   --- 7.1 Symbols fron the kernel (vmlinux + modules)
+	   --- 7.1 Symbols from the kernel (vmlinux + modules)
 	   --- 7.2 Symbols and external modules
 	   --- 7.3 Symbols from another external module
 	=== 8. Tips & Tricks
@@ -63,14 +63,15 @@ when building an external module.
 	For the running kernel use:
 		make -C /lib/modules/`uname -r`/build M=`pwd`
 
-	For the above command to succeed the kernel must have been built with
-	modules enabled.
+	For the above command to succeed, the kernel must have been
+	built with modules enabled.
 
 	To install the modules that were just built:
 
 		make -C <path-to-kernel> M=`pwd` modules_install
 
-	More complex examples later, the above should get you going.
+	More complex examples will be shown later, the above should
+	be enough to get you started.
 
 --- 2.2 Available targets
 
@@ -89,13 +90,13 @@ when building an external module.
 		Same functionality as if no target was specified.
 		See description above.
 
-	make -C $KDIR M=$PWD modules_install
+	make -C $KDIR M=`pwd` modules_install
 		Install the external module(s).
 		Installation default is in /lib/modules/<kernel-version>/extra,
 		but may be prefixed with INSTALL_MOD_PATH - see separate
 		chapter.
 
-	make -C $KDIR M=$PWD clean
+	make -C $KDIR M=`pwd` clean
 		Remove all generated files for the module - the kernel
 		source directory is not modified.
 
@@ -129,23 +130,22 @@ when building an external module.
 
 	To make sure the kernel contains the information required to
 	build external modules the target 'modules_prepare' must be used.
-	'module_prepare' solely exists as a simple way to prepare
-	a kernel for building external modules.
+	'module_prepare' exists solely as a simple way to prepare
+	a kernel source tree for building external modules.
 	Note: modules_prepare will not build Module.symvers even if
-	      CONFIG_MODULEVERSIONING is set.
-	      Therefore a full kernel build needs to be executed to make
-	      module versioning work.
+	CONFIG_MODULEVERSIONING is set. Therefore a full kernel build
+	needs to be executed to make module versioning work.
 
 --- 2.5 Building separate files for a module
 	It is possible to build single files which are part of a module.
-	This works equal for the kernel, a module and even for external
-	modules.
+	This works equally well for the kernel, a module and even for
+	external modules.
 	Examples (module foo.ko, consist of bar.o, baz.o):
 		make -C $KDIR M=`pwd` bar.lst
 		make -C $KDIR M=`pwd` bar.o
 		make -C $KDIR M=`pwd` foo.ko
 		make -C $KDIR M=`pwd` /
-	
+
 
 === 3. Example commands
 
@@ -177,7 +177,7 @@ Then, to install the module use the foll
 	        M=`pwd`                               \
 		modules_install
 
-If one looks closely you will see that this is the same commands as
+If you look closely you will see that this is the same command as
 listed before - with the directories spelled out.
 
 The above are rather long commands, and the following chapter
@@ -311,7 +311,7 @@ following files:
 Include files are a necessity when a .c file uses something from other .c
 files (not strictly in the sense of C, but if good programming practice is
 used). Any module that consists of more than one .c file will have a .h file
-for one of the .c files. 
+for one of the .c files.
 
 - If the .h file only describes a module internal interface, then the .h file
   shall be placed in the same directory as the .c files.
@@ -368,13 +368,13 @@ directory and therefore need to deal wit
 	handle this too.
 
 	Consider the following example:
-	
+
 	|
 	+- src/complex_main.c
 	|   +- hal/hardwareif.c
 	|   +- hal/include/hardwareif.h
 	+- include/complex.h
-	
+
 	To build a single module named complex.ko, we then need the following
 	kbuild file:
 
@@ -462,12 +462,12 @@ Module.symvers contains a list of all ex
 	Sample:
 		0x2d036834  scsi_remove_host   drivers/scsi/scsi_mod
 
-	For a kernel build without CONFIG_MODVERSIONING enabled, the crc
+	For a kernel build without CONFIG_MODVERSIONS enabled, the crc
 	would read: 0x00000000
 
 	Module.symvers serves two purposes:
 	1) It lists all exported symbols both from vmlinux and all modules
-	2) It lists the CRC if CONFIG_MODVERSION is enabled
+	2) It lists the CRC if CONFIG_MODVERSIONS is enabled
 
 --- 7.2 Symbols and external modules
 
@@ -479,7 +479,7 @@ Module.symvers contains a list of all ex
 	the external module is being built, this file will be read too.
 	During the MODPOST step, a new Module.symvers file will be written
 	containing all exported symbols that were not defined in the kernel.
-	
+
 --- 7.3 Symbols from another external module
 
 	Sometimes, an external module uses exported symbols from another
@@ -499,7 +499,7 @@ Module.symvers contains a list of all ex
 		./foo/ <= contains the foo module
 		./bar/ <= contains the bar module
 		The top-level Kbuild file would then look like:
-		
+
 		#./Kbuild: (this file may also be named Makefile)
 			obj-y := foo/ bar/
 
@@ -521,7 +521,7 @@ Module.symvers contains a list of all ex
 		build is finished, a new Module.symvers file is created
 		containing the sum of all symbols defined and not part of the
 		kernel.
-		
+
 === 8. Tips & Tricks
 
 --- 8.1 Testing for CONFIG_FOO_BAR
-- 
1.4.1

