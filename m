Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWF1RAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWF1RAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWF1Q7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:59:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39684 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751432AbWF1Qyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:55 -0400
Date: Wed, 28 Jun 2006 18:54:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/jffs2/: make 2 functions static
Message-ID: <20060628165455.GT13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Jun 2006

 fs/jffs2/malloc.c   |    2 +-
 fs/jffs2/nodelist.h |    2 --
 fs/jffs2/scan.c     |    4 ++--
 3 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.17-mm1-full/fs/jffs2/malloc.c.old	2006-06-22 11:31:15.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/jffs2/malloc.c	2006-06-22 11:31:23.000000000 +0200
@@ -190,7 +190,7 @@
 	kmem_cache_free(tmp_dnode_info_slab, x);
 }
 
-struct jffs2_raw_node_ref *jffs2_alloc_refblock(void)
+static struct jffs2_raw_node_ref *jffs2_alloc_refblock(void)
 {
 	struct jffs2_raw_node_ref *ret;
 
--- linux-2.6.17-mm1-full/fs/jffs2/nodelist.h.old	2006-06-22 11:31:31.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/jffs2/nodelist.h	2006-06-22 11:31:38.000000000 +0200
@@ -427,8 +427,6 @@
 /* scan.c */
 int jffs2_scan_medium(struct jffs2_sb_info *c);
 void jffs2_rotate_lists(struct jffs2_sb_info *c);
-int jffs2_fill_scan_buf(struct jffs2_sb_info *c, void *buf,
-				uint32_t ofs, uint32_t len);
 struct jffs2_inode_cache *jffs2_scan_make_ino_cache(struct jffs2_sb_info *c, uint32_t ino);
 int jffs2_scan_classify_jeb(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb);
 int jffs2_scan_dirty_space(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb, uint32_t size);
--- linux-2.6.17-mm1-full/fs/jffs2/scan.c.old	2006-06-22 11:31:47.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/jffs2/scan.c	2006-06-22 11:32:11.000000000 +0200
@@ -274,8 +274,8 @@
 	return ret;
 }
 
-int jffs2_fill_scan_buf (struct jffs2_sb_info *c, void *buf,
-				uint32_t ofs, uint32_t len)
+static int jffs2_fill_scan_buf(struct jffs2_sb_info *c, void *buf,
+			       uint32_t ofs, uint32_t len)
 {
 	int ret;
 	size_t retlen;

