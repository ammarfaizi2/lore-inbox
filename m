Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbULGTjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbULGTjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbULGTjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:39:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42507 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261907AbULGTfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:35:32 -0500
Date: Tue, 7 Dec 2004 20:35:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] devpts/inode.c: make one struct static (fwd)
Message-ID: <20041207193524.GD7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 30 Oct 2004 19:54:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] devpts/inode.c: make one struct static

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

