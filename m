Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272815AbTHKQwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272804AbTHKQuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:50:11 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:1881 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272815AbTHKQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:30 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse annotations for page_alloc
Message-Id: <E19mFqr-00068N-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, more work to do here..

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/mm/page_alloc.c linux-2.5/mm/page_alloc.c
--- bk-linus/mm/page_alloc.c	2003-08-07 21:57:58.000000000 +0100
+++ linux-2.5/mm/page_alloc.c	2003-08-07 22:20:17.000000000 +0100
@@ -1610,7 +1610,7 @@ void setup_per_zone_pages_min(void)
  *	changes.
  */
 int min_free_kbytes_sysctl_handler(ctl_table *table, int write, 
-		struct file *file, void *buffer, size_t *length)
+		struct file *file, void __user *buffer, size_t *length)
 {
 	proc_dointvec(table, write, file, buffer, length);
 	setup_per_zone_pages_min();
