Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWAPOCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWAPOCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAPOCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:02:32 -0500
Received: from mx1.suse.de ([195.135.220.2]:54440 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750766AbWAPOCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:02:32 -0500
Date: Mon, 16 Jan 2006 15:02:30 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] export writeback_bdev and writeback_inode
Message-ID: <20060116140230.GA10157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*** Warning: "writeback_bdev" [fs/msdos/msdos.ko] undefined!
*** Warning: "writeback_inode" [fs/msdos/msdos.ko] undefined!

Signed-off-by: Olaf Hering <olh@suse.de>

 fs/fs-writeback.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.15/fs/fs-writeback.c
===================================================================
--- linux-2.6.15.orig/fs/fs-writeback.c
+++ linux-2.6.15/fs/fs-writeback.c
@@ -397,6 +397,7 @@ writeback_bdev(struct super_block *sb)
 	filemap_flush(mapping);
 	blk_run_address_space(mapping);
 }
+EXPORT_SYMBOL_GPL(writeback_bdev);
 
 void
 writeback_inode(struct inode *inode)
@@ -410,6 +411,7 @@ writeback_inode(struct inode *inode)
 	sync_inode(inode, &wbc);
 	filemap_fdatawrite(mapping);
 }
+EXPORT_SYMBOL_GPL(writeback_inode);
 
 /*
  * Start writeback of dirty pagecache data against all unlocked inodes.
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
