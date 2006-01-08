Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbWAHSrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbWAHSrV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbWAHSrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:47:21 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:17935 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932751AbWAHSrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:47:20 -0500
Date: Sun, 8 Jan 2006 19:47:32 +0100
From: Jean Delvare <khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] ide-disk: Restore missing space in log message
Message-Id: <20060108194732.55a402ed.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

(Please disregard my previous post, I messed up with the keyboard and
sent it before it was ready...)

I've noticed a strange message log change in the current git tree
(2.6.15-git4):
  hda: cache flushes notsupported
instead of
  hda: cache flushes not supported

Here's the trivial patch fixing it.

Restore a missing space in a log message, which was accidentally
removed by a previous change: 3e087b575496b8aa445192f58e7d996b1cdfa121

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>
---
 drivers/ide/ide-disk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-git.orig/drivers/ide/ide-disk.c	2006-01-08 10:55:58.000000000 +0100
+++ linux-2.6.15-git/drivers/ide/ide-disk.c	2006-01-08 19:33:18.000000000 +0100
@@ -776,7 +776,7 @@
 			 ide_id_has_flush_cache_ext(id));
 
 		printk(KERN_INFO "%s: cache flushes %ssupported\n",
-		       drive->name, barrier ? "" : "not");
+		       drive->name, barrier ? "" : "not ");
 
 		if (barrier) {
 			ordered = QUEUE_ORDERED_DRAIN_FLUSH;

-- 
Jean Delvare
