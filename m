Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTI1Xel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbTI1XeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:34:10 -0400
Received: from hera.cwi.nl ([192.16.191.8]:33007 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262771AbTI1Xbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:31:52 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:31:49 +0200 (MEST)
Message-Id: <UTC200309282331.h8SNVnl07005.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] jbd sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/jbd/journal.c b/fs/jbd/journal.c
--- a/fs/jbd/journal.c	Mon Sep 29 01:05:41 2003
+++ b/fs/jbd/journal.c	Mon Sep 29 01:14:22 2003
@@ -1800,7 +1800,7 @@
 	return ret;
 }
 
-int write_jbd_debug(struct file *file, const char *buffer,
+int write_jbd_debug(struct file *file, const char __user *buffer,
 			   unsigned long count, void *data)
 {
 	char buf[32];
