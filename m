Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVGZPAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVGZPAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVGZO67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:58:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18181 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261847AbVGZO6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:58:08 -0400
Date: Tue, 26 Jul 2005 16:57:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] "extern inline" -> "static inline"
Message-ID: <20050726145759.GS3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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

