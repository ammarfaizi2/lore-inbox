Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbUJ3Nmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUJ3Nmx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 09:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUJ3Nmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 09:42:53 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:47303 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261167AbUJ3Nmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 09:42:47 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: james4765@verizon.net
Message-Id: <20041030134246.23710.45693.84191@localhost.localdomain>
Subject: [PATCH] floppy: change MODULE_PARM to module_param in drivers/block/floppy.c
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.211.53] at Sat, 30 Oct 2004 08:42:46 -0500
Date: Sat, 30 Oct 2004 08:42:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace MODULE_PARM with module_param in drivers/block/floppy.c.  Compile tested.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/drivers/block/floppy.c linux-2.6.9/drivers/block/floppy.c
--- linux-2.6.9-original/drivers/block/floppy.c	2004-10-18 17:53:22.000000000 -0400
+++ linux-2.6.9/drivers/block/floppy.c	2004-10-30 09:16:04.856720081 -0400
@@ -180,6 +180,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
+#include <linux/moduleparam.h>
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -4623,9 +4624,9 @@
 	wait_for_completion(&device_release);
 }
 
-MODULE_PARM(floppy, "s");
-MODULE_PARM(FLOPPY_IRQ, "i");
-MODULE_PARM(FLOPPY_DMA, "i");
+module_param(floppy, charp, 0);
+module_param(FLOPPY_IRQ, int, 0);
+module_param(FLOPPY_DMA, int, 0);
 MODULE_AUTHOR("Alain L. Knaff");
 MODULE_SUPPORTED_DEVICE("fd");
 MODULE_LICENSE("GPL");
