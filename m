Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUJ3Rzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUJ3Rzq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUJ3Rzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:55:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3080 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261231AbUJ3Rze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:55:34 -0400
Date: Sat, 30 Oct 2004 19:54:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] devpts/inode.c: make one struct static
Message-ID: <20041030175458.GO4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes struct devpts_file_inode_operations in 
fs/devpts/inode.c static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/devpts/inode.c.old	2004-10-30 13:56:39.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/devpts/inode.c	2004-10-30 13:57:05.000000000 +0200
@@ -31,7 +31,7 @@
 	NULL
 };
 
-struct inode_operations devpts_file_inode_operations = {
+static struct inode_operations devpts_file_inode_operations = {
 #ifdef CONFIG_DEVPTS_FS_XATTR
 	.setxattr	= generic_setxattr,
 	.getxattr	= generic_getxattr,

