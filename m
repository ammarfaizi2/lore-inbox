Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWBESOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWBESOE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 13:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWBESOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 13:14:04 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:40422 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751236AbWBESOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 13:14:03 -0500
Subject: [PATCH] isofs: remove unused debugging macros
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Date: Sun, 05 Feb 2006 20:14:00 +0200
Message-Id: <1139163241.11782.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes unused debugging macros from isofs. The referred debug
functions do not exist in the kernel.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/isofs/isofs.h |   12 ------------
 1 file changed, 12 deletions(-)

Index: 2.6/fs/isofs/isofs.h
===================================================================
--- 2.6.orig/fs/isofs/isofs.h
+++ 2.6/fs/isofs/isofs.h
@@ -178,15 +178,3 @@ extern struct inode_operations isofs_dir
 extern struct file_operations isofs_dir_operations;
 extern struct address_space_operations isofs_symlink_aops;
 extern struct export_operations isofs_export_ops;
-
-/* The following macros are used to check for memory leaks. */
-#ifdef LEAK_CHECK
-#define free_s leak_check_free_s
-#define malloc leak_check_malloc
-#define sb_bread leak_check_bread
-#define brelse leak_check_brelse
-extern void * leak_check_malloc(unsigned int size);
-extern void leak_check_free_s(void * obj, int size);
-extern struct buffer_head * leak_check_bread(struct super_block *sb, int block);
-extern void leak_check_brelse(struct buffer_head * bh);
-#endif /* LEAK_CHECK */


