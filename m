Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVKVNII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVKVNII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVKVNII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:08:08 -0500
Received: from qlink.QueensU.CA ([130.15.126.18]:41607 "EHLO qlink.queensu.ca")
	by vger.kernel.org with ESMTP id S1751304AbVKVNIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:08:06 -0500
Message-ID: <43831836.3040505@groenstue.dk>
Date: Tue, 22 Nov 2005 14:08:06 +0100
From: Kristian Edlund <edlund@groenstue.dk>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trivial@rustcorp.com.au
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Typos in Documation/kbuild/modules.txt 2.6.15-rc2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristian Edlund <edlund@groenstue.dk>

I found a few typos, in Documentation/kbuild/modules.txt
I also changes the $PWD to `pwd` for consistency throughout the document.

Signed-off-by: Kristian Edlund <edlund@groenstue.dk>

---

I am not sure this is the right place to post, but now I am trying 
anyway. If I am completly wrong and changes to documentation should not 
be sent here, could please help me a bit with where I should send it.

--- Documentation/kbuild/modules.txt.orig    2005-11-22 
03:47:12.000000000 +0100
+++ Documentation/kbuild/modules.txt    2005-11-22 03:11:13.000000000 +0100
@@ -38,8 +38,8 @@ included in the kernel tree.
 What is covered within this file is mainly information to authors
 of modules. The author of an external modules should supply
 a makefile that hides most of the complexity so one only has to type
-'make' to buld the module. A complete example will be present in
-chapter ¤. Creating a kbuild file for an external module".
+'make' to build the module. A complete example will be present in
+chapter 4. Creating a kbuild file for an external module".
 
 
 === 2. How to build external modules
@@ -84,14 +84,14 @@ when building an external module.
         Same functionality as if no target was specified.
         See description above.
 
-    make -C $KDIR M=$PWD modules_install
+    make -C $KDIR M=`pwd` modules_install
         Install the external module(s).
         Installation default is in /lib/modules/<kernel-version>/extra,
-        but may be prefixed with INSTALL_MOD_PATH - see separate chater.
+        but may be prefixed with INSTALL_MOD_PATH - see separate chapter.
 
-    make -C $KDIR M=$PWD clean
+    make -C $KDIR M=`pwd` clean
         Remove all generated files for the module - the kernel
-        source directory is not moddified.
+        source directory is not modified.
 
     make -C $KDIR M=`pwd` help
         help will list the available target when building external
@@ -99,8 +99,6 @@ when building an external module.
 
 --- 2.3 Available options:
 
-    $KDIR refer to path to kernel src
-
     make -C $KDIR
         Used to specify where to find the kernel source.
         '$KDIR' represent the directory where the kernel source is.
@@ -341,7 +339,7 @@ directory and therefore needs to deal wi
         EXTRA_CFLAGS := -Iinclude
         8123-y := 8123_if.o 8123_pci.o 8123_bin.o
 
-    Note that in the assingment there is no space between -I and the path.
+    Note that in the assignment there is no space between -I and the path.
     This is a kbuild limitation and no space must be present.
 


