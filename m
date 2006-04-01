Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWDAKm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWDAKm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 05:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWDAKm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 05:42:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18194 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751156AbWDAKm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 05:42:26 -0500
Date: Sat, 1 Apr 2006 12:42:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Bharata B Rao <bharata@in.ibm.com>,
       Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Subject: [-mm patch] fix a superfluous kmem_set_shrinker() prototype
Message-ID: <20060401104224.GE28310@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug I introduced in 
slab-cache-shrinker-statistics.patch.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-mm2-full/include/linux/slab.h.old	2006-03-31 15:56:09.000000000 +0200
+++ linux-2.6.16-mm2-full/include/linux/slab.h	2006-03-31 15:56:24.000000000 +0200
@@ -222,9 +222,6 @@
 
 extern atomic_t slab_reclaim_pages;
 
-struct shrinker;
-extern void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker);
-
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */

