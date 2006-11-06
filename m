Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753256AbWKFPrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbWKFPrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbWKFPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:47:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:52725 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753256AbWKFPrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:47:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MfyCA10++MV/qvUA1NOD2qZh121EIeSYQQs7YUmCk2NEzEypDJPAOGDmqs3o+Br2Yw6YeNjKJGhP1ZLTy26yEHcaeqj7DwY6DAatZlZwPJ0utQCmsxB+89h6rd+xfvM2sxH9uixsJyilIpK7gyV/Ps/6etZgTVA00+OEcVIaT28=
Date: Mon, 6 Nov 2006 16:47:27 +0000
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slab.c: whitespace cleanup
Message-Id: <20061106164727.7ad2fb2c.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whitespace cleanup for mm/slab.c

Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff --git a/mm/slab.c b/mm/slab.c
index 84c631f..486e14c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -308,10 +308,10 @@ struct kmem_list3 __initdata initkmem_li
 #define	SIZE_AC 1
 #define	SIZE_L3 (1 + MAX_NUMNODES)
 
-static int drain_freelist(struct kmem_cache *cache,
-			struct kmem_list3 *l3, int tofree);
+static int drain_freelist(struct kmem_cache *cache, struct kmem_list3 *l3,
+			  int tofree);
 static void free_block(struct kmem_cache *cachep, void **objpp, int len,
-			int node);
+		       int node);
 static int enable_cpucache(struct kmem_cache *cachep);
 static void cache_reap(void *unused);
 
@@ -761,7 +761,7 @@ static inline struct array_cache *cpu_ca
 }
 
 static inline struct kmem_cache *__find_general_cachep(size_t size,
-							gfp_t gfpflags)
+						       gfp_t gfpflags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 
@@ -1429,14 +1429,13 @@ void __init kmem_cache_init(void)
 					ARCH_KMALLOC_FLAGS|SLAB_PANIC,
 					NULL, NULL);
 
-	if (INDEX_AC != INDEX_L3) {
+	if (INDEX_AC != INDEX_L3)
 		sizes[INDEX_L3].cs_cachep =
 			kmem_cache_create(names[INDEX_L3].name,
 				sizes[INDEX_L3].cs_size,
 				ARCH_KMALLOC_MINALIGN,
 				ARCH_KMALLOC_FLAGS|SLAB_PANIC,
 				NULL, NULL);
-	}
 
 	slab_early_init = 0;
 
@@ -1448,13 +1447,12 @@ void __init kmem_cache_init(void)
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches.
 		 */
-		if (!sizes->cs_cachep) {
+		if (!sizes->cs_cachep)
 			sizes->cs_cachep = kmem_cache_create(names->name,
 					sizes->cs_size,
 					ARCH_KMALLOC_MINALIGN,
 					ARCH_KMALLOC_FLAGS|SLAB_PANIC,
 					NULL, NULL);
-		}
 
 		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
 					sizes->cs_size,
@@ -1510,10 +1508,9 @@ void __init kmem_cache_init(void)
 			init_list(malloc_sizes[INDEX_AC].cs_cachep,
 				  &initkmem_list3[SIZE_AC + nid], nid);
 
-			if (INDEX_AC != INDEX_L3) {
+			if (INDEX_AC != INDEX_L3)
 				init_list(malloc_sizes[INDEX_L3].cs_cachep,
 					  &initkmem_list3[SIZE_L3 + nid], nid);
-			}
 		}
 	}
 
@@ -1593,11 +1590,11 @@ static void *kmem_getpages(struct kmem_c
 
 	nr_pages = (1 << cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
-		add_zone_page_state(page_zone(page),
-			NR_SLAB_RECLAIMABLE, nr_pages);
+		add_zone_page_state(page_zone(page), NR_SLAB_RECLAIMABLE,
+				    nr_pages);
 	else
-		add_zone_page_state(page_zone(page),
-			NR_SLAB_UNRECLAIMABLE, nr_pages);
+		add_zone_page_state(page_zone(page), NR_SLAB_UNRECLAIMABLE,
+				    nr_pages);
 	for (i = 0; i < nr_pages; i++)
 		__SetPageSlab(page + i);
 	return page_address(page);
@@ -1613,11 +1610,11 @@ static void kmem_freepages(struct kmem_c
 	const unsigned long nr_freed = i;
 
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
-		sub_zone_page_state(page_zone(page),
-				NR_SLAB_RECLAIMABLE, nr_freed);
+		sub_zone_page_state(page_zone(page), NR_SLAB_RECLAIMABLE,
+				    nr_freed);
 	else
-		sub_zone_page_state(page_zone(page),
-				NR_SLAB_UNRECLAIMABLE, nr_freed);
+		sub_zone_page_state(page_zone(page), NR_SLAB_UNRECLAIMABLE,
+				    nr_freed);
 	while (i--) {
 		BUG_ON(!PageSlab(page));
 		__ClearPageSlab(page);
@@ -1646,7 +1643,7 @@ static void store_stackinfo(struct kmem_
 {
 	int size = obj_size(cachep);
 
-	addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
+	addr = (unsigned long *)((char *)addr + obj_offset(cachep));
 
 	if (size < 5 * sizeof(unsigned long))
 		return;
@@ -1898,9 +1895,8 @@ static void set_up_list3s(struct kmem_ca
 
 	for_each_online_node(node) {
 		cachep->nodelists[node] = &initkmem_list3[index + node];
-		cachep->nodelists[node]->next_reap = jiffies +
-		    REAPTIMEOUT_LIST3 +
-		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
+		cachep->nodelists[node]->next_reap = jiffies + REAPTIMEOUT_LIST3
+			+ ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 	}
 }
 
@@ -1938,8 +1934,8 @@ static void __kmem_cache_destroy(struct 
  * high order pages for slabs.  When the gfp() functions are more friendly
  * towards high-order requests, this should be changed.
  */
-static size_t calculate_slab_order(struct kmem_cache *cachep,
-			size_t size, size_t align, unsigned long flags)
+static size_t calculate_slab_order(struct kmem_cache *cachep, size_t size,
+				   size_t align, unsigned long flags)
 {
 	unsigned long offslab_limit;
 	size_t left_over = 0;
@@ -2029,8 +2025,8 @@ static int setup_cpu_cache(struct kmem_c
 			int node;
 			for_each_online_node(node) {
 				cachep->nodelists[node] =
-				    kmalloc_node(sizeof(struct kmem_list3),
-						GFP_KERNEL, node);
+					kmalloc_node(sizeof(struct kmem_list3),
+						     GFP_KERNEL, node);
 				BUG_ON(!cachep->nodelists[node]);
 				kmem_list3_init(cachep->nodelists[node]);
 			}
@@ -2079,10 +2075,10 @@ static int setup_cpu_cache(struct kmem_c
  * as davem.
  */
 struct kmem_cache *
-kmem_cache_create (const char *name, size_t size, size_t align,
-	unsigned long flags,
-	void (*ctor)(void*, struct kmem_cache *, unsigned long),
-	void (*dtor)(void*, struct kmem_cache *, unsigned long))
+kmem_cache_create(const char *name, size_t size, size_t align,
+		  unsigned long flags,
+		  void (*ctor)(void*, struct kmem_cache *, unsigned long),
+		  void (*dtor)(void*, struct kmem_cache *, unsigned long))
 {
 	size_t left_over, slab_size, ralign;
 	struct kmem_cache *cachep = NULL, *pc;
@@ -2185,9 +2181,8 @@ kmem_cache_create (const char *name, siz
 		ralign = cache_line_size();
 		while (size <= ralign / 2)
 			ralign /= 2;
-	} else {
+	} else
 		ralign = BYTES_PER_WORD;
-	}
 
 	/*
 	 * Redzoning and user store require word alignment. Note this will be
@@ -2231,12 +2226,12 @@ kmem_cache_create (const char *name, siz
 		cachep->obj_offset += BYTES_PER_WORD;
 		size += 2 * BYTES_PER_WORD;
 	}
-	if (flags & SLAB_STORE_USER) {
+	if (flags & SLAB_STORE_USER)
 		/* user store requires one word storage behind the end of
 		 * the real object.
 		 */
 		size += BYTES_PER_WORD;
-	}
+	
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
 	if (size >= malloc_sizes[INDEX_L3 + 1].cs_size
 	    && cachep->obj_size > cache_line_size() && size < PAGE_SIZE) {
@@ -2280,11 +2275,10 @@ kmem_cache_create (const char *name, siz
 		left_over -= slab_size;
 	}
 
-	if (flags & CFLGS_OFF_SLAB) {
+	if (flags & CFLGS_OFF_SLAB)
 		/* really off slab. No need for manual alignment */
 		slab_size =
 		    cachep->num * sizeof(kmem_bufctl_t) + sizeof(struct slab);
-	}
 
 	cachep->colour_off = cache_line_size();
 	/* Offset must be a multiple of the alignment. */
@@ -2366,8 +2360,7 @@ static void check_spinlock_acquired_node
 #endif
 
 static void drain_array(struct kmem_cache *cachep, struct kmem_list3 *l3,
-			struct array_cache *ac,
-			int force, int node);
+			struct array_cache *ac, int force, int node);
 
 static void do_drain(void *arg)
 {
@@ -2409,8 +2402,8 @@ static void drain_cpu_caches(struct kmem
  *
  * Returns the actual number of slabs released.
  */
-static int drain_freelist(struct kmem_cache *cache,
-			struct kmem_list3 *l3, int tofree)
+static int drain_freelist(struct kmem_cache *cache, struct kmem_list3 *l3,
+			  int tofree)
 {
 	struct list_head *p;
 	int nr_freed;
@@ -4082,10 +4075,9 @@ ssize_t slabinfo_write(struct file *file
 			if (limit < 1 || batchcount < 1 ||
 					batchcount > limit || shared < 0) {
 				res = 0;
-			} else {
+			} else
 				res = do_tune_cpucache(cachep, limit,
 						       batchcount, shared);
-			}
 			break;
 		}
 	}
@@ -4121,22 +4113,23 @@ static inline int add_caller(unsigned lo
 	l = n[1];
 	p = n + 2;
 	while (l) {
-		int i = l/2;
+		int i = l / 2;
 		unsigned long *q = p + 2 * i;
 		if (*q == v) {
 			q[1]++;
 			return 1;
 		}
-		if (*q > v) {
+		if (*q > v)
 			l = i;
-		} else {
+		else {
 			p = q + 2;
 			l -= i + 1;
 		}
 	}
 	if (++n[1] == n[0])
 		return 0;
-	memmove(p + 2, p, n[1] * 2 * sizeof(unsigned long) - ((void *)p - (void *)n));
+	memmove(p + 2, p,
+		n[1] * 2 * sizeof(unsigned long) - ((void *)p - (void *)n));
 	p[0] = v;
 	p[1] = 1;
 	return 1;
@@ -4213,7 +4206,8 @@ static int leaks_show(struct seq_file *m
 	if (n[0] == n[1]) {
 		/* Increase the buffer size */
 		mutex_unlock(&cache_chain_mutex);
-		m->private = kzalloc(n[0] * 4 * sizeof(unsigned long), GFP_KERNEL);
+		m->private = kzalloc(n[0] * 4 * sizeof(unsigned long),
+				     GFP_KERNEL);
 		if (!m->private) {
 			/* Too bad, we are really out */
 			m->private = n;
@@ -4228,8 +4222,8 @@ static int leaks_show(struct seq_file *m
 		return 0;
 	}
 	for (i = 0; i < n[1]; i++) {
-		seq_printf(m, "%s: %lu ", name, n[2*i+3]);
-		show_symbol(m, n[2*i+2]);
+		seq_printf(m, "%s: %lu ", name, n[2 * i + 3]);
+		show_symbol(m, n[2 * i + 2]);
 		seq_putc(m, '\n');
 	}
 
