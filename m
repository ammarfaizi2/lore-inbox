Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVLKVyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVLKVyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVLKVya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:54:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31758 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750875AbVLKVyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:54:25 -0500
Date: Sun, 11 Dec 2005 22:54:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Joel Becker <joel.becker@oracle.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Kurt Hackel <kurt.hackel@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/ocfs2/file.c: make ocfs2_extend_allocation() static
Message-ID: <20051211215424.GA23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global function 
ocfs2_extend_allocation() static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Nov 2005

--- linux-2.6.14-mm2-full/fs/ocfs2/file.c.old	2005-11-11 16:55:01.000000000 +0100
+++ linux-2.6.14-mm2-full/fs/ocfs2/file.c	2005-11-11 16:55:19.000000000 +0100
@@ -413,8 +413,8 @@
 	return status;
 }
 
-int ocfs2_extend_allocation(struct inode *inode,
-			    u32 clusters_to_add)
+static int ocfs2_extend_allocation(struct inode *inode,
+				   u32 clusters_to_add)
 {
 	int status = 0;
 	int restart_func = 0;

