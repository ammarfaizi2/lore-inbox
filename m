Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272803AbTHKRVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272827AbTHKQtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:49:43 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:345 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272799AbTHKQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:30 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse annotations for page-writeback
Message-Id: <E19mFqr-00068K-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More to do, but its a beginning.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/mm/page-writeback.c linux-2.5/mm/page-writeback.c
--- bk-linus/mm/page-writeback.c	2003-06-30 14:01:04.000000000 +0100
+++ linux-2.5/mm/page-writeback.c	2003-07-13 16:55:51.000000000 +0100
@@ -345,7 +345,7 @@ static void wb_kupdate(unsigned long arg
  * sysctl handler for /proc/sys/vm/dirty_writeback_centisecs
  */
 int dirty_writeback_centisecs_handler(ctl_table *table, int write,
-		struct file *file, void *buffer, size_t *length)
+		struct file *file, void __user *buffer, size_t *length)
 {
 	proc_dointvec(table, write, file, buffer, length);
 	if (dirty_writeback_centisecs) {
