Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbTE1NaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264740AbTE1NaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:30:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32784 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264734AbTE1NaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:30:16 -0400
Date: Wed, 28 May 2003 14:43:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH] two ll_rw_block style fixes
Message-ID: <20030528144326.B5586@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A random patch from the -rmk patch series which someone might like to
take on board.  It's no longer part of the -rmk patch though.

--- orig/drivers/block/ll_rw_blk.c	Tue May 27 10:04:29 2003
+++ linux/drivers/block/ll_rw_blk.c	Tue May 27 10:40:20 2003
@@ -1204,7 +1204,7 @@
 	}
 
 	q->request_fn		= rfn;
-	q->back_merge_fn       	= ll_back_merge_fn;
+	q->back_merge_fn	= ll_back_merge_fn;
 	q->front_merge_fn      	= ll_front_merge_fn;
 	q->merge_requests_fn	= ll_merge_requests_fn;
 	q->prep_rq_fn		= NULL;
@@ -2277,7 +2277,7 @@
 	for (i = 0; i < ARRAY_SIZE(congestion_wqh); i++)
 		init_waitqueue_head(&congestion_wqh[i]);
 	return 0;
-};
+}
 
 EXPORT_SYMBOL(process_that_request_first);
 EXPORT_SYMBOL(end_that_request_first);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

