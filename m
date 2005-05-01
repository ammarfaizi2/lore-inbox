Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVEAPnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVEAPnf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVEAPne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:43:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43272 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261658AbVEAPmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:42:07 -0400
Date: Sun, 1 May 2005 17:42:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/afs/file.c: make a struct static
Message-ID: <20050501154205.GI3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Apr 2005

--- linux-2.6.12-rc2-mm3-full/fs/afs/file.c.old	2005-04-20 23:01:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/afs/file.c	2005-04-20 23:02:00.000000000 +0200
@@ -62,7 +62,7 @@
 	.invalidatepage	= afs_file_invalidatepage,
 };
 
-struct vm_operations_struct afs_fs_vm_operations = {
+static struct vm_operations_struct afs_fs_vm_operations = {
 	.nopage		= filemap_nopage,
 	.populate	= filemap_populate,
 #ifdef CONFIG_AFS_FSCACHE

