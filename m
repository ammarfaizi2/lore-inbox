Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269674AbRHQEwW>; Fri, 17 Aug 2001 00:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269676AbRHQEwO>; Fri, 17 Aug 2001 00:52:14 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5936 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269674AbRHQEwB>; Fri, 17 Aug 2001 00:52:01 -0400
Date: Fri, 17 Aug 2001 06:52:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9aa1
Message-ID: <20010817065224.B830@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.8aa1: 00_alpha-ds20l-support-1
Only in 2.4.8aa1: 00_alpha-illegal-irq-1
Only in 2.4.8aa1: 00_alpha-illop-1
Only in 2.4.8aa1: 00_alpha-iommu_fixup-1
Only in 2.4.8aa1: 00_alpha-mips-rtc-1
Only in 2.4.8aa1: 00_alpha-numa-initrd-1
Only in 2.4.8aa1: 00_alpha-sg_fill-1
Only in 2.4.8aa1: 00_alpha-smp_tune_scheduling-1
Only in 2.4.8aa1: 00_alpha-srm-2.4.6-pre1-1
Only in 2.4.8aa1: 00_drm_vm-1
Only in 2.4.8aa1: 00_module-oops-1
Only in 2.4.8aa1: 00_rawio-down_read-1

	Merged in mainline.

Only in 2.4.8aa1: 00_3c59x-zerocopy-2
Only in 2.4.9aa1: 00_3c59x-zerocopy-3

	Rediffed. The highlevel will take care to linearize
	(bounce) when needed at runtime when highmem is enabled.

Only in 2.4.9aa1: 00_alpha-pc_keyb-1

	Fixed compilation trouble on alpha.

Only in 2.4.8aa1: 00_cachelinealigned-in-smp-1
Only in 2.4.9aa1: 00_cachelinealigned-in-smp-2

	Rediffed for trivial rejects.

Only in 2.4.8aa1: 00_create_bounces-sleeps-1

	Dropped, alternate patch is in mainline (seems we want to avoid kmap
	when we don't sleep).

Only in 2.4.8aa1: 00_debug-vm-lru-mm-corruption-1

	Dropped (it was random memory corruption, probably not related to the
	vm but related to the eepro100 driver).

Only in 2.4.9aa1: 00_lvm-0.9.1_beta7-6_min-1

	Fixed compilation trouble.

Only in 2.4.8aa1: 00_o_direct-12
Only in 2.4.9aa1: 00_o_direct-13

	Fixed a some minor bug about negative count, reads beyond the end of
	the file and similar non fatal issues, spotted by Janet Morgan.

Only in 2.4.9aa1: 00_poll-nfds-1

	Limit the nfds in poll to the rlimit value to avoid an unprivilegied
	user to allocate dozen of mbytes per process of unswappable ram.

Only in 2.4.8aa1: 40_blkdev-pagecache-12
Only in 2.4.9aa1: 40_blkdev-pagecache-13

	Rediffed in function of the updated o_direct patch.

Only in 2.4.8aa1: 50_uml-2.4.7-5.bz2
Only in 2.4.9aa1: 50_uml-patch-2.4.9.bz2

	Picked new uml patch from sourceforge.

Only in 2.4.8aa1: 60_pagecache-atomic-2
Only in 2.4.9aa1: 60_pagecache-atomic-3

	Rediffed due trivial rejects.

Only in 2.4.9aa1: 70_mmap-rb-3

	Rewritten the core vma lookup engine with an rbtree instead of an avl
	for faster rebalance and for checkpointing and in turn avoiding many
	unneded browse of the tree. WARNING: this is experimental so make sure
	to backout this patch called "70_mmap-rb-3" for any production box, it
	must be tested more and benchmarked carefully. The reason I included it
	even if it's not well tested is just to get more testing and in turn
	more feedback. This patch should also do all the clever merging for
	the anonymous mappings for mmap/mremap/mprotect like 2.2 was used to do.
	It should be an overall noticeable improvement.

Andrea
