Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268536AbTBOF3G>; Sat, 15 Feb 2003 00:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268538AbTBOF3G>; Sat, 15 Feb 2003 00:29:06 -0500
Received: from [195.223.140.107] ([195.223.140.107]:3717 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268536AbTBOF3E>;
	Sat, 15 Feb 2003 00:29:04 -0500
Date: Sat, 15 Feb 2003 06:16:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre4aa3
Message-ID: <20030215051634.GA1216@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre4aa3.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre4aa3/

Diff between 2.4.21pre4aa1 and 2.4.21pre4aa3:

Only in 2.4.21pre4aa1: 00_extraversion-17
Only in 2.4.21pre4aa3: 00_extraversion-19
Only in 2.4.21pre4aa1: 9900_aio-15.gz
Only in 2.4.21pre4aa3: 9900_aio-17.gz

	Rediffed.

Only in 2.4.21pre4aa1: 00_getcwd-err-2

	It was superflous (noticed by Christoph Hellwig)

Only in 2.4.21pre4aa3: 00_ll_rw_block-sync-race-1

	Add lock_page in ll_rw_block to fix a fs race
	condition. Fix suggested by Mikulas Patocka.

Only in 2.4.21pre4aa1: 00_lowlatency-fixes-8
Only in 2.4.21pre4aa3: 9998_lowlatency-fixes-11

	Merged more latency points (w/o introucing
	live locks), and also a workaround for ext3
	that isn't always refiling buffers after
	clearing the dirty bit.

Only in 2.4.21pre4aa3: 00_mark-inode-dirty-smp-race-1

	Fix for an SMP race found by Mikulas Patocka
	where an inode update could get lost with out
	of order cpus in smp.

Only in 2.4.21pre4aa3: 00_osync-lock-1

	Microoptimization, avoids a spin_lock/unlock cycle,
	from Christoph Hellwig.

Only in 2.4.21pre4aa3: 00_panic-export-1

	Export a few panic variables to avoid dynamic linking
	failures with drivers/char/ipmi/ipmi_msghandler.o and
	drivers/char/ipmi/ipmi_watchdog.o (noticed by Eyal Lebedinsky)

Only in 2.4.21pre4aa3: 00_radeon-Mobility9000-1

	radeon pci updates from Alvaro Lopez Ortega.

Only in 2.4.21pre4aa3: 00_sbp2-1

	Fix compilation in drivers/ieee1394/sbp2.o, from Eyal Lebedinsky.

Only in 2.4.21pre4aa3: 00_scx200-1

	Allow scx200.c to compile, from Eyal Lebedinsky.

Only in 2.4.21pre4aa3: 00_watchdog-1

	Fix compilation failure in drivers/char/ipmi/ipmi_watchdog.c, from
	Eyal Lebedinsky.

Only in 2.4.21pre4aa1: 50_uml-patch-2.4.19-1.gz
Only in 2.4.21pre4aa1: 50_uml-patch-2.4.19-2.gz
Only in 2.4.21pre4aa3: 50_uml-patch-2.4.19-50.gz
Only in 2.4.21pre4aa1: 50_uml-patch-2.4.19-7.gz
Only in 2.4.21pre4aa1: 51_uml-aa-11
Only in 2.4.21pre4aa3: 51_uml-aa-12
Only in 2.4.21pre4aa1: 51_uml-o1-2
Only in 2.4.21pre4aa3: 51_uml-o1-3
Only in 2.4.21pre4aa1: 52_uml-sys-read-write-4
Only in 2.4.21pre4aa3: 52_uml-sys-read-write-5
Only in 2.4.21pre4aa1: 56_uml-pte-highmem-5
Only in 2.4.21pre4aa3: 56_uml-pte-highmem-6

	Synchronize with uml-2.4.19-50 (latest). Jeff, I'd appreciate if
	you could test it (and again I recommend to drop the non skas
	protection design model, especially in the future with ASN skas
	should run almost as fast as non skas w/o jail).

Only in 2.4.21pre4aa1: 70_xfs-1.2-1.gz
Only in 2.4.21pre4aa3: 70_xfs-1.2-3.gz
Only in 2.4.21pre4aa1: 71_posix_acl-1
Only in 2.4.21pre4aa3: 71_posix_acl-2
Only in 2.4.21pre4aa3: 72_swapl-1

	Go in full sync with xfs 1.2 (was just almost in sync).

Only in 2.4.21pre4aa1: 94_discontigmem-meminfo-4
Only in 2.4.21pre4aa3: 94_discontigmem-meminfo-6

	No change.

Only in 2.4.21pre4aa1: 9920_kgdb-5.gz
Only in 2.4.21pre4aa3: 9920_kgdb-6.gz

	Only use stabs and avoid dwarf2 on non-x86-64 since gdb
	isn't capable to use dwarf2 on other archs (we should fix
	gdb on x86 to use dwarf2 too so we can ship kgdb enabled kernels with
	zero runtime overhead [i.e. we can leave -fomit-frame-pointer enabled])

Only in 2.4.21pre4aa1: 9981_elevator-lowlatency-3
Only in 2.4.21pre4aa3: 9981_elevator-lowlatency-4

	Fix deadlock that can happen in mainline too, we check rq.count to
	be zero not atomically with the queue unplug, and in turn we may
	run the unplug _before_ the request is been inserted in the queue
	(but after it was allocated). The same race in elevator-lowlatency
	existed also on the blk_oversized_queue side, but as far as I
	can tell, this race isn't new and it affects mainline too (for some
	reason it was easier to reproduce it here). It is been verified that
	checking rq.count and oversized-queue atomically with the queue unplug
	fixed the hang (w/o doing any other change). This update fixes also
	an incorrect setting of the batch_requests, I originally wanted to set
	it to 0 not to nr_requests. This also limits the number of requests to
	something less than 8k, 8k of queue (despite it would be only a few megs
	of data payload locked) isn't worthwhile and it also generates too high
	latencies during seeks.

Only in 2.4.21pre4aa3: 9986_elevator-merge-fast-path-1

	Try to avoid some computational complexity for the merging, this helps
	in somehow mixed seeking workloads, backported from Stephen C. Tweedie,
	and integrated by Jens Axboe.

Only in 2.4.21pre4aa3: 9997_rawio-readv-writev-1

	Merged readv/writev rawio native support from Janet Morgan.

Only in 2.4.21pre4aa3: 9999_gcc-3.3-2

	Compile with gcc 3.3 (should still compile on 3.2 now, thanks to
	Eyal Lebedinsky for noticing the problem).

Andrea
