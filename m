Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUH2U6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUH2U6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUH2U6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:58:15 -0400
Received: from verein.lst.de ([213.95.11.210]:1976 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266756AbUH2U6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:58:13 -0400
Date: Sun, 29 Aug 2004 22:58:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hfs/hfsplus is missing .sendfile
Message-ID: <20040829205808.GA5136@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seem to be some crazy mac users that want to use the loop driver
on hfsplus.


--- 1.16/fs/hfs/inode.c	2004-05-25 11:53:05 +02:00
+++ edited/fs/hfs/inode.c	2004-08-29 22:30:51 +02:00
@@ -609,6 +609,7 @@
 	.read		= generic_file_read,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
+	.sendfile	= generic_file_sendfile,
 	.fsync		= file_fsync,
 	.open		= hfs_file_open,
 	.release	= hfs_file_release,
--- 1.5/fs/hfsplus/inode.c	2004-07-12 10:00:54 +02:00
+++ edited/fs/hfsplus/inode.c	2004-08-29 22:31:05 +02:00
@@ -308,6 +308,7 @@
 	.read		= generic_file_read,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
+	.sendfile	= generic_file_sendfile,
 	.fsync		= file_fsync,
 	.open		= hfsplus_file_open,
 	.release	= hfsplus_file_release,
