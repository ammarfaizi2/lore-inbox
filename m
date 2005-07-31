Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVGaW3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVGaW3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVGaW13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:27:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26379 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262012AbVGaW0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:26:16 -0400
Date: Mon, 1 Aug 2005 00:26:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] "extern inline" -> "static inline"
Message-ID: <20050731222615.GP3608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Jul 2005

 include/linux/reiserfs_fs.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.13-rc3-mm1-full/include/linux/reiserfs_fs.h.old	2005-07-26 13:42:59.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/linux/reiserfs_fs.h	2005-07-26 13:43:37.000000000 +0200
@@ -2097,7 +2097,7 @@
 			 b_blocknr_t, int for_unformatted);
 int reiserfs_allocate_blocknrs(reiserfs_blocknr_hint_t *, b_blocknr_t *, int,
 			       int);
-extern inline int reiserfs_new_form_blocknrs(struct tree_balance *tb,
+static inline int reiserfs_new_form_blocknrs(struct tree_balance *tb,
 					     b_blocknr_t * new_blocknrs,
 					     int amount_needed)
 {
@@ -2113,7 +2113,7 @@
 					  0);
 }
 
-extern inline int reiserfs_new_unf_blocknrs(struct reiserfs_transaction_handle
+static inline int reiserfs_new_unf_blocknrs(struct reiserfs_transaction_handle
 					    *th, struct inode *inode,
 					    b_blocknr_t * new_blocknrs,
 					    struct path *path, long block)
@@ -2130,7 +2130,7 @@
 }
 
 #ifdef REISERFS_PREALLOCATE
-extern inline int reiserfs_new_unf_blocknrs2(struct reiserfs_transaction_handle
+static inline int reiserfs_new_unf_blocknrs2(struct reiserfs_transaction_handle
 					     *th, struct inode *inode,
 					     b_blocknr_t * new_blocknrs,
 					     struct path *path, long block)

