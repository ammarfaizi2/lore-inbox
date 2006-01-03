Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWACN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWACN3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWACN2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:28:18 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:43269 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932357AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 11/26] kbuild: patch to Documentation/kbuild/modules.txt
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947251455@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Strand <bstrand@switchmanagement.com>
Date: 1132622588 +0000

First off, thanks for the kbuild docs, they are very useful!  Second,
I've attached a patch to modules.txt (from 2.6.14.2) with a "compile"
fix to a Makefile example, and some trivial spelling/grammar nits.
Please let me know if you want the patch in some other format (eg not
MIME), or if I should go bother someone else about it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Documentation/kbuild/modules.txt |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

98a1e444111c9fd3f7a2b55225f7febf4209c020
diff --git a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
index c91caf7..1c0db65 100644
--- a/Documentation/kbuild/modules.txt
+++ b/Documentation/kbuild/modules.txt
@@ -38,7 +38,7 @@ included in the kernel tree.
 What is covered within this file is mainly information to authors
 of modules. The author of an external modules should supply
 a makefile that hides most of the complexity so one only has to type
-'make' to buld the module. A complete example will be present in
+'make' to build the module. A complete example will be present in
 chapter ¤. Creating a kbuild file for an external module".
 
 
@@ -69,7 +69,7 @@ when building an external module.
 
 --- 2.2 Available targets
 
-	$KDIR refers to path to kernel source top-level directory
+	$KDIR refers to the path to the kernel source top-level directory
 
 	make -C $KDIR M=`pwd`
 		Will build the module(s) located in current directory.
@@ -87,11 +87,11 @@ when building an external module.
 	make -C $KDIR M=$PWD modules_install
 		Install the external module(s).
 		Installation default is in /lib/modules/<kernel-version>/extra,
-		but may be prefixed with INSTALL_MOD_PATH - see separate chater.
+		but may be prefixed with INSTALL_MOD_PATH - see separate chapter.
 
 	make -C $KDIR M=$PWD clean
 		Remove all generated files for the module - the kernel
-		source directory is not moddified.
+		source directory is not modified.
 
 	make -C $KDIR M=`pwd` help
 		help will list the available target when building external
@@ -99,7 +99,7 @@ when building an external module.
 
 --- 2.3 Available options:
 
-	$KDIR refer to path to kernel src
+	$KDIR refers to the path to the kernel source top-level directory
 
 	make -C $KDIR
 		Used to specify where to find the kernel source.
@@ -206,11 +206,11 @@ following files:
 
 		KERNELDIR := /lib/modules/`uname -r`/build
 		all::
-			$(MAKE) -C $KERNELDIR M=`pwd` $@
+			$(MAKE) -C $(KERNELDIR) M=`pwd` $@
 
 		# Module specific targets
 		genbin:
-			echo "X" > 8123_bini.o_shipped
+			echo "X" > 8123_bin.o_shipped
 
 		endif
 
@@ -341,13 +341,13 @@ directory and therefore needs to deal wi
 		EXTRA_CFLAGS := -Iinclude
 		8123-y := 8123_if.o 8123_pci.o 8123_bin.o
 
-	Note that in the assingment there is no space between -I and the path.
-	This is a kbuild limitation and no space must be present.
+	Note that in the assignment there is no space between -I and the path.
+	This is a kbuild limitation:  there must be no space present.
 
 
 === 6. Module installation
 
-Modules which are included in the kernel is installed in the directory:
+Modules which are included in the kernel are installed in the directory:
 
 	/lib/modules/$(KERNELRELEASE)/kernel
 
@@ -365,7 +365,7 @@ External modules are installed in the di
 		=> Install dir: /frodo/lib/modules/$(KERNELRELEASE)/kernel
 
 	INSTALL_MOD_PATH may be set as an ordinary shell variable or as in the
-	example above be specified on the commandline when calling make.
+	example above be specified on the command line when calling make.
 	INSTALL_MOD_PATH has effect both when installing modules included in
 	the kernel as well as when installing external modules.
 
@@ -384,7 +384,7 @@ External modules are installed in the di
 
 === 7. Module versioning
 
-Module versioning are enabled by the CONFIG_MODVERSIONS tag.
+Module versioning is enabled by the CONFIG_MODVERSIONS tag.
 
 Module versioning is used as a simple ABI consistency check. The Module
 versioning creates a CRC value of the full prototype for an exported symbol and
-- 
1.0.6

