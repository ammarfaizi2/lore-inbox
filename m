Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWAYTzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWAYTzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWAYTzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:55:21 -0500
Received: from mail.gmx.net ([213.165.64.21]:4821 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751148AbWAYTzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:55:21 -0500
X-Authenticated: #704063
Subject: [Patch][Trivial] Fix debug statement in inftlcore.c
From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: gerg@snapgear.com
Content-Type: text/plain
Date: Wed, 25 Jan 2006 20:55:10 +0100
Message-Id: <1138218910.5767.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes a copy/paste bug found by cpminer inside the
inftlcore.c file

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16-rc1-git4/drivers/mtd/inftlcore.c.orig	2006-01-25 20:51:14.000000000 +0100
+++ linux-2.6.16-rc1-git4/drivers/mtd/inftlcore.c	2006-01-25 20:51:25.000000000 +0100
@@ -132,7 +132,7 @@ static void inftl_add_mtd(struct mtd_blk
 		return;
 	}
 #ifdef PSYCHO_DEBUG
-	printk(KERN_INFO "INFTL: Found new nftl%c\n", nftl->mbd.devnum + 'a');
+	printk(KERN_INFO "INFTL: Found new inftl%c\n", inftl->mbd.devnum + 'a');
 #endif
 	return;
 }


