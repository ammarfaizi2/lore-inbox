Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318946AbSIJBf5>; Mon, 9 Sep 2002 21:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318962AbSIJBf4>; Mon, 9 Sep 2002 21:35:56 -0400
Received: from [195.223.140.120] ([195.223.140.120]:4648 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318946AbSIJBfw>; Mon, 9 Sep 2002 21:35:52 -0400
Date: Mon, 9 Sep 2002 18:50:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20pre5aa2
Message-ID: <20020909165007.GA17868@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20pre5aa1 had a deadlock in the sched_yield changes (missing _irq
while taking the spinlock). this new one should be rock solid ;).

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre5aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre5aa2/

Changelog:

Only in 2.4.20pre5aa2: 00_ext3-o_direct-1

	O_DIRECT support for ext3, from Andrew and Stephen.

Only in 2.4.20pre5aa2: 00_find_or_create_page-1

	Cleanup patch from Christoph to start the xfs merging.

Only in 2.4.20pre5aa1: 00_net-softirq-2
Only in 2.4.20pre5aa2: 00_net-softirq-3

	This time I think I fixed the AF_UNIX latency in lmbench
	to go as fast as with irqrate applied (if yes, as I expect it was
	totally unrelated to the irqrate irq proper part). Please
	benchmark (totally untested).

Only in 2.4.20pre5aa1: 00_prepare-write-fixes-3-1
Only in 2.4.20pre5aa2: 98_prepare-write-fixes-3-1

	Moved at the end so it compiles even if you stop applying patches
	in the middle. From Christoph.

Only in 2.4.20pre5aa2: 00_reiserfs-o_direct-1

	Fixes for O_DIRECT with reiserfs from Chris.

Only in 2.4.20pre5aa1: 00_sched-O1-aa-2.4.19rc3-2.gz
Only in 2.4.20pre5aa2: 00_sched-O1-aa-2.4.19rc3-3.gz

	Fix deadlock in sched_yield (rq->lock must be acquired after
	disabling irqs). From Andi.

Only in 2.4.20pre5aa2: 00_slabinfo-shared-address-space-1

	Fix from Arnd Bergmann to avoid archs with shared/overlapped address
	space across kernel and userspace to show broken (literally ;) in
	/proc/slabinfo.

Only in 2.4.20pre5aa1: 10_rawio-vary-io-12
Only in 2.4.20pre5aa2: 10_rawio-vary-io-13

	Cleanedup version from Christoph.

Only in 2.4.20pre5aa2: 50_uml-patch-2.4.19-2.gz
Only in 2.4.20pre5aa2: 51_uml-aa-11
Only in 2.4.20pre5aa1: 51_uml-ac-to-aa-10
Only in 2.4.20pre5aa2: 53_uml-cache-shift-1
Only in 2.4.20pre5aa1: 56_uml-pte-highmem-3
Only in 2.4.20pre5aa2: 56_uml-pte-highmem-4
Only in 2.4.20pre5aa1: 60_tux-flush_icache_range-1

	Make UML compile and work again (didn't like too much the /usr/lib/uml
	hardcoded path just for this proggy:

andrea@dualathlon:~> ls /usr/lib/uml/
port-helper
andrea@dualathlon:~>

	to make the debugger working). I'd prefer to install it locally
	in my home dir.

Only in 2.4.20pre5aa2: 70_PF_FSTRANS-1
Only in 2.4.20pre5aa2: 70_alloc_inode-1
Only in 2.4.20pre5aa2: 70_delalloc-1
Only in 2.4.20pre5aa2: 70_dmapi-stuff-1
Only in 2.4.20pre5aa2: 70_iget-1
Only in 2.4.20pre5aa2: 70_intermezzo-junk-1
Only in 2.4.20pre5aa2: 70_quota-backport-1
Only in 2.4.20pre5aa2: 70_vmap-1
Only in 2.4.20pre5aa2: 70_xattr-1
Only in 2.4.20pre5aa1: 70_xfs-1.1-6.gz
Only in 2.4.20pre5aa2: 70_xfs-config-stuff-1
Only in 2.4.20pre5aa2: 70_xfs-cvs-020905-1
Only in 2.4.20pre5aa2: 70_xfs-exports-1
Only in 2.4.20pre5aa2: 70_xfs-sysctl-1
Only in 2.4.20pre5aa2: 71_posix_acl-1
Only in 2.4.20pre5aa2: 71_xfs-aa-1
Only in 2.4.20pre5aa1: 71_xfs-kiobuf-slab-1
Only in 2.4.20pre5aa2: 71_xfs-zalloc-fix-1
Only in 2.4.20pre5aa1: 72_xfs-O_DIRECT-1
Only in 2.4.20pre5aa1: 73_xfs-blksize-PAGE_SIZE-1
Only in 2.4.20pre5aa1: 74_super_quotaops-1
Only in 2.4.20pre5aa1: 75_compile-dmapi-1
Only in 2.4.20pre5aa1: 76_xfs-64bit-1

	XFS SGI updates from Christoph.

Only in 2.4.20pre5aa1: 82_x86_64-suse-3
Only in 2.4.20pre5aa2: 82_x86_64-suse-4
Only in 2.4.20pre5aa1: 87_x86_64-o1sched-2

	Make x86-64 compile (modulo aio, didn't merge the wtd framework yet).

Only in 2.4.20pre5aa1: 90_ext3-commit-interval-2
Only in 2.4.20pre5aa2: 90_ext3-commit-interval-3
Only in 2.4.20pre5aa1: 96_inode_read_write-atomic-4
Only in 2.4.20pre5aa2: 96_inode_read_write-atomic-5
Only in 2.4.20pre5aa1: 9940_ocfs-1.gz
Only in 2.4.20pre5aa2: 9940_ocfs-2.gz

	Rediffed

Only in 2.4.20pre5aa1: 9900_aio-4.gz
Only in 2.4.20pre5aa2: 9900_aio-5.gz
Only in 2.4.20pre5aa1: 9910_shm-largepage-2.gz
Only in 2.4.20pre5aa2: 9910_shm-largepage-3.gz
Only in 2.4.20pre5aa1: 9920_kgdb-1.gz
Only in 2.4.20pre5aa2: 9920_kgdb-2.gz

	Rediffed after fixing some compilation issue (wtd is still missing
	for most archs though).

Only in 2.4.20pre5aa1: 9950_futex-1.gz
Only in 2.4.20pre5aa2: 9950_futex-2.gz

	New fixed version.

Andrea
