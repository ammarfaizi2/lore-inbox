Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265133AbRGSSih>; Thu, 19 Jul 2001 14:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbRGSSi2>; Thu, 19 Jul 2001 14:38:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36456 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265133AbRGSSiO>; Thu, 19 Jul 2001 14:38:14 -0400
Date: Thu, 19 Jul 2001 20:38:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7pre8aa1
Message-ID: <20010719203842.A31850@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Diff between 2.4.7pre6aa1 and 2.4.7pre8aa1 (besides moving on top
of 2.4.7pre8).

Only in 2.4.7pre8aa1/: 00_do_swap_page-fix-1

	Account major faults for swapins. (from -ac)

Only in 2.4.7pre6aa1: 00_drop_async-io-get_bh-1
Only in 2.4.7pre8aa1/: 00_drop_async-io-get_bh-2

	Rediffed for trivial reiserfs reject (reiserfs updates are included in
	pre8).

Only in 2.4.7pre8aa1/: 00_ircomm-t39m-1

	Fix for irda so that it works with my GPRS phone.

Only in 2.4.7pre6aa1: 00_lvm-0.9.1_beta7-4.bz2
Only in 2.4.7pre8aa1/: 00_lvm-0.9.1_beta7-5.bz2

	Rediffed for trivial rejects about updates that
	were just included into this patch.

Only in 2.4.7pre6aa1: 00_lvm-0.9.1_beta7-4_rwsem-fast-path-1
Only in 2.4.7pre8aa1/: 00_lvm-0.9.1_beta7-5_rwsem-fast-path-2

	Rediffed so we solve snapshot hash lookups with the
	read lock as well (low prio optimization). Also
	#if 0 around the _pe_lock instead of any other fix,
	since the pv_move with live writes going on the lv
	is racy anyways in lvm beta7.

Only in 2.4.7pre6aa1: 00_rwsem-15
Only in 2.4.7pre8aa1/: 00_rwsem-16

	Found a race in asm xchgadd algorithm, possibly mainline
	could be affected too, will fix it and inspect mainline
	ASAP.

Only in 2.4.7pre6aa1: 00_sched-yield-1

	Merged in mainline.

Only in 2.4.7pre8aa1/: 00_via-quirks-1

	VIA fixups from -ac.

Only in 2.4.7pre6aa1: 10_prefetch-1
Only in 2.4.7pre8aa1/: 10_prefetch-2

	Rediffed for trivial rejects.

Only in 2.4.7pre6aa1/30_tux: 30_atomic-alloc-2
Only in 2.4.7pre8aa1/30_tux: 30_atomic-alloc-3

	Rediffed for trivial rejects.

Only in 2.4.7pre8aa1/30_tux: 32_tux-uml-1

	Moved the uml part of the -aa updates in the tux directory
	since they are not needed when the tux patches are not applied.

Only in 2.4.7pre6aa1: 40_blkdev-pagecache-5
Only in 2.4.7pre8aa1/: 40_blkdev-pagecache-6

	Default opens to O_LARGEFILE in blkdev_open so that mkreiserfs
	doesn't need to be recompiled and we don't break
	backwards compatibility (can be dropped in 2.5 if we want to).

Only in 2.4.7pre8aa1/: 41_blkdev-pagecache-5_drop_get_bh_async-1

	When blkdev patch is applied in combination with the
	00_drop_async-io-get_bh patch we must remeber to drop
	the get_bh from the blkdev async_io too.

Only in 2.4.7pre6aa1: 51_uml-ac-to-aa-2.bz2
Only in 2.4.7pre8aa1/: 51_uml-ac-to-aa-3.bz2

	Moved part of it in the tux directory so it can compile
	without tux (in reality I got errno compilation error
	but it's low prio and I'll sort it out later, Jeff Dike any
	hint is welcome ;).

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre8aa1/
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre8aa1.bz2

Andrea
