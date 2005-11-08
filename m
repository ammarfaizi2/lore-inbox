Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVKHNoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVKHNoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVKHNoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:44:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31758 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964937AbVKHNoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:44:20 -0500
Date: Tue, 8 Nov 2005 14:44:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/md/kcopyd.c: remove kcopyd_cancel()
Message-ID: <20051108134419.GR3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A function that is
- not used
- empty
- without a prototype in any header file
should be removed.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Nov 2005

 drivers/md/kcopyd.c |   11 -----------
 1 file changed, 11 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/md/kcopyd.c.old	2005-11-05 16:36:11.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/md/kcopyd.c	2005-11-05 17:04:45.000000000 +0100
@@ -558,16 +558,6 @@
 	return 0;
 }
 
-/*
- * Cancels a kcopyd job, eg. someone might be deactivating a
- * mirror.
- */
-int kcopyd_cancel(struct kcopyd_job *job, int block)
-{
-	/* FIXME: finish */
-	return -1;
-}
-
 /*-----------------------------------------------------------------
  * Unit setup
  *---------------------------------------------------------------*/
@@ -685,4 +675,3 @@
 EXPORT_SYMBOL(kcopyd_client_create);
 EXPORT_SYMBOL(kcopyd_client_destroy);
 EXPORT_SYMBOL(kcopyd_copy);
-EXPORT_SYMBOL(kcopyd_cancel);

