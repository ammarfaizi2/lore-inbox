Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVDUEfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDUEfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 00:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVDUEff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 00:35:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15113 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261214AbVDUEfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 00:35:25 -0400
Date: Thu, 21 Apr 2005 06:35:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/afs/file.c: make a struct static
Message-ID: <20050421043521.GB3828@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

