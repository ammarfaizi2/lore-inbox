Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWBKFpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWBKFpO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 00:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWBKFpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 00:45:14 -0500
Received: from xenotime.net ([66.160.160.81]:57241 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751199AbWBKFpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 00:45:12 -0500
Date: Fri, 10 Feb 2006 21:45:55 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, penberg@cs.helsinki.fi
Subject: [PATCH] slab: fix kernel-doc warnings
Message-Id: <20060210214555.1ec88891.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warnings in mm/slab.c.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 mm/slab.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

--- linux-2616-rc2g9.orig/mm/slab.c
+++ linux-2616-rc2g9/mm/slab.c
@@ -1526,8 +1526,12 @@ static void check_poison_obj(struct kmem
 
 #if DEBUG
 /**
- * slab_destroy_objs - call the registered destructor for each object in
- *      a slab that is to be destroyed.
+ * slab_destroy_objs - destroy a slab and its objects
+ * @cachep: cache pointer being destroyed
+ * @slabp: slab pointer being destroyed
+ *
+ * Call the registered destructor for each object in a slab that is being
+ * destroyed.
  */
 static void slab_destroy_objs(struct kmem_cache *cachep, struct slab *slabp)
 {
@@ -1574,6 +1578,10 @@ static void slab_destroy_objs(struct kme
 #endif
 
 /**
+ * slab_destroy - destroy and release all objects in a slab
+ * @cachep: cache pointer being destroyed
+ * @slabp: slab pointer being destroyed
+ *
  * Destroy all the objs in a slab, and release the mem back to the system.
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
@@ -3085,6 +3093,7 @@ EXPORT_SYMBOL(kmalloc_node);
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
+ * @caller: function caller for debug tracking of the caller
  *
  * kmalloc is the normal method of allocating memory
  * in the kernel.


---
