Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVAWKTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVAWKTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVAWKSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:18:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61191 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261282AbVAWKQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:16:53 -0500
Date: Sun, 23 Jan 2005 11:16:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/elevator.c: make two functions static
Message-ID: <20050123101652.GH3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Jens Axboe <axboe@suse.de>

---

 drivers/block/elevator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

This patch was already sent on:
- 29 Nov 2004

--- linux-2.6.10-rc1-mm3-full/drivers/block/elevator.c.old	2004-11-06 19:55:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/elevator.c	2004-11-06 19:55:34.000000000 +0100
@@ -92,7 +92,7 @@
 }
 EXPORT_SYMBOL(elv_try_last_merge);
 
-struct elevator_type *elevator_find(const char *name)
+static struct elevator_type *elevator_find(const char *name)
 {
 	struct elevator_type *e = NULL;
 	struct list_head *entry;
@@ -222,7 +222,7 @@
 	kfree(e);
 }
 
-int elevator_global_init(void)
+static int elevator_global_init(void)
 {
 	return 0;
 }

