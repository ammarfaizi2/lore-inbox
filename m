Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274995AbTHLB4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275001AbTHLB4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:56:13 -0400
Received: from remt26.cluster1.charter.net ([209.225.8.36]:38362 "EHLO
	remt26.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S274995AbTHLByg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:54:36 -0400
Subject: [patch] 2.6.0-test3 fs/jffs/inode-v23.c
From: Josh Boyer <jwboyer@charter.net>
To: jffs-dev@axis.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1060653273.1998.15.camel@yoda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Aug 2003 20:54:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a compiler warning due to an incorrect structure type
for a function parameter.  Not sure if jffs is supported anymore, but I
thought I would send this anyway.

jb

--- linux-2.6.0-test3.orig/fs/jffs/inode-v23.c	2003-07-27
20:46:52.000000000 -0500
+++ linux-2.6.0-test3/fs/jffs/inode-v23.c	2003-08-11 20:45:38.382051048
-0500
@@ -383,7 +383,7 @@
 
 /* Get statistics of the file system.  */
 int
-jffs_statfs(struct super_block *sb, struct statfs *buf)
+jffs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct jffs_control *c = (struct jffs_control *) sb->s_fs_info;
 	struct jffs_fmcontrol *fmc;

