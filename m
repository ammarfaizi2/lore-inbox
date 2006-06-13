Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932811AbWFMEIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811AbWFMEIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWFMEIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:08:14 -0400
Received: from xenotime.net ([66.160.160.81]:46811 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932811AbWFMEIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:08:13 -0400
Date: Mon, 12 Jun 2006 21:10:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] ide-floppy: fix debug-only syntax error
Message-Id: <20060612211055.23aaf3df.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix debug-only printk syntax error.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/ide/ide-floppy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-rc6.orig/drivers/ide/ide-floppy.c
+++ linux-2617-rc6/drivers/ide/ide-floppy.c
@@ -1288,7 +1288,7 @@ static ide_startstop_t idefloppy_do_requ
 
 	debug_log(KERN_INFO "rq_status: %d, dev: %s, flags: %lx, errors: %d\n",
 			rq->rq_status,
-			rq->rq_disk ? rq->rq_disk->disk_name ? "?",
+			rq->rq_disk ? rq->rq_disk->disk_name : "?",
 			rq->flags, rq->errors);
 	debug_log(KERN_INFO "sector: %ld, nr_sectors: %ld, "
 			"current_nr_sectors: %d\n", (long)rq->sector,


---
