Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUBBUBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUBBUAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:00:13 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:12940 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265908AbUBBT6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:58:19 -0500
Date: Mon, 2 Feb 2004 20:58:19 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 27/42]
Message-ID: <20040202195819.GA6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


linuxvfs.c:682: warning: `befs_listxattr' defined but not used
linuxvfs.c:690: warning: `befs_getxattr' defined but not used
linuxvfs.c:697: warning: `befs_setxattr' defined but not used
linuxvfs.c:703: warning: `befs_removexattr' defined but not used

Extended attribute not implemented yet. Wrapped with #if 0 + comment.

diff -Nru -X dontdiff linux-2.4-vanilla/fs/befs/linuxvfs.c linux-2.4/fs/befs/linuxvfs.c
--- linux-2.4-vanilla/fs/befs/linuxvfs.c	Fri Jun 13 16:51:37 2003
+++ linux-2.4/fs/befs/linuxvfs.c	Sat Jan 31 18:17:28 2004
@@ -55,12 +55,15 @@
 static int befs_statfs(struct super_block *, struct statfs *);
 static int parse_options(char *, befs_mount_options *);
 
+/* Extended attributes aren't implemented yet */
+#if 0
 static ssize_t befs_listxattr(struct dentry *dentry, char *buffer, size_t size);
 static ssize_t befs_getxattr(struct dentry *dentry, const char *name,
 			     void *buffer, size_t size);
 static int befs_setxattr(struct dentry *dentry, const char *name, void *value,
 			 size_t size, int flags);
 static int befs_removexattr(struct dentry *dentry, const char *name);
+#endif
 
 /* slab cache for befs_inode_info objects */
 static kmem_cache_t *befs_inode_cachep;
@@ -677,6 +680,8 @@
 
 /****Xattr****/
 
+/* Extended attributes aren't implemented yet */
+#if 0
 static ssize_t
 befs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
@@ -703,6 +708,7 @@
 {
 	return 0;
 }
+#endif
 
 /****Superblock****/
 

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Dicono che  il cane sia  il miglior  amico dell'uomo. Secondo me  non e`
vero. Quanti dei vostri amici avete fatto castrare, recentemente?
