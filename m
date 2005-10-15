Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVJOJzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVJOJzP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 05:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVJOJzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 05:55:15 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:54025 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751027AbVJOJzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 05:55:14 -0400
From: Felix Oxley <lkml@oxley.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]driver/block/kconfig-2.6.14-rc4
Date: Sat, 15 Oct 2005 10:55:02 +0100
User-Agent: KMail/1.8.2
Cc: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510151055.02879.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sure who the following patch should be directed to.
(I couldn't find the Maintainer for RAM disk or initrd listed in the 
Maintainers file.)

Change to Kconfig text for RAM disks where suggested setting was N.
Now reminds the user that this option is required for initrd.

Hopefully this will stop me turning off this option and thus being unable to 
boot my system :-)

Signed-off-by: Felix Oxley <lkml@oxley.org>

--- ./drivers/block/Kconfig.orig	2005-10-15 08:58:20.000000000 +0100
+++ ./drivers/block/Kconfig	2005-10-15 09:25:31.000000000 +0100
@@ -368,19 +368,21 @@ config BLK_DEV_RAM
 	  Saying Y here will allow you to use a portion of your RAM memory as
 	  a block device, so that you can make file systems on it, read and
 	  write to it and do all the other things that you can do with normal
-	  block devices (such as hard drives). It is usually used to load and
-	  store a copy of a minimal root file system off of a floppy into RAM
-	  during the initial install of Linux.
+	  block devices (such as hard drives).
+
+	  It is usually used to load and store a copy of a minimal root file
+	  system into RAM during the boot sequence.
+	  (For this purpose say Y to this and also to initrd below)
 
 	  Note that the kernel command line option "ramdisk=XX" is now
 	  obsolete. For details, read <file:Documentation/ramdisk.txt>.
 
+	  Unless your system uses a RAM disk whilst booting you probably
+	  won't need this functionality, and can thus say N here.
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called rd.
 
-	  Most normal users won't need the RAM disk functionality, and can
-	  thus say N here.
-
 config BLK_DEV_RAM_COUNT
 	int "Default number of RAM disks" if BLK_DEV_RAM
 	default "16"
