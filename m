Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbVHSXnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVHSXnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVHSXnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:43:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13075 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965193AbVHSXnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:43:32 -0400
Date: Sat, 20 Aug 2005 01:43:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: xfs-masters@oss.sgi.com
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/xfs/linux-2.6/xfs_buf.h: "extern inline" doesn't make sense
Message-ID: <20050819234330.GF3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/fs/xfs/linux-2.6/xfs_buf.h.old	2005-08-19 23:23:40.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/fs/xfs/linux-2.6/xfs_buf.h	2005-08-19 23:23:47.000000000 +0200
@@ -452,7 +452,7 @@
 
 #define XFS_BUF_PTR(bp)		(xfs_caddr_t)((bp)->pb_addr)
 
-extern inline xfs_caddr_t xfs_buf_offset(xfs_buf_t *bp, size_t offset)
+static inline xfs_caddr_t xfs_buf_offset(xfs_buf_t *bp, size_t offset)
 {
 	if (bp->pb_flags & PBF_MAPPED)
 		return XFS_BUF_PTR(bp) + offset;

