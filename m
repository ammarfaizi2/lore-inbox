Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVLKVyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVLKVyh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVLKVyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:54:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30990 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750873AbVLKVyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:54:19 -0500
Date: Sun, 11 Dec 2005 22:54:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/md/kcopyd.c: #if 0 kcopyd_cancel()
Message-ID: <20051211215419.GZ23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's the not yet implemented global function 
kcopyd_cancel().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Nov 2005

 drivers/md/kcopyd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14-mm1-full/drivers/md/kcopyd.c.old	2005-11-08 17:41:31.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/md/kcopyd.c	2005-11-08 17:41:59.000000000 +0100
@@ -562,11 +562,13 @@
  * Cancels a kcopyd job, eg. someone might be deactivating a
  * mirror.
  */
+#if 0
 int kcopyd_cancel(struct kcopyd_job *job, int block)
 {
 	/* FIXME: finish */
 	return -1;
 }
+#endif  /*  0  */
 
 /*-----------------------------------------------------------------
  * Unit setup
@@ -685,4 +687,3 @@
 EXPORT_SYMBOL(kcopyd_client_create);
 EXPORT_SYMBOL(kcopyd_client_destroy);
 EXPORT_SYMBOL(kcopyd_copy);
-EXPORT_SYMBOL(kcopyd_cancel);

