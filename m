Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbVKPIvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVKPIvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbVKPIvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:51:39 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:64678 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030237AbVKPIvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:51:37 -0500
Message-ID: <437AF30E.8070006@namesys.com>
Date: Wed, 16 Nov 2005 00:51:26 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vs <vs@thebsh.namesys.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [PATCH 3/8] reiser4-rename-cluster-files.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090604090700010108000405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604090700010108000405
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit




--------------090604090700010108000405
Content-Type: message/rfc822;
 name="[PATCH 3/8] reiser4-rename-cluster-files.patch.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 3/8] reiser4-rename-cluster-files.patch.eml"

Return-Path: <vs@tribesman.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24412 invoked from network); 15 Nov 2005 17:00:10 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO tribesman.namesys.com) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:00:10 -0000
Received: by tribesman.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 512)
	id 4080071D994; Tue, 15 Nov 2005 19:59:46 +0300 (MSK)
Date: Tue, 15 Nov 2005 19:59:46 +0300
To: reiser@namesys.com
Subject: [PATCH 3/8] reiser4-rename-cluster-files.patch
Message-ID: <437A1402.mail7JG1DNV1O@tribesman.namesys.com>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1VF4G19EIP-=-1R3X41XZ6J-CUT-HERE-1GJJDDERNM-=-1OV7749ARO"
From: vs@tribesman.namesys.com (Vladimir Saveliev)

This is a multi-part message in MIME format.

--1VF4G19EIP-=-1R3X41XZ6J-CUT-HERE-1GJJDDERNM-=-1OV7749ARO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

.

--1VF4G19EIP-=-1R3X41XZ6J-CUT-HERE-1GJJDDERNM-=-1OV7749ARO
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reiser4-rename-cluster-files.patch"


From: Edward Shishkin <edward@namesys.com>

This patch moves several files within reiser4/.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/Makefile                    |    7 
 fs/reiser4/estimate.c                  |    2 
 fs/reiser4/flush.h                     |    2 
 fs/reiser4/plugin/cluster.c            |   66 ++++++
 fs/reiser4/plugin/cluster.h            |  327 +++++++++++++++++++++++++++++++++
 fs/reiser4/plugin/crypto/cipher.c      |  115 +++++++++++
 fs/reiser4/plugin/crypto/cipher.h      |   58 +++++
 fs/reiser4/plugin/crypto/digest.c      |   58 +++++
 fs/reiser4/plugin/file/cryptcompress.c |    2 
 fs/reiser4/plugin/file/cryptcompress.h |    2 
 fs/reiser4/plugin/item/ctail.c         |    2 
 fs/reiser4/plugin/plugin.h             |    2 
 fs/reiser4/cluster.c                   |   66 ------
 fs/reiser4/cluster.h                   |  327 ---------------------------------
 fs/reiser4/crypt.c                     |  115 -----------
 fs/reiser4/crypt.h                     |   58 -----
 fs/reiser4/plugin/digest.c             |   58 -----
 17 files changed, 634 insertions(+), 633 deletions(-)

diff -puN fs/reiser4/Makefile~reiser4-rename-cluster-files fs/reiser4/Makefile
--- linux-2.6.14-mm2/fs/reiser4/Makefile~reiser4-rename-cluster-files	2005-11-15 17:05:28.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/Makefile	2005-11-15 17:05:42.000000000 +0300
@@ -44,8 +44,6 @@ reiser4-y := \
 		   emergency_flush.o \
 		   entd.o\
 		   readahead.o \
-		   cluster.o \
-		   crypt.o \
 		   status_flags.o \
 		   init_super.o \
 		   safe_link.o \
@@ -54,6 +52,7 @@ reiser4-y := \
 		   plugin/plugin_set.o \
 		   plugin/node/node.o \
 		   plugin/object.o \
+		   plugin/cluster.o \
 		   plugin/inode_ops.o \
 		   plugin/inode_ops_rename.o \
 		   plugin/file_ops.o \
@@ -66,9 +65,11 @@ reiser4-y := \
 		   plugin/dir_plugin_common.o \
 		   plugin/dir/hashed_dir.o \
 		   plugin/dir/seekable_dir.o \
-		   plugin/digest.o \
 		   plugin/node/node40.o \
            \
+		   plugin/crypto/cipher.o \
+		   plugin/crypto/digest.o \
+           \
 		   plugin/compress/minilzo.o \
 		   plugin/compress/compress.o \
 		   plugin/compress/compress_mode.o \
diff -puN -L fs/reiser4/cluster.c fs/reiser4/cluster.c~reiser4-rename-cluster-files /dev/null
--- linux-2.6.14-mm2/fs/reiser4/cluster.c
+++ /dev/null	2003-09-23 21:59:22.000000000 +0400
@@ -1,66 +0,0 @@
-/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
-
-/* Contains reiser4 cluster plugins (see
-   http://www.namesys.com/cryptcompress_design.html
-   "Concepts of clustering" for details). */
-
-#include "plugin/plugin_header.h"
-#include "plugin/plugin.h"
-#include "inode.h"
-
-static int change_cluster(struct inode *inode, reiser4_plugin * plugin)
-{
-	int result = 0;
-
-	assert("edward-1324", inode != NULL);
-	assert("edward-1325", plugin != NULL);
-	assert("edward-1326", is_reiser4_inode(inode));
-	assert("edward-1327", plugin->h.type_id == REISER4_CLUSTER_PLUGIN_TYPE);
-
-	if (inode_file_plugin(inode)->h.id == DIRECTORY_FILE_PLUGIN_ID)
-		result = plugin_set_cluster(&reiser4_inode_data(inode)->pset,
-					    &plugin->clust);
-	else
-		result = RETERR(-EINVAL);
-	return result;
-}
-
-static reiser4_plugin_ops cluster_plugin_ops = {
-	.init = NULL,
-	.load = NULL,
-	.save_len = NULL,
-	.save = NULL,
-	.change = &change_cluster
-};
-
-#define SUPPORT_CLUSTER(SHIFT, ID, LABEL, DESC)			\
-	[CLUSTER_ ## ID ## _ID] = {				\
-		.h = {						\
-			.type_id = REISER4_CLUSTER_PLUGIN_TYPE,	\
-			.id = CLUSTER_ ## ID ## _ID,		\
-			.pops = &cluster_plugin_ops,		\
-			.label = LABEL,				\
-			.desc = DESC,				\
-			.linkage = {NULL, NULL}			\
-		},						\
-		.shift = SHIFT					\
-	}
-
-cluster_plugin cluster_plugins[LAST_CLUSTER_ID] = {
-	SUPPORT_CLUSTER(16, 64K, "64K", "Large"),
-	SUPPORT_CLUSTER(15, 32K, "32K", "Big"),
-	SUPPORT_CLUSTER(14, 16K, "16K", "Average"),
-	SUPPORT_CLUSTER(13, 8K, "8K", "Small"),
-	SUPPORT_CLUSTER(12, 4K, "4K", "Minimal")
-};
-
-/*
-  Local variables:
-  c-indentation-style: "K&R"
-  mode-name: "LC"
-  c-basic-offset: 8
-  tab-width: 8
-  fill-column: 120
-  scroll-step: 1
-  End:
-*/
diff -puN -L fs/reiser4/cluster.h fs/reiser4/cluster.h~reiser4-rename-cluster-files /dev/null
--- linux-2.6.14-mm2/fs/reiser4/cluster.h
+++ /dev/null	2003-09-23 21:59:22.000000000 +0400
@@ -1,327 +0,0 @@
-/* Copyright 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
-
-/* This file contains page/cluster index translators and offset modulators
-   See http://www.namesys.com/cryptcompress_design.html for details */
-
-#if !defined( __FS_REISER4_CLUSTER_H__ )
-#define __FS_REISER4_CLUSTER_H__
-
-#include "inode.h"
-
-static inline loff_t min_count(loff_t a, loff_t b)
-{
-	return (a < b ? a : b);
-}
-
-static inline loff_t max_count(loff_t a, loff_t b)
-{
-	return (a > b ? a : b);
-}
-
-static inline int inode_cluster_shift(struct inode *inode)
-{
-	assert("edward-92", inode != NULL);
-	assert("edward-93", reiser4_inode_data(inode) != NULL);
-
-	return inode_cluster_plugin(inode)->shift;
-}
-
-static inline unsigned cluster_nrpages_shift(struct inode *inode)
-{
-	return inode_cluster_shift(inode) - PAGE_CACHE_SHIFT;
-}
-
-/* cluster size in page units */
-static inline unsigned cluster_nrpages(struct inode *inode)
-{
-	return 1U << cluster_nrpages_shift(inode);
-}
-
-static inline size_t inode_cluster_size(struct inode *inode)
-{
-	assert("edward-96", inode != NULL);
-
-	return 1U << inode_cluster_shift(inode);
-}
-
-static inline unsigned long pg_to_clust(unsigned long idx, struct inode *inode)
-{
-	return idx >> cluster_nrpages_shift(inode);
-}
-
-static inline unsigned long clust_to_pg(unsigned long idx, struct inode *inode)
-{
-	return idx << cluster_nrpages_shift(inode);
-}
-
-static inline unsigned long
-pg_to_clust_to_pg(unsigned long idx, struct inode *inode)
-{
-	return clust_to_pg(pg_to_clust(idx, inode), inode);
-}
-
-static inline unsigned long off_to_pg(loff_t off)
-{
-	return (off >> PAGE_CACHE_SHIFT);
-}
-
-static inline loff_t pg_to_off(unsigned long idx)
-{
-	return ((loff_t) (idx) << PAGE_CACHE_SHIFT);
-}
-
-static inline unsigned long off_to_clust(loff_t off, struct inode *inode)
-{
-	return off >> inode_cluster_shift(inode);
-}
-
-static inline loff_t clust_to_off(unsigned long idx, struct inode *inode)
-{
-	return (loff_t) idx << inode_cluster_shift(inode);
-}
-
-static inline unsigned long count_to_nr(loff_t count, unsigned shift)
-{
-	return (count + (1UL << shift) - 1) >> shift;
-}
-
-/* number of pages occupied by @count bytes */
-static inline unsigned long count_to_nrpages(loff_t count)
-{
-	return count_to_nr(count, PAGE_CACHE_SHIFT);
-}
-
-/* number of clusters occupied by @count bytes */
-static inline cloff_t count_to_nrclust(loff_t count, struct inode *inode)
-{
-	return count_to_nr(count, inode_cluster_shift(inode));
-}
-
-/* number of clusters occupied by @count pages */
-static inline cloff_t pgcount_to_nrclust(pgoff_t count, struct inode *inode)
-{
-	return count_to_nr(count, cluster_nrpages_shift(inode));
-}
-
-static inline loff_t off_to_clust_to_off(loff_t off, struct inode *inode)
-{
-	return clust_to_off(off_to_clust(off, inode), inode);
-}
-
-static inline unsigned long off_to_clust_to_pg(loff_t off, struct inode *inode)
-{
-	return clust_to_pg(off_to_clust(off, inode), inode);
-}
-
-static inline unsigned off_to_pgoff(loff_t off)
-{
-	return off & (PAGE_CACHE_SIZE - 1);
-}
-
-static inline unsigned off_to_cloff(loff_t off, struct inode *inode)
-{
-	return off & ((loff_t) (inode_cluster_size(inode)) - 1);
-}
-
-static inline unsigned
-pg_to_off_to_cloff(unsigned long idx, struct inode *inode)
-{
-	return off_to_cloff(pg_to_off(idx), inode);
-}
-
-/* if @size != 0, returns index of the page
-   which contains the last byte of the file */
-static inline pgoff_t size_to_pg(loff_t size)
-{
-	return (size ? off_to_pg(size - 1) : 0);
-}
-
-/* minimal index of the page which doesn't contain
-   file data */
-static inline pgoff_t size_to_next_pg(loff_t size)
-{
-	return (size ? off_to_pg(size - 1) + 1 : 0);
-}
-
-static inline unsigned off_to_pgcount(loff_t off, unsigned long idx)
-{
-	if (idx > off_to_pg(off))
-		return 0;
-	if (idx < off_to_pg(off))
-		return PAGE_CACHE_SIZE;
-	return off_to_pgoff(off);
-}
-
-static inline unsigned
-off_to_count(loff_t off, unsigned long idx, struct inode *inode)
-{
-	if (idx > off_to_clust(off, inode))
-		return 0;
-	if (idx < off_to_clust(off, inode))
-		return inode_cluster_size(inode);
-	return off_to_cloff(off, inode);
-}
-
-static inline unsigned
-fsize_to_count(reiser4_cluster_t * clust, struct inode *inode)
-{
-	assert("edward-288", clust != NULL);
-	assert("edward-289", inode != NULL);
-
-	return off_to_count(inode->i_size, clust->index, inode);
-}
-
-static inline int
-cluster_is_complete(reiser4_cluster_t * clust, struct inode * inode)
-{
-	return clust->tc.lsize == inode_cluster_size(inode);
-}
-
-static inline void reiser4_slide_init(reiser4_slide_t * win)
-{
-	assert("edward-1084", win != NULL);
-	memset(win, 0, sizeof *win);
-}
-
-static inline void
-tfm_cluster_init_act(tfm_cluster_t * tc, tfm_action act)
-{
-	assert("edward-1356", tc != NULL);
-	assert("edward-1357", act != TFM_INVAL);
-	tc->act = act;
-}
-
-static inline void
-cluster_init_act (reiser4_cluster_t * clust, tfm_action act, reiser4_slide_t * window){
-	assert("edward-84", clust != NULL);
-	memset(clust, 0, sizeof *clust);
-	tfm_cluster_init_act(&clust->tc, act);
-	clust->dstat = INVAL_DISK_CLUSTER;
-	clust->win = window;
-}
-
-static inline void
-cluster_init_read(reiser4_cluster_t * clust, reiser4_slide_t * window)
-{
-	cluster_init_act (clust, TFM_READ, window);
-}
-
-static inline void
-cluster_init_write(reiser4_cluster_t * clust, reiser4_slide_t * window)
-{
-	cluster_init_act (clust, TFM_WRITE, window);
-}
-
-static inline int dclust_get_extension(hint_t * hint)
-{
-	return hint->ext_coord.extension.ctail.shift;
-}
-
-static inline void dclust_set_extension(hint_t * hint)
-{
-	assert("edward-1270",
-	       item_id_by_coord(&hint->ext_coord.coord) == CTAIL_ID);
-	hint->ext_coord.extension.ctail.shift =
-	    cluster_shift_by_coord(&hint->ext_coord.coord);
-}
-
-static inline int hint_is_unprepped_dclust(hint_t * hint)
-{
-	return dclust_get_extension(hint) == (int)UCTAIL_SHIFT;
-}
-
-static inline void coord_set_between_clusters(coord_t * coord)
-{
-#if REISER4_DEBUG
-	int result;
-	result = zload(coord->node);
-	assert("edward-1296", !result);
-#endif
-	if (!coord_is_between_items(coord)) {
-		coord->between = AFTER_ITEM;
-		coord->unit_pos = 0;
-	}
-#if REISER4_DEBUG
-	zrelse(coord->node);
-#endif
-}
-
-int inflate_cluster(reiser4_cluster_t *, struct inode *);
-int find_cluster(reiser4_cluster_t *, struct inode *, int read, int write);
-void forget_cluster_pages(struct page **page, int nrpages);
-int flush_cluster_pages(reiser4_cluster_t *, jnode *, struct inode *);
-int deflate_cluster(reiser4_cluster_t *, struct inode *);
-void truncate_page_cluster(struct inode *inode, cloff_t start);
-void set_hint_cluster(struct inode *inode, hint_t * hint, unsigned long index,
-		      znode_lock_mode mode);
-void invalidate_hint_cluster(reiser4_cluster_t * clust);
-void put_hint_cluster(reiser4_cluster_t * clust, struct inode *inode,
-		      znode_lock_mode mode);
-int get_disk_cluster_locked(reiser4_cluster_t * clust, struct inode *inode,
-			    znode_lock_mode lock_mode);
-void reset_cluster_params(reiser4_cluster_t * clust);
-int set_cluster_by_page(reiser4_cluster_t * clust, struct page * page,
-			int count);
-int prepare_page_cluster(struct inode *inode, reiser4_cluster_t * clust,
-			 int capture);
-void release_cluster_pages_nocapture(reiser4_cluster_t *);
-void put_cluster_handle(reiser4_cluster_t * clust);
-int grab_tfm_stream(struct inode *inode, tfm_cluster_t * tc, tfm_stream_id id);
-int tfm_cluster_is_uptodate(tfm_cluster_t * tc);
-void tfm_cluster_set_uptodate(tfm_cluster_t * tc);
-void tfm_cluster_clr_uptodate(tfm_cluster_t * tc);
-unsigned long clust_by_coord(const coord_t * coord, struct inode *inode);
-
-/* move cluster handle to the target position
-   specified by the page of index @pgidx
-*/
-static inline void
-move_cluster_forward(reiser4_cluster_t * clust, struct inode *inode,
-		     pgoff_t pgidx, int *progress)
-{
-	assert("edward-1297", clust != NULL);
-	assert("edward-1298", inode != NULL);
-
-	reset_cluster_params(clust);
-	if (*progress &&
-	    /* Hole in the indices. Hint became invalid and can not be
-	       used by find_cluster_item() even if seal/node versions
-	       will coincide */
-	    pg_to_clust(pgidx, inode) != clust->index + 1) {
-		unset_hint(clust->hint);
-		invalidate_hint_cluster(clust);
-	}
-	*progress = 1;
-	clust->index = pg_to_clust(pgidx, inode);
-}
-
-static inline int
-alloc_clust_pages(reiser4_cluster_t * clust, struct inode *inode)
-{
-	assert("edward-791", clust != NULL);
-	assert("edward-792", inode != NULL);
-	clust->pages =
-		kmalloc(sizeof(*clust->pages) << inode_cluster_shift(inode),
-			GFP_KERNEL);
-	if (!clust->pages)
-		return -ENOMEM;
-	return 0;
-}
-
-static inline void free_clust_pages(reiser4_cluster_t * clust)
-{
-	kfree(clust->pages);
-}
-
-#endif				/* __FS_REISER4_CLUSTER_H__ */
-
-/* Make Linus happy.
-   Local variables:
-   c-indentation-style: "K&R"
-   mode-name: "LC"
-   c-basic-offset: 8
-   tab-width: 8
-   fill-column: 120
-   scroll-step: 1
-   End:
-*/
diff -puN -L fs/reiser4/crypt.c fs/reiser4/crypt.c~reiser4-rename-cluster-files /dev/null
--- linux-2.6.14-mm2/fs/reiser4/crypt.c
+++ /dev/null	2003-09-23 21:59:22.000000000 +0400
@@ -1,115 +0,0 @@
-/* Copyright 2001, 2002, 2003 by Hans Reiser,
-   licensing governed by reiser4/README */
-/* Reiser4 cipher transform plugins */
-
-#include "debug.h"
-#include "plugin/plugin.h"
-#include "plugin/file/cryptcompress.h"
-#include <linux/types.h>
-#include <linux/random.h>
-
-#define MAX_CRYPTO_BLOCKSIZE 128
-
-/*
-  Default align() method of the crypto-plugin (look for description of this
-  method in plugin/plugin.h)
-
-  1) creates the aligning armored format of the input flow before encryption.
-     "armored" means that padding is filled by private data (for example,
-     pseudo-random sequence of bytes is not private data).
-  2) returns length of appended padding
-
-   [ flow | aligning_padding ]
-            ^
-            |
-	  @pad
-*/
-static int align_stream_common(__u8 * pad,
-			       int flow_size /* size of non-aligned flow */,
-			       int blocksize /* crypto-block size */)
-{
-	int pad_size;
-
-	assert("edward-01", pad != NULL);
-	assert("edward-02", flow_size != 0);
-	assert("edward-03", blocksize != 0
-	       || blocksize <= MAX_CRYPTO_BLOCKSIZE);
-
-	pad_size = blocksize - (flow_size % blocksize);
-	get_random_bytes(pad, pad_size);
-	return pad_size;
-}
-
-/* This is used for all the cipher algorithms which do not inflate
-   block-aligned data */
-static loff_t scale_common(struct inode *inode, size_t blocksize,
-			   loff_t src_off /* offset to scale */ )
-{
-	return src_off;
-}
-
-static void free_aes (struct crypto_tfm * tfm)
-{
-#if REISER4_AES
-	crypto_free_tfm(tfm);
-#endif
-	return;
-}
-
-static struct crypto_tfm * alloc_aes (void)
-{
-#if REISER4_AES
-	return crypto_alloc_tfm ("aes", 0);
-#else
-	warning("edward-1417", "aes unsupported");
-	return ERR_PTR(-EINVAL);
-#endif /* REISER4_AES */
-}
-
-crypto_plugin crypto_plugins[LAST_CRYPTO_ID] = {
-	[NONE_CRYPTO_ID] = {
-		.h = {
-			.type_id = REISER4_CRYPTO_PLUGIN_TYPE,
-			.id = NONE_CRYPTO_ID,
-			.pops = NULL,
-			.label = "none",
-			.desc = "no cipher transform",
-			.linkage = {NULL, NULL}
-		},
-		.alloc = NULL,
-		.free = NULL,
-		.scale = NULL,
-		.align_stream = NULL,
-		.setkey = NULL,
-		.encrypt = NULL,
-		.decrypt = NULL
-	},
-	[AES_CRYPTO_ID] = {
-		.h = {
-			.type_id = REISER4_CRYPTO_PLUGIN_TYPE,
-			.id = AES_CRYPTO_ID,
-			.pops = NULL,
-			.label = "aes",
-			.desc = "aes cipher transform",
-			.linkage = {NULL, NULL}
-		},
-		.alloc = alloc_aes,
-		.free = free_aes,
-		.scale = scale_common,
-		.align_stream = align_stream_common,
-		.setkey = NULL,
-		.encrypt = NULL,
-		.decrypt = NULL
-	}
-};
-
-/* Make Linus happy.
-   Local variables:
-   c-indentation-style: "K&R"
-   mode-name: "LC"
-   c-basic-offset: 8
-   tab-width: 8
-   fill-column: 120
-   scroll-step: 1
-   End:
-*/
diff -puN -L fs/reiser4/crypt.h fs/reiser4/crypt.h~reiser4-rename-cluster-files /dev/null
--- linux-2.6.14-mm2/fs/reiser4/crypt.h
+++ /dev/null	2003-09-23 21:59:22.000000000 +0400
@@ -1,58 +0,0 @@
-#if !defined( __FS_REISER4_CRYPT_H__ )
-#define __FS_REISER4_CRYPT_H__
-
-#include <linux/crypto.h>
-
-/* Crypto transforms involved in ciphering process and
-   supported by reiser4 via appropriate transform plugins */
-typedef enum {
-	CIPHER_TFM,       /* cipher transform */
-	DIGEST_TFM,       /* digest transform */
-	LAST_TFM
-} reiser4_tfm;
-
-/* This represents a transform from the set above */
-typedef struct reiser4_tfma {
-	reiser4_plugin * plug;     /* transform plugin */
-	struct crypto_tfm * tfm;   /* per-transform allocated info,
-                                      belongs to the crypto-api. */
-} reiser4_tfma_t;
-
-/* This contains cipher related info copied from user space */
-typedef struct crypto_data {
-	int keysize;    /* key size */
-	__u8 * key;     /* uninstantiated key */
-	int keyid_size; /* size of passphrase */
-	__u8 * keyid;   /* passphrase (uninstantiated keyid) */
-} crypto_data_t;
-
-/* Dynamically allocated per instantiated key info */
-typedef struct crypto_stat {
-	reiser4_tfma_t tfma[LAST_TFM];
-//      cipher_key_plugin * kplug; *//* key manager responsible for
-//                                      inheriting, validating, etc... */
-	__u8 * keyid;                /* fingerprint (instantiated keyid) of
-					the cipher key prepared by digest
-					plugin, supposed to be stored in
-					disk stat-data */
-	int inst;                    /* this indicates if the ciper key
-					is instantiated in the system */
-	int keysize;                 /* uninstantiated key size (bytes),
-					supposed to be stored in disk
-					stat-data */
-	int keyload_count;           /* number of the objects which has
-					this crypto-stat attached */
-} crypto_stat_t;
-
-#endif /* __FS_REISER4_CRYPT_H__ */
-
-/*
-   Local variables:
-   c-indentation-style: "K&R"
-   mode-name: "LC"
-   c-basic-offset: 8
-   tab-width: 8
-   fill-column: 120
-   scroll-step: 1
-   End:
-*/
diff -puN fs/reiser4/estimate.c~reiser4-rename-cluster-files fs/reiser4/estimate.c
--- linux-2.6.14-mm2/fs/reiser4/estimate.c~reiser4-rename-cluster-files	2005-11-15 17:05:28.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/estimate.c	2005-11-15 17:05:42.000000000 +0300
@@ -5,7 +5,7 @@
 #include "tree.h"
 #include "carry.h"
 #include "inode.h"
-#include "cluster.h"
+#include "plugin/cluster.h"
 #include "plugin/item/ctail.h"
 
 /* this returns how many nodes might get dirty and added nodes if @children nodes are dirtied
diff -puN fs/reiser4/flush.h~reiser4-rename-cluster-files fs/reiser4/flush.h
--- linux-2.6.14-mm2/fs/reiser4/flush.h~reiser4-rename-cluster-files	2005-11-15 17:05:28.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/flush.h	2005-11-15 17:05:42.000000000 +0300
@@ -5,7 +5,7 @@
 #if !defined(__REISER4_FLUSH_H__)
 #define __REISER4_FLUSH_H__
 
-#include "cluster.h"
+#include "plugin/cluster.h"
 
 /* The flush_scan data structure maintains the state of an in-progress flush-scan on a
    single level of the tree.  A flush-scan is used for counting the number of adjacent
diff -puN /dev/null fs/reiser4/plugin/cluster.c
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/cluster.c	2005-11-15 17:05:42.000000000 +0300
@@ -0,0 +1,66 @@
+/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
+
+/* Contains reiser4 cluster plugins (see
+   http://www.namesys.com/cryptcompress_design.html
+   "Concepts of clustering" for details). */
+
+#include "plugin_header.h"
+#include "plugin.h"
+#include "../inode.h"
+
+static int change_cluster(struct inode *inode, reiser4_plugin * plugin)
+{
+	int result = 0;
+
+	assert("edward-1324", inode != NULL);
+	assert("edward-1325", plugin != NULL);
+	assert("edward-1326", is_reiser4_inode(inode));
+	assert("edward-1327", plugin->h.type_id == REISER4_CLUSTER_PLUGIN_TYPE);
+
+	if (inode_file_plugin(inode)->h.id == DIRECTORY_FILE_PLUGIN_ID)
+		result = plugin_set_cluster(&reiser4_inode_data(inode)->pset,
+					    &plugin->clust);
+	else
+		result = RETERR(-EINVAL);
+	return result;
+}
+
+static reiser4_plugin_ops cluster_plugin_ops = {
+	.init = NULL,
+	.load = NULL,
+	.save_len = NULL,
+	.save = NULL,
+	.change = &change_cluster
+};
+
+#define SUPPORT_CLUSTER(SHIFT, ID, LABEL, DESC)			\
+	[CLUSTER_ ## ID ## _ID] = {				\
+		.h = {						\
+			.type_id = REISER4_CLUSTER_PLUGIN_TYPE,	\
+			.id = CLUSTER_ ## ID ## _ID,		\
+			.pops = &cluster_plugin_ops,		\
+			.label = LABEL,				\
+			.desc = DESC,				\
+			.linkage = {NULL, NULL}			\
+		},						\
+		.shift = SHIFT					\
+	}
+
+cluster_plugin cluster_plugins[LAST_CLUSTER_ID] = {
+	SUPPORT_CLUSTER(16, 64K, "64K", "Large"),
+	SUPPORT_CLUSTER(15, 32K, "32K", "Big"),
+	SUPPORT_CLUSTER(14, 16K, "16K", "Average"),
+	SUPPORT_CLUSTER(13, 8K, "8K", "Small"),
+	SUPPORT_CLUSTER(12, 4K, "4K", "Minimal")
+};
+
+/*
+  Local variables:
+  c-indentation-style: "K&R"
+  mode-name: "LC"
+  c-basic-offset: 8
+  tab-width: 8
+  fill-column: 120
+  scroll-step: 1
+  End:
+*/
diff -puN /dev/null fs/reiser4/plugin/cluster.h
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/cluster.h	2005-11-15 17:05:42.000000000 +0300
@@ -0,0 +1,327 @@
+/* Copyright 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
+
+/* This file contains page/cluster index translators and offset modulators
+   See http://www.namesys.com/cryptcompress_design.html for details */
+
+#if !defined( __FS_REISER4_CLUSTER_H__ )
+#define __FS_REISER4_CLUSTER_H__
+
+#include "../inode.h"
+
+static inline loff_t min_count(loff_t a, loff_t b)
+{
+	return (a < b ? a : b);
+}
+
+static inline loff_t max_count(loff_t a, loff_t b)
+{
+	return (a > b ? a : b);
+}
+
+static inline int inode_cluster_shift(struct inode *inode)
+{
+	assert("edward-92", inode != NULL);
+	assert("edward-93", reiser4_inode_data(inode) != NULL);
+
+	return inode_cluster_plugin(inode)->shift;
+}
+
+static inline unsigned cluster_nrpages_shift(struct inode *inode)
+{
+	return inode_cluster_shift(inode) - PAGE_CACHE_SHIFT;
+}
+
+/* cluster size in page units */
+static inline unsigned cluster_nrpages(struct inode *inode)
+{
+	return 1U << cluster_nrpages_shift(inode);
+}
+
+static inline size_t inode_cluster_size(struct inode *inode)
+{
+	assert("edward-96", inode != NULL);
+
+	return 1U << inode_cluster_shift(inode);
+}
+
+static inline unsigned long pg_to_clust(unsigned long idx, struct inode *inode)
+{
+	return idx >> cluster_nrpages_shift(inode);
+}
+
+static inline unsigned long clust_to_pg(unsigned long idx, struct inode *inode)
+{
+	return idx << cluster_nrpages_shift(inode);
+}
+
+static inline unsigned long
+pg_to_clust_to_pg(unsigned long idx, struct inode *inode)
+{
+	return clust_to_pg(pg_to_clust(idx, inode), inode);
+}
+
+static inline unsigned long off_to_pg(loff_t off)
+{
+	return (off >> PAGE_CACHE_SHIFT);
+}
+
+static inline loff_t pg_to_off(unsigned long idx)
+{
+	return ((loff_t) (idx) << PAGE_CACHE_SHIFT);
+}
+
+static inline unsigned long off_to_clust(loff_t off, struct inode *inode)
+{
+	return off >> inode_cluster_shift(inode);
+}
+
+static inline loff_t clust_to_off(unsigned long idx, struct inode *inode)
+{
+	return (loff_t) idx << inode_cluster_shift(inode);
+}
+
+static inline unsigned long count_to_nr(loff_t count, unsigned shift)
+{
+	return (count + (1UL << shift) - 1) >> shift;
+}
+
+/* number of pages occupied by @count bytes */
+static inline unsigned long count_to_nrpages(loff_t count)
+{
+	return count_to_nr(count, PAGE_CACHE_SHIFT);
+}
+
+/* number of clusters occupied by @count bytes */
+static inline cloff_t count_to_nrclust(loff_t count, struct inode *inode)
+{
+	return count_to_nr(count, inode_cluster_shift(inode));
+}
+
+/* number of clusters occupied by @count pages */
+static inline cloff_t pgcount_to_nrclust(pgoff_t count, struct inode *inode)
+{
+	return count_to_nr(count, cluster_nrpages_shift(inode));
+}
+
+static inline loff_t off_to_clust_to_off(loff_t off, struct inode *inode)
+{
+	return clust_to_off(off_to_clust(off, inode), inode);
+}
+
+static inline unsigned long off_to_clust_to_pg(loff_t off, struct inode *inode)
+{
+	return clust_to_pg(off_to_clust(off, inode), inode);
+}
+
+static inline unsigned off_to_pgoff(loff_t off)
+{
+	return off & (PAGE_CACHE_SIZE - 1);
+}
+
+static inline unsigned off_to_cloff(loff_t off, struct inode *inode)
+{
+	return off & ((loff_t) (inode_cluster_size(inode)) - 1);
+}
+
+static inline unsigned
+pg_to_off_to_cloff(unsigned long idx, struct inode *inode)
+{
+	return off_to_cloff(pg_to_off(idx), inode);
+}
+
+/* if @size != 0, returns index of the page
+   which contains the last byte of the file */
+static inline pgoff_t size_to_pg(loff_t size)
+{
+	return (size ? off_to_pg(size - 1) : 0);
+}
+
+/* minimal index of the page which doesn't contain
+   file data */
+static inline pgoff_t size_to_next_pg(loff_t size)
+{
+	return (size ? off_to_pg(size - 1) + 1 : 0);
+}
+
+static inline unsigned off_to_pgcount(loff_t off, unsigned long idx)
+{
+	if (idx > off_to_pg(off))
+		return 0;
+	if (idx < off_to_pg(off))
+		return PAGE_CACHE_SIZE;
+	return off_to_pgoff(off);
+}
+
+static inline unsigned
+off_to_count(loff_t off, unsigned long idx, struct inode *inode)
+{
+	if (idx > off_to_clust(off, inode))
+		return 0;
+	if (idx < off_to_clust(off, inode))
+		return inode_cluster_size(inode);
+	return off_to_cloff(off, inode);
+}
+
+static inline unsigned
+fsize_to_count(reiser4_cluster_t * clust, struct inode *inode)
+{
+	assert("edward-288", clust != NULL);
+	assert("edward-289", inode != NULL);
+
+	return off_to_count(inode->i_size, clust->index, inode);
+}
+
+static inline int
+cluster_is_complete(reiser4_cluster_t * clust, struct inode * inode)
+{
+	return clust->tc.lsize == inode_cluster_size(inode);
+}
+
+static inline void reiser4_slide_init(reiser4_slide_t * win)
+{
+	assert("edward-1084", win != NULL);
+	memset(win, 0, sizeof *win);
+}
+
+static inline void
+tfm_cluster_init_act(tfm_cluster_t * tc, tfm_action act)
+{
+	assert("edward-1356", tc != NULL);
+	assert("edward-1357", act != TFM_INVAL);
+	tc->act = act;
+}
+
+static inline void
+cluster_init_act (reiser4_cluster_t * clust, tfm_action act, reiser4_slide_t * window){
+	assert("edward-84", clust != NULL);
+	memset(clust, 0, sizeof *clust);
+	tfm_cluster_init_act(&clust->tc, act);
+	clust->dstat = INVAL_DISK_CLUSTER;
+	clust->win = window;
+}
+
+static inline void
+cluster_init_read(reiser4_cluster_t * clust, reiser4_slide_t * window)
+{
+	cluster_init_act (clust, TFM_READ, window);
+}
+
+static inline void
+cluster_init_write(reiser4_cluster_t * clust, reiser4_slide_t * window)
+{
+	cluster_init_act (clust, TFM_WRITE, window);
+}
+
+static inline int dclust_get_extension(hint_t * hint)
+{
+	return hint->ext_coord.extension.ctail.shift;
+}
+
+static inline void dclust_set_extension(hint_t * hint)
+{
+	assert("edward-1270",
+	       item_id_by_coord(&hint->ext_coord.coord) == CTAIL_ID);
+	hint->ext_coord.extension.ctail.shift =
+	    cluster_shift_by_coord(&hint->ext_coord.coord);
+}
+
+static inline int hint_is_unprepped_dclust(hint_t * hint)
+{
+	return dclust_get_extension(hint) == (int)UCTAIL_SHIFT;
+}
+
+static inline void coord_set_between_clusters(coord_t * coord)
+{
+#if REISER4_DEBUG
+	int result;
+	result = zload(coord->node);
+	assert("edward-1296", !result);
+#endif
+	if (!coord_is_between_items(coord)) {
+		coord->between = AFTER_ITEM;
+		coord->unit_pos = 0;
+	}
+#if REISER4_DEBUG
+	zrelse(coord->node);
+#endif
+}
+
+int inflate_cluster(reiser4_cluster_t *, struct inode *);
+int find_cluster(reiser4_cluster_t *, struct inode *, int read, int write);
+void forget_cluster_pages(struct page **page, int nrpages);
+int flush_cluster_pages(reiser4_cluster_t *, jnode *, struct inode *);
+int deflate_cluster(reiser4_cluster_t *, struct inode *);
+void truncate_page_cluster(struct inode *inode, cloff_t start);
+void set_hint_cluster(struct inode *inode, hint_t * hint, unsigned long index,
+		      znode_lock_mode mode);
+void invalidate_hint_cluster(reiser4_cluster_t * clust);
+void put_hint_cluster(reiser4_cluster_t * clust, struct inode *inode,
+		      znode_lock_mode mode);
+int get_disk_cluster_locked(reiser4_cluster_t * clust, struct inode *inode,
+			    znode_lock_mode lock_mode);
+void reset_cluster_params(reiser4_cluster_t * clust);
+int set_cluster_by_page(reiser4_cluster_t * clust, struct page * page,
+			int count);
+int prepare_page_cluster(struct inode *inode, reiser4_cluster_t * clust,
+			 int capture);
+void release_cluster_pages_nocapture(reiser4_cluster_t *);
+void put_cluster_handle(reiser4_cluster_t * clust);
+int grab_tfm_stream(struct inode *inode, tfm_cluster_t * tc, tfm_stream_id id);
+int tfm_cluster_is_uptodate(tfm_cluster_t * tc);
+void tfm_cluster_set_uptodate(tfm_cluster_t * tc);
+void tfm_cluster_clr_uptodate(tfm_cluster_t * tc);
+unsigned long clust_by_coord(const coord_t * coord, struct inode *inode);
+
+/* move cluster handle to the target position
+   specified by the page of index @pgidx
+*/
+static inline void
+move_cluster_forward(reiser4_cluster_t * clust, struct inode *inode,
+		     pgoff_t pgidx, int *progress)
+{
+	assert("edward-1297", clust != NULL);
+	assert("edward-1298", inode != NULL);
+
+	reset_cluster_params(clust);
+	if (*progress &&
+	    /* Hole in the indices. Hint became invalid and can not be
+	       used by find_cluster_item() even if seal/node versions
+	       will coincide */
+	    pg_to_clust(pgidx, inode) != clust->index + 1) {
+		unset_hint(clust->hint);
+		invalidate_hint_cluster(clust);
+	}
+	*progress = 1;
+	clust->index = pg_to_clust(pgidx, inode);
+}
+
+static inline int
+alloc_clust_pages(reiser4_cluster_t * clust, struct inode *inode)
+{
+	assert("edward-791", clust != NULL);
+	assert("edward-792", inode != NULL);
+	clust->pages =
+		kmalloc(sizeof(*clust->pages) << inode_cluster_shift(inode),
+			GFP_KERNEL);
+	if (!clust->pages)
+		return -ENOMEM;
+	return 0;
+}
+
+static inline void free_clust_pages(reiser4_cluster_t * clust)
+{
+	kfree(clust->pages);
+}
+
+#endif				/* __FS_REISER4_CLUSTER_H__ */
+
+/* Make Linus happy.
+   Local variables:
+   c-indentation-style: "K&R"
+   mode-name: "LC"
+   c-basic-offset: 8
+   tab-width: 8
+   fill-column: 120
+   scroll-step: 1
+   End:
+*/
diff -puN /dev/null fs/reiser4/plugin/crypto/cipher.c
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/crypto/cipher.c	2005-11-15 17:05:42.000000000 +0300
@@ -0,0 +1,115 @@
+/* Copyright 2001, 2002, 2003 by Hans Reiser,
+   licensing governed by reiser4/README */
+/* Reiser4 cipher transform plugins */
+
+#include "../../debug.h"
+#include "../plugin.h"
+#include "../file/cryptcompress.h"
+#include <linux/types.h>
+#include <linux/random.h>
+
+#define MAX_CRYPTO_BLOCKSIZE 128
+
+/*
+  Default align() method of the crypto-plugin (look for description of this
+  method in plugin/plugin.h)
+
+  1) creates the aligning armored format of the input flow before encryption.
+     "armored" means that padding is filled by private data (for example,
+     pseudo-random sequence of bytes is not private data).
+  2) returns length of appended padding
+
+   [ flow | aligning_padding ]
+            ^
+            |
+	  @pad
+*/
+static int align_stream_common(__u8 * pad,
+			       int flow_size /* size of non-aligned flow */,
+			       int blocksize /* crypto-block size */)
+{
+	int pad_size;
+
+	assert("edward-01", pad != NULL);
+	assert("edward-02", flow_size != 0);
+	assert("edward-03", blocksize != 0
+	       || blocksize <= MAX_CRYPTO_BLOCKSIZE);
+
+	pad_size = blocksize - (flow_size % blocksize);
+	get_random_bytes(pad, pad_size);
+	return pad_size;
+}
+
+/* This is used for all the cipher algorithms which do not inflate
+   block-aligned data */
+static loff_t scale_common(struct inode *inode, size_t blocksize,
+			   loff_t src_off /* offset to scale */ )
+{
+	return src_off;
+}
+
+static void free_aes (struct crypto_tfm * tfm)
+{
+#if REISER4_AES
+	crypto_free_tfm(tfm);
+#endif
+	return;
+}
+
+static struct crypto_tfm * alloc_aes (void)
+{
+#if REISER4_AES
+	return crypto_alloc_tfm ("aes", 0);
+#else
+	warning("edward-1417", "aes unsupported");
+	return ERR_PTR(-EINVAL);
+#endif /* REISER4_AES */
+}
+
+crypto_plugin crypto_plugins[LAST_CRYPTO_ID] = {
+	[NONE_CRYPTO_ID] = {
+		.h = {
+			.type_id = REISER4_CRYPTO_PLUGIN_TYPE,
+			.id = NONE_CRYPTO_ID,
+			.pops = NULL,
+			.label = "none",
+			.desc = "no cipher transform",
+			.linkage = {NULL, NULL}
+		},
+		.alloc = NULL,
+		.free = NULL,
+		.scale = NULL,
+		.align_stream = NULL,
+		.setkey = NULL,
+		.encrypt = NULL,
+		.decrypt = NULL
+	},
+	[AES_CRYPTO_ID] = {
+		.h = {
+			.type_id = REISER4_CRYPTO_PLUGIN_TYPE,
+			.id = AES_CRYPTO_ID,
+			.pops = NULL,
+			.label = "aes",
+			.desc = "aes cipher transform",
+			.linkage = {NULL, NULL}
+		},
+		.alloc = alloc_aes,
+		.free = free_aes,
+		.scale = scale_common,
+		.align_stream = align_stream_common,
+		.setkey = NULL,
+		.encrypt = NULL,
+		.decrypt = NULL
+	}
+};
+
+/* Make Linus happy.
+   Local variables:
+   c-indentation-style: "K&R"
+   mode-name: "LC"
+   c-basic-offset: 8
+   tab-width: 8
+   fill-column: 120
+   scroll-step: 1
+   End:
+*/
diff -puN /dev/null fs/reiser4/plugin/crypto/cipher.h
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/crypto/cipher.h	2005-11-15 17:05:42.000000000 +0300
@@ -0,0 +1,58 @@
+#if !defined( __FS_REISER4_CRYPT_H__ )
+#define __FS_REISER4_CRYPT_H__
+
+#include <linux/crypto.h>
+
+/* Crypto transforms involved in ciphering process and
+   supported by reiser4 via appropriate transform plugins */
+typedef enum {
+	CIPHER_TFM,       /* cipher transform */
+	DIGEST_TFM,       /* digest transform */
+	LAST_TFM
+} reiser4_tfm;
+
+/* This represents a transform from the set above */
+typedef struct reiser4_tfma {
+	reiser4_plugin * plug;     /* transform plugin */
+	struct crypto_tfm * tfm;   /* per-transform allocated info,
+                                      belongs to the crypto-api. */
+} reiser4_tfma_t;
+
+/* This contains cipher related info copied from user space */
+typedef struct crypto_data {
+	int keysize;    /* key size */
+	__u8 * key;     /* uninstantiated key */  
+	int keyid_size; /* size of passphrase */
+	__u8 * keyid;   /* passphrase (uninstantiated keyid) */
+} crypto_data_t;
+
+/* Dynamically allocated per instantiated key info */
+typedef struct crypto_stat {
+	reiser4_tfma_t tfma[LAST_TFM];
+//      cipher_key_plugin * kplug; *//* key manager responsible for
+//                                      inheriting, validating, etc... */
+	__u8 * keyid;                /* fingerprint (instantiated keyid) of
+					the cipher key prepared by digest
+					plugin, supposed to be stored in
+					disk stat-data */
+	int inst;                    /* this indicates if the ciper key
+					is instantiated in the system */
+	int keysize;                 /* uninstantiated key size (bytes),
+					supposed to be stored in disk
+					stat-data */
+	int keyload_count;           /* number of the objects which has
+					this crypto-stat attached */  
+} crypto_stat_t;
+
+#endif /* __FS_REISER4_CRYPT_H__ */
+
+/* 
+   Local variables:
+   c-indentation-style: "K&R"
+   mode-name: "LC"
+   c-basic-offset: 8
+   tab-width: 8
+   fill-column: 120
+   scroll-step: 1
+   End:
+*/
diff -puN /dev/null fs/reiser4/plugin/crypto/digest.c
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/crypto/digest.c	2005-11-15 17:05:42.000000000 +0300
@@ -0,0 +1,58 @@
+/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
+
+/* reiser4 digest transform plugin (is used by cryptcompress object plugin) */
+/* EDWARD-FIXME-HANS: and it does what? a digest is a what? */
+#include "../../debug.h"
+#include "../plugin_header.h"
+#include "../plugin.h"
+#include "../file/cryptcompress.h"
+
+#include <linux/types.h>
+
+extern digest_plugin digest_plugins[LAST_DIGEST_ID];
+
+static struct crypto_tfm * alloc_sha256 (void)
+{
+#if REISER4_SHA256
+	return crypto_alloc_tfm ("sha256", 0);
+#else
+	warning("edward-1418", "sha256 unsupported");
+	return ERR_PTR(-EINVAL);
+#endif
+}
+
+static void free_sha256 (struct crypto_tfm * tfm)
+{
+#if REISER4_SHA256
+	crypto_free_tfm(tfm);
+#endif
+	return;
+}
+
+/* digest plugins */
+digest_plugin digest_plugins[LAST_DIGEST_ID] = {
+	[SHA256_32_DIGEST_ID] = {
+		.h = {
+			.type_id = REISER4_DIGEST_PLUGIN_TYPE,
+			.id = SHA256_32_DIGEST_ID,
+			.pops = NULL,
+			.label = "sha256_32",
+			.desc = "sha256_32 digest transform",
+			.linkage = {NULL, NULL}
+		},
+		.fipsize = sizeof(__u32),
+		.alloc = alloc_sha256,
+		.free = free_sha256
+	}
+};
+
+/*
+  Local variables:
+  c-indentation-style: "K&R"
+  mode-name: "LC"
+  c-basic-offset: 8
+  tab-width: 8
+  fill-column: 120
+  scroll-step: 1
+  End:
+*/
diff -puN -L fs/reiser4/plugin/digest.c fs/reiser4/plugin/digest.c~reiser4-rename-cluster-files /dev/null
--- linux-2.6.14-mm2/fs/reiser4/plugin/digest.c
+++ /dev/null	2003-09-23 21:59:22.000000000 +0400
@@ -1,58 +0,0 @@
-/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
-
-/* reiser4 digest transform plugin (is used by cryptcompress object plugin) */
-/* EDWARD-FIXME-HANS: and it does what? a digest is a what? */
-#include "../debug.h"
-#include "plugin_header.h"
-#include "plugin.h"
-#include "file/cryptcompress.h"
-
-#include <linux/types.h>
-
-extern digest_plugin digest_plugins[LAST_DIGEST_ID];
-
-static struct crypto_tfm * alloc_sha256 (void)
-{
-#if REISER4_SHA256
-	return crypto_alloc_tfm ("sha256", 0);
-#else
-	warning("edward-1418", "sha256 unsupported");
-	return ERR_PTR(-EINVAL);
-#endif
-}
-
-static void free_sha256 (struct crypto_tfm * tfm)
-{
-#if REISER4_SHA256
-	crypto_free_tfm(tfm);
-#endif
-	return;
-}
-
-/* digest plugins */
-digest_plugin digest_plugins[LAST_DIGEST_ID] = {
-	[SHA256_32_DIGEST_ID] = {
-		.h = {
-			.type_id = REISER4_DIGEST_PLUGIN_TYPE,
-			.id = SHA256_32_DIGEST_ID,
-			.pops = NULL,
-			.label = "sha256_32",
-			.desc = "sha256_32 digest transform",
-			.linkage = {NULL, NULL}
-		},
-		.fipsize = sizeof(__u32),
-		.alloc = alloc_sha256,
-		.free = free_sha256
-	}
-};
-
-/*
-  Local variables:
-  c-indentation-style: "K&R"
-  mode-name: "LC"
-  c-basic-offset: 8
-  tab-width: 8
-  fill-column: 120
-  scroll-step: 1
-  End:
-*/
diff -puN fs/reiser4/plugin/file/cryptcompress.c~reiser4-rename-cluster-files fs/reiser4/plugin/file/cryptcompress.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/cryptcompress.c~reiser4-rename-cluster-files	2005-11-15 17:05:28.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/cryptcompress.c	2005-11-15 17:05:42.000000000 +0300
@@ -5,7 +5,7 @@
 
 #include "../../page_cache.h"
 #include "../../inode.h"
-#include "../../cluster.h"
+#include "../cluster.h"
 #include "../object.h"
 #include "../../tree_walk.h"
 #include "funcs.h"
diff -puN fs/reiser4/plugin/file/cryptcompress.h~reiser4-rename-cluster-files fs/reiser4/plugin/file/cryptcompress.h
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/cryptcompress.h~reiser4-rename-cluster-files	2005-11-15 17:05:28.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/cryptcompress.h	2005-11-15 17:05:42.000000000 +0300
@@ -5,7 +5,7 @@
 #define __FS_REISER4_CRYPTCOMPRESS_H__
 
 #include "../compress/compress.h"
-#include "../../crypt.h"
+#include "../crypto/cipher.h"
 
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
diff -puN fs/reiser4/plugin/item/ctail.c~reiser4-rename-cluster-files fs/reiser4/plugin/item/ctail.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/item/ctail.c~reiser4-rename-cluster-files	2005-11-15 17:05:28.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/item/ctail.c	2005-11-15 17:05:42.000000000 +0300
@@ -30,7 +30,7 @@ Internal on-disk structure:
 #include "../../super.h"
 #include "../../context.h"
 #include "../../page_cache.h"
-#include "../../cluster.h"
+#include "../cluster.h"
 #include "../../flush.h"
 #include "../../tree_walk.h"
 #include "../file/funcs.h"
diff -puN fs/reiser4/plugin/plugin.h~reiser4-rename-cluster-files fs/reiser4/plugin/plugin.h
--- linux-2.6.14-mm2/fs/reiser4/plugin/plugin.h~reiser4-rename-cluster-files	2005-11-15 17:05:28.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/plugin.h	2005-11-15 17:05:42.000000000 +0300
@@ -11,7 +11,7 @@
 #include "../dformat.h"
 #include "../key.h"
 #include "compress/compress.h"
-#include "../crypt.h"
+#include "crypto/cipher.h"
 #include "plugin_header.h"
 #include "item/static_stat.h"
 #include "item/internal.h"

_

--1VF4G19EIP-=-1R3X41XZ6J-CUT-HERE-1GJJDDERNM-=-1OV7749ARO--




--------------090604090700010108000405--
