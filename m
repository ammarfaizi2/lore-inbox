Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUKLWQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUKLWQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUKLWQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:16:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:3204 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262634AbUKLWQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:16:01 -0500
Date: Fri, 12 Nov 2004 14:15:57 -0800
From: Chris Wright <chrisw@osdl.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Mark as_init and as_exit as init and exit functions
Message-ID: <20041112141556.S14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark as_init and as_exit as init and exit functions, and make them static.

Signed-off-by: Chris Wright <chris@osdl.org>

===== drivers/block/as-iosched.c 1.41 vs edited =====
--- 1.41/drivers/block/as-iosched.c	2004-10-19 02:40:18 -07:00
+++ edited/drivers/block/as-iosched.c	2004-10-29 16:28:05 -07:00
@@ -2096,7 +2096,7 @@ static struct elevator_type iosched_as =
 	.elevator_owner = THIS_MODULE,
 };
 
-int as_init(void)
+static int __init as_init(void)
 {
 	int ret;
 
@@ -2120,7 +2120,7 @@ int as_init(void)
 	return ret;
 }
 
-void as_exit(void)
+static void __exit as_exit(void)
 {
 	kmem_cache_destroy(arq_pool);
 	elv_unregister(&iosched_as);
