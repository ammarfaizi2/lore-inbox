Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbUKLWW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbUKLWW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUKLWW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:22:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:59527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262642AbUKLWVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:21:11 -0500
Date: Fri, 12 Nov 2004 14:21:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Mark deadline_init and deadline_exit as init and exit functions
Message-ID: <20041112142108.V2357@build.pdx.osdl.net>
References: <20041112141556.S14339@build.pdx.osdl.net> <20041112141743.U2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041112141743.U2357@build.pdx.osdl.net>; from chrisw@osdl.org on Fri, Nov 12, 2004 at 02:17:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark deadline_init and deadline_exit as init and exit functions, and
make them static.

Signed-off-by: Chris Wright <chris@osdl.org>

===== drivers/block/deadline-iosched.c 1.31 vs edited =====
--- 1.31/drivers/block/deadline-iosched.c	2004-10-19 02:40:18 -07:00
+++ edited/drivers/block/deadline-iosched.c	2004-10-29 15:51:12 -07:00
@@ -936,7 +936,7 @@ static struct elevator_type iosched_dead
 	.elevator_owner = THIS_MODULE,
 };
 
-int deadline_init(void)
+static int __init deadline_init(void)
 {
 	int ret;
 
@@ -953,7 +953,7 @@ int deadline_init(void)
 	return ret;
 }
 
-void deadline_exit(void)
+static void __exit deadline_exit(void)
 {
 	kmem_cache_destroy(drq_pool);
 	elv_unregister(&iosched_deadline);
