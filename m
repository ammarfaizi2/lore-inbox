Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUASNFX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUASNFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:05:23 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:3515 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264898AbUASNFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:05:19 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com,
       torvalds@osdl.org
Subject: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
Message-Id: <E1AiZ5h-00043I-00@jaguar.mkp.net>
From: Jes Sorensen <jes@trained-monkey.org>
Date: Mon, 19 Jan 2004 08:05:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since we now support # of CPUs > BITS_PER_LONG with cpumask_t it would
be nice to be able to support more than BITS_PER_LONG memory blocks.

Patch relative to 2.6.1-mm4.

Cheers,
Jes

--- orig/linux-2.6.1-mm4/include/linux/mmzone.h	Fri Jan 16 01:59:20 2004
+++ linux-2.6.1-mm4/include/linux/mmzone.h	Mon Jan 19 04:44:37 2004
@@ -296,7 +296,7 @@
 					  void *, size_t *);
 
 #ifdef CONFIG_NUMA
-#define MAX_NR_MEMBLKS	BITS_PER_LONG /* Max number of Memory Blocks */
+#define MAX_NR_MEMBLKS	MAX_NUMNODES /* Max number of Memory Blocks */
 #else /* !CONFIG_NUMA */
 #define MAX_NR_MEMBLKS	1
 #endif /* CONFIG_NUMA */


