Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbUK2M2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUK2M2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUK2M1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:27:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42258 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261700AbUK2M0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:26:35 -0500
Date: Mon, 29 Nov 2004 13:26:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/elevator.c: make two functions static
Message-ID: <20041129122632.GI9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global functions static.


diffstat output:
 drivers/block/elevator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

