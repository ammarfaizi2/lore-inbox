Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSEDOgk>; Sat, 4 May 2002 10:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313122AbSEDOgj>; Sat, 4 May 2002 10:36:39 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:45842 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S313087AbSEDOgi>;
	Sat, 4 May 2002 10:36:38 -0400
Date: Sat, 4 May 2002 16:36:36 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 - i8xx series chipsets patches (patch 1)
Message-ID: <20020504163636.A11108@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am sending the following patch to Marcelo for inclusion in the kernel.

Greetings,
Wim.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.405   -> 1.406  
#	drivers/char/i810_rng.c	1.9     -> 1.10   
#	Documentation/i810_rng.txt	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/04	wim@iguana.be	1.406
# [PATCH] 2.4.19-pre8 - i8xx series chipsets patches
# 
# i810_rng: add support for other i8xx chipsets to the Random Number Generator module.
# This is being done by adding the detection of the 82801E I/O Controller Hub.
# --------------------------------------------
#
diff -Nru a/Documentation/i810_rng.txt b/Documentation/i810_rng.txt
--- a/Documentation/i810_rng.txt	Sat May  4 15:03:21 2002
+++ b/Documentation/i810_rng.txt	Sat May  4 15:03:21 2002
@@ -70,6 +70,9 @@
 
 Change history:
 
+	Version 0.9.8:
+	* Support other i8xx chipsets by adding 82801E detection
+
 	Version 0.9.7:
 	* Support other i8xx chipsets too (by adding 82801BA(M) and
 	  82801CA(M) detection)
diff -Nru a/drivers/char/i810_rng.c b/drivers/char/i810_rng.c
--- a/drivers/char/i810_rng.c	Sat May  4 15:03:21 2002
+++ b/drivers/char/i810_rng.c	Sat May  4 15:03:21 2002
@@ -35,7 +35,7 @@
 /*
  * core module and version information
  */
-#define RNG_VERSION "0.9.7"
+#define RNG_VERSION "0.9.8"
 #define RNG_MODULE_NAME "i810_rng"
 #define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
 #define PFX RNG_MODULE_NAME ": "
@@ -336,6 +336,7 @@
 	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
