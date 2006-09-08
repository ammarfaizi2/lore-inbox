Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWIHVj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWIHVj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWIHVj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:39:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52424 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751178AbWIHVjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:39:25 -0400
Date: Fri, 8 Sep 2006 17:39:23 -0400
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ext4 development <linux-ext4@vger.kernel.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060908213920.11498.91737.sendpatchset@kleikamp.austin.ibm.com>
In-Reply-To: <20060908213914.11498.3272.sendpatchset@kleikamp.austin.ibm.com>
References: <20060908213914.11498.3272.sendpatchset@kleikamp.austin.ibm.com>
Subject: [RFC:PATCH 001/002] EXT3: More whitespace cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EXT3: More whitespace cleanups

More white space cleanups in preparation of cloning ext4 from ext3.
Removing spaces that precede a tab.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

---
diff -Nurp linux000/fs/ext3/acl.c linux001/fs/ext3/acl.c
--- linux000/fs/ext3/acl.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/ext3/acl.c	2006-09-08 16:25:07.000000000 -0500
@@ -258,7 +258,7 @@ ext3_set_acl(handle_t *handle, struct in
 		default:
 			return -EINVAL;
 	}
- 	if (acl) {
+	if (acl) {
 		value = ext3_acl_to_disk(acl, &size);
 		if (IS_ERR(value))
 			return (int)PTR_ERR(value);
diff -Nurp linux000/fs/ext3/balloc.c linux001/fs/ext3/balloc.c
--- linux000/fs/ext3/balloc.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/ext3/balloc.c	2006-09-08 16:25:07.000000000 -0500
@@ -40,7 +40,7 @@
 
 /**
  * ext3_get_group_desc() -- load group descriptor from disk
- * @sb: 		super block
+ * @sb:			super block
  * @block_group:	given block group
  * @bh:			pointer to the buffer head to store the block
  *			group descriptor
@@ -355,7 +355,7 @@ void ext3_init_block_alloc_info(struct i
 		rsv->rsv_start = EXT3_RESERVE_WINDOW_NOT_ALLOCATED;
 		rsv->rsv_end = EXT3_RESERVE_WINDOW_NOT_ALLOCATED;
 
-	 	/*
+		/*
 		 * if filesystem is mounted with NORESERVATION, the goal
 		 * reservation window size is set to zero to indicate
 		 * block reservation is off
@@ -681,7 +681,7 @@ bitmap_search_next_usable_block(ext3_grp
 		jbd_lock_bh_state(bh);
 		if (jh->b_committed_data)
 			start = ext3_find_next_zero_bit(jh->b_committed_data,
-						 	maxblocks, next);
+							maxblocks, next);
 		jbd_unlock_bh_state(bh);
 	}
 	return -1;
@@ -790,10 +790,10 @@ claim_block(spinlock_t *lock, ext3_grpbl
  * and at last, allocate the blocks by claiming the found free bit as allocated.
  *
  * To set the range of this allocation:
- * 	if there is a reservation window, only try to allocate block(s) from the
+ *	if there is a reservation window, only try to allocate block(s) from the
  *	file's own reservation window;
  *	Otherwise, the allocation range starts from the give goal block, ends at
- * 	the block group's last block.
+ *	the block group's last block.
  *
  * If we failed to allocate the desired block then we may end up crossing to a
  * new bitmap.  In that case we must release write access to the old one via
@@ -880,12 +880,12 @@ fail_access:
 }
 
 /**
- * 	find_next_reservable_window():
+ *	find_next_reservable_window():
  *		find a reservable space within the given range.
  *		It does not allocate the reservation window for now:
  *		alloc_new_reservation() will do the work later.
  *
- * 	@search_head: the head of the searching list;
+ *	@search_head: the head of the searching list;
  *		This is not necessarily the list head of the whole filesystem
  *
  *		We have both head and start_block to assist the search
@@ -893,12 +893,12 @@ fail_access:
  *		but we will shift to the place where start_block is,
  *		then start from there, when looking for a reservable space.
  *
- * 	@size: the target new reservation window size
+ *	@size: the target new reservation window size
  *
- * 	@group_first_block: the first block we consider to start
+ *	@group_first_block: the first block we consider to start
  *			the real search from
  *
- * 	@last_block:
+ *	@last_block:
  *		the maximum block number that our goal reservable space
  *		could start from. This is normally the last block in this
  *		group. The search will end when we found the start of next
@@ -906,10 +906,10 @@ fail_access:
  *		This could handle the cross boundary reservation window
  *		request.
  *
- * 	basically we search from the given range, rather than the whole
- * 	reservation double linked list, (start_block, last_block)
- * 	to find a free region that is of my size and has not
- * 	been reserved.
+ *	basically we search from the given range, rather than the whole
+ *	reservation double linked list, (start_block, last_block)
+ *	to find a free region that is of my size and has not
+ *	been reserved.
  *
  */
 static int find_next_reservable_window(
@@ -962,7 +962,7 @@ static int find_next_reservable_window(
 			/*
 			 * Found a reserveable space big enough.  We could
 			 * have a reservation across the group boundary here
-		 	 */
+			 */
 			break;
 		}
 	}
@@ -998,7 +998,7 @@ static int find_next_reservable_window(
 }
 
 /**
- * 	alloc_new_reservation()--allocate a new reservation window
+ *	alloc_new_reservation()--allocate a new reservation window
  *
  *		To make a new reservation, we search part of the filesystem
  *		reservation list (the list that inside the group). We try to
diff -Nurp linux000/fs/ext3/dir.c linux001/fs/ext3/dir.c
--- linux000/fs/ext3/dir.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/ext3/dir.c	2006-09-08 16:25:07.000000000 -0500
@@ -70,7 +70,7 @@ int ext3_check_dir_entry (const char * f
 			  unsigned long offset)
 {
 	const char * error_msg = NULL;
- 	const int rlen = le16_to_cpu(de->rec_len);
+	const int rlen = le16_to_cpu(de->rec_len);
 
 	if (rlen < EXT3_DIR_REC_LEN(1))
 		error_msg = "rec_len is smaller than minimal";
diff -Nurp linux000/fs/ext3/hash.c linux001/fs/ext3/hash.c
--- linux000/fs/ext3/hash.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/ext3/hash.c	2006-09-08 16:25:07.000000000 -0500
@@ -95,7 +95,7 @@ int ext3fs_dirhash(const char *name, int
 	__u32	minor_hash = 0;
 	const char	*p;
 	int		i;
-	__u32 		in[8], buf[4];
+	__u32		in[8], buf[4];
 
 	/* Initialize the default seed for the hash checksum functions */
 	buf[0] = 0x67452301;
diff -Nurp linux000/fs/ext3/inode.c linux001/fs/ext3/inode.c
--- linux000/fs/ext3/inode.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/ext3/inode.c	2006-09-08 16:25:07.000000000 -0500
@@ -13,11 +13,11 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
  *  Goal-directed block allocation by Stephen Tweedie
- * 	(sct@redhat.com), 1993, 1998
+ *	(sct@redhat.com), 1993, 1998
  *  Big-endian to little-endian byte-swapping/bitmaps by
  *        David S. Miller (davem@caip.rutgers.edu), 1995
  *  64-bit file support on 64-bit platforms by Jakub Jelinek
- * 	(jj@sunsite.ms.mff.cuni.cz)
+ *	(jj@sunsite.ms.mff.cuni.cz)
  *
  *  Assorted race fixes, rewrite of ext3_get_block() by Al Viro, 2000
  */
@@ -471,7 +471,7 @@ static ext3_fsblk_t ext3_find_goal(struc
  *	ext3_blks_to_allocate: Look up the block map and count the number
  *	of direct blocks need to be allocated for the given branch.
  *
- * 	@branch: chain of indirect blocks
+ *	@branch: chain of indirect blocks
  *	@k: number of blocks need for indirect blocks
  *	@blks: number of data blocks to be mapped.
  *	@blocks_to_boundary:  the offset in the indirect block
@@ -1099,7 +1099,7 @@ static int walk_page_buffers(	handle_t *
 
 	for (	bh = head, block_start = 0;
 		ret == 0 && (bh != head || !block_start);
-	    	block_start = block_end, bh = next)
+		block_start = block_end, bh = next)
 	{
 		next = bh->b_this_page;
 		block_end = block_start + blocksize;
diff -Nurp linux000/fs/ext3/namei.c linux001/fs/ext3/namei.c
--- linux000/fs/ext3/namei.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/ext3/namei.c	2006-09-08 16:25:07.000000000 -0500
@@ -15,13 +15,13 @@
  *  Big-endian to little-endian byte-swapping/bitmaps by
  *        David S. Miller (davem@caip.rutgers.edu), 1995
  *  Directory entry file type support and forward compatibility hooks
- *  	for B-tree directories by Theodore Ts'o (tytso@mit.edu), 1998
+ *	for B-tree directories by Theodore Ts'o (tytso@mit.edu), 1998
  *  Hash Tree Directory indexing (c)
- *  	Daniel Phillips, 2001
+ *	Daniel Phillips, 2001
  *  Hash Tree Directory indexing porting
- *  	Christopher Li, 2002
+ *	Christopher Li, 2002
  *  Hash Tree Directory indexing cleanup
- * 	Theodore Ts'o, 2002
+ *	Theodore Ts'o, 2002
  */
 
 #include <linux/fs.h>
@@ -279,7 +279,7 @@ static struct stats dx_show_leaf(struct 
 				       ((char *) de - base));
 			}
 			space += EXT3_DIR_REC_LEN(de->name_len);
-	 		names++;
+			names++;
 		}
 		de = (struct ext3_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
 	}
@@ -1689,7 +1689,7 @@ static int ext3_mknod (struct inode * di
 
 retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS(dir->i_sb) +
-			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3 +
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3 +
 					2*EXT3_QUOTA_INIT_BLOCKS(dir->i_sb));
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -1817,7 +1817,7 @@ static int empty_dir (struct inode * ino
 			!le32_to_cpu(de1->inode) ||
 			strcmp (".", de->name) ||
 			strcmp ("..", de1->name)) {
-	    	ext3_warning (inode->i_sb, "empty_dir",
+		ext3_warning (inode->i_sb, "empty_dir",
 			      "bad directory (dir #%lu) - no `.' or `..'",
 			      inode->i_ino);
 		brelse (bh);
@@ -2130,7 +2130,7 @@ static int ext3_symlink (struct inode * 
 
 retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS(dir->i_sb) +
-			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 5 +
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 5 +
 					2*EXT3_QUOTA_INIT_BLOCKS(dir->i_sb));
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -2228,7 +2228,7 @@ static int ext3_rename (struct inode * o
 		DQUOT_INIT(new_dentry->d_inode);
 	handle = ext3_journal_start(old_dir, 2 *
 					EXT3_DATA_TRANS_BLOCKS(old_dir->i_sb) +
-			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
diff -Nurp linux000/fs/ext3/super.c linux001/fs/ext3/super.c
--- linux000/fs/ext3/super.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/ext3/super.c	2006-09-08 16:25:07.000000000 -0500
@@ -733,8 +733,8 @@ static match_table_t tokens = {
 
 static ext3_fsblk_t get_sb_block(void **data)
 {
-	ext3_fsblk_t 	sb_block;
-	char 		*options = (char *) *data;
+	ext3_fsblk_t	sb_block;
+	char		*options = (char *) *data;
 
 	if (!options || strncmp(options, "sb=", 3) != 0)
 		return 1;	/* Default location */
@@ -2740,7 +2740,7 @@ static int __init init_ext3_fs(void)
 out:
 	destroy_inodecache();
 out1:
- 	exit_ext3_xattr();
+	exit_ext3_xattr();
 	return err;
 }
 
diff -Nurp linux000/fs/jbd/checkpoint.c linux001/fs/jbd/checkpoint.c
--- linux000/fs/jbd/checkpoint.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/jbd/checkpoint.c	2006-09-08 16:25:07.000000000 -0500
@@ -480,7 +480,7 @@ static int journal_clean_one_cp_list(str
 	if (!jh)
 		return 0;
 
- 	last_jh = jh->b_cpprev;
+	last_jh = jh->b_cpprev;
 	do {
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
diff -Nurp linux000/fs/jbd/journal.c linux001/fs/jbd/journal.c
--- linux000/fs/jbd/journal.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/jbd/journal.c	2006-09-08 16:25:07.000000000 -0500
@@ -181,7 +181,7 @@ loop:
 						transaction->t_expires))
 			should_sleep = 0;
 		if (journal->j_flags & JFS_UNMOUNT)
- 			should_sleep = 0;
+			should_sleep = 0;
 		if (should_sleep) {
 			spin_unlock(&journal->j_state_lock);
 			schedule();
diff -Nurp linux000/fs/jbd/recovery.c linux001/fs/jbd/recovery.c
--- linux000/fs/jbd/recovery.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/jbd/recovery.c	2006-09-08 16:25:07.000000000 -0500
@@ -314,7 +314,7 @@ static int do_one_pass(journal_t *journa
 	unsigned long		next_log_block;
 	int			err, success = 0;
 	journal_superblock_t *	sb;
-	journal_header_t * 	tmp;
+	journal_header_t *	tmp;
 	struct buffer_head *	bh;
 	unsigned int		sequence;
 	int			blocktype;
diff -Nurp linux000/fs/jbd/transaction.c linux001/fs/jbd/transaction.c
--- linux000/fs/jbd/transaction.c	2006-09-08 07:24:23.000000000 -0500
+++ linux001/fs/jbd/transaction.c	2006-09-08 16:25:07.000000000 -0500
@@ -580,7 +580,7 @@ repeat:
 		 */
 		JBUFFER_TRACE(jh, "Unexpected dirty buffer");
 		jbd_unexpected_dirty_buffer(jh);
- 	}
+	}
 
 	unlock_buffer(bh);
 
@@ -1373,7 +1373,7 @@ int journal_stop(handle_t *handle)
 	if (handle->h_sync ||
 			transaction->t_outstanding_credits >
 				journal->j_max_transaction_buffers ||
-	    		time_after_eq(jiffies, transaction->t_expires)) {
+			time_after_eq(jiffies, transaction->t_expires)) {
 		/* Do this even for aborted journals: an abort still
 		 * completes the commit thread, it just doesn't write
 		 * anything to disk. */
@@ -1908,7 +1908,7 @@ void journal_invalidatepage(journal_t *j
 		next = bh->b_this_page;
 
 		if (offset <= curr_off) {
-		 	/* This block is wholly outside the truncation point */
+			/* This block is wholly outside the truncation point */
 			lock_buffer(bh);
 			may_free &= journal_unmap_buffer(journal, bh);
 			unlock_buffer(bh);
diff -Nurp linux000/include/linux/ext3_fs.h linux001/include/linux/ext3_fs.h
--- linux000/include/linux/ext3_fs.h	2006-09-08 07:24:30.000000000 -0500
+++ linux001/include/linux/ext3_fs.h	2006-09-08 16:25:07.000000000 -0500
@@ -494,7 +494,7 @@ struct ext3_super_block {
 	__u8	s_reserved_char_pad;
 	__u16	s_reserved_word_pad;
 	__le32	s_default_mount_opts;
-	__le32	s_first_meta_bg; 	/* First metablock block group */
+	__le32	s_first_meta_bg;	/* First metablock block group */
 	__u32	s_reserved[190];	/* Padding to the end of the block */
 };
 
diff -Nurp linux000/include/linux/ext3_fs_i.h linux001/include/linux/ext3_fs_i.h
--- linux000/include/linux/ext3_fs_i.h	2006-09-08 07:23:29.000000000 -0500
+++ linux001/include/linux/ext3_fs_i.h	2006-09-08 16:25:07.000000000 -0500
@@ -35,7 +35,7 @@ struct ext3_reserve_window {
 };
 
 struct ext3_reserve_window_node {
-	struct rb_node	 	rsv_node;
+	struct rb_node		rsv_node;
 	__u32			rsv_goal_size;
 	__u32			rsv_alloc_hit;
 	struct ext3_reserve_window	rsv_window;
diff -Nurp linux000/include/linux/jbd.h linux001/include/linux/jbd.h
--- linux000/include/linux/jbd.h	2006-09-08 07:24:30.000000000 -0500
+++ linux001/include/linux/jbd.h	2006-09-08 16:25:07.000000000 -0500
@@ -64,7 +64,7 @@ extern int journal_enable_debug;
 		if ((n) <= journal_enable_debug) {			\
 			printk (KERN_DEBUG "(%s, %d): %s: ",		\
 				__FILE__, __LINE__, __FUNCTION__);	\
-		  	printk (f, ## a);				\
+			printk (f, ## a);				\
 		}							\
 	} while (0)
 #else
@@ -201,9 +201,9 @@ typedef struct journal_superblock_s
 
 /* 0x0024 */
 	/* Remaining fields are only valid in a version-2 superblock */
-	__be32	s_feature_compat; 	/* compatible feature set */
-	__be32	s_feature_incompat; 	/* incompatible feature set */
-	__be32	s_feature_ro_compat; 	/* readonly-compatible feature set */
+	__be32	s_feature_compat;	/* compatible feature set */
+	__be32	s_feature_incompat;	/* incompatible feature set */
+	__be32	s_feature_ro_compat;	/* readonly-compatible feature set */
 /* 0x0030 */
 	__u8	s_uuid[16];		/* 128-bit uuid for journal */
 
@@ -699,7 +699,7 @@ struct journal_s
 	wait_queue_head_t	j_wait_updates;
 
 	/* Semaphore for locking against concurrent checkpoints */
-	struct mutex	 	j_checkpoint_mutex;
+	struct mutex		j_checkpoint_mutex;
 
 	/*
 	 * Journal head: identifies the first unused block in the journal.

-- 
David Kleikamp
IBM Linux Technology Center
