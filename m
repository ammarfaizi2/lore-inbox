Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWHYO4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWHYO4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWHYOz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:55:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65408 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030198AbWHYOtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:49:33 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/18] [PATCH] BLOCK: Move bdev_cache_init() declaration to headerfile [try #3]
Date: Fri, 25 Aug 2006 15:49:29 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825144929.30722.68373.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
References: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move the bdev_cache_init() extern declaration from fs/dcache.c to
linux/blkdev.h.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/dcache.c            |    2 +-
 include/linux/blkdev.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b4a3a3..886ca6f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@ #include <linux/security.h>
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/blkdev.h>
 
 
 int sysctl_vfs_cache_pressure __read_mostly = 100;
@@ -1742,7 +1743,6 @@ kmem_cache_t *filp_cachep __read_mostly;
 
 EXPORT_SYMBOL(d_genocide);
 
-extern void bdev_cache_init(void);
 extern void chrdev_init(void);
 
 void __init vfs_caches_init_early(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c0c60d3..04a11f7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -834,5 +834,6 @@ #define MODULE_ALIAS_BLOCKDEV(major,mino
 #define MODULE_ALIAS_BLOCKDEV_MAJOR(major) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-*")
 
+extern void bdev_cache_init(void);
 
 #endif
