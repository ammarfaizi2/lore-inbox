Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274936AbTHLAvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 20:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274958AbTHLAvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 20:51:21 -0400
Received: from remt23.cluster1.charter.net ([209.225.8.33]:31707 "EHLO
	remt23.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S274936AbTHLAvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 20:51:20 -0400
Subject: [patch] 2.6.0-test3 drivers/ide/legacy/hd.c
From: Josh Boyer <jwboyer@charter.net>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1060649477.1998.6.camel@yoda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Aug 2003 19:51:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a typo in drivers/ide/legacy/hd.c.  This gets rid
of a compiler warning as well.

jb

--- linux-2.6.0-test3.orig/drivers/ide/legacy/hd.c	2003-08-11
19:43:12.000000000 -0500
+++ linux-2.6.0-test3/drivers/ide/legacy/hd.c	2003-08-11
19:41:36.000000000 -0500
@@ -715,7 +715,7 @@
 
 	hd_queue = blk_init_queue(do_hd_request, &hd_lock);
 	if (!hd_queue) {
-		unegister_blkdev(MAJOR_NR,"hd");
+		unregister_blkdev(MAJOR_NR,"hd");
 		return -ENOMEM;
 	}


