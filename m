Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263306AbTCNI55>; Fri, 14 Mar 2003 03:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263312AbTCNI55>; Fri, 14 Mar 2003 03:57:57 -0500
Received: from mail-3.tiscali.it ([195.130.225.149]:39772 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263306AbTCNI5v>;
	Fri, 14 Mar 2003 03:57:51 -0500
Date: Fri, 14 Mar 2003 10:08:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre5aa1
Message-ID: <20030314090825.GB1375@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre5aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre5aa1/

diff between 2.4.21pre4aa3 and 2.4.21pre5aa1 [notably an hard to trigger
race that could lead to a deadlock is been fixed, such race could happen
only in 2.4.21pre4aa3, not in any other version]

Only in 2.4.21pre5aa1: 00_backout-set_cpus_allowed-1

	This is just provided by the o1 sched.

Only in 2.4.21pre5aa1: 00_clean-inode-fix-1

	Reset r_dev.

Only in 2.4.21pre5aa1: 00_close-root-fd-1

	Let init get the right fd for stdin/out with initrd.

Only in 2.4.21pre4aa3: 00_elevator-backmerge-1
Only in 2.4.21pre4aa3: 00_mmap-TASK_SIZE-len-1
Only in 2.4.21pre4aa3: 00_msgrcv-smp-race-1
Only in 2.4.21pre4aa3: 00_nfs-xid-smp-1
Only in 2.4.21pre4aa3: 00_reiserfs-o_direct-1
Only in 2.4.21pre4aa3: 00_sbp2-1
Only in 2.4.21pre4aa3: 00_scx200-1
Only in 2.4.21pre4aa3: 00_tcp-retrans-collapse-1
Only in 2.4.21pre4aa3: 00_vmalloc-ltp-crash-1

	Merged in mainline.

Only in 2.4.21pre4aa3: 00_extraversion-19
Only in 2.4.21pre5aa1: 00_extraversion-20
Only in 2.4.21pre4aa3: 00_rwsem-fair-35
Only in 2.4.21pre4aa3: 00_rwsem-fair-35-recursive-8
Only in 2.4.21pre5aa1: 00_rwsem-fair-36
Only in 2.4.21pre5aa1: 00_rwsem-fair-36-recursive-8
Only in 2.4.21pre5aa1: 00_sched-O1-aa-2.4.19rc3-10.gz
Only in 2.4.21pre4aa3: 00_sched-O1-aa-2.4.19rc3-9.gz
Only in 2.4.21pre4aa3: 00_silent-stack-overflow-17
Only in 2.4.21pre5aa1: 00_silent-stack-overflow-18
Only in 2.4.21pre4aa3: 20_pte-highmem-28.gz
Only in 2.4.21pre5aa1: 20_pte-highmem-29.gz
Only in 2.4.21pre4aa3: 50_uml-patch-2.4.19-50.gz
Only in 2.4.21pre5aa1: 50_uml-patch-2.4.19-50-1.gz
Only in 2.4.21pre4aa3: 82_x86_64-suse-7
Only in 2.4.21pre5aa1: 82_x86_64-suse-9
Only in 2.4.21pre4aa3: 9931_io_request_scale-drivers-2
Only in 2.4.21pre5aa1: 9931_io_request_scale-drivers-3
Only in 2.4.21pre4aa3: 9995_frlock-gettimeofday-2
Only in 2.4.21pre5aa1: 9995_frlock-gettimeofday-4
Only in 2.4.21pre4aa3: 9999_gcc-3.3-2
Only in 2.4.21pre5aa1: 9999_gcc-3.3-3

	Rediffed.

Only in 2.4.21pre4aa3: 00_nfs-2.4.17-pathconf-2
Only in 2.4.21pre5aa1: 30_14-pathconf-2

	Renamed.

Only in 2.4.21pre4aa3: 00_radeon-Mobility9000-1
Only in 2.4.21pre5aa1: 00_radeon-Mobility9000-2

	Add a missing 'braek'.

Only in 2.4.21pre5aa1: 00_smp-timers-not-deadlocking-1

	Corrected varsion of the smp timers that can deadlock in 2.5
	and in all kernels that were used to incorporate this patch,
	including jam. This is fixed so that a timer reinserting
	itself to run immediate, won't loop forever deadlocking
	a CPU spinning in a tight loop. This bug was present in
	ancient 2.4 kernels too and this is been fixed after bugreports
	in both 2.2 and again in 2.4 because we forgotten to forward
	port it to 2.4, these fixes must be forward ported today
	to 2.5 too. Fixed also run_all_timers to correctly convert
	the logical to physical cpu id (doesn't matter on x86, but
	run_all_timers doesn't matter either on x86, other archs
	may need this fix to avoid crashing too). This patch
	was originally written from Ingo Molnar, David Miller with the help of
	Alexey Kuznetsov, for more details see the timer.c added credit lines.

Only in 2.4.21pre5aa1: 22_sched-deadlock-mmdrop-1

	Backport from 2.5 (in a more icache friendy way) an anti-deadlock
	fix for the o1 scheduler that can otherwise send a cross IPI with
	irq disabled.

Only in 2.4.21pre5aa1: 30_00_fix_symlink-1
Only in 2.4.21pre5aa1: 30_01_fix_softirq-1
Only in 2.4.21pre4aa3: 30_03_call-reserve2-1
Only in 2.4.21pre5aa1: 30_03_call-reserve2-2
Only in 2.4.21pre4aa3: 30_09_o_direct-2
Only in 2.4.21pre5aa1: 30_09_o_direct-3
Only in 2.4.21pre5aa1: 30_15-xprt_fixes-1
Only in 2.4.21pre5aa1: 30_16_rpciod-lock-1
Only in 2.4.21pre5aa1: 30_17-fix_read-1

	Various nfs updates. This fixes several highmem issues with nfs.
	From Trond, Chuck and various sources, for more details read:

		http://www.fys.uio.no/~trondmy/src/2.4.21-pre5/

Only in 2.4.21pre4aa3: 51_uml-o1-3
Only in 2.4.21pre5aa1: 51_uml-o1-4

	Added some o1 sched support to UML and let
	schedule_tail be called for UP too accordingly with the
	sched-deadlock-mmdrop bugfix.

Only in 2.4.21pre4aa3: 60_tux-timer_t-1
Only in 2.4.21pre5aa1: 60_tux-timer_t-2.gz

	Part of it obsoleted by smptimers.

Only in 2.4.21pre4aa3: 9900_aio-17.gz
Only in 2.4.21pre5aa1: 9900_aio-18.gz

	Cleaned up the whole asm/kmap_types.h mess, moved
	kmap_types.h into linux/, this must be visible
	for aio and it has to be the same for all archs so it doesn't belong to
	asm/.

Only in 2.4.21pre4aa3: 9910_shm-largepage-10.gz
Only in 2.4.21pre5aa1: 9910_shm-largepage-11.gz

	64bit cleanups.

Only in 2.4.21pre4aa3: 9920_kgdb-6.gz
Only in 2.4.21pre5aa1: 9920_kgdb-7.gz

	Documentation bits.

Only in 2.4.21pre5aa1: 9985_blk-atomic-aa6-jfs-1

	Fix collision with blk-atomic.

Only in 2.4.21pre4aa3: 9998_lowlatency-fixes-11
Only in 2.4.21pre5aa1: 9998_lowlatency-fixes-12

	Fixed deadlock bug in write_some_buffers (see l-k for details).

Only in 2.4.21pre5aa1: 9999_fsync-msync-async-errors-1

	Allow userspace to always be notified about async write failures
	when calling msync and fsync even if they happened long before
	the systemcall run.

Only in 2.4.21pre5aa1: 9999_sched_yield_scale-1

	Use a sched_yield that scales well by default, this should
	help with JVM or applications with huge lock contention in
	the current libpthread, but it will hurt interactivity
	of those apps if there's some background load. For openoffice
	set the sysctl back to 0, you don't mind if sched_yield
	doesn't allow the colliding-workloads to scale well. The
	scale-behaviour is also the preferred one for all sched_yield
	usages in the kernel. Over time nothing should call sched_yield()
	anymore, this is an hack for now.

Andrea
