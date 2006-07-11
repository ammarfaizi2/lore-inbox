Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWGKHGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWGKHGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWGKHGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:06:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14749 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030212AbWGKHF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:05:59 -0400
Date: Tue, 11 Jul 2006 17:05:46 +1000
From: Nathan Scott <nathans@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Update ramdisk documentation
Message-ID: <20060711170546.D1710004@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The default ramdisk blocksize is actually 1024, not 512 bytes.
Also fixes up some trailing whitespace issues.

Signed-off-by: Nathan Scott <nathans@sgi.com>


Index: ramdisk-2.6/Documentation/ramdisk.txt
===================================================================
--- ramdisk-2.6.orig/Documentation/ramdisk.txt	2006-07-11 16:36:12.696186000 +1000
+++ ramdisk-2.6/Documentation/ramdisk.txt	2006-07-11 16:36:20.008643000 +1000
@@ -6,7 +6,7 @@ Contents:
 	1) Overview
 	2) Kernel Command Line Parameters
 	3) Using "rdev -r"
-	4) An Example of Creating a Compressed RAM Disk 
+	4) An Example of Creating a Compressed RAM Disk
 
 
 1) Overview
@@ -34,7 +34,7 @@ make it clearer.  The original "ramdisk=
 compatibility reasons, but it may be removed in the future.
 
 The new RAM disk also has the ability to load compressed RAM disk images,
-allowing one to squeeze more programs onto an average installation or 
+allowing one to squeeze more programs onto an average installation or
 rescue floppy disk.
 
 
@@ -51,7 +51,7 @@ default is 4096 (4 MB) (8192 (8 MB) on S
 	===================
 
 This parameter tells the RAM disk driver how many bytes to use per block.  The
-default is 512.
+default is 1024 (BLOCK_SIZE).
 
 
 3) Using "rdev -r"
@@ -70,7 +70,7 @@ These numbers are no magical secrets, as
 ./arch/i386/kernel/setup.c:#define RAMDISK_PROMPT_FLAG          0x8000
 ./arch/i386/kernel/setup.c:#define RAMDISK_LOAD_FLAG            0x4000
 
-Consider a typical two floppy disk setup, where you will have the 
+Consider a typical two floppy disk setup, where you will have the
 kernel on disk one, and have already put a RAM disk image onto disk #2.
 
 Hence you want to set bits 0 to 13 as 0, meaning that your RAM disk
@@ -97,12 +97,12 @@ Since the default start = 0 and the defa
 	append = "load_ramdisk=1"
 
 
-4) An Example of Creating a Compressed RAM Disk 
+4) An Example of Creating a Compressed RAM Disk
 ----------------------------------------------
 
 To create a RAM disk image, you will need a spare block device to
 construct it on. This can be the RAM disk device itself, or an
-unused disk partition (such as an unmounted swap partition). For this 
+unused disk partition (such as an unmounted swap partition). For this
 example, we will use the RAM disk device, "/dev/ram0".
 
 Note: This technique should not be done on a machine with less than 8 MB
