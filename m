Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278345AbRJMS0Q>; Sat, 13 Oct 2001 14:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278346AbRJMS0G>; Sat, 13 Oct 2001 14:26:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11298 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278345AbRJMSZz>; Sat, 13 Oct 2001 14:25:55 -0400
Date: Sat, 13 Oct 2001 20:26:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13pre2aa1
Message-ID: <20011013202615.A721@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.12aa1: 00_backout-2.4.11pre1-1
Only in 2.4.12aa1: 00_o_direct-2
Only in 2.4.13pre2aa1: 00_o_direct-3

	Made a self contained patch that applies cleanly to 2.4.13pre2 ready
	for merging. Many thanks to Janet Morgan for fiding another bug in the
	blkdev O_DIRECT support.

Only in 2.4.12aa1: 00_cache-without-buffers-1
Only in 2.4.12aa1: 00_parport-fix-1

	Just in mainline.

Only in 2.4.13pre2aa1: 00_files_struct_rcu-2.4.10-04-1

	File locking read/write spinlock replaced with RCU.

Only in 2.4.13pre2aa1: 00_ordered-freeing-1

	Free the pages so that they gets allocated in physical order later,
	shouldn't matter but I got reports of slower in-core (cache)
	performance on some arch after a fresh boot, and speedup after the
	freelist got randomized by load.

Only in 2.4.13pre2aa1: 00_rcu-poll-1

	RCU implementation based on latest Dipankar's patch against 2.4.10.
	I changed it so that it only has as fast-path/reader-load cost a
	per-cpu counter increment in scheduler and nothing else. It is not
	arch dependent either. I also tried to optimized the UP case.

Only in 2.4.12aa1: 00_rwsem-fair-22
Only in 2.4.13pre2aa1: 00_rwsem-fair-23

	Rediffed.

Only in 2.4.12aa1: 00_rwsem-fair-22-recursive-4
Only in 2.4.13pre2aa1: 00_rwsem-fair-23-recursive-4

	Renamed.

Only in 2.4.12aa1: 00_vm-2
Only in 2.4.13pre2aa1: 00_vm-3
Only in 2.4.13pre2aa1: 00_vm-3.1

	Further vm changes, backed out the PG_wait_for_IO since it seems not
	to make a relevant difference. Should behave better under swap load.
	In particular I'm probing the inactive list from shrink_cache now,
	so that I get feedback on when it's time to swap before the shrinks
	on the inactive list starts failing.

Only in 2.4.12aa1: 10_compiler.h-1
Only in 2.4.13pre2aa1: 10_compiler.h-2

	Rediffed.

Only in 2.4.13pre2aa1: 10_lvm-snapshot-check-1
Only in 2.4.12aa1: 10_lvm-snapshot-hardsectsize-1
Only in 2.4.13pre2aa1: 10_lvm-snapshot-hardsectsize-2

	LVM updates from Chris.

Only in 2.4.12aa1: 10_numa-sched-11
Only in 2.4.13pre2aa1: 10_numa-sched-12

	Rediffed.

Only in 2.4.12aa1: 50_uml-patch-2.4.11-1.bz2
Only in 2.4.13pre2aa1: 50_uml-patch-2.4.12-1-1.bz2

	Latest patch from Jeff.

Only in 2.4.12aa1: 60_tux-2.4.10-ac10-E6.bz2
Only in 2.4.13pre2aa1: 60_tux-2.4.10-ac10-F5.bz2
Only in 2.4.12aa1: 62_tux-generic-file-read-1
Only in 2.4.13pre2aa1: 62_tux-generic-file-read-2

	Latest update from Ingo.

Andrea
