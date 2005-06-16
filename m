Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVFPDj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVFPDj6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 23:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVFPDj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 23:39:58 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:19500 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261711AbVFPDjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 23:39:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=I54JJOOGCkwPhSc3qwWeWyCxyrFWZNM4vU/Du1ikTSrbW/XQo+VQ1onrk5QnW3yvhnRkinOax4885IRYZBWw7T9q1NqVwzDOkd/MnIvws7zeJmnLMqdXtenF8p+mTRmT694nOrfMXtH5linKQwxAPDZxhfFdlJu1kmXXlrlue20=
Date: Thu, 16 Jun 2005 12:39:50 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6.12-rc6-mm1] blk: kill elevator_global_init()
Message-ID: <20050616033950.GA26870@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.
 Hello, Andrew.

 This patch kills elevator_global_init() in elevator.c which does
nothing.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-06-16 12:12:04.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-06-16 12:16:59.000000000 +0900
@@ -249,11 +249,6 @@ void elevator_exit(elevator_t *e)
 	kfree(e);
 }
 
-static int elevator_global_init(void)
-{
-	return 0;
-}
-
 int elv_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
 	elevator_t *e = q->elevator;
@@ -727,8 +722,6 @@ ssize_t elv_iosched_show(request_queue_t
 	return len;
 }
 
-module_init(elevator_global_init);
-
 EXPORT_SYMBOL(elv_add_request);
 EXPORT_SYMBOL(__elv_add_request);
 EXPORT_SYMBOL(elv_requeue_request);

