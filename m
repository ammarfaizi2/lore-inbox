Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTIPDC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTIPDCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:02:21 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:2542 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261685AbTIPDCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:02:11 -0400
Message-ID: <1063681321.3f667d2971673@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:02:01 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 1 of 15 -- /drivers/block/ll_rw_blk.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes kernel-doc errors reported whilst doing
a make mandocs on 2.6-test4-bk5

Linus, please apply.

Cheers,
Mikal


--------------------------


diff -Nur linux-2.6.0-test4-bk5-mandocs/drivers/block/ll_rw_blk.c
linux-2.6.0-test4-bk5-mandocs_tweaks/drivers/block/ll_rw_blk.c
--- linux-2.6.0-test4-bk5-mandocs/drivers/block/ll_rw_blk.c	2003-09-04
10:56:11.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/drivers/block/ll_rw_blk.c	2003-09-10
13:18:30.000000000 +1000
@@ -119,7 +119,7 @@
 
 /**
  * blk_get_backing_dev_info - get the address of a queue's backing_dev_info
- * @dev:	device
+ * @bdev:	device
  *
  * Locates the passed device's request queue and returns the address of its
  * backing_dev_info
@@ -407,8 +407,8 @@
 
 /**
  * blk_queue_dma_alignment - set dma length and memory alignment
- * @q:  the request queue for the device
- * @dma_mask:  alignment mask
+ * @q:     the request queue for the device
+ * @mask:  alignment mask
  *
  * description:
  *    set required memory and length aligment for direct dma transactions.
@@ -587,9 +587,8 @@
 /**
  * blk_queue_end_tag - end tag operations for a request
  * @q:  the request queue for the device
- * @tag:  the tag that has completed
+ * @rq:  the tagged request that has completed
  *
- *  Description:
  *    Typically called when end_that_request_first() returns 0, meaning
  *    all transfers have been done for a request. It's important to call
  *    this function before end_that_request_last(), as that will put the
@@ -1134,7 +1133,7 @@
 
 /**
  * blk_run_queue - run a single device queue
- * @q	The queue to run
+ * @q:	The queue to run
  */
 void blk_run_queue(struct request_queue *q)
 {
@@ -1282,11 +1281,10 @@
 
 /**
  * blk_init_queue  - prepare a request queue for use with a block device
- * @q:    The &request_queue_t to be initialised
- * @rfn:  The function to be called to process requests that have been
- *        placed on the queue.
+ * @rfn:  the function to be called to process requests that have been
+ *        placed on the queue
+ * @lock: the spinlock which controlls access to the queue
  *
- * Description:
  *    If a block device wishes to use the standard request handling procedures,
  *    which sorts requests and coalesces adjacent requests, then it must
  *    call blk_init_queue().  The function @rfn will be called when there

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
