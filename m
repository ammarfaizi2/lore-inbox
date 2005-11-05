Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVKEQbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVKEQbL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVKEQbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:31:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41225 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751248AbVKEQbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:31:10 -0500
Date: Sat, 5 Nov 2005 17:31:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/md/kcopyd.c: remove kcopyd_cancel()
Message-ID: <20051105163108.GJ5368@stusta.de>
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

