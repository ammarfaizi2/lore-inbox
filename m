Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUJ2B5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUJ2B5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUJ2ByD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:54:03 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23558 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263195AbUJ2ATN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:19:13 -0400
Date: Fri, 29 Oct 2004 02:18:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: shaggy@austin.ibm.com
Cc: jfs-discussion@oss.software.ibm.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] jfs_metapage.c: remove an unused function
Message-ID: <20041029001839.GK29142@stusta.de>
References: <20041028222444.GQ3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028222444.GQ3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from fs/jfs/jfs_metapage.c


diffstat output:
 fs/jfs/jfs_metapage.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/fs/jfs/jfs_metapage.c.old	2004-10-28 22:41:29.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/fs/jfs/jfs_metapage.c	2004-10-28 22:41:42.000000000 +0200
@@ -108,11 +108,6 @@
 	}
 }
 
-static inline struct metapage *alloc_metapage(int no_wait)
-{
-	return mempool_alloc(metapage_mempool, no_wait ? GFP_ATOMIC : GFP_NOFS);
-}
-
 static inline void free_metapage(struct metapage *mp)
 {
 	mp->flag = 0;
