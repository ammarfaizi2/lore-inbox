Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTFIOcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTFIObu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:31:50 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:32270 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264377AbTFIOX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:23:59 -0400
Date: Mon, 9 Jun 2003 15:37:39 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] dm: Remove some debug messages
Message-ID: <20030609143739.GG11331@fib011235813.fsnet.co.uk>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some debug messages.
--- diff/drivers/md/dm-table.c	2003-06-09 15:05:13.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-06-09 15:06:29.000000000 +0100
@@ -243,8 +243,6 @@
 {
 	unsigned int i;
 
-	DMWARN("destroying table");
-
 	/* destroying the table counts as an event */
 	dm_table_event(t);
 
--- diff/drivers/md/dm.c	2003-06-09 15:05:08.000000000 +0100
+++ source/drivers/md/dm.c	2003-06-09 15:05:35.000000000 +0100
@@ -588,7 +588,6 @@
 		return NULL;
 	}
 
-	DMWARN("allocating minor %d.", minor);
 	memset(md, 0, sizeof(*md));
 	init_rwsem(&md->lock);
 	atomic_set(&md->holders, 1);
@@ -692,7 +691,6 @@
 void dm_put(struct mapped_device *md)
 {
 	if (atomic_dec_and_test(&md->holders)) {
-		DMWARN("destroying md");
 		if (!test_bit(DMF_SUSPENDED, &md->flags))
 			dm_table_suspend_targets(md->map);
 		__unbind(md);
