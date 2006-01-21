Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWAUAfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWAUAfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWAUAfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:35:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13843 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932308AbWAUAfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:35:08 -0500
Date: Sat, 21 Jan 2006 01:35:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ext2-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ext2/: proper ext2_get_parent() prototype
Message-ID: <20060121003508.GH31803@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a proper prototype for ext2_get_parent().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ext2/ext2.h  |    3 +++
 fs/ext2/super.c |    1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc1-mm2-full/fs/ext2/ext2.h.old	2006-01-21 01:11:51.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/ext2/ext2.h	2006-01-21 01:12:26.000000000 +0100
@@ -138,6 +138,9 @@
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);
 
+/* namei.c */
+struct dentry *ext2_get_parent(struct dentry *child);
+
 /* super.c */
 extern void ext2_error (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
--- linux-2.6.16-rc1-mm2-full/fs/ext2/super.c.old	2006-01-21 01:12:36.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/fs/ext2/super.c	2006-01-21 01:12:48.000000000 +0100
@@ -253,7 +253,6 @@
  * systems, but can be improved upon.
  * Currently only get_parent is required.
  */
-struct dentry *ext2_get_parent(struct dentry *child);
 static struct export_operations ext2_export_ops = {
 	.get_parent = ext2_get_parent,
 };

