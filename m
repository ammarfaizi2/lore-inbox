Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSFJUg0>; Mon, 10 Jun 2002 16:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316194AbSFJUgZ>; Mon, 10 Jun 2002 16:36:25 -0400
Received: from psmtp2.dnsg.net ([193.168.128.42]:41883 "HELO psmtp2.dnsg.net")
	by vger.kernel.org with SMTP id <S316161AbSFJUgX>;
	Mon, 10 Jun 2002 16:36:23 -0400
Subject: 2.5.21 - end_request warning.
To: linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2002 00:33:24 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17HXj2-0000a2-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
another small thing. The end_request error message should be marked with
KERN_ERR.

blue skies,
  Martin.

diff -urN linux-2.5.21/drivers/block/ll_rw_blk.c linux-2.5.21-s390/drivers/block/ll_rw_blk.c
--- linux-2.5.21/drivers/block/ll_rw_blk.c	Sun Jun  9 07:27:22 2002
+++ linux-2.5.21-s390/drivers/block/ll_rw_blk.c	Mon Jun 10 11:30:26 2002
@@ -1879,7 +1879,7 @@
 
 	req->errors = 0;
 	if (!uptodate)
-		printk("end_request: I/O error, dev %s, sector %lu\n",
+		printk(KERN_ERR "end_request: I/O error, dev %s, sector %lu\n",
 			kdevname(req->rq_dev), req->sector);
 
 	total_nsect = 0;
