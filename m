Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbTGBKqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTGBKp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:45:59 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:27141 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264926AbTGBKpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:45:08 -0400
Date: Wed, 2 Jul 2003 11:59:32 +0100
From: Joe Thornber <thornber@sistina.com>
To: dm-devel@sistina.com
Cc: Kevin Corry <kevcorry@us.ibm.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
Message-ID: <20030702105932.GB6243@fib011235813.fsnet.co.uk>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <20030701150246.GD1596@fib011235813.fsnet.co.uk> <200307011505.07184.kevcorry@us.ibm.com> <20030702085951.GB410@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702085951.GB410@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct comments.
--- diff/drivers/md/dm-ioctl-v4.c	2003-07-02 11:31:05.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-07-02 11:30:56.000000000 +0100
@@ -41,7 +41,7 @@
 void dm_hash_remove_all(void);
 
 /*
- * Guards access to all three tables.
+ * Guards access to both hash tables.
  */
 static DECLARE_RWSEM(_hash_lock);
 
@@ -205,7 +205,7 @@
 		return -ENOMEM;
 
 	/*
-	 * Insert the cell into all three hash tables.
+	 * Insert the cell into both hash tables.
 	 */
 	down_write(&_hash_lock);
 	if (__get_name_cell(name))
