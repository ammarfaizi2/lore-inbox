Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTHWGG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 02:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTHWGG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 02:06:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:1422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263310AbTHWGGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 02:06:52 -0400
Date: Fri, 22 Aug 2003 23:05:09 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, jffs-dev@axis.com
Subject: [PATCH] eliminate type warnings in jffs
Message-Id: <20030822230509.053c2985.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



patch_name:	jffs_fntypes.patch
patch_version:	2003-08-22.22:57:20
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	eliminate warning: initialization from incompatible
		pointer type (2 times)
product:	Linux
product_versions: 260-test4
maintainer:	jffs-dev@axis.com
diffstat:	=
 fs/jffs/inode-v23.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naur ./fs/jffs/inode-v23.c~fntypes ./fs/jffs/inode-v23.c
--- ./fs/jffs/inode-v23.c~fntypes	Fri Aug 22 16:57:08 2003
+++ ./fs/jffs/inode-v23.c	Fri Aug 22 22:43:45 2003
@@ -1530,7 +1530,7 @@
 	return err;
 } /* jffs_file_write()  */
 
-static ssize_t
+static int
 jffs_prepare_write(struct file *filp, struct page *page,
                   unsigned from, unsigned to)
 {
@@ -1543,7 +1543,7 @@
 	return 0;
 } /* jffs_prepare_write() */
 
-static ssize_t
+static int
 jffs_commit_write(struct file *filp, struct page *page,
                  unsigned from, unsigned to)
 {


--
~Randy
