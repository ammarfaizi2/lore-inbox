Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUD1BmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUD1BmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUD1BmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:42:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:16840 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264578AbUD1BmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:42:17 -0400
Date: Tue, 27 Apr 2004 18:44:25 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to kcopyd.c
Message-ID: <20040428014425.GA19475@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this adds __init to jobs_init(), and __exit to kcopyd_exit().


diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/kcopyd.c linux-2.6.6-rc2-udm1-patched/drivers/md/kcopyd.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/kcopyd.c	2004-04-27 18:37:27.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/kcopyd.c	2004-04-27 18:42:45.000000000 -0700
@@ -218,7 +218,7 @@
 static LIST_HEAD(_io_jobs);
 static LIST_HEAD(_pages_jobs);
 
-static int jobs_init(void)
+static int __init jobs_init(void)
 {
 	INIT_LIST_HEAD(&_complete_jobs);
 	INIT_LIST_HEAD(&_io_jobs);
@@ -655,7 +655,7 @@
 	return 0;
 }
 
-void kcopyd_exit(void)
+void __exit kcopyd_exit(void)
 {
 	jobs_exit();
 	destroy_workqueue(_kcopyd_wq);
