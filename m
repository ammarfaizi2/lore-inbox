Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbSJCFPk>; Thu, 3 Oct 2002 01:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbSJCFPk>; Thu, 3 Oct 2002 01:15:40 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:37303 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262733AbSJCFPL>; Thu, 3 Oct 2002 01:15:11 -0400
From: <peterc@gelato.unsw.edu.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 15:20:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15771.54176.801541.208418@lemon.gelato.unsw.EDU.AU>
Subject: [PATCH] Large Block device patch part 4/4
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch can be picked up from http://www.gelato.unsw.edu.au or from
the bk repository at bk://gelato.unsw.edu.au:2023
See part 0/4 for details.

 drivers/block/Config.help    |    4 ++++
 drivers/block/Config.in      |    3 +++
 drivers/block/paride/pf.c    |    2 +-
 drivers/block/ps2esdi.c      |    4 ++--
 drivers/ide/ide-floppy.c     |    5 +++--
 drivers/mtd/devices/blkmtd.c |    6 +++---
 fs/adfs/inode.c              |    2 +-
 fs/affs/file.c               |   13 +++++++------
 fs/affs/inode.c              |    2 +-
 fs/bfs/file.c                |    2 +-
 fs/buffer.c                  |    8 ++++----
 fs/efs/inode.c               |    2 +-
 fs/ext2/inode.c              |    2 +-
 fs/ext3/ialloc.c             |    2 +-
 fs/ext3/inode.c              |    2 +-
 fs/fat/file.c                |    2 +-
 fs/fat/inode.c               |    2 +-
 fs/freevxfs/vxfs_subr.c      |    6 +++---
 fs/hfs/inode.c               |    2 +-
 fs/hpfs/file.c               |    2 +-
 fs/inode.c                   |    4 ++--
 fs/isofs/inode.c             |    6 +++---
 fs/jfs/inode.c               |    2 +-
 fs/minix/inode.c             |    2 +-
 fs/qnx4/inode.c              |    2 +-
 fs/reiserfs/inode.c          |    2 +-
 fs/sysv/itree.c              |    2 +-
 fs/udf/inode.c               |    2 +-
 fs/ufs/inode.c               |    2 +-
 fs/xfs/linux/xfs_aops.c      |    5 +++--
 include/asm-i386/types.h     |    5 +++++
 include/asm-ppc/types.h      |    5 +++++
 include/linux/fs.h           |    6 +++---
 include/linux/iso_fs.h       |    2 +-
 include/linux/types.h        |   10 ++++------
 35 files changed, 74 insertions(+), 56 deletions(-)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.673   -> 1.677  
#	      fs/jfs/inode.c	1.18    -> 1.19   
#	drivers/block/ps2esdi.c	1.51    -> 1.52   
#	include/asm-i386/types.h	1.2     -> 1.3    
#	drivers/mtd/devices/blkmtd.c	1.18    -> 1.20   
#	     fs/ext2/inode.c	1.43    -> 1.44   
#	       fs/bfs/file.c	1.11    -> 1.12   
#	      fs/ufs/inode.c	1.14    -> 1.15   
#	  include/linux/fs.h	1.165   -> 1.166  
#	       fs/fat/file.c	1.16    -> 1.17   
#	drivers/block/Config.in	1.7     -> 1.8    
#	     fs/sysv/itree.c	1.13    -> 1.14   
#	fs/freevxfs/vxfs_subr.c	1.9     -> 1.10   
#	     fs/adfs/inode.c	1.14    -> 1.15   
#	     fs/qnx4/inode.c	1.21    -> 1.22   
#	 fs/reiserfs/inode.c	1.66    -> 1.67   
#	include/linux/types.h	1.4     -> 1.5    
#	      fs/efs/inode.c	1.6     -> 1.7    
#	      fs/hpfs/file.c	1.10    -> 1.11   
#	      fs/fat/inode.c	1.43    -> 1.44   
#	     fs/affs/inode.c	1.15    -> 1.16   
#	      fs/affs/file.c	1.21    -> 1.22   
#	drivers/ide/ide-floppy.c	1.15    -> 1.16   
#	    fs/ext3/ialloc.c	1.15    -> 1.16   
#	    fs/minix/inode.c	1.27    -> 1.28   
#	drivers/block/Config.help	1.2     -> 1.3    
#	         fs/buffer.c	1.153   -> 1.154  
#	include/linux/iso_fs.h	1.8     -> 1.9    
#	     fs/ext3/inode.c	1.39    -> 1.40   
#	drivers/block/paride/pf.c	1.30    -> 1.31   
#	include/asm-ppc/types.h	1.5     -> 1.6    
#	fs/xfs/linux/xfs_aops.c	1.7     -> 1.8    
#	    fs/isofs/inode.c	1.25    -> 1.26   
#	          fs/inode.c	1.69    -> 1.70   
#	      fs/hfs/inode.c	1.8     -> 1.9    
#	      fs/udf/inode.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.674
# Filesystem migration to possibly 64-bit sector_t:
# -- bmap() now takes and returns a sector_t to allow filesystems 
#    (e.g., JFS, XFS) that are 64-bit clean to deal with large files
# -- buffer handling now 64-bit clean
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.675
# Enable 64-bit sector_t on IA32 and PPC.
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.676
# kiobufs takes sector_t array, not array of long.
# FIx blkmtd.c to deal in such an array.
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.677
# Miscellaneous fixes for 64-bit sector_t.
# 	-- missed printk formats
# 	-- ide_floppy_do_request had incorrect signature
# 	-- in blkmtd.c there was a pointer used to 
# 	   manipulate an array to be used by kiobuf --
#  	   it was unsigned long, needed to be sector_t
# --------------------------------------------
#
diff -Nru a/drivers/block/Config.help b/drivers/block/Config.help
--- a/drivers/block/Config.help	Thu Oct  3 15:06:06 2002
+++ b/drivers/block/Config.help	Thu Oct  3 15:06:06 2002
@@ -258,3 +258,7 @@
   supported by this driver, and for further information on the use of
   this driver.
 
+CONFIG_LBD
+  Say Y here if you want to attach large (bigger than 2TB) discs to
+  your machine, or if you want to have a raid or loopback device
+  bigger than 2TB.  Otherwise say N.
diff -Nru a/drivers/block/Config.in b/drivers/block/Config.in
--- a/drivers/block/Config.in	Thu Oct  3 15:06:06 2002
+++ b/drivers/block/Config.in	Thu Oct  3 15:06:06 2002
@@ -48,4 +48,7 @@
 fi
 dep_bool '  Initial RAM disk (initrd) support' CONFIG_BLK_DEV_INITRD $CONFIG_BLK_DEV_RAM
 
+if [ "$CONFIG_X86" = "y" -o "$CONFIG_PPC32" = "y" ]; then
+   bool 'Support for Large Block Devices' CONFIG_LBD
+fi
 endmenu
diff -Nru a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
--- a/drivers/block/paride/pf.c	Thu Oct  3 15:06:06 2002
+++ b/drivers/block/paride/pf.c	Thu Oct  3 15:06:06 2002
@@ -687,7 +687,7 @@
 	else {
 		if (pf->media_status == PF_RO)
 			printk(", RO");
-		printk(", %ld blocks\n", get_capacity(&pf->disk));
+		printk(", %llu blocks\n", (unsigned long long)get_capacity(&pf->disk));
 	}
 	return 0;
 }
diff -Nru a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
--- a/drivers/block/ps2esdi.c	Thu Oct  3 15:06:06 2002
+++ b/drivers/block/ps2esdi.c	Thu Oct  3 15:06:06 2002
@@ -532,8 +532,8 @@
 	}
 	/* is request is valid */ 
 	else {
-		printk("Grrr. error. ps2esdi_drives: %d, %lu %llu\n", ps2esdi_drives,
-		       CURRENT->sector, (unsigned long long)get_capacity(&ps2esdi_gendisk[unit]));
+		printk("Grrr. error. ps2esdi_drives: %d, %llu %llu\n", ps2esdi_drives,
+		       (unsigned long long)CURRENT->sector, (unsigned long long)get_capacity(&ps2esdi_gendisk[unit]));
 		end_request(CURRENT, FAIL);
 	}
 
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	Thu Oct  3 15:06:06 2002
+++ b/drivers/ide/ide-floppy.c	Thu Oct  3 15:06:06 2002
@@ -1241,17 +1241,18 @@
 /*
  *	idefloppy_do_request is our request handling function.	
  */
-static ide_startstop_t idefloppy_do_request (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t idefloppy_do_request (ide_drive_t *drive, struct request *rq, sector_t block_s)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_pc_t *pc;
+	unsigned long block = (unsigned long)block_s;
 
 #if IDEFLOPPY_DEBUG_LOG
 	printk(KERN_INFO "rq_status: %d, rq_dev: %u, flags: %lx, errors: %d\n",
 			rq->rq_status, (unsigned int) rq->rq_dev,
 			rq->flags, rq->errors);
 	printk(KERN_INFO "sector: %ld, nr_sectors: %ld, "
-			"current_nr_sectors: %ld\n", rq->sector,
+			"current_nr_sectors: %ld\n", (long)rq->sector,
 			rq->nr_sectors, rq->current_nr_sectors);
 #endif /* IDEFLOPPY_DEBUG_LOG */
 
diff -Nru a/drivers/mtd/devices/blkmtd.c b/drivers/mtd/devices/blkmtd.c
--- a/drivers/mtd/devices/blkmtd.c	Thu Oct  3 15:06:06 2002
+++ b/drivers/mtd/devices/blkmtd.c	Thu Oct  3 15:06:06 2002
@@ -164,7 +164,7 @@
   int err;
   int sectornr, sectors, i;
   struct kiobuf *iobuf;
-  unsigned long *blocks;
+  sector_t *blocks;
 
   if(!rawdevice) {
     printk("blkmtd: readpage: PANIC file->private_data == NULL\n");
@@ -223,7 +223,7 @@
 
   /* Pre 2.4.4 doesn't have space for the block list in the kiobuf */ 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-  blocks = kmalloc(KIO_MAX_SECTORS * sizeof(unsigned long));
+  blocks = kmalloc(KIO_MAX_SECTORS * sizeof(*blocks));
   if(blocks == NULL) {
     printk("blkmtd: cant allocate iobuf blocks\n");
     free_kiovec(1, &iobuf);
@@ -298,7 +298,7 @@
   int err;
   struct task_struct *tsk = current;
   struct kiobuf *iobuf;
-  unsigned long *blocks;
+  sector_t *blocks;
 
   DECLARE_WAITQUEUE(wait, tsk);
   DEBUG(1, "blkmtd: writetask: starting (pid = %d)\n", tsk->pid);
diff -Nru a/fs/adfs/inode.c b/fs/adfs/inode.c
--- a/fs/adfs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/adfs/inode.c	Thu Oct  3 15:06:06 2002
@@ -67,7 +67,7 @@
 		&ADFS_I(page->mapping->host)->mmu_private);
 }
 
-static int _adfs_bmap(struct address_space *mapping, long block)
+static sector_t _adfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, adfs_get_block);
 }
diff -Nru a/fs/affs/file.c b/fs/affs/file.c
--- a/fs/affs/file.c	Thu Oct  3 15:06:06 2002
+++ b/fs/affs/file.c	Thu Oct  3 15:06:06 2002
@@ -338,10 +338,11 @@
 	struct buffer_head	*ext_bh;
 	u32			 ext;
 
-	pr_debug("AFFS: get_block(%u, %ld)\n", (u32)inode->i_ino, block);
+	pr_debug("AFFS: get_block(%u, %lu)\n", (u32)inode->i_ino, (unsigned long)block);
 
-	if (block < 0)
-		goto err_small;
+
+	if (block > (sector_t)0x7fffffffUL)
+		BUG();
 
 	if (block >= AFFS_I(inode)->i_blkcnt) {
 		if (block > AFFS_I(inode)->i_blkcnt || !create)
@@ -352,12 +353,12 @@
 	//lock cache
 	affs_lock_ext(inode);
 
-	ext = block / AFFS_SB(sb)->s_hashsize;
+	ext = (u32)block / AFFS_SB(sb)->s_hashsize;
 	block -= ext * AFFS_SB(sb)->s_hashsize;
 	ext_bh = affs_get_extblock(inode, ext);
 	if (IS_ERR(ext_bh))
 		goto err_ext;
-	map_bh(bh_result, sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, block)));
+	map_bh(bh_result, sb, (sector_t)be32_to_cpu(AFFS_BLOCK(sb, ext_bh, block)));
 
 	if (create) {
 		u32 blocknr = affs_alloc_block(inode, ext_bh->b_blocknr);
@@ -422,7 +423,7 @@
 	return cont_prepare_write(page, from, to, affs_get_block,
 		&AFFS_I(page->mapping->host)->mmu_private);
 }
-static int _affs_bmap(struct address_space *mapping, long block)
+static sector_t _affs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,affs_get_block);
 }
diff -Nru a/fs/affs/inode.c b/fs/affs/inode.c
--- a/fs/affs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/affs/inode.c	Thu Oct  3 15:06:06 2002
@@ -416,7 +416,7 @@
 	}
 	affs_fix_checksum(sb, bh);
 	mark_buffer_dirty_inode(bh, inode);
-	dentry->d_fsdata = (void *)bh->b_blocknr;
+	dentry->d_fsdata = (void *)(long)bh->b_blocknr;
 
 	affs_lock_dir(dir);
 	retval = affs_insert_hash(dir, bh);
diff -Nru a/fs/bfs/file.c b/fs/bfs/file.c
--- a/fs/bfs/file.c	Thu Oct  3 15:06:06 2002
+++ b/fs/bfs/file.c	Thu Oct  3 15:06:06 2002
@@ -145,7 +145,7 @@
 	return block_prepare_write(page, from, to, bfs_get_block);
 }
 
-static int bfs_bmap(struct address_space *mapping, long block)
+static sector_t bfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, bfs_get_block);
 }
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Thu Oct  3 15:06:06 2002
+++ b/fs/buffer.c	Thu Oct  3 15:06:06 2002
@@ -1828,7 +1828,7 @@
 		unsigned from, unsigned to, get_block_t *get_block)
 {
 	unsigned block_start, block_end;
-	unsigned long block;
+	sector_t block;
 	int err = 0;
 	unsigned blocksize, bbits;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
@@ -1844,7 +1844,7 @@
 	head = page_buffers(page);
 
 	bbits = inode->i_blkbits;
-	block = page->index << (PAGE_CACHE_SHIFT - bbits);
+	block = (sector_t)page->index << (PAGE_CACHE_SHIFT - bbits);
 
 	for(bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {
@@ -1985,7 +1985,7 @@
 int block_read_full_page(struct page *page, get_block_t *get_block)
 {
 	struct inode *inode = page->mapping->host;
-	unsigned long iblock, lblock;
+	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, blocks;
 	int nr, i;
@@ -2000,7 +2000,7 @@
 	head = page_buffers(page);
 
 	blocks = PAGE_CACHE_SIZE >> inode->i_blkbits;
-	iblock = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	iblock = (sector_t)page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
 	lblock = (inode->i_size+blocksize-1) >> inode->i_blkbits;
 	bh = head;
 	nr = 0;
diff -Nru a/fs/efs/inode.c b/fs/efs/inode.c
--- a/fs/efs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/efs/inode.c	Thu Oct  3 15:06:06 2002
@@ -19,7 +19,7 @@
 {
 	return block_read_full_page(page,efs_get_block);
 }
-static int _efs_bmap(struct address_space *mapping, long block)
+static sector_t _efs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,efs_get_block);
 }
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/ext2/inode.c	Thu Oct  3 15:06:06 2002
@@ -601,7 +601,7 @@
 	return block_prepare_write(page,from,to,ext2_get_block);
 }
 
-static int ext2_bmap(struct address_space *mapping, long block)
+static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
diff -Nru a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c	Thu Oct  3 15:06:06 2002
+++ b/fs/ext3/ialloc.c	Thu Oct  3 15:06:06 2002
@@ -479,7 +479,7 @@
 			!(inode = iget(sb, ino)) || is_bad_inode(inode) ||
 			NEXT_ORPHAN(inode) > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan inode %lu!  e2fsck was run?\n", ino);
+			     "bad orphan inode %lu!  e2fsck was run?\n", (unsigned long)ino);
 		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%llu) = %d\n",
 		       bit, 
 			(unsigned long long)bitmap_bh->b_blocknr, 
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/ext3/inode.c	Thu Oct  3 15:06:06 2002
@@ -1181,7 +1181,7 @@
  * So, if we see any bmap calls here on a modified, data-journaled file,
  * take extra steps to flush any blocks which might be in the cache. 
  */
-static int ext3_bmap(struct address_space *mapping, long block)
+static sector_t ext3_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	journal_t *journal;
diff -Nru a/fs/fat/file.c b/fs/fat/file.c
--- a/fs/fat/file.c	Thu Oct  3 15:06:06 2002
+++ b/fs/fat/file.c	Thu Oct  3 15:06:06 2002
@@ -59,7 +59,7 @@
 		BUG();
 		return -EIO;
 	}
-	if (!(iblock % MSDOS_SB(sb)->cluster_size)) {
+	if (!((unsigned long)iblock % MSDOS_SB(sb)->cluster_size)) {
 		int error;
 
 		error = fat_add_cluster(inode);
diff -Nru a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/fat/inode.c	Thu Oct  3 15:06:06 2002
@@ -1000,7 +1000,7 @@
 	return generic_commit_write(file, page, from, to);
 }
 
-static int _fat_bmap(struct address_space *mapping, long block)
+static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,fat_get_block);
 }
diff -Nru a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
--- a/fs/freevxfs/vxfs_subr.c	Thu Oct  3 15:06:06 2002
+++ b/fs/freevxfs/vxfs_subr.c	Thu Oct  3 15:06:06 2002
@@ -43,7 +43,7 @@
 
 
 static int		vxfs_readpage(struct file *, struct page *);
-static int		vxfs_bmap(struct address_space *, long);
+static sector_t		vxfs_bmap(struct address_space *, sector_t);
 
 struct address_space_operations vxfs_aops = {
 	.readpage =		vxfs_readpage,
@@ -186,8 +186,8 @@
  * Locking status:
  *   We are under the bkl.
  */
-static int
-vxfs_bmap(struct address_space *mapping, long block)
+static sector_t
+vxfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, vxfs_getblk);
 }
diff -Nru a/fs/hfs/inode.c b/fs/hfs/inode.c
--- a/fs/hfs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/hfs/inode.c	Thu Oct  3 15:06:06 2002
@@ -242,7 +242,7 @@
 	return cont_prepare_write(page,from,to,hfs_get_block,
 		&HFS_I(page->mapping->host)->mmu_private);
 }
-static int hfs_bmap(struct address_space *mapping, long block)
+static sector_t hfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,hfs_get_block);
 }
diff -Nru a/fs/hpfs/file.c b/fs/hpfs/file.c
--- a/fs/hpfs/file.c	Thu Oct  3 15:06:06 2002
+++ b/fs/hpfs/file.c	Thu Oct  3 15:06:06 2002
@@ -111,7 +111,7 @@
 	return cont_prepare_write(page,from,to,hpfs_get_block,
 		&hpfs_i(page->mapping->host)->mmu_private);
 }
-static int _hpfs_bmap(struct address_space *mapping, long block)
+static sector_t _hpfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,hpfs_get_block);
 }
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/inode.c	Thu Oct  3 15:06:06 2002
@@ -905,9 +905,9 @@
  *	file.
  */
  
-int bmap(struct inode * inode, int block)
+sector_t bmap(struct inode * inode, sector_t block)
 {
-	int res = 0;
+	sector_t res = 0;
 	if (inode->i_mapping->a_ops->bmap)
 		res = inode->i_mapping->a_ops->bmap(inode->i_mapping, block);
 	return res;
diff -Nru a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/isofs/inode.c	Thu Oct  3 15:06:06 2002
@@ -1045,9 +1045,9 @@
 	return 0;
 }
 
-struct buffer_head *isofs_bread(struct inode *inode, unsigned int block)
+struct buffer_head *isofs_bread(struct inode *inode, sector_t block)
 {
-	unsigned int blknr = isofs_bmap(inode, block);
+	sector_t blknr = isofs_bmap(inode, block);
 	if (!blknr)
 		return NULL;
 	return sb_bread(inode->i_sb, blknr);
@@ -1058,7 +1058,7 @@
 	return block_read_full_page(page,isofs_get_block);
 }
 
-static int _isofs_bmap(struct address_space *mapping, long block)
+static sector_t _isofs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,isofs_get_block);
 }
diff -Nru a/fs/jfs/inode.c b/fs/jfs/inode.c
--- a/fs/jfs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/jfs/inode.c	Thu Oct  3 15:06:06 2002
@@ -305,7 +305,7 @@
 	return block_prepare_write(page, from, to, jfs_get_block);
 }
 
-static int jfs_bmap(struct address_space *mapping, long block)
+static sector_t jfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
diff -Nru a/fs/minix/inode.c b/fs/minix/inode.c
--- a/fs/minix/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/minix/inode.c	Thu Oct  3 15:06:06 2002
@@ -328,7 +328,7 @@
 {
 	return block_prepare_write(page,from,to,minix_get_block);
 }
-static int minix_bmap(struct address_space *mapping, long block)
+static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,minix_get_block);
 }
diff -Nru a/fs/qnx4/inode.c b/fs/qnx4/inode.c
--- a/fs/qnx4/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/qnx4/inode.c	Thu Oct  3 15:06:06 2002
@@ -444,7 +444,7 @@
 	return cont_prepare_write(page, from, to, qnx4_get_block,
 				  &qnx4_inode->mmu_private);
 }
-static int qnx4_bmap(struct address_space *mapping, long block)
+static sector_t qnx4_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,qnx4_get_block);
 }
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/reiserfs/inode.c	Thu Oct  3 15:06:06 2002
@@ -2029,7 +2029,7 @@
 }
 
 
-static int reiserfs_aop_bmap(struct address_space *as, long block) {
+static sector_t reiserfs_aop_bmap(struct address_space *as, sector_t block) {
   return generic_block_bmap(as, block, reiserfs_bmap) ;
 }
 
diff -Nru a/fs/sysv/itree.c b/fs/sysv/itree.c
--- a/fs/sysv/itree.c	Thu Oct  3 15:06:06 2002
+++ b/fs/sysv/itree.c	Thu Oct  3 15:06:06 2002
@@ -459,7 +459,7 @@
 {
 	return block_prepare_write(page,from,to,get_block);
 }
-static int sysv_bmap(struct address_space *mapping, long block)
+static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,get_block);
 }
diff -Nru a/fs/udf/inode.c b/fs/udf/inode.c
--- a/fs/udf/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/udf/inode.c	Thu Oct  3 15:06:06 2002
@@ -146,7 +146,7 @@
 	return block_prepare_write(page, from, to, udf_get_block);
 }
 
-static int udf_bmap(struct address_space *mapping, long block)
+static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,udf_get_block);
 }
diff -Nru a/fs/ufs/inode.c b/fs/ufs/inode.c
--- a/fs/ufs/inode.c	Thu Oct  3 15:06:06 2002
+++ b/fs/ufs/inode.c	Thu Oct  3 15:06:06 2002
@@ -457,7 +457,7 @@
 {
 	return block_prepare_write(page,from,to,ufs_getfrag_block);
 }
-static int ufs_bmap(struct address_space *mapping, long block)
+static sector_t ufs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,ufs_getfrag_block);
 }
diff -Nru a/fs/xfs/linux/xfs_aops.c b/fs/xfs/linux/xfs_aops.c
--- a/fs/xfs/linux/xfs_aops.c	Thu Oct  3 15:06:06 2002
+++ b/fs/xfs/linux/xfs_aops.c	Thu Oct  3 15:06:06 2002
@@ -690,10 +690,11 @@
 					linvfs_get_blocks_direct);
 }
 
-STATIC int
+
+STATIC sector_t
 linvfs_bmap(
 	struct address_space	*mapping,
-	long			block)
+	sector_t		block)
 {
 	struct inode		*inode = (struct inode *)mapping->host;
 	vnode_t			*vp = LINVFS_GET_VP(inode);
diff -Nru a/include/asm-i386/types.h b/include/asm-i386/types.h
--- a/include/asm-i386/types.h	Thu Oct  3 15:06:06 2002
+++ b/include/asm-i386/types.h	Thu Oct  3 15:06:06 2002
@@ -52,6 +52,11 @@
 #endif
 typedef u64 dma64_addr_t;
 
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#define HAVE_SECTOR_T
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -Nru a/include/asm-ppc/types.h b/include/asm-ppc/types.h
--- a/include/asm-ppc/types.h	Thu Oct  3 15:06:06 2002
+++ b/include/asm-ppc/types.h	Thu Oct  3 15:06:06 2002
@@ -45,6 +45,11 @@
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#define HAVE_SECTOR_T
+#endif
+
 #endif /* __KERNEL__ */
 
 /*
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Thu Oct  3 15:06:06 2002
+++ b/include/linux/fs.h	Thu Oct  3 15:06:06 2002
@@ -305,7 +305,7 @@
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
-	int (*bmap)(struct address_space *, long);
+	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
 	int (*direct_IO)(int, struct inode *, const struct iovec *iov, loff_t offset, unsigned long nr_segs);
@@ -355,7 +355,7 @@
 	int			bd_holders;
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
-	unsigned long		bd_offset;
+	sector_t		bd_offset;
 	unsigned		bd_part_count;
 	int			bd_invalidated;
 };
@@ -1146,7 +1146,7 @@
 extern int filemap_fdatawrite(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
-extern int bmap(struct inode *, int);
+extern sector_t bmap(struct inode *, sector_t);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
 extern int vfs_permission(struct inode *, int);
diff -Nru a/include/linux/iso_fs.h b/include/linux/iso_fs.h
--- a/include/linux/iso_fs.h	Thu Oct  3 15:06:06 2002
+++ b/include/linux/iso_fs.h	Thu Oct  3 15:06:06 2002
@@ -230,7 +230,7 @@
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
 extern struct dentry *isofs_lookup(struct inode *, struct dentry *);
-extern struct buffer_head *isofs_bread(struct inode *, unsigned int);
+extern struct buffer_head *isofs_bread(struct inode *, sector_t);
 extern int isofs_get_blocks(struct inode *, sector_t, struct buffer_head **, unsigned long);
 
 extern struct inode_operations isofs_dir_inode_operations;
diff -Nru a/include/linux/types.h b/include/linux/types.h
--- a/include/linux/types.h	Thu Oct  3 15:06:06 2002
+++ b/include/linux/types.h	Thu Oct  3 15:06:06 2002
@@ -117,13 +117,11 @@
 #endif
 
 /*
- * transition to 64-bit sector_t, possibly making it an option...
+ * The type used for indexing onto a disc or disc partition.
+ * If required, asm/types.h can override it and define
+ * HAVE_SECTOR_T
  */
-#undef BLK_64BIT_SECTOR
-
-#ifdef BLK_64BIT_SECTOR
-typedef u64 sector_t;
-#else
+#ifndef HAVE_SECTOR_T
 typedef unsigned long sector_t;
 #endif
 
