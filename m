Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWEAVSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWEAVSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWEAVSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:18:37 -0400
Received: from mail.fuug.fi ([83.145.198.117]:11729 "EHLO mail.fuug.fi")
	by vger.kernel.org with ESMTP id S1751259AbWEAVSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:18:36 -0400
Date: Tue, 2 May 2006 00:17:54 +0300 (EEST)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: xfs-masters@oss.sgi.com, nathans@sgi.com
cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/xfs/xfs_bmap.c: initialize variable, remove warning
Message-ID: <Pine.LNX.4.64.0605020015230.5245@joo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petri T. Koistinen <petri.koistinen@iki.fi>

Remove warning by initializing uninitialized variable.

Warning:
  CC      fs/xfs/xfs_bmap.o
fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
fs/xfs/xfs_bmap.c:2498: warning: 'rtx' is used uninitialized in this function

Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>
---
 fs/xfs/xfs_bmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
---
diff --git a/fs/xfs/xfs_bmap.c b/fs/xfs/xfs_bmap.c
index 26939d3..35bad7b 100644
--- a/fs/xfs/xfs_bmap.c
+++ b/fs/xfs/xfs_bmap.c
@@ -2453,7 +2453,7 @@ xfs_bmap_rtalloc(
 	xfs_extlen_t	prod = 0;	/* product factor for allocators */
 	xfs_extlen_t	ralen = 0;	/* realtime allocation length */
 	xfs_extlen_t	align;		/* minimum allocation alignment */
-	xfs_rtblock_t	rtx;		/* realtime extent number */
+	xfs_rtblock_t	rtx = 0;	/* realtime extent number */
 	xfs_rtblock_t	rtb;

 	mp = ap->ip->i_mount;


