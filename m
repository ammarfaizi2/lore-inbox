Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVKJCCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVKJCCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbVKJCCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:02:49 -0500
Received: from silver.veritas.com ([143.127.12.111]:13610 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750784AbVKJCCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:02:48 -0500
Date: Thu, 10 Nov 2005 02:01:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] mm reiser4: long page counts
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100200270.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 02:02:48.0022 (UTC) FILETIME=[D91D2F60:01C5E59A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update -mm tree's reiser4 source for the long page_count.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/reiser4/page_cache.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- mm11/fs/reiser4/page_cache.c	2005-11-09 14:38:18.000000000 +0000
+++ mm12/fs/reiser4/page_cache.c	2005-11-09 14:40:00.000000000 +0000
@@ -751,7 +751,7 @@ void print_page(const char *prefix, stru
 		printk("null page\n");
 		return;
 	}
-	printk("%s: page index: %lu mapping: %p count: %i private: %lx\n",
+	printk("%s: page index: %lu mapping: %p count: %li private: %lx\n",
 	       prefix, page->index, page->mapping, page_count(page),
 	       page->private);
 	printk("\tflags: %s%s%s%s %s%s%s %s%s%s %s%s\n",
