Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVCSWOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVCSWOd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 17:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVCSWOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 17:14:33 -0500
Received: from mail.dif.dk ([193.138.115.101]:60637 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261871AbVCSWOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 17:14:30 -0500
Date: Sat, 19 Mar 2005 23:16:07 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Christopher Hoover <ch@hpl.hp.com>,
       Thibaut VARENE <varenet@parisc-linux.org>, linux-kernel@vger.kernel.org
Subject: [patch] Trivial patch to update a comment in drivers/video/s1d13xxxfb.c
Message-ID: <Pine.LNX.4.62.0503192310260.2501@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial patch to update a comment in drivers/video/s1d13xxxfb.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm4-orig/drivers/video/s1d13xxxfb.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/s1d13xxxfb.c	2005-03-19 22:45:10.000000000 +0100
@@ -720,7 +720,7 @@ static int s1d13xxxfb_resume(struct devi
 	if (s1dfb->disp_save) {
 		memcpy_toio(info->screen_base, s1dfb->disp_save,
 				info->fix.smem_len);
-		kfree(s1dfb->disp_save);	/* XXX kmalloc()'d when? */
+		kfree(s1dfb->disp_save);	/* kmalloc()'d in s1d13xxxfb_suspend */
 	}
 
 	if ((s1dfb->display & 0x01) != 0)

