Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWCZVI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWCZVI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWCZVI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:08:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4617 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750841AbWCZVI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:08:28 -0500
Date: Sun, 26 Mar 2006 23:08:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/fat/: proper prototypes for two functions
Message-ID: <20060326210827.GT4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds proper prototypes for fat_cache_init() and 
fat_cache_destroy() in msdos_fs.h.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/fat/inode.c           |    3 ---
 include/linux/msdos_fs.h |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16-mm1-full/include/linux/msdos_fs.h.old	2006-03-26 19:58:45.000000000 +0200
+++ linux-2.6.16-mm1-full/include/linux/msdos_fs.h	2006-03-26 19:59:03.000000000 +0200
@@ -420,6 +420,9 @@
 extern void fat_date_unix2dos(int unix_date, __le16 *time, __le16 *date);
 extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
 
+int fat_cache_init(void);
+void fat_cache_destroy(void);
+
 #endif /* __KERNEL__ */
 
 #endif
--- linux-2.6.16-mm1-full/fs/fat/inode.c.old	2006-03-26 19:59:16.000000000 +0200
+++ linux-2.6.16-mm1-full/fs/fat/inode.c	2006-03-26 19:59:29.000000000 +0200
@@ -1435,9 +1435,6 @@
 
 EXPORT_SYMBOL_GPL(fat_fill_super);
 
-int __init fat_cache_init(void);
-void fat_cache_destroy(void);
-
 static int __init init_fat_fs(void)
 {
 	int err;

