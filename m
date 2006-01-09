Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWAIDTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWAIDTu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWAIDTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:19:22 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:45509 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751205AbWAIDS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:18:56 -0500
Message-Id: <200601090411.k094BBJR001207@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/6] UML - Kill an unused variable
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jan 2006 23:11:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The HDIO_GETGEO patch left an unused variable in the UML block
driver.  This gets rid of it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/drivers/ubd_kern.c	2006-01-06 21:05:23.000000000 -0500
+++ linux-2.6.15-mm/arch/um/drivers/ubd_kern.c	2006-01-08 09:33:13.000000000 -0500
@@ -1073,7 +1073,6 @@ static int ubd_getgeo(struct block_devic
 static int ubd_ioctl(struct inode * inode, struct file * file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct hd_geometry __user *loc = (struct hd_geometry __user *) arg;
 	struct ubd *dev = inode->i_bdev->bd_disk->private_data;
 	struct hd_driveid ubd_id = {
 		.cyls		= 0,

