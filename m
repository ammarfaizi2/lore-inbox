Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTE1Hdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTE1Hdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:33:38 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:50958 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S264601AbTE1Hdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:33:37 -0400
Date: Wed, 28 May 2003 02:46:30 -0500 (CDT)
Message-Id: <200305280746.h4S7kUhC029132@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Vagn Scott <vagn@ranok.com>
In-Reply-To: <E19KqBF-0000Ba-00@Maya.ny.ranok.com>
Subject: [2.5.70] Kernel panic: Attempted to kill init!
Cc: Andrew Morton <akpm@digeo.com>, <coda@cs.cmu.edu>,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== fs/coda/inode.c 1.25 vs edited =====
--- 1.25/fs/coda/inode.c	Sun May 25 20:38:56 2003
+++ edited/fs/coda/inode.c	Wed May 28 02:38:28 2003
@@ -70,7 +70,7 @@
 {
 	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
 					     sizeof(struct coda_inode_info),
-					     0, SLAB_HWCACHE_ALIGN||SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (coda_inode_cachep == NULL)
 		return -ENOMEM;
