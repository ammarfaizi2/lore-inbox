Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWHGW5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWHGW5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWHGW4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:56:20 -0400
Received: from xenotime.net ([66.160.160.81]:23729 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750879AbWHGW4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:56:16 -0400
Date: Mon, 7 Aug 2006 15:47:50 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: pavel@ucw.cz, akpm <akpm@osdl.org>
Subject: [PATCH -mm 1/5] nbd: printk format warning
Message-Id: <20060807154750.5a268055.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning(s):
drivers/block/nbd.c:410: warning: long unsigned int format, different type arg (arg 4)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/block/nbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc3mm2.orig/drivers/block/nbd.c
+++ linux-2618-rc3mm2/drivers/block/nbd.c
@@ -407,7 +407,7 @@ static void do_nbd_request(request_queue
 		struct nbd_device *lo;
 
 		blkdev_dequeue_request(req);
-		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%lx)\n",
+		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%x)\n",
 				req->rq_disk->disk_name, req, req->cmd_type);
 
 		if (!blk_fs_request(req))


---
