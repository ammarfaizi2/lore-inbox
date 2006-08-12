Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWHLAFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWHLAFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 20:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWHLAFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 20:05:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:50642 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932359AbWHLAFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 20:05:12 -0400
Subject: [PATCH 1/2] ext3 and jbd cleanup: remove whitespace
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060811161655.0ad11259.akpm@osdl.org>
References: <1155172827.3161.80.camel@localhost.localdomain>
	 <20060809233940.50162afb.akpm@osdl.org> <20060810171755.GA19238@thunk.org>
	 <20060810110047.af273a55.akpm@osdl.org>
	 <1155334389.3765.18.camel@dyn9047017069.beaverton.ibm.com>
	 <20060811161655.0ad11259.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 11 Aug 2006 17:05:03 -0700
Message-Id: <1155341104.20600.7.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove whitespace from ext3 and jbd, before we clone ext4.

Signed-Off-By: Mingming Cao<cmm@us.ibm.com>

diff -urN linux-2.6.18-rc4/fs/ext3/balloc.c linux-2.6.18-rc4-ws/fs/ext3/balloc.c
--- linux-2.6.18-rc4/fs/ext3/balloc.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/balloc.c	2006-08-10 22:50:58.565737801 -0700
@@ -74,7 +74,7 @@
 }
 
 /*
- * Read the bitmap for a given block_group, reading into the specified 
+ * Read the bitmap for a given block_group, reading into the specified
  * slot in the superblock's bitmap cache.
  *
  * Return buffer_head on success or NULL in case of failure.
@@ -419,8 +419,8 @@
 		}
 		/* @@@ This prevents newly-allocated data from being
 		 * freed and then reallocated within the same
-		 * transaction. 
-		 * 
+		 * transaction.
+		 *
 		 * Ideally we would want to allow that to happen, but to
 		 * do so requires making journal_forget() capable of
 		 * revoking the queued write of a data block, which
@@ -433,7 +433,7 @@
 		 * safe not to set the allocation bit in the committed
 		 * bitmap, because we know that there is no outstanding
 		 * activity on the buffer any more and so it is safe to
-		 * reallocate it.  
+		 * reallocate it.
 		 */
 		BUFFER_TRACE(bitmap_bh, "set in b_committed_data");
 		J_ASSERT_BH(bitmap_bh,
@@ -518,7 +518,7 @@
  * data would allow the old block to be overwritten before the
  * transaction committed (because we force data to disk before commit).
  * This would lead to corruption if we crashed between overwriting the
- * data and committing the delete. 
+ * data and committing the delete.
  *
  * @@@ We may want to make this allocation behaviour conditional on
  * data-writes at some point, and disable it for metadata allocations or
@@ -584,7 +584,7 @@
 
 	if (start > 0) {
 		/*
-		 * The goal was occupied; search forward for a free 
+		 * The goal was occupied; search forward for a free
 		 * block within the next XX blocks.
 		 *
 		 * end_goal is more or less random, but it has to be
@@ -1194,7 +1194,7 @@
 /*
  * ext3_new_block uses a goal block to assist allocation.  If the goal is
  * free, or there is a free block within 32 blocks of the goal, that block
- * is allocated.  Otherwise a forward search is made for a free block; within 
+ * is allocated.  Otherwise a forward search is made for a free block; within
  * each block group the search first looks for an entire free byte in the block
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
@@ -1303,7 +1303,7 @@
 	smp_rmb();
 
 	/*
-	 * Now search the rest of the groups.  We assume that 
+	 * Now search the rest of the groups.  We assume that
 	 * i and gdp correctly point to the last group visited.
 	 */
 	for (bgi = 0; bgi < ngroups; bgi++) {
diff -urN linux-2.6.18-rc4/fs/ext3/bitmap.c linux-2.6.18-rc4-ws/fs/ext3/bitmap.c
--- linux-2.6.18-rc4/fs/ext3/bitmap.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/bitmap.c	2006-08-10 22:50:58.566737693 -0700
@@ -20,7 +20,7 @@
 	unsigned int i;
 	unsigned long sum = 0;
 
-	if (!map) 
+	if (!map)
 		return (0);
 	for (i = 0; i < numchars; i++)
 		sum += nibblemap[map->b_data[i] & 0xf] +
diff -urN linux-2.6.18-rc4/fs/ext3/dir.c linux-2.6.18-rc4-ws/fs/ext3/dir.c
--- linux-2.6.18-rc4/fs/ext3/dir.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/dir.c	2006-08-10 22:50:58.605733477 -0700
@@ -59,7 +59,7 @@
 
 	return (ext3_filetype_table[filetype]);
 }
-			       
+
 
 int ext3_check_dir_entry (const char * function, struct inode * dir,
 			  struct ext3_dir_entry_2 * de,
@@ -162,7 +162,7 @@
 		 * to make sure. */
 		if (filp->f_version != inode->i_version) {
 			for (i = 0; i < sb->s_blocksize && i < offset; ) {
-				de = (struct ext3_dir_entry_2 *) 
+				de = (struct ext3_dir_entry_2 *)
 					(bh->b_data + i);
 				/* It's too expensive to do a full
 				 * dirent test each time round this
@@ -181,7 +181,7 @@
 			filp->f_version = inode->i_version;
 		}
 
-		while (!error && filp->f_pos < inode->i_size 
+		while (!error && filp->f_pos < inode->i_size
 		       && offset < sb->s_blocksize) {
 			de = (struct ext3_dir_entry_2 *) (bh->b_data + offset);
 			if (!ext3_check_dir_entry ("ext3_readdir", inode, de,
@@ -229,7 +229,7 @@
 /*
  * These functions convert from the major/minor hash to an f_pos
  * value.
- * 
+ *
  * Currently we only use major hash numer.  This is unfortunate, but
  * on 32-bit machines, the same VFS interface is used for lseek and
  * llseek, so if we use the 64 bit offset, then the 32-bit versions of
@@ -250,7 +250,7 @@
 struct fname {
 	__u32		hash;
 	__u32		minor_hash;
-	struct rb_node	rb_hash; 
+	struct rb_node	rb_hash;
 	struct fname	*next;
 	__u32		inode;
 	__u8		name_len;
@@ -410,7 +410,7 @@
 	curr_pos = hash2pos(fname->hash, fname->minor_hash);
 	while (fname) {
 		error = filldir(dirent, fname->name,
-				fname->name_len, curr_pos, 
+				fname->name_len, curr_pos,
 				fname->inode,
 				get_dtype(sb, fname->file_type));
 		if (error) {
@@ -465,7 +465,7 @@
 		/*
 		 * Fill the rbtree if we have no more entries,
 		 * or the inode has changed since we last read in the
-		 * cached entries. 
+		 * cached entries.
 		 */
 		if ((!info->curr_node) ||
 		    (filp->f_version != inode->i_version)) {
diff -urN linux-2.6.18-rc4/fs/ext3/file.c linux-2.6.18-rc4-ws/fs/ext3/file.c
--- linux-2.6.18-rc4/fs/ext3/file.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/file.c	2006-08-10 22:50:58.606733368 -0700
@@ -100,7 +100,7 @@
 
 force_commit:
 	err = ext3_force_commit(inode->i_sb);
-	if (err) 
+	if (err)
 		return err;
 	return ret;
 }
diff -urN linux-2.6.18-rc4/fs/ext3/fsync.c linux-2.6.18-rc4-ws/fs/ext3/fsync.c
--- linux-2.6.18-rc4/fs/ext3/fsync.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/fsync.c	2006-08-10 22:50:58.607733260 -0700
@@ -8,14 +8,14 @@
  *                      Universite Pierre et Marie Curie (Paris VI)
  *  from
  *  linux/fs/minix/truncate.c   Copyright (C) 1991, 1992  Linus Torvalds
- * 
+ *
  *  ext3fs fsync primitive
  *
  *  Big-endian to little-endian byte-swapping/bitmaps by
  *        David S. Miller (davem@caip.rutgers.edu), 1995
- * 
+ *
  *  Removed unnecessary code duplication for little endian machines
- *  and excessive __inline__s. 
+ *  and excessive __inline__s.
  *        Andi Kleen, 1997
  *
  * Major simplications and cleanup - we only need to do the metadata, because
diff -urN linux-2.6.18-rc4/fs/ext3/hash.c linux-2.6.18-rc4-ws/fs/ext3/hash.c
--- linux-2.6.18-rc4/fs/ext3/hash.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/hash.c	2006-08-10 22:50:58.630730774 -0700
@@ -4,7 +4,7 @@
  * Copyright (C) 2002 by Theodore Ts'o
  *
  * This file is released under the GPL v2.
- * 
+ *
  * This file may be redistributed under the terms of the GNU Public
  * License.
  */
@@ -80,11 +80,11 @@
  * Returns the hash of a filename.  If len is 0 and name is NULL, then
  * this function can be used to test whether or not a hash version is
  * supported.
- * 
+ *
  * The seed is an 4 longword (32 bits) "secret" which can be used to
  * uniquify a hash.  If the seed is all zero's, then some default seed
  * may be used.
- * 
+ *
  * A particular hash version specifies whether or not the seed is
  * represented, and whether or not the returned hash is 32 bits or 64
  * bits.  32 bit hashes will return 0 for the minor hash.
diff -urN linux-2.6.18-rc4/fs/ext3/ialloc.c linux-2.6.18-rc4-ws/fs/ext3/ialloc.c
--- linux-2.6.18-rc4/fs/ext3/ialloc.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/ialloc.c	2006-08-10 22:50:58.632730558 -0700
@@ -216,7 +216,7 @@
 			continue;
 		if (le16_to_cpu(desc->bg_free_inodes_count) < avefreei)
 			continue;
-		if (!best_desc || 
+		if (!best_desc ||
 		    (le16_to_cpu(desc->bg_free_blocks_count) >
 		     le16_to_cpu(best_desc->bg_free_blocks_count))) {
 			best_group = group;
@@ -226,30 +226,30 @@
 	return best_group;
 }
 
-/* 
- * Orlov's allocator for directories. 
- * 
+/*
+ * Orlov's allocator for directories.
+ *
  * We always try to spread first-level directories.
  *
- * If there are blockgroups with both free inodes and free blocks counts 
- * not worse than average we return one with smallest directory count. 
- * Otherwise we simply return a random group. 
- * 
- * For the rest rules look so: 
- * 
- * It's OK to put directory into a group unless 
- * it has too many directories already (max_dirs) or 
- * it has too few free inodes left (min_inodes) or 
- * it has too few free blocks left (min_blocks) or 
- * it's already running too large debt (max_debt). 
- * Parent's group is prefered, if it doesn't satisfy these 
- * conditions we search cyclically through the rest. If none 
- * of the groups look good we just look for a group with more 
- * free inodes than average (starting at parent's group). 
- * 
- * Debt is incremented each time we allocate a directory and decremented 
- * when we allocate an inode, within 0--255. 
- */ 
+ * If there are blockgroups with both free inodes and free blocks counts
+ * not worse than average we return one with smallest directory count.
+ * Otherwise we simply return a random group.
+ *
+ * For the rest rules look so:
+ *
+ * It's OK to put directory into a group unless
+ * it has too many directories already (max_dirs) or
+ * it has too few free inodes left (min_inodes) or
+ * it has too few free blocks left (min_blocks) or
+ * it's already running too large debt (max_debt).
+ * Parent's group is prefered, if it doesn't satisfy these
+ * conditions we search cyclically through the rest. If none
+ * of the groups look good we just look for a group with more
+ * free inodes than average (starting at parent's group).
+ *
+ * Debt is incremented each time we allocate a directory and decremented
+ * when we allocate an inode, within 0--255.
+ */
 
 #define INODE_COST 64
 #define BLOCK_COST 256
@@ -454,7 +454,7 @@
 			group = find_group_dir(sb, dir);
 		else
 			group = find_group_orlov(sb, dir);
-	} else 
+	} else
 		group = find_group_other(sb, dir);
 
 	err = -ENOSPC;
diff -urN linux-2.6.18-rc4/fs/ext3/inode.c linux-2.6.18-rc4-ws/fs/ext3/inode.c
--- linux-2.6.18-rc4/fs/ext3/inode.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/inode.c	2006-08-10 22:50:58.684724936 -0700
@@ -55,7 +55,7 @@
 /*
  * The ext3 forget function must perform a revoke if we are freeing data
  * which has been journaled.  Metadata (eg. indirect blocks) must be
- * revoked in all cases. 
+ * revoked in all cases.
  *
  * "bh" may be NULL: a metadata block may have been freed from memory
  * but there may still be a record of it in the journal, and that record
@@ -105,7 +105,7 @@
  * Work out how many blocks we need to proceed with the next chunk of a
  * truncate transaction.
  */
-static unsigned long blocks_for_truncate(struct inode *inode) 
+static unsigned long blocks_for_truncate(struct inode *inode)
 {
 	unsigned long needed;
 
@@ -122,13 +122,13 @@
 
 	/* But we need to bound the transaction so we don't overflow the
 	 * journal. */
-	if (needed > EXT3_MAX_TRANS_DATA) 
+	if (needed > EXT3_MAX_TRANS_DATA)
 		needed = EXT3_MAX_TRANS_DATA;
 
 	return EXT3_DATA_TRANS_BLOCKS(inode->i_sb) + needed;
 }
 
-/* 
+/*
  * Truncate transactions can be complex and absolutely huge.  So we need to
  * be able to restart the transaction at a conventient checkpoint to make
  * sure we don't overflow the journal.
@@ -136,9 +136,9 @@
  * start_transaction gets us a new handle for a truncate transaction,
  * and extend_transaction tries to extend the existing one a bit.  If
  * extend fails, we need to propagate the failure up and restart the
- * transaction in the top-level truncate loop. --sct 
+ * transaction in the top-level truncate loop. --sct
  */
-static handle_t *start_transaction(struct inode *inode) 
+static handle_t *start_transaction(struct inode *inode)
 {
 	handle_t *result;
 
@@ -215,12 +215,12 @@
 	ext3_orphan_del(handle, inode);
 	EXT3_I(inode)->i_dtime	= get_seconds();
 
-	/* 
+	/*
 	 * One subtle ordering requirement: if anything has gone wrong
 	 * (transaction abort, IO errors, whatever), then we can still
 	 * do these next steps (the fs will already have been marked as
 	 * having errors), but we can't free the inode if the mark_dirty
-	 * fails.  
+	 * fails.
 	 */
 	if (ext3_mark_inode_dirty(handle, inode))
 		/* If that failed, just do the required in-core inode clear. */
@@ -398,7 +398,7 @@
  *	  + if there is a block to the left of our position - allocate near it.
  *	  + if pointer will live in indirect block - allocate near that block.
  *	  + if pointer will live in inode - allocate in the same
- *	    cylinder group. 
+ *	    cylinder group.
  *
  * In the latter case we colour the starting block by the callers PID to
  * prevent it from clashing with concurrent allocations for a different inode
@@ -744,7 +744,7 @@
 		jbd_debug(5, "splicing indirect only\n");
 		BUFFER_TRACE(where->bh, "call ext3_journal_dirty_metadata");
 		err = ext3_journal_dirty_metadata(handle, where->bh);
-		if (err) 
+		if (err)
 			goto err_out;
 	} else {
 		/*
@@ -1134,7 +1134,7 @@
  * So what we do is to rely on the fact that journal_stop/journal_start
  * will _not_ run commit under these circumstances because handle->h_ref
  * is elevated.  We'll still have enough credits for the tiny quotafile
- * write.  
+ * write.
  */
 static int do_journal_get_write_access(handle_t *handle,
 					struct buffer_head *bh)
@@ -1279,7 +1279,7 @@
 	if (inode->i_size > EXT3_I(inode)->i_disksize) {
 		EXT3_I(inode)->i_disksize = inode->i_size;
 		ret2 = ext3_mark_inode_dirty(handle, inode);
-		if (!ret) 
+		if (!ret)
 			ret = ret2;
 	}
 	ret2 = ext3_journal_stop(handle);
@@ -1288,7 +1288,7 @@
 	return ret;
 }
 
-/* 
+/*
  * bmap() is special.  It gets used by applications such as lilo and by
  * the swapper to find the on-disk block of a specific piece of data.
  *
@@ -1297,10 +1297,10 @@
  * filesystem and enables swap, then they may get a nasty shock when the
  * data getting swapped to that swapfile suddenly gets overwritten by
  * the original zero's written out previously to the journal and
- * awaiting writeback in the kernel's buffer cache. 
+ * awaiting writeback in the kernel's buffer cache.
  *
  * So, if we see any bmap calls here on a modified, data-journaled file,
- * take extra steps to flush any blocks which might be in the cache. 
+ * take extra steps to flush any blocks which might be in the cache.
  */
 static sector_t ext3_bmap(struct address_space *mapping, sector_t block)
 {
@@ -1309,16 +1309,16 @@
 	int err;
 
 	if (EXT3_I(inode)->i_state & EXT3_STATE_JDATA) {
-		/* 
+		/*
 		 * This is a REALLY heavyweight approach, but the use of
 		 * bmap on dirty files is expected to be extremely rare:
 		 * only if we run lilo or swapon on a freshly made file
-		 * do we expect this to happen. 
+		 * do we expect this to happen.
 		 *
 		 * (bmap requires CAP_SYS_RAWIO so this does not
 		 * represent an unprivileged user DOS attack --- we'd be
 		 * in trouble if mortal users could trigger this path at
-		 * will.) 
+		 * will.)
 		 *
 		 * NB. EXT3_STATE_JDATA is not set on files other than
 		 * regular files.  If somebody wants to bmap a directory
@@ -1454,7 +1454,7 @@
 	 */
 
 	/*
-	 * And attach them to the current transaction.  But only if 
+	 * And attach them to the current transaction.  But only if
 	 * block_write_full_page() succeeded.  Otherwise they are unmapped,
 	 * and generally junk.
 	 */
@@ -1641,7 +1641,7 @@
 		}
 	}
 
-	ret = blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov, 
+	ret = blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
 				 offset, nr_segs,
 				 ext3_get_block, NULL);
 
@@ -2022,7 +2022,7 @@
 			   __le32 *first, __le32 *last)
 {
 	ext3_fsblk_t block_to_free = 0;    /* Starting block # of a run */
-	unsigned long count = 0;	    /* Number of blocks in the run */ 
+	unsigned long count = 0;	    /* Number of blocks in the run */
 	__le32 *block_to_free_p = NULL;	    /* Pointer into inode/ind
 					       corresponding to
 					       block_to_free */
@@ -2051,7 +2051,7 @@
 			} else if (nr == block_to_free + count) {
 				count++;
 			} else {
-				ext3_clear_blocks(handle, inode, this_bh, 
+				ext3_clear_blocks(handle, inode, this_bh,
 						  block_to_free,
 						  count, block_to_free_p, p);
 				block_to_free = nr;
@@ -2181,7 +2181,7 @@
 					*p = 0;
 					BUFFER_TRACE(parent_bh,
 					"call ext3_journal_dirty_metadata");
-					ext3_journal_dirty_metadata(handle, 
+					ext3_journal_dirty_metadata(handle,
 								    parent_bh);
 				}
 			}
@@ -2631,7 +2631,7 @@
 	}
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size
 					 * (for stat), not the fs block
-					 * size */  
+					 * size */
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 #ifdef EXT3_FRAGMENTS
@@ -2701,7 +2701,7 @@
 		if (raw_inode->i_block[0])
 			init_special_inode(inode, inode->i_mode,
 			   old_decode_dev(le32_to_cpu(raw_inode->i_block[0])));
-		else 
+		else
 			init_special_inode(inode, inode->i_mode,
 			   new_decode_dev(le32_to_cpu(raw_inode->i_block[1])));
 	}
@@ -2721,8 +2721,8 @@
  *
  * The caller must have write access to iloc->bh.
  */
-static int ext3_do_update_inode(handle_t *handle, 
-				struct inode *inode, 
+static int ext3_do_update_inode(handle_t *handle,
+				struct inode *inode,
 				struct ext3_iloc *iloc)
 {
 	struct ext3_inode *raw_inode = ext3_raw_inode(iloc);
@@ -2897,7 +2897,7 @@
  * commit will leave the blocks being flushed in an unused state on
  * disk.  (On recovery, the inode will get truncated and the blocks will
  * be freed, so we have a strong guarantee that no future commit will
- * leave these blocks visible to the user.)  
+ * leave these blocks visible to the user.)
  *
  * Called with inode->sem down.
  */
@@ -3040,13 +3040,13 @@
 	return err;
 }
 
-/* 
+/*
  * On success, We end up with an outstanding reference count against
- * iloc->bh.  This _must_ be cleaned up later. 
+ * iloc->bh.  This _must_ be cleaned up later.
  */
 
 int
-ext3_reserve_inode_write(handle_t *handle, struct inode *inode, 
+ext3_reserve_inode_write(handle_t *handle, struct inode *inode,
 			 struct ext3_iloc *iloc)
 {
 	int err = 0;
@@ -3136,7 +3136,7 @@
 }
 
 #if 0
-/* 
+/*
  * Bind an inode's backing buffer_head into this transaction, to prevent
  * it from being flushed to disk early.  Unlike
  * ext3_reserve_inode_write, this leaves behind no bh reference and
@@ -3154,7 +3154,7 @@
 			BUFFER_TRACE(iloc.bh, "get_write_access");
 			err = journal_get_write_access(handle, iloc.bh);
 			if (!err)
-				err = ext3_journal_dirty_metadata(handle, 
+				err = ext3_journal_dirty_metadata(handle,
 								  iloc.bh);
 			brelse(iloc.bh);
 		}
diff -urN linux-2.6.18-rc4/fs/ext3/namei.c linux-2.6.18-rc4-ws/fs/ext3/namei.c
--- linux-2.6.18-rc4/fs/ext3/namei.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/namei.c	2006-08-10 22:50:58.710722125 -0700
@@ -76,7 +76,7 @@
 #ifdef DX_DEBUG
 #define dxtrace(command) command
 #else
-#define dxtrace(command) 
+#define dxtrace(command)
 #endif
 
 struct fake_dirent
@@ -169,7 +169,7 @@
 static void dx_insert_block (struct dx_frame *frame, u32 hash, u32 block);
 static int ext3_htree_next_block(struct inode *dir, __u32 hash,
 				 struct dx_frame *frame,
-				 struct dx_frame *frames, 
+				 struct dx_frame *frames,
 				 __u32 *start_hash);
 static struct buffer_head * ext3_dx_find_entry(struct dentry *dentry,
 		       struct ext3_dir_entry_2 **res_dir, int *err);
@@ -250,7 +250,7 @@
 }
 
 struct stats
-{ 
+{
 	unsigned names;
 	unsigned space;
 	unsigned bcount;
@@ -464,7 +464,7 @@
  */
 static int ext3_htree_next_block(struct inode *dir, __u32 hash,
 				 struct dx_frame *frame,
-				 struct dx_frame *frames, 
+				 struct dx_frame *frames,
 				 __u32 *start_hash)
 {
 	struct dx_frame *p;
@@ -632,7 +632,7 @@
 		}
 		count += ret;
 		hashval = ~0;
-		ret = ext3_htree_next_block(dir, HASH_NB_ALWAYS, 
+		ret = ext3_htree_next_block(dir, HASH_NB_ALWAYS,
 					    frame, frames, &hashval);
 		*next_hash = hashval;
 		if (ret < 0) {
@@ -649,7 +649,7 @@
 			break;
 	}
 	dx_release(frames);
-	dxtrace(printk("Fill tree: returned %d entries, next hash: %x\n", 
+	dxtrace(printk("Fill tree: returned %d entries, next hash: %x\n",
 		       count, *next_hash));
 	return count;
 errout:
@@ -1050,7 +1050,7 @@
 		parent = ERR_PTR(-ENOMEM);
 	}
 	return parent;
-} 
+}
 
 #define S_SHIFT 12
 static unsigned char ext3_type_by_mode[S_IFMT >> S_SHIFT] = {
@@ -1198,7 +1198,7 @@
  * add_dirent_to_buf will attempt search the directory block for
  * space.  It will return -ENOSPC if no space is available, and -EIO
  * and -EEXIST if directory entry already exists.
- * 
+ *
  * NOTE!  bh is NOT released in the case where ENOSPC is returned.  In
  * all other cases bh is released.
  */
@@ -1572,7 +1572,7 @@
  * ext3_delete_entry deletes a directory entry by merging it with the
  * previous entry
  */
-static int ext3_delete_entry (handle_t *handle, 
+static int ext3_delete_entry (handle_t *handle,
 			      struct inode * dir,
 			      struct ext3_dir_entry_2 * de_del,
 			      struct buffer_head * bh)
@@ -1643,12 +1643,12 @@
  * is so far negative - it has no inode.
  *
  * If the create succeeds, we fill in the inode information
- * with d_instantiate(). 
+ * with d_instantiate().
  */
 static int ext3_create (struct inode * dir, struct dentry * dentry, int mode,
 		struct nameidata *nd)
 {
-	handle_t *handle; 
+	handle_t *handle;
 	struct inode * inode;
 	int err, retries = 0;
 
@@ -1813,7 +1813,7 @@
 	de1 = (struct ext3_dir_entry_2 *)
 			((char *) de + le16_to_cpu(de->rec_len));
 	if (le32_to_cpu(de->inode) != inode->i_ino ||
-			!le32_to_cpu(de1->inode) || 
+			!le32_to_cpu(de1->inode) ||
 			strcmp (".", de->name) ||
 			strcmp ("..", de1->name)) {
 	    	ext3_warning (inode->i_sb, "empty_dir",
@@ -1883,7 +1883,7 @@
 	 * being truncated, or files being unlinked. */
 
 	/* @@@ FIXME: Observation from aviro:
-	 * I think I can trigger J_ASSERT in ext3_orphan_add().  We block 
+	 * I think I can trigger J_ASSERT in ext3_orphan_add().  We block
 	 * here (on lock_super()), so race with ext3_link() which might bump
 	 * ->i_nlink. For, say it, character device. Not a regular file,
 	 * not a directory, not a symlink and ->i_nlink > 0.
@@ -2393,4 +2393,4 @@
 	.removexattr	= generic_removexattr,
 #endif
 	.permission	= ext3_permission,
-}; 
+};
diff -urN linux-2.6.18-rc4/fs/ext3/super.c linux-2.6.18-rc4-ws/fs/ext3/super.c
--- linux-2.6.18-rc4/fs/ext3/super.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/ext3/super.c	2006-08-10 22:50:58.736719315 -0700
@@ -62,13 +62,13 @@
 static void ext3_write_super (struct super_block * sb);
 static void ext3_write_super_lockfs(struct super_block *sb);
 
-/* 
+/*
  * Wrappers for journal_start/end.
  *
  * The only special thing we need to do here is to make sure that all
  * journal_end calls result in the superblock being marked dirty, so
  * that sync() will call the filesystem's write_super callback if
- * appropriate. 
+ * appropriate.
  */
 handle_t *ext3_journal_start_sb(struct super_block *sb, int nblocks)
 {
@@ -90,11 +90,11 @@
 	return journal_start(journal, nblocks);
 }
 
-/* 
+/*
  * The only special thing we need to do here is to make sure that all
  * journal_stop calls result in the superblock being marked dirty, so
  * that sync() will call the filesystem's write_super callback if
- * appropriate. 
+ * appropriate.
  */
 int __ext3_journal_stop(const char *where, handle_t *handle)
 {
@@ -369,7 +369,7 @@
 {
 	struct list_head *l;
 
-	printk(KERN_ERR "sb orphan head is %d\n", 
+	printk(KERN_ERR "sb orphan head is %d\n",
 	       le32_to_cpu(sbi->s_es->s_last_orphan));
 
 	printk(KERN_ERR "sb_info orphan list:\n");
@@ -378,7 +378,7 @@
 		printk(KERN_ERR "  "
 		       "inode %s:%ld at %p: mode %o, nlink %d, next %d\n",
 		       inode->i_sb->s_id, inode->i_ino, inode,
-		       inode->i_mode, inode->i_nlink, 
+		       inode->i_mode, inode->i_nlink,
 		       NEXT_ORPHAN(inode));
 	}
 }
@@ -475,7 +475,7 @@
 		inode_init_once(&ei->vfs_inode);
 	}
 }
- 
+
 static int init_inodecache(void)
 {
 	ext3_inode_cachep = kmem_cache_create("ext3_inode_cache",
@@ -1441,7 +1441,7 @@
 	    (EXT3_HAS_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT3_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT3_HAS_INCOMPAT_FEATURE(sb, ~0U)))
-		printk(KERN_WARNING 
+		printk(KERN_WARNING
 		       "EXT3-fs warning: feature flags set on rev 0 fs, "
 		       "running e2fsck is recommended\n");
 	/*
@@ -1467,7 +1467,7 @@
 
 	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
 	    blocksize > EXT3_MAX_BLOCK_SIZE) {
-		printk(KERN_ERR 
+		printk(KERN_ERR
 		       "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
 		       blocksize, sb->s_id);
 		goto failed_mount;
@@ -1491,14 +1491,14 @@
 		offset = (sb_block * EXT3_MIN_BLOCK_SIZE) % blocksize;
 		bh = sb_bread(sb, logic_sb_block);
 		if (!bh) {
-			printk(KERN_ERR 
+			printk(KERN_ERR
 			       "EXT3-fs: Can't read superblock on 2nd try.\n");
 			goto failed_mount;
 		}
 		es = (struct ext3_super_block *)(((char *)bh->b_data) + offset);
 		sbi->s_es = es;
 		if (es->s_magic != cpu_to_le16(EXT3_SUPER_MAGIC)) {
-			printk (KERN_ERR 
+			printk (KERN_ERR
 				"EXT3-fs: Magic mismatch, very weird !\n");
 			goto failed_mount;
 		}
@@ -1778,7 +1778,7 @@
 /*
  * Setup any per-fs journal parameters now.  We'll do this both on
  * initial mount, once the journal has been initialised but before we've
- * done any recovery; and again on any subsequent remount. 
+ * done any recovery; and again on any subsequent remount.
  */
 static void ext3_init_journal_params(struct super_block *sb, journal_t *journal)
 {
diff -urN linux-2.6.18-rc4/fs/jbd/checkpoint.c linux-2.6.18-rc4-ws/fs/jbd/checkpoint.c
--- linux-2.6.18-rc4/fs/jbd/checkpoint.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/jbd/checkpoint.c	2006-08-10 22:50:12.168761094 -0700
@@ -1,6 +1,6 @@
 /*
  * linux/fs/checkpoint.c
- * 
+ *
  * Written by Stephen C. Tweedie <sct@redhat.com>, 1999
  *
  * Copyright 1999 Red Hat Software --- All Rights Reserved
@@ -9,8 +9,8 @@
  * the terms of the GNU General Public License, version 2, or at your
  * option, any later version, incorporated herein by reference.
  *
- * Checkpoint routines for the generic filesystem journaling code.  
- * Part of the ext2fs journaling system.  
+ * Checkpoint routines for the generic filesystem journaling code.
+ * Part of the ext2fs journaling system.
  *
  * Checkpointing is the process of ensuring that a section of the log is
  * committed fully to disk, so that that portion of the log can be
@@ -225,7 +225,7 @@
  * Try to flush one buffer from the checkpoint list to disk.
  *
  * Return 1 if something happened which requires us to abort the current
- * scan of the checkpoint list.  
+ * scan of the checkpoint list.
  *
  * Called with j_list_lock held and drops it if 1 is returned
  * Called under jbd_lock_bh_state(jh2bh(jh)), and drops it
@@ -269,7 +269,7 @@
 		 * possibly block, while still holding the journal lock.
 		 * We cannot afford to let the transaction logic start
 		 * messing around with this buffer before we write it to
-		 * disk, as that would break recoverability.  
+		 * disk, as that would break recoverability.
 		 */
 		BUFFER_TRACE(bh, "queue");
 		get_bh(bh);
@@ -292,7 +292,7 @@
  * Perform an actual checkpoint. We take the first transaction on the
  * list of transactions to be checkpointed and send all its buffers
  * to disk. We submit larger chunks of data at once.
- * 
+ *
  * The journal should be locked before calling this function.
  */
 int log_do_checkpoint(journal_t *journal)
@@ -303,10 +303,10 @@
 
 	jbd_debug(1, "Start checkpoint\n");
 
-	/* 
+	/*
 	 * First thing: if there are any transactions in the log which
 	 * don't need checkpointing, just eliminate them from the
-	 * journal straight away.  
+	 * journal straight away.
 	 */
 	result = cleanup_journal_tail(journal);
 	jbd_debug(1, "cleanup_journal_tail returned %d\n", result);
@@ -384,9 +384,9 @@
  * we have already got rid of any since the last update of the log tail
  * in the journal superblock.  If so, we can instantly roll the
  * superblock forward to remove those transactions from the log.
- * 
+ *
  * Return <0 on error, 0 on success, 1 if there was nothing to clean up.
- * 
+ *
  * Called with the journal lock held.
  *
  * This is the only part of the journaling code which really needs to be
@@ -403,8 +403,8 @@
 	unsigned long	blocknr, freed;
 
 	/* OK, work out the oldest transaction remaining in the log, and
-	 * the log block it starts at. 
-	 * 
+	 * the log block it starts at.
+	 *
 	 * If the log is now empty, we need to work out which is the
 	 * next transaction ID we will write, and where it will
 	 * start. */
@@ -557,7 +557,7 @@
 	return ret;
 }
 
-/* 
+/*
  * journal_remove_checkpoint: called after a buffer has been committed
  * to disk (either by being write-back flushed to disk, or being
  * committed to the log).
@@ -635,7 +635,7 @@
  * Called with the journal locked.
  * Called with j_list_lock held.
  */
-void __journal_insert_checkpoint(struct journal_head *jh, 
+void __journal_insert_checkpoint(struct journal_head *jh,
 			       transaction_t *transaction)
 {
 	JBUFFER_TRACE(jh, "entry");
@@ -657,7 +657,7 @@
 
 /*
  * We've finished with this transaction structure: adios...
- * 
+ *
  * The transaction must have no links except for the checkpoint by this
  * point.
  *
diff -urN linux-2.6.18-rc4/fs/jbd/journal.c linux-2.6.18-rc4-ws/fs/jbd/journal.c
--- linux-2.6.18-rc4/fs/jbd/journal.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/jbd/journal.c	2006-08-10 22:50:12.227754698 -0700
@@ -577,7 +577,7 @@
  * this is a no-op.  If needed, we can use j_blk_offset - everything is
  * ready.
  */
-int journal_bmap(journal_t *journal, unsigned long blocknr, 
+int journal_bmap(journal_t *journal, unsigned long blocknr,
 		 unsigned long *retp)
 {
 	int err = 0;
@@ -698,10 +698,10 @@
  *  @len:  Lenght of the journal in blocks.
  *  @blocksize: blocksize of journalling device
  *  @returns: a newly created journal_t *
- *  
+ *
  *  journal_init_dev creates a journal which maps a fixed contiguous
  *  range of blocks on an arbitrary block device.
- * 
+ *
  */
 journal_t * journal_init_dev(struct block_device *bdev,
 			struct block_device *fs_dev,
@@ -738,11 +738,11 @@
 
 	return journal;
 }
- 
-/** 
+
+/**
  *  journal_t * journal_init_inode () - creates a journal which maps to a inode.
  *  @inode: An inode to create the journal in
- *  
+ *
  * journal_init_inode creates a journal which maps an on-disk inode as
  * the journal.  The inode must exist already, must support bmap() and
  * must have all data blocks preallocated.
@@ -762,7 +762,7 @@
 	journal->j_inode = inode;
 	jbd_debug(1,
 		  "journal %p: inode %s/%ld, size %Ld, bits %d, blksize %ld\n",
-		  journal, inode->i_sb->s_id, inode->i_ino, 
+		  journal, inode->i_sb->s_id, inode->i_ino,
 		  (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
@@ -797,10 +797,10 @@
 	return journal;
 }
 
-/* 
+/*
  * If the journal init or create aborts, we need to mark the journal
  * superblock as being NULL to prevent the journal destroy from writing
- * back a bogus superblock. 
+ * back a bogus superblock.
  */
 static void journal_fail_superblock (journal_t *journal)
 {
@@ -843,13 +843,13 @@
 	return 0;
 }
 
-/** 
+/**
  * int journal_create() - Initialise the new journal file
  * @journal: Journal to create. This structure must have been initialised
- * 
+ *
  * Given a journal_t structure which tells us which disk blocks we can
  * use, create a new journal superblock and initialise all of the
- * journal fields from scratch.  
+ * journal fields from scratch.
  **/
 int journal_create(journal_t *journal)
 {
@@ -914,7 +914,7 @@
 	return journal_reset(journal);
 }
 
-/** 
+/**
  * void journal_update_superblock() - Update journal sb on disk.
  * @journal: The journal to update.
  * @wait: Set to '0' if you don't want to wait for IO completion.
@@ -938,7 +938,7 @@
 				journal->j_transaction_sequence) {
 		jbd_debug(1,"JBD: Skipping superblock update on recovered sb "
 			"(start %ld, seq %d, errno %d)\n",
-			journal->j_tail, journal->j_tail_sequence, 
+			journal->j_tail, journal->j_tail_sequence,
 			journal->j_errno);
 		goto out;
 	}
@@ -1061,7 +1061,7 @@
 /**
  * int journal_load() - Read journal from disk.
  * @journal: Journal to act on.
- * 
+ *
  * Given a journal_t structure which tells us which disk blocks contain
  * a journal, read the journal from disk to initialise the in-memory
  * structures.
@@ -1164,9 +1164,9 @@
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
  * @incompat: bitmask of incompatible features
- * 
+ *
  * Check whether the journal uses all of a given set of
- * features.  Return true (non-zero) if it does. 
+ * features.  Return true (non-zero) if it does.
  **/
 
 int journal_check_used_features (journal_t *journal, unsigned long compat,
@@ -1195,7 +1195,7 @@
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
  * @incompat: bitmask of incompatible features
- * 
+ *
  * Check whether the journaling code supports the use of
  * all of a given set of features on this journal.  Return true
  * (non-zero) if it can. */
@@ -1233,7 +1233,7 @@
  * @incompat: bitmask of incompatible features
  *
  * Mark a given journal feature as present on the
- * superblock.  Returns true if the requested features could be set. 
+ * superblock.  Returns true if the requested features could be set.
  *
  */
 
@@ -1319,7 +1319,7 @@
 /**
  * int journal_flush () - Flush journal
  * @journal: Journal to act on.
- * 
+ *
  * Flush all data for a given journal to disk and empty the journal.
  * Filesystems can use this when remounting readonly to ensure that
  * recovery does not need to happen on remount.
@@ -1386,7 +1386,7 @@
  * int journal_wipe() - Wipe journal contents
  * @journal: Journal to act on.
  * @write: flag (see below)
- * 
+ *
  * Wipe out all of the contents of a journal, safely.  This will produce
  * a warning if the journal contains any valid recovery information.
  * Must be called between journal_init_*() and journal_load().
@@ -1441,7 +1441,7 @@
 
 /*
  * Journal abort has very specific semantics, which we describe
- * for journal abort. 
+ * for journal abort.
  *
  * Two internal function, which provide abort to te jbd layer
  * itself are here.
@@ -1496,7 +1496,7 @@
  * Perform a complete, immediate shutdown of the ENTIRE
  * journal (not of a single transaction).  This operation cannot be
  * undone without closing and reopening the journal.
- *           
+ *
  * The journal_abort function is intended to support higher level error
  * recovery mechanisms such as the ext2/ext3 remount-readonly error
  * mode.
@@ -1530,7 +1530,7 @@
  * supply an errno; a null errno implies that absolutely no further
  * writes are done to the journal (unless there are any already in
  * progress).
- * 
+ *
  */
 
 void journal_abort(journal_t *journal, int errno)
@@ -1538,7 +1538,7 @@
 	__journal_abort_soft(journal, errno);
 }
 
-/** 
+/**
  * int journal_errno () - returns the journal's error state.
  * @journal: journal to examine.
  *
@@ -1562,7 +1562,7 @@
 	return err;
 }
 
-/** 
+/**
  * int journal_clear_err () - clears the journal's error state
  * @journal: journal to act on.
  *
@@ -1582,7 +1582,7 @@
 	return err;
 }
 
-/** 
+/**
  * void journal_ack_err() - Ack journal err.
  * @journal: journal to act on.
  *
@@ -1604,7 +1604,7 @@
 
 /*
  * Simple support for retrying memory allocations.  Introduced to help to
- * debug different VM deadlock avoidance strategies. 
+ * debug different VM deadlock avoidance strategies.
  */
 void * __jbd_kmalloc (const char *where, size_t size, gfp_t flags, int retry)
 {
diff -urN linux-2.6.18-rc4/fs/jbd/recovery.c linux-2.6.18-rc4-ws/fs/jbd/recovery.c
--- linux-2.6.18-rc4/fs/jbd/recovery.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/jbd/recovery.c	2006-08-10 22:50:12.252751988 -0700
@@ -1,6 +1,6 @@
 /*
  * linux/fs/recovery.c
- * 
+ *
  * Written by Stephen C. Tweedie <sct@redhat.com>, 1999
  *
  * Copyright 1999-2000 Red Hat Software --- All Rights Reserved
@@ -10,7 +10,7 @@
  * option, any later version, incorporated herein by reference.
  *
  * Journal recovery routines for the generic filesystem journaling code;
- * part of the ext2fs journaling system.  
+ * part of the ext2fs journaling system.
  */
 
 #ifndef __KERNEL__
@@ -25,9 +25,9 @@
 
 /*
  * Maintain information about the progress of the recovery job, so that
- * the different passes can carry information between them. 
+ * the different passes can carry information between them.
  */
-struct recovery_info 
+struct recovery_info
 {
 	tid_t		start_transaction;
 	tid_t		end_transaction;
@@ -116,7 +116,7 @@
 	err = 0;
 
 failed:
-	if (nbufs) 
+	if (nbufs)
 		journal_brelse_array(bufs, nbufs);
 	return err;
 }
@@ -128,7 +128,7 @@
  * Read a block from the journal
  */
 
-static int jread(struct buffer_head **bhp, journal_t *journal, 
+static int jread(struct buffer_head **bhp, journal_t *journal,
 		 unsigned int offset)
 {
 	int err;
@@ -212,14 +212,14 @@
 /**
  * journal_recover - recovers a on-disk journal
  * @journal: the journal to recover
- * 
+ *
  * The primary function for recovering the log contents when mounting a
- * journaled device.  
+ * journaled device.
  *
  * Recovery is done in three passes.  In the first pass, we look for the
  * end of the log.  In the second, we assemble the list of revoke
  * blocks.  In the third and final pass, we replay any un-revoked blocks
- * in the log.  
+ * in the log.
  */
 int journal_recover(journal_t *journal)
 {
@@ -231,10 +231,10 @@
 	memset(&info, 0, sizeof(info));
 	sb = journal->j_superblock;
 
-	/* 
+	/*
 	 * The journal superblock's s_start field (the current log head)
 	 * is always zero if, and only if, the journal was cleanly
-	 * unmounted.  
+	 * unmounted.
 	 */
 
 	if (!sb->s_start) {
@@ -253,7 +253,7 @@
 	jbd_debug(0, "JBD: recovery, exit status %d, "
 		  "recovered transactions %u to %u\n",
 		  err, info.start_transaction, info.end_transaction);
-	jbd_debug(0, "JBD: Replayed %d and revoked %d/%d blocks\n", 
+	jbd_debug(0, "JBD: Replayed %d and revoked %d/%d blocks\n",
 		  info.nr_replays, info.nr_revoke_hits, info.nr_revokes);
 
 	/* Restart the log at the next transaction ID, thus invalidating
@@ -268,15 +268,15 @@
 /**
  * journal_skip_recovery - Start journal and wipe exiting records
  * @journal: journal to startup
- * 
+ *
  * Locate any valid recovery information from the journal and set up the
  * journal structures in memory to ignore it (presumably because the
- * caller has evidence that it is out of date).  
+ * caller has evidence that it is out of date).
  * This function does'nt appear to be exorted..
  *
  * We perform one pass over the journal to allow us to tell the user how
  * much recovery information is being erased, and to let us initialise
- * the journal transaction sequence numbers to the next unused ID. 
+ * the journal transaction sequence numbers to the next unused ID.
  */
 int journal_skip_recovery(journal_t *journal)
 {
@@ -297,7 +297,7 @@
 #ifdef CONFIG_JBD_DEBUG
 		int dropped = info.end_transaction - be32_to_cpu(sb->s_sequence);
 #endif
-		jbd_debug(0, 
+		jbd_debug(0,
 			  "JBD: ignoring %d transaction%s from the journal.\n",
 			  dropped, (dropped == 1) ? "" : "s");
 		journal->j_transaction_sequence = ++info.end_transaction;
@@ -324,10 +324,10 @@
 	MAX_BLOCKS_PER_DESC = ((journal->j_blocksize-sizeof(journal_header_t))
 			       / sizeof(journal_block_tag_t));
 
-	/* 
+	/*
 	 * First thing is to establish what we expect to find in the log
 	 * (in terms of transaction IDs), and where (in terms of log
-	 * block offsets): query the superblock.  
+	 * block offsets): query the superblock.
 	 */
 
 	sb = journal->j_superblock;
@@ -344,7 +344,7 @@
 	 * Now we walk through the log, transaction by transaction,
 	 * making sure that each transaction has a commit block in the
 	 * expected place.  Each complete transaction gets replayed back
-	 * into the main filesystem. 
+	 * into the main filesystem.
 	 */
 
 	while (1) {
@@ -379,8 +379,8 @@
 		next_log_block++;
 		wrap(journal, next_log_block);
 
-		/* What kind of buffer is it? 
-		 * 
+		/* What kind of buffer is it?
+		 *
 		 * If it is a descriptor block, check that it has the
 		 * expected sequence number.  Otherwise, we're all done
 		 * here. */
@@ -394,7 +394,7 @@
 
 		blocktype = be32_to_cpu(tmp->h_blocktype);
 		sequence = be32_to_cpu(tmp->h_sequence);
-		jbd_debug(3, "Found magic %d, sequence %d\n", 
+		jbd_debug(3, "Found magic %d, sequence %d\n",
 			  blocktype, sequence);
 
 		if (sequence != next_commit_ID) {
@@ -438,7 +438,7 @@
 					/* Recover what we can, but
 					 * report failure at the end. */
 					success = err;
-					printk (KERN_ERR 
+					printk (KERN_ERR
 						"JBD: IO error %d recovering "
 						"block %ld in log\n",
 						err, io_block);
@@ -452,7 +452,7 @@
 					 * revoked, then we're all done
 					 * here. */
 					if (journal_test_revoke
-					    (journal, blocknr, 
+					    (journal, blocknr,
 					     next_commit_ID)) {
 						brelse(obh);
 						++info->nr_revoke_hits;
@@ -465,7 +465,7 @@
 							blocknr,
 							journal->j_blocksize);
 					if (nbh == NULL) {
-						printk(KERN_ERR 
+						printk(KERN_ERR
 						       "JBD: Out of memory "
 						       "during recovery.\n");
 						err = -ENOMEM;
@@ -537,7 +537,7 @@
 	}
 
  done:
-	/* 
+	/*
 	 * We broke out of the log scan loop: either we came to the
 	 * known end of the log or we found an unexpected block in the
 	 * log.  If the latter happened, then we know that the "current"
@@ -567,7 +567,7 @@
 
 /* Scan a revoke record, marking all blocks mentioned as revoked. */
 
-static int scan_revoke_records(journal_t *journal, struct buffer_head *bh, 
+static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 			       tid_t sequence, struct recovery_info *info)
 {
 	journal_revoke_header_t *header;
diff -urN linux-2.6.18-rc4/fs/jbd/revoke.c linux-2.6.18-rc4-ws/fs/jbd/revoke.c
--- linux-2.6.18-rc4/fs/jbd/revoke.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/jbd/revoke.c	2006-08-10 22:50:12.278749169 -0700
@@ -1,6 +1,6 @@
 /*
  * linux/fs/revoke.c
- * 
+ *
  * Written by Stephen C. Tweedie <sct@redhat.com>, 2000
  *
  * Copyright 2000 Red Hat corp --- All Rights Reserved
@@ -15,10 +15,10 @@
  * Revoke is the mechanism used to prevent old log records for deleted
  * metadata from being replayed on top of newer data using the same
  * blocks.  The revoke mechanism is used in two separate places:
- * 
+ *
  * + Commit: during commit we write the entire list of the current
  *   transaction's revoked blocks to the journal
- * 
+ *
  * + Recovery: during recovery we record the transaction ID of all
  *   revoked blocks.  If there are multiple revoke records in the log
  *   for a single block, only the last one counts, and if there is a log
@@ -29,7 +29,7 @@
  * single transaction:
  *
  * Block is revoked and then journaled:
- *   The desired end result is the journaling of the new block, so we 
+ *   The desired end result is the journaling of the new block, so we
  *   cancel the revoke before the transaction commits.
  *
  * Block is journaled and then revoked:
@@ -41,7 +41,7 @@
  *   transaction must have happened after the block was journaled and so
  *   the revoke must take precedence.
  *
- * Block is revoked and then written as data: 
+ * Block is revoked and then written as data:
  *   The data write is allowed to succeed, but the revoke is _not_
  *   cancelled.  We still need to prevent old log records from
  *   overwriting the new data.  We don't even need to clear the revoke
@@ -54,7 +54,7 @@
  *			buffer has not been revoked, and cancel_revoke
  *			need do nothing.
  * RevokeValid set, Revoked set:
- *			buffer has been revoked.  
+ *			buffer has been revoked.
  */
 
 #ifndef __KERNEL__
@@ -77,7 +77,7 @@
    journal replay, this involves recording the transaction ID of the
    last transaction to revoke this block. */
 
-struct jbd_revoke_record_s 
+struct jbd_revoke_record_s
 {
 	struct list_head  hash;
 	tid_t		  sequence;	/* Used for recovery only */
@@ -90,8 +90,8 @@
 {
 	/* It is conceivable that we might want a larger hash table
 	 * for recovery.  Must be a power of two. */
-	int		  hash_size; 
-	int		  hash_shift; 
+	int		  hash_size;
+	int		  hash_shift;
 	struct list_head *hash_table;
 };
 
@@ -301,22 +301,22 @@
 
 #ifdef __KERNEL__
 
-/* 
+/*
  * journal_revoke: revoke a given buffer_head from the journal.  This
  * prevents the block from being replayed during recovery if we take a
  * crash after this current transaction commits.  Any subsequent
  * metadata writes of the buffer in this transaction cancel the
- * revoke.  
+ * revoke.
  *
  * Note that this call may block --- it is up to the caller to make
  * sure that there are no further calls to journal_write_metadata
  * before the revoke is complete.  In ext3, this implies calling the
  * revoke before clearing the block bitmap when we are deleting
- * metadata. 
+ * metadata.
  *
  * Revoke performs a journal_forget on any buffer_head passed in as a
  * parameter, but does _not_ forget the buffer_head if the bh was only
- * found implicitly. 
+ * found implicitly.
  *
  * bh_in may not be a journalled buffer - it may have come off
  * the hash tables without an attached journal_head.
@@ -325,7 +325,7 @@
  * by one.
  */
 
-int journal_revoke(handle_t *handle, unsigned long blocknr, 
+int journal_revoke(handle_t *handle, unsigned long blocknr,
 		   struct buffer_head *bh_in)
 {
 	struct buffer_head *bh = NULL;
@@ -487,7 +487,7 @@
 	else
 		journal->j_revoke = journal->j_revoke_table[0];
 
-	for (i = 0; i < journal->j_revoke->hash_size; i++) 
+	for (i = 0; i < journal->j_revoke->hash_size; i++)
 		INIT_LIST_HEAD(&journal->j_revoke->hash_table[i]);
 }
 
@@ -498,7 +498,7 @@
  * Called with the journal lock held.
  */
 
-void journal_write_revoke_records(journal_t *journal, 
+void journal_write_revoke_records(journal_t *journal,
 				  transaction_t *transaction)
 {
 	struct journal_head *descriptor;
@@ -507,7 +507,7 @@
 	struct list_head *hash_list;
 	int i, offset, count;
 
-	descriptor = NULL; 
+	descriptor = NULL;
 	offset = 0;
 	count = 0;
 
@@ -519,10 +519,10 @@
 		hash_list = &revoke->hash_table[i];
 
 		while (!list_empty(hash_list)) {
-			record = (struct jbd_revoke_record_s *) 
+			record = (struct jbd_revoke_record_s *)
 				hash_list->next;
 			write_one_revoke_record(journal, transaction,
-						&descriptor, &offset, 
+						&descriptor, &offset,
 						record);
 			count++;
 			list_del(&record->hash);
@@ -534,14 +534,14 @@
 	jbd_debug(1, "Wrote %d revoke records\n", count);
 }
 
-/* 
+/*
  * Write out one revoke record.  We need to create a new descriptor
- * block if the old one is full or if we have not already created one.  
+ * block if the old one is full or if we have not already created one.
  */
 
-static void write_one_revoke_record(journal_t *journal, 
+static void write_one_revoke_record(journal_t *journal,
 				    transaction_t *transaction,
-				    struct journal_head **descriptorp, 
+				    struct journal_head **descriptorp,
 				    int *offsetp,
 				    struct jbd_revoke_record_s *record)
 {
@@ -584,21 +584,21 @@
 		*descriptorp = descriptor;
 	}
 
-	* ((__be32 *)(&jh2bh(descriptor)->b_data[offset])) = 
+	* ((__be32 *)(&jh2bh(descriptor)->b_data[offset])) =
 		cpu_to_be32(record->blocknr);
 	offset += 4;
 	*offsetp = offset;
 }
 
-/* 
+/*
  * Flush a revoke descriptor out to the journal.  If we are aborting,
  * this is a noop; otherwise we are generating a buffer which needs to
  * be waited for during commit, so it has to go onto the appropriate
  * journal buffer list.
  */
 
-static void flush_descriptor(journal_t *journal, 
-			     struct journal_head *descriptor, 
+static void flush_descriptor(journal_t *journal,
+			     struct journal_head *descriptor,
 			     int offset)
 {
 	journal_revoke_header_t *header;
@@ -618,7 +618,7 @@
 }
 #endif
 
-/* 
+/*
  * Revoke support for recovery.
  *
  * Recovery needs to be able to:
@@ -629,7 +629,7 @@
  *  check whether a given block in a given transaction should be replayed
  *  (ie. has not been revoked by a revoke record in that or a subsequent
  *  transaction)
- * 
+ *
  *  empty the revoke table after recovery.
  */
 
@@ -637,11 +637,11 @@
  * First, setting revoke records.  We create a new revoke record for
  * every block ever revoked in the log as we scan it for recovery, and
  * we update the existing records if we find multiple revokes for a
- * single block. 
+ * single block.
  */
 
-int journal_set_revoke(journal_t *journal, 
-		       unsigned long blocknr, 
+int journal_set_revoke(journal_t *journal,
+		       unsigned long blocknr,
 		       tid_t sequence)
 {
 	struct jbd_revoke_record_s *record;
@@ -653,18 +653,18 @@
 		if (tid_gt(sequence, record->sequence))
 			record->sequence = sequence;
 		return 0;
-	} 
+	}
 	return insert_revoke_hash(journal, blocknr, sequence);
 }
 
-/* 
+/*
  * Test revoke records.  For a given block referenced in the log, has
  * that block been revoked?  A revoke record with a given transaction
  * sequence number revokes all blocks in that transaction and earlier
  * ones, but later transactions still need replayed.
  */
 
-int journal_test_revoke(journal_t *journal, 
+int journal_test_revoke(journal_t *journal,
 			unsigned long blocknr,
 			tid_t sequence)
 {
diff -urN linux-2.6.18-rc4/fs/jbd/transaction.c linux-2.6.18-rc4-ws/fs/jbd/transaction.c
--- linux-2.6.18-rc4/fs/jbd/transaction.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/fs/jbd/transaction.c	2006-08-10 22:50:12.309745809 -0700
@@ -1,6 +1,6 @@
 /*
  * linux/fs/transaction.c
- * 
+ *
  * Written by Stephen C. Tweedie <sct@redhat.com>, 1998
  *
  * Copyright 1998 Red Hat corp --- All Rights Reserved
@@ -10,7 +10,7 @@
  * option, any later version, incorporated herein by reference.
  *
  * Generic filesystem transaction handling code; part of the ext2fs
- * journaling system.  
+ * journaling system.
  *
  * This file manages transactions (compound commits managed by the
  * journaling code) and handles (individual atomic operations by the
@@ -74,7 +74,7 @@
  * start_this_handle: Given a handle, deal with any locking or stalling
  * needed to make sure that there is enough journal space for the handle
  * to begin.  Attach the handle to a transaction and set up the
- * transaction's buffer credits.  
+ * transaction's buffer credits.
  */
 
 static int start_this_handle(journal_t *journal, handle_t *handle)
@@ -117,7 +117,7 @@
 	if (is_journal_aborted(journal) ||
 	    (journal->j_errno != 0 && !(journal->j_flags & JFS_ACK_ERR))) {
 		spin_unlock(&journal->j_state_lock);
-		ret = -EROFS; 
+		ret = -EROFS;
 		goto out;
 	}
 
@@ -182,7 +182,7 @@
 		goto repeat;
 	}
 
-	/* 
+	/*
 	 * The commit code assumes that it can get enough log space
 	 * without forcing a checkpoint.  This is *critical* for
 	 * correctness: a checkpoint of a buffer which is also
@@ -191,7 +191,7 @@
 	 *
 	 * We must therefore ensure the necessary space in the journal
 	 * *before* starting to dirty potentially checkpointed buffers
-	 * in the new transaction. 
+	 * in the new transaction.
 	 *
 	 * The worst part is, any transaction currently committing can
 	 * reduce the free space arbitrarily.  Be careful to account for
@@ -246,13 +246,13 @@
 }
 
 /**
- * handle_t *journal_start() - Obtain a new handle.  
+ * handle_t *journal_start() - Obtain a new handle.
  * @journal: Journal to start transaction on.
  * @nblocks: number of block buffer we might modify
  *
  * We make sure that the transaction can guarantee at least nblocks of
  * modified buffers in the log.  We block until the log can guarantee
- * that much space.  
+ * that much space.
  *
  * This function is visible to journal users (like ext3fs), so is not
  * called with the journal already locked.
@@ -292,11 +292,11 @@
  * int journal_extend() - extend buffer credits.
  * @handle:  handle to 'extend'
  * @nblocks: nr blocks to try to extend by.
- * 
+ *
  * Some transactions, such as large extends and truncates, can be done
  * atomically all at once or in several stages.  The operation requests
  * a credit for a number of buffer modications in advance, but can
- * extend its credit if it needs more.  
+ * extend its credit if it needs more.
  *
  * journal_extend tries to give the running handle more buffer credits.
  * It does not guarantee that allocation - this is a best-effort only.
@@ -363,7 +363,7 @@
  * int journal_restart() - restart a handle .
  * @handle:  handle to restart
  * @nblocks: nr credits requested
- * 
+ *
  * Restart a handle for a multi-transaction filesystem
  * operation.
  *
@@ -462,7 +462,7 @@
 /**
  * void journal_unlock_updates (journal_t* journal) - release barrier
  * @journal:  Journal to release the barrier on.
- * 
+ *
  * Release a transaction barrier obtained with journal_lock_updates().
  *
  * Should be called without the journal lock held.
@@ -547,8 +547,8 @@
 	jbd_lock_bh_state(bh);
 
 	/* We now hold the buffer lock so it is safe to query the buffer
-	 * state.  Is the buffer dirty? 
-	 * 
+	 * state.  Is the buffer dirty?
+	 *
 	 * If so, there are two possibilities.  The buffer may be
 	 * non-journaled, and undergoing a quite legitimate writeback.
 	 * Otherwise, it is journaled, and we don't expect dirty buffers
@@ -566,7 +566,7 @@
 		 */
 		if (jh->b_transaction) {
 			J_ASSERT_JH(jh,
-				jh->b_transaction == transaction || 
+				jh->b_transaction == transaction ||
 				jh->b_transaction ==
 					journal->j_committing_transaction);
 			if (jh->b_next_transaction)
@@ -653,7 +653,7 @@
 		 * buffer had better remain locked during the kmalloc,
 		 * but that should be true --- we hold the journal lock
 		 * still and the buffer is already on the BUF_JOURNAL
-		 * list so won't be flushed. 
+		 * list so won't be flushed.
 		 *
 		 * Subtle point, though: if this is a get_undo_access,
 		 * then we will be relying on the frozen_data to contain
@@ -764,8 +764,8 @@
  * manually rather than reading off disk), then we need to keep the
  * buffer_head locked until it has been completely filled with new
  * data.  In this case, we should be able to make the assertion that
- * the bh is not already part of an existing transaction.  
- * 
+ * the bh is not already part of an existing transaction.
+ *
  * The buffer should already be locked by the caller by this point.
  * There is no lock ranking violation: it was a newly created,
  * unlocked buffer beforehand. */
@@ -777,7 +777,7 @@
  *
  * Call this if you create a new bh.
  */
-int journal_get_create_access(handle_t *handle, struct buffer_head *bh) 
+int journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
@@ -846,13 +846,13 @@
  * do not reuse freed space until the deallocation has been committed,
  * since if we overwrote that space we would make the delete
  * un-rewindable in case of a crash.
- * 
+ *
  * To deal with that, journal_get_undo_access requests write access to a
  * buffer for parts of non-rewindable operations such as delete
  * operations on the bitmaps.  The journaling code must keep a copy of
  * the buffer's contents prior to the undo_access call until such time
  * as we know that the buffer has definitely been committed to disk.
- * 
+ *
  * We never need to know which transaction the committed data is part
  * of, buffers touched here are guaranteed to be dirtied later and so
  * will be committed to a new transaction in due course, at which point
@@ -910,13 +910,13 @@
 	return err;
 }
 
-/** 
+/**
  * int journal_dirty_data() -  mark a buffer as containing dirty data which
  *                             needs to be flushed before we can commit the
- *                             current transaction.  
+ *                             current transaction.
  * @handle: transaction
  * @bh: bufferhead to mark
- * 
+ *
  * The buffer is placed on the transaction's data list and is marked as
  * belonging to the transaction.
  *
@@ -945,15 +945,15 @@
 
 	/*
 	 * What if the buffer is already part of a running transaction?
-	 * 
+	 *
 	 * There are two cases:
 	 * 1) It is part of the current running transaction.  Refile it,
 	 *    just in case we have allocated it as metadata, deallocated
-	 *    it, then reallocated it as data. 
+	 *    it, then reallocated it as data.
 	 * 2) It is part of the previous, still-committing transaction.
 	 *    If all we want to do is to guarantee that the buffer will be
 	 *    written to disk before this new transaction commits, then
-	 *    being sure that the *previous* transaction has this same 
+	 *    being sure that the *previous* transaction has this same
 	 *    property is sufficient for us!  Just leave it on its old
 	 *    transaction.
 	 *
@@ -1075,18 +1075,18 @@
 	return 0;
 }
 
-/** 
+/**
  * int journal_dirty_metadata() -  mark a buffer as containing dirty metadata
  * @handle: transaction to add buffer to.
- * @bh: buffer to mark 
- * 
+ * @bh: buffer to mark
+ *
  * mark dirty metadata which needs to be journaled as part of the current
  * transaction.
  *
  * The buffer is placed on the transaction's metadata list and is marked
- * as belonging to the transaction.  
+ * as belonging to the transaction.
  *
- * Returns error number or 0 on success.  
+ * Returns error number or 0 on success.
  *
  * Special care needs to be taken if the buffer already belongs to the
  * current committing transaction (in which case we should have frozen
@@ -1134,11 +1134,11 @@
 
 	set_buffer_jbddirty(bh);
 
-	/* 
+	/*
 	 * Metadata already on the current transaction list doesn't
 	 * need to be filed.  Metadata on another transaction's list must
 	 * be committing, and will be refiled once the commit completes:
-	 * leave it alone for now. 
+	 * leave it alone for now.
 	 */
 	if (jh->b_transaction != transaction) {
 		JBUFFER_TRACE(jh, "already on other transaction");
@@ -1164,7 +1164,7 @@
 	return 0;
 }
 
-/* 
+/*
  * journal_release_buffer: undo a get_write_access without any buffer
  * updates, if the update decided in the end that it didn't need access.
  *
@@ -1175,20 +1175,20 @@
 	BUFFER_TRACE(bh, "entry");
 }
 
-/** 
+/**
  * void journal_forget() - bforget() for potentially-journaled buffers.
  * @handle: transaction handle
  * @bh:     bh to 'forget'
  *
  * We can only do the bforget if there are no commits pending against the
  * buffer.  If the buffer is dirty in the current running transaction we
- * can safely unlink it. 
+ * can safely unlink it.
  *
  * bh may not be a journalled buffer at all - it may be a non-JBD
  * buffer which came off the hashtable.  Check for this.
  *
  * Decrements bh->b_count by one.
- * 
+ *
  * Allow this call even if the handle has aborted --- it may be part of
  * the caller's cleanup after an abort.
  */
@@ -1236,7 +1236,7 @@
 
 		drop_reserve = 1;
 
-		/* 
+		/*
 		 * We are no longer going to journal this buffer.
 		 * However, the commit of this transaction is still
 		 * important to the buffer: the delete that we are now
@@ -1245,7 +1245,7 @@
 		 *
 		 * So, if we have a checkpoint on the buffer, we should
 		 * now refile the buffer on our BJ_Forget list so that
-		 * we know to remove the checkpoint after we commit. 
+		 * we know to remove the checkpoint after we commit.
 		 */
 
 		if (jh->b_cp_transaction) {
@@ -1263,7 +1263,7 @@
 			}
 		}
 	} else if (jh->b_transaction) {
-		J_ASSERT_JH(jh, (jh->b_transaction == 
+		J_ASSERT_JH(jh, (jh->b_transaction ==
 				 journal->j_committing_transaction));
 		/* However, if the buffer is still owned by a prior
 		 * (committing) transaction, we can't drop it yet... */
@@ -1293,7 +1293,7 @@
 /**
  * int journal_stop() - complete a transaction
  * @handle: tranaction to complete.
- * 
+ *
  * All done for a particular handle.
  *
  * There is not much action needed here.  We just return any remaining
@@ -1302,7 +1302,7 @@
  * filesystem is marked for synchronous update.
  *
  * journal_stop itself will not usually return an error, but it may
- * do so in unusual circumstances.  In particular, expect it to 
+ * do so in unusual circumstances.  In particular, expect it to
  * return -EIO if a journal_abort has been executed since the
  * transaction began.
  */
@@ -1387,7 +1387,7 @@
 
 		/*
 		 * Special case: JFS_SYNC synchronous updates require us
-		 * to wait for the commit to complete.  
+		 * to wait for the commit to complete.
 		 */
 		if (handle->h_sync && !(current->flags & PF_MEMALLOC))
 			err = log_wait_commit(journal, tid);
@@ -1438,7 +1438,7 @@
  * jbd_lock_bh_state(jh2bh(jh)) is held.
  */
 
-static inline void 
+static inline void
 __blist_add_buffer(struct journal_head **list, struct journal_head *jh)
 {
 	if (!*list) {
@@ -1453,7 +1453,7 @@
 	}
 }
 
-/* 
+/*
  * Remove a buffer from a transaction list, given the transaction's list
  * head pointer.
  *
@@ -1474,7 +1474,7 @@
 	jh->b_tnext->b_tprev = jh->b_tprev;
 }
 
-/* 
+/*
  * Remove a buffer from the appropriate transaction list.
  *
  * Note that this function can *change* the value of
@@ -1594,17 +1594,17 @@
 }
 
 
-/** 
+/**
  * int journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
  * @page: to try and free
  * @unused_gfp_mask: unused
  *
- * 
+ *
  * For all the buffers on this page,
  * if they are fully written out ordered data, move them onto BUF_CLEAN
  * so try_to_free_buffers() can reap them.
- * 
+ *
  * This function returns non-zero if we wish try_to_free_buffers()
  * to be called. We do this if the page is releasable by try_to_free_buffers().
  * We also do it if the page has locked or dirty buffers and the caller wants
@@ -1628,7 +1628,7 @@
  * cannot happen because we never reallocate freed data as metadata
  * while the data is part of a transaction.  Yes?
  */
-int journal_try_to_free_buffers(journal_t *journal, 
+int journal_try_to_free_buffers(journal_t *journal,
 				struct page *page, gfp_t unused_gfp_mask)
 {
 	struct buffer_head *head;
@@ -1696,7 +1696,7 @@
 }
 
 /*
- * journal_invalidatepage 
+ * journal_invalidatepage
  *
  * This code is tricky.  It has a number of cases to deal with.
  *
@@ -1704,15 +1704,15 @@
  *
  * i_size must be updated on disk before we start calling invalidatepage on the
  * data.
- * 
+ *
  *  This is done in ext3 by defining an ext3_setattr method which
  *  updates i_size before truncate gets going.  By maintaining this
  *  invariant, we can be sure that it is safe to throw away any buffers
  *  attached to the current transaction: once the transaction commits,
  *  we know that the data will not be needed.
- * 
+ *
  *  Note however that we can *not* throw away data belonging to the
- *  previous, committing transaction!  
+ *  previous, committing transaction!
  *
  * Any disk blocks which *are* part of the previous, committing
  * transaction (and which therefore cannot be discarded immediately) are
@@ -1731,7 +1731,7 @@
  * don't make guarantees about the order in which data hits disk --- in
  * particular we don't guarantee that new dirty data is flushed before
  * transaction commit --- so it is always safe just to discard data
- * immediately in that mode.  --sct 
+ * immediately in that mode.  --sct
  */
 
 /*
@@ -1875,9 +1875,9 @@
 	return may_free;
 }
 
-/** 
+/**
  * void journal_invalidatepage()
- * @journal: journal to use for flush... 
+ * @journal: journal to use for flush...
  * @page:    page to flush
  * @offset:  length of page to invalidate.
  *
@@ -1885,7 +1885,7 @@
  *
  */
 void journal_invalidatepage(journal_t *journal,
-		      struct page *page, 
+		      struct page *page,
 		      unsigned long offset)
 {
 	struct buffer_head *head, *bh, *next;
@@ -1923,8 +1923,8 @@
 	}
 }
 
-/* 
- * File a buffer on the given transaction list. 
+/*
+ * File a buffer on the given transaction list.
  */
 void __journal_file_buffer(struct journal_head *jh,
 			transaction_t *transaction, int jlist)
@@ -1947,7 +1947,7 @@
 	 * with __jbd_unexpected_dirty_buffer()'s handling of dirty
 	 * state. */
 
-	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
+	if (jlist == BJ_Metadata || jlist == BJ_Reserved ||
 	    jlist == BJ_Shadow || jlist == BJ_Forget) {
 		if (test_clear_buffer_dirty(bh) ||
 		    test_clear_buffer_jbddirty(bh))
@@ -2007,7 +2007,7 @@
 	jbd_unlock_bh_state(jh2bh(jh));
 }
 
-/* 
+/*
  * Remove a buffer from its current buffer list in preparation for
  * dropping it from its current transaction entirely.  If the buffer has
  * already started to be used by a subsequent transaction, refile the
@@ -2059,7 +2059,7 @@
  * to the caller to remove the journal_head if necessary.  For the
  * unlocked journal_refile_buffer call, the caller isn't going to be
  * doing anything else to the buffer so we need to do the cleanup
- * ourselves to avoid a jh leak. 
+ * ourselves to avoid a jh leak.
  *
  * *** The journal_head may be freed by this call! ***
  */
diff -urN linux-2.6.18-rc4/include/linux/ext3_jbd.h linux-2.6.18-rc4-ws/include/linux/ext3_jbd.h
--- linux-2.6.18-rc4/include/linux/ext3_jbd.h	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/include/linux/ext3_jbd.h	2006-08-10 22:50:58.738719098 -0700
@@ -23,7 +23,7 @@
 
 /* Define the number of blocks we need to account to a transaction to
  * modify one block of data.
- * 
+ *
  * We may have to touch one inode, one bitmap buffer, up to three
  * indirection blocks, the group and superblock summaries, and the data
  * block to complete the transaction.  */
@@ -88,16 +88,16 @@
 #endif
 
 int
-ext3_mark_iloc_dirty(handle_t *handle, 
+ext3_mark_iloc_dirty(handle_t *handle,
 		     struct inode *inode,
 		     struct ext3_iloc *iloc);
 
-/* 
+/*
  * On success, We end up with an outstanding reference count against
- * iloc->bh.  This _must_ be cleaned up later. 
+ * iloc->bh.  This _must_ be cleaned up later.
  */
 
-int ext3_reserve_inode_write(handle_t *handle, struct inode *inode, 
+int ext3_reserve_inode_write(handle_t *handle, struct inode *inode,
 			struct ext3_iloc *iloc);
 
 int ext3_mark_inode_dirty(handle_t *handle, struct inode *inode);
diff -urN linux-2.6.18-rc4/include/linux/jbd.h linux-2.6.18-rc4-ws/include/linux/jbd.h
--- linux-2.6.18-rc4/include/linux/jbd.h	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4-ws/include/linux/jbd.h	2006-08-10 22:50:12.336742882 -0700
@@ -1,6 +1,6 @@
 /*
  * linux/include/linux/jbd.h
- * 
+ *
  * Written by Stephen C. Tweedie <sct@redhat.com>
  *
  * Copyright 1998-2000 Red Hat, Inc --- All Rights Reserved
@@ -94,8 +94,8 @@
  * number of outstanding buffers possible at any time.  When the
  * operation completes, any buffer credits not used are credited back to
  * the transaction, so that at all times we know how many buffers the
- * outstanding updates on a transaction might possibly touch. 
- * 
+ * outstanding updates on a transaction might possibly touch.
+ *
  * This is an opaque datatype.
  **/
 typedef struct handle_s		handle_t;	/* Atomic operation type */
@@ -105,7 +105,7 @@
  * typedef journal_t - The journal_t maintains all of the journaling state information for a single filesystem.
  *
  * journal_t is linked to from the fs superblock structure.
- * 
+ *
  * We use the journal_t to keep track of all outstanding transaction
  * activity on the filesystem, and to manage the state of the log
  * writing process.
@@ -125,7 +125,7 @@
  * On-disk structures
  */
 
-/* 
+/*
  * Descriptor block types:
  */
 
@@ -146,8 +146,8 @@
 } journal_header_t;
 
 
-/* 
- * The block tag: used to describe a single buffer in the journal 
+/*
+ * The block tag: used to describe a single buffer in the journal
  */
 typedef struct journal_block_tag_s
 {
@@ -155,9 +155,9 @@
 	__be32		t_flags;	/* See below */
 } journal_block_tag_t;
 
-/* 
+/*
  * The revoke descriptor: used on disk to describe a series of blocks to
- * be revoked from the log 
+ * be revoked from the log
  */
 typedef struct journal_revoke_header_s
 {
@@ -371,10 +371,10 @@
  **/
 
 /* Docbook can't yet cope with the bit fields, but will leave the documentation
- * in so it can be fixed later. 
+ * in so it can be fixed later.
  */
 
-struct handle_s 
+struct handle_s
 {
 	/* Which compound transaction is this update a part of? */
 	transaction_t		*h_transaction;
@@ -432,7 +432,7 @@
  *
  */
 
-struct transaction_s 
+struct transaction_s
 {
 	/* Pointer to the journal for this transaction. [no locking] */
 	journal_t		*t_journal;
@@ -452,7 +452,7 @@
 		T_RUNDOWN,
 		T_FLUSH,
 		T_COMMIT,
-		T_FINISHED 
+		T_FINISHED
 	}			t_state;
 
 	/*
@@ -566,7 +566,7 @@
  *     journal_t.
  * @j_flags:  General journaling state flags
  * @j_errno:  Is there an outstanding uncleared error on the journal (from a
- *     prior abort)? 
+ *     prior abort)?
  * @j_sb_buffer: First part of superblock buffer
  * @j_superblock: Second part of superblock buffer
  * @j_format_version: Version of the superblock format
@@ -580,7 +580,7 @@
  * @j_wait_transaction_locked: Wait queue for waiting for a locked transaction
  *  to start committing, or for a barrier lock to be released
  * @j_wait_logspace: Wait queue for waiting for checkpointing to complete
- * @j_wait_done_commit: Wait queue for waiting for commit to complete 
+ * @j_wait_done_commit: Wait queue for waiting for commit to complete
  * @j_wait_checkpoint:  Wait queue to trigger checkpointing
  * @j_wait_commit: Wait queue to trigger commit
  * @j_wait_updates: Wait queue to wait for updates to complete
@@ -589,7 +589,7 @@
  * @j_tail: Journal tail - identifies the oldest still-used block in the
  *  journal.
  * @j_free: Journal free - how many free blocks are there in the journal?
- * @j_first: The block number of the first usable block 
+ * @j_first: The block number of the first usable block
  * @j_last: The block number one beyond the last usable block
  * @j_dev: Device where we store the journal
  * @j_blocksize: blocksize for the location where we store the journal.
@@ -601,12 +601,12 @@
  * @j_list_lock: Protects the buffer lists and internal buffer state.
  * @j_inode: Optional inode where we store the journal.  If present, all journal
  *     block numbers are mapped into this inode via bmap().
- * @j_tail_sequence:  Sequence number of the oldest transaction in the log 
+ * @j_tail_sequence:  Sequence number of the oldest transaction in the log
  * @j_transaction_sequence: Sequence number of the next transaction to grant
  * @j_commit_sequence: Sequence number of the most recently committed
  *  transaction
  * @j_commit_request: Sequence number of the most recent transaction wanting
- *     commit 
+ *     commit
  * @j_uuid: Uuid of client object.
  * @j_task: Pointer to the current commit thread for this journal
  * @j_max_transaction_buffers:  Maximum number of metadata buffers to allow in a
@@ -820,8 +820,8 @@
 	void *j_private;
 };
 
-/* 
- * Journal flag definitions 
+/*
+ * Journal flag definitions
  */
 #define JFS_UNMOUNT	0x001	/* Journal thread is being destroyed */
 #define JFS_ABORT	0x002	/* Journaling has been aborted for errors. */
@@ -830,7 +830,7 @@
 #define JFS_LOADED	0x010	/* The journal superblock has been loaded */
 #define JFS_BARRIER	0x020	/* Use IDE barriers */
 
-/* 
+/*
  * Function declarations for the journaling transaction and buffer
  * management
  */
@@ -859,7 +859,7 @@
 void __journal_insert_checkpoint(struct journal_head *, transaction_t *);
 
 /* Buffer IO */
-extern int 
+extern int
 journal_write_metadata_buffer(transaction_t	  *transaction,
 			      struct journal_head  *jh_in,
 			      struct journal_head **jh_out,
@@ -887,7 +887,7 @@
 /* The journaling code user interface:
  *
  * Create and destroy handles
- * Register buffer modifications against the current transaction. 
+ * Register buffer modifications against the current transaction.
  */
 
 extern handle_t *journal_start(journal_t *, int nblocks);
@@ -914,11 +914,11 @@
 				int start, int len, int bsize);
 extern journal_t * journal_init_inode (struct inode *);
 extern int	   journal_update_format (journal_t *);
-extern int	   journal_check_used_features 
+extern int	   journal_check_used_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
-extern int	   journal_check_available_features 
+extern int	   journal_check_available_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
-extern int	   journal_set_features 
+extern int	   journal_set_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern int	   journal_create     (journal_t *);
 extern int	   journal_load       (journal_t *journal);
@@ -1012,7 +1012,7 @@
  * bit, when set, indicates that we have had a fatal error somewhere,
  * either inside the journaling layer or indicated to us by the client
  * (eg. ext3), and that we and should not commit any further
- * transactions.  
+ * transactions.
  */
 
 static inline int is_journal_aborted(journal_t *journal)
@@ -1079,7 +1079,7 @@
 #define BJ_Reserved	7	/* Buffer is reserved for access by journal */
 #define BJ_Locked	8	/* Locked for I/O during commit */
 #define BJ_Types	9
- 
+
 extern int jbd_blocks_per_page(struct inode *inode);
 
 #ifdef __KERNEL__


