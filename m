Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268621AbTBZCwS>; Tue, 25 Feb 2003 21:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268620AbTBZCvJ>; Tue, 25 Feb 2003 21:51:09 -0500
Received: from [24.77.48.240] ([24.77.48.240]:25401 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268626AbTBZCut>;
	Tue, 25 Feb 2003 21:50:49 -0500
Date: Tue, 25 Feb 2003 19:01:09 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302260301.h1Q319B07255@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - invocation
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    invokation -> invocation

Fixes 6 occurrences in all.

diff -ur a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Mon Feb 24 11:05:34 2003
+++ b/fs/buffer.c	Tue Feb 25 17:50:42 2003
@@ -2495,7 +2495,7 @@
 
 	/*
 	 * The page straddles i_size.  It must be zeroed out on each and every
-	 * writepage invokation because it may be mmapped.  "A file is mapped
+	 * writepage invocation because it may be mmapped.  "A file is mapped
 	 * in multiples of the page size.  For a file that is not a multiple of
 	 * the  page size, the remaining memory is zeroed when mapped, and
 	 * writes to that region are not written out to the file."
diff -ur a/fs/direct-io.c b/fs/direct-io.c
--- a/fs/direct-io.c	Mon Feb 24 11:05:34 2003
+++ b/fs/direct-io.c	Tue Feb 25 17:50:46 2003
@@ -42,7 +42,7 @@
 /*
  * This code generally works in units of "dio_blocks".  A dio_block is
  * somewhere between the hard sector size and the filesystem block size.  it
- * is determined on a per-invokation basis.   When talking to the filesystem
+ * is determined on a per-invocation basis.   When talking to the filesystem
  * we need to convert dio_blocks to fs_blocks by scaling the dio_block quantity
  * down by dio->blkfactor.  Similarly, fs-blocksize quantities are converted
  * to bio_block quantities by shifting left by blkfactor.
diff -ur a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Mon Feb 24 11:05:39 2003
+++ b/fs/ntfs/aops.c	Tue Feb 25 17:50:50 2003
@@ -942,7 +942,7 @@
 	 * the below memcpy() already takes care of the mmap-at-end-of-file
 	 * requirements. If the file is converted to a non-resident one, then
 	 * the code path use is switched to the non-resident one where the
-	 * zeroing happens on each ntfs_writepage() invokation.
+	 * zeroing happens on each ntfs_writepage() invocation.
 	 *
 	 * The above also applies nicely when i_size is decreased.
 	 *
diff -ur a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Mon Feb 24 11:05:37 2003
+++ b/fs/ntfs/mft.c	Tue Feb 25 17:50:55 2003
@@ -202,7 +202,7 @@
  * records/inodes present in the page before I/O can proceed. In that case we
  * wouldn't need to bother with PG_locked and PG_uptodate as nobody will be
  * accessing anything without owning the mrec_lock semaphore. But we do need
- * to use them because of the read_cache_page() invokation and the code becomes
+ * to use them because of the read_cache_page() invocation and the code becomes
  * so much simpler this way that it is well worth it.
  *
  * The mft record is now ours and we return a pointer to it. You need to check
diff -ur a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	Mon Feb 24 11:05:10 2003
+++ b/include/asm-i386/uaccess.h	Tue Feb 25 17:50:58 2003
@@ -258,7 +258,7 @@
 unsigned long __copy_from_user_ll(void *to, const void *from, unsigned long n);
 
 /*
- * Here we special-case 1, 2 and 4-byte copy_*_user invokations.  On a fault
+ * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
  * we return the initial request size (1, 2 or 4), as copy_*_user should do.
  * If a store crosses a page boundary and gets a fault, the x86 will not write
  * anything, so this is accurate.
diff -ur a/sound/core/device.c b/sound/core/device.c
--- a/sound/core/device.c	Mon Feb 24 11:05:34 2003
+++ b/sound/core/device.c	Tue Feb 25 17:51:07 2003
@@ -144,7 +144,7 @@
  * Registers the device which was already created via
  * snd_device_new().  Usually this is called from snd_card_register(),
  * but it can be called later if any new devices are created after
- * invokation of snd_card_register().
+ * invocation of snd_card_register().
  *
  * Returns zero if successful, or a negative error code on failure or if the
  * device not found.
