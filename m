Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVAHV6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVAHV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVAHV5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:57:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8197 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261834AbVAHVzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:55:11 -0500
Date: Sat, 8 Jan 2005 22:55:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vandrove@vc.cvut.cz
Cc: linware@sh.cvut.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ncpfs/ncplib_kernel.c: make a function static
Message-ID: <20050108215504.GA14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/fs/ncpfs/ncplib_kernel.c.old	2005-01-08 04:31:10.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ncpfs/ncplib_kernel.c	2005-01-08 04:31:19.000000000 +0100
@@ -933,7 +933,7 @@
 	return 0;
 }
 
-int
+static int
 ncp_RenameNSEntry(struct ncp_server *server,
 		  struct inode *old_dir, char *old_name, __le16 old_type,
 		  struct inode *new_dir, char *new_name)

