Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUIGOxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUIGOxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUIGOt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:49:59 -0400
Received: from verein.lst.de ([213.95.11.210]:50329 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268131AbUIGOqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:46:54 -0400
Date: Tue, 7 Sep 2004 16:46:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mark md_interrupt_thread static
Message-ID: <20040907144647.GA8844@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.221/drivers/md/md.c	2004-08-27 08:30:29 +02:00
+++ edited/drivers/md/md.c	2004-09-07 15:14:47 +02:00
@@ -2895,7 +2895,7 @@
 	return thread;
 }
 
-void md_interrupt_thread(mdk_thread_t *thread)
+static void md_interrupt_thread(mdk_thread_t *thread)
 {
 	if (!thread->tsk) {
 		MD_BUG();
@@ -3797,6 +3797,5 @@
 EXPORT_SYMBOL(md_unregister_thread);
 EXPORT_SYMBOL(md_wakeup_thread);
 EXPORT_SYMBOL(md_print_devices);
-EXPORT_SYMBOL(md_interrupt_thread);
 EXPORT_SYMBOL(md_check_recovery);
 MODULE_LICENSE("GPL");
