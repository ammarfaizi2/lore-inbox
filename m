Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTEDTjX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 15:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbTEDTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 15:39:23 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:16392 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261566AbTEDTjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 15:39:22 -0400
Date: Sun, 4 May 2003 14:13:56 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Trivial C99 patch for fs/libfs.c
Message-ID: <20030504191356.GA24907@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts an old-style initializer to the C99 style. The patch
is against the current BK.

Art Haas

===== fs/libfs.c 1.17 vs edited =====
--- 1.17/fs/libfs.c	Fri Apr 25 17:16:53 2003
+++ edited/fs/libfs.c	Sun May  4 14:09:03 2003
@@ -338,7 +338,7 @@
 
 int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files)
 {
-	static struct super_operations s_ops = {statfs:simple_statfs};
+	static struct super_operations s_ops = {.statfs = simple_statfs};
 	struct inode *inode;
 	struct dentry *root;
 	struct dentry *dentry;
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
