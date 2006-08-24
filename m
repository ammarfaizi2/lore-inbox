Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWHXVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWHXVeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWHXVeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:34:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422689AbWHXVdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:33:08 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/17] BLOCK: Move bdev_cache_init() declaration to headerfile [try #2]
Date: Thu, 24 Aug 2006 22:33:06 +0100
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com
Message-Id: <20060824213305.21323.66404.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
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
index aafe827..41a643f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -840,5 +840,6 @@ #define MODULE_ALIAS_BLOCKDEV(major,mino
 #define MODULE_ALIAS_BLOCKDEV_MAJOR(major) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-*")
 
+extern void bdev_cache_init(void);
 
 #endif
