Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVABOlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVABOlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 09:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVABOlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 09:41:47 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:23689 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261251AbVABOlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 09:41:39 -0500
Date: Sun, 2 Jan 2005 09:41:36 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fix for modular floppy builds
Message-ID: <Pine.LNX.4.61.0501020934320.6458@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Modular floppy builds are still broken in -bk5. Can you merge in Jeff's 
patch below?

thanks,

-- Cal


Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.6

This will update the following files:

 drivers/block/floppy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/12/29 1.2079)
   block/floppy.c: fix build by removing UTS_RELEASE use
   
   It's redundant to the kernel message that prints out the kernel version,
   as well as many other places where one can request the kernel version.

diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	2004-12-29 14:00:55 -05:00
+++ b/drivers/block/floppy.c	2004-12-29 14:00:55 -05:00
@@ -4595,7 +4595,7 @@
 
 int init_module(void)
 {
-	printk(KERN_INFO "inserting floppy driver for " UTS_RELEASE "\n");
+	printk(KERN_INFO "inserting floppy driver\n");
 
 	if (floppy)
 		parse_floppy_cfg_string(floppy);
