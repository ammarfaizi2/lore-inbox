Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSKRVuI>; Mon, 18 Nov 2002 16:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSKRVuH>; Mon, 18 Nov 2002 16:50:07 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:3200 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S264885AbSKRVuG>; Mon, 18 Nov 2002 16:50:06 -0500
Date: Mon, 18 Nov 2002 16:56:56 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] give NFS client a "set_page_dirty" address space op.
Message-ID: <Pine.LNX.4.44.0211181654530.1518-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

against 2.5.48.


diff -ruN 03-wb_base/fs/nfs/file.c 04-set_page_dirty/fs/nfs/file.c
--- 03-wb_base/fs/nfs/file.c	Sun Nov 17 23:29:49 2002
+++ 04-set_page_dirty/fs/nfs/file.c	Mon Nov 18 11:55:32 2002
@@ -168,6 +168,7 @@
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
 	.prepare_write = nfs_prepare_write,

