Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVBFSq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVBFSq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVBFSos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:44:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46352 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261276AbVBFSoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:44:32 -0500
Date: Sun, 6 Feb 2005 19:44:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vandrove@vc.cvut.cz, linware@sh.cvut.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ncpfs/ncplib_kernel.c: make a function static
Message-ID: <20050206184427.GS3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jan 2005

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

