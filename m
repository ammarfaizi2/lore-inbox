Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSGQWv6>; Wed, 17 Jul 2002 18:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSGQWv6>; Wed, 17 Jul 2002 18:51:58 -0400
Received: from [195.223.140.120] ([195.223.140.120]:12555 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316821AbSGQWv5>; Wed, 17 Jul 2002 18:51:57 -0400
Date: Thu, 18 Jul 2002 00:55:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc2aa1
Message-ID: <20020717225504.GA994@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would appreciate any feedback on the last patches for the i_size
atomic accesses on 32bit archs. Thanks,

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc2aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc2aa1/

diff between 2.4.19rc1aa2 and 2.4.19rc1aa2:

Only in 2.4.19rc1aa2: 000_e100-2.0.30-k1.gz
Only in 2.4.19rc2aa1: 000_e100-2.1.6.gz
Only in 2.4.19rc1aa2: 000_e1000-4.2.17-k1.gz
Only in 2.4.19rc2aa1: 000_e1000-4.3.2.gz

	Upgrade to latest drivers to see if they fix the reports.

Only in 2.4.19rc1aa2: 00_free_pgtable-and-p4-tlb-race-fixes-1

	Merged into mainline.

Only in 2.4.19rc1aa2: 00_nfs-bkl-2
Only in 2.4.19rc2aa1: 00_nfs-bkl-3
Only in 2.4.19rc1aa2: 00_rwsem-fair-29
Only in 2.4.19rc1aa2: 00_rwsem-fair-29-recursive-8
Only in 2.4.19rc2aa1: 00_rwsem-fair-30
Only in 2.4.19rc2aa1: 00_rwsem-fair-30-recursive-8
Only in 2.4.19rc1aa2: 00_sched-O1-rml-2.4.19-pre9-1.gz
Only in 2.4.19rc2aa1: 00_sched-O1-rml-2.4.19-pre9-2.gz
Only in 2.4.19rc2aa1: 10_rawio-vary-io-10
Only in 2.4.19rc1aa2: 10_rawio-vary-io-9
Only in 2.4.19rc1aa2: 70_xfs-1.1-3.gz
Only in 2.4.19rc2aa1: 70_xfs-1.1-4.gz
Only in 2.4.19rc1aa2: 90_init-survive-threaded-race-4
Only in 2.4.19rc2aa1: 90_init-survive-threaded-race-5
Only in 2.4.19rc1aa2: 91_zone_start_pfn-5
Only in 2.4.19rc2aa1: 91_zone_start_pfn-6

	Rediffed.

Only in 2.4.19rc1aa2: 20_pte-highmem-25
Only in 2.4.19rc2aa1: 20_pte-highmem-26

	Rediffed.

Only in 2.4.19rc1aa2: 00_readv-writev-1

	Go in sync with mainline (alpha has some change now).

Only in 2.4.19rc2aa1: 00_set_64bit-atomic-1

	I noticed set_64bit wasn't atomic due the lack of lock prefix. This
	fixes the problem to be sure the cpu sees coherent values while
	walking pagetables.

Only in 2.4.19rc1aa2: 00_setfl-race-fix-1
Only in 2.4.19rc2aa1: 00_setfl-race-fix-2

	Merge ioctl part of the new ->fasync locking from Marcus Alanen.
	BTW, it looks fasync callback can also be recalled w/o the
	big kernel lock, the fasync_helper seems thread safe, but
	I preferred not to risk in 2.4 in case some driver is relying on the
	big kernel lock somehow.

Only in 2.4.19rc1aa2: 00_shm_destroy-deadlock-1
Only in 2.4.19rc2aa1: 00_shm_destroy-deadlock-2

	Mainline changes shm_tot inside the shmid lock, which isn't
	needed, the semaphore serializes the shm_tot instead.

Only in 2.4.19rc2aa1: 00_sock_fasync-memleak-1

	Fix memleak if sock lookup fails, from Robert Love.

Only in 2.4.19rc2aa1: 00_wait_kio-cleanup-1

	Drop pointless buffer_locked check, wait_on_buffer does
	it internally (noticed by Jens).

Only in 2.4.19rc1aa2: 07_qlogicfc-1.gz
Only in 2.4.19rc2aa1: 07_qlogicfc-2.gz
Only in 2.4.19rc1aa2: 08_qlogicfc-template-aa-1
Only in 2.4.19rc2aa1: 08_qlogicfc-template-aa-2
Only in 2.4.19rc1aa2: 09_qlogic-link-1
Only in 2.4.19rc2aa1: 09_qlogic-link-2

	Upgrade to 6.1b2 driver.

Only in 2.4.19rc2aa1: 50_uml-patch-2.4.18-40

	New uml updates from Jeff (36->40).

Only in 2.4.19rc2aa1: 76_xfs-64bit-1

	64bit fixes.

Only in 2.4.19rc1aa2: 80_x86_64-common-code-4
Only in 2.4.19rc2aa1: 80_x86_64-common-code-5
Only in 2.4.19rc2aa1: 81_x86_64-arch-2.4.19rc1-1.gz
Only in 2.4.19rc1aa2: 81_x86_64-arch-6.gz
Only in 2.4.19rc1aa2: 82_x86-64-compile-aa-6
Only in 2.4.19rc1aa2: 82_x86-64-pte-highmem-2
Only in 2.4.19rc2aa1: 82_x86_64-suse-2
Only in 2.4.19rc2aa1: 83_x86_64-cvs-020716-1
Only in 2.4.19rc1aa2: 83_x86_64-setup64-compile-1
Only in 2.4.19rc2aa1: 84_x86-64-mtrr-compile-1
Only in 2.4.19rc1aa2: 84_x86_64-io-compile-1
Only in 2.4.19rc1aa2: 85_x86_64-mmx-xmm-init-4
Only in 2.4.19rc1aa2: 86_x86_64-FIOQSIZE-1
Only in 2.4.19rc2aa1: 87_x86_64-o1sched-1
Only in 2.4.19rc2aa1: 88_x86_64-poll-1

	Synchronize with CVS, code from SuSE Labs.

Only in 2.4.19rc2aa1: 90_proc-mapped-base-1

	Allow the tasks to choose the start of the heap using
	/proc/<pid>/mapped_base .

Only in 2.4.19rc1aa2: 94_numaq-tsc-3
Only in 2.4.19rc2aa1: 94_numaq-tsc-4

	Don't disable the tsc feature anymore, unless the user
	specifys notsc, the user needs to specify notsc anyways to be sure to
	get a failure if userspace tries to read the tsc.

Only in 2.4.19rc2aa1: 95_fsync-corruption-fix-2

	Do all the fsync in two passes, and avoid rolling the bh in the inode
	list every time we write to it.

Only in 2.4.19rc2aa1: 96_inode_read_write-atomic-1
Only in 2.4.19rc2aa1: 97_i_size-corruption-fixes-1

	While checking for another potential race, I found this race between
	i_size writers and i_size readers. The i_size readers aren't taking
	the i_sem, so they can read the i_size while only the upper 32bit
	are updated, so any update of the i_size that changes both the high
	32bits and low 32bits of the 64bit i_size, may lead the reader of the
	i_size to get out of bounds results (the reader is also write page
	that will go and ask the fs to allocate indirect blocks at weird
	offsets behind the end of the i_size). This race can happen with SMP
	only for example while growing the file size over 4G. Only the readers
	inside the i_sem doesn't risk to get random i_size values. The patch
	fixes this incrementally, by implementing two methods (i_size_read,
	i_size_write) that ensure the lockless readers to get coherent i_size
	values. The rules are: 1) i_size_write must be used for all i_size
	updates (at least when there can be potential parallel readers outside
	the i_sem), 2) i_size_read must be used for all lockless reads when
	an i_size change can happen from under us.

	The i_size_read/write on x86 are implemented with read_64bit and
	set_64bit (see also the above fix to make set_64bit atomic
	which should be needed also for the PAE pgd). The only idea
	I had for read_64bit on x86 is been to use chmxchg8b for it too,
	with the exchange values matching the compare values read off the
	pointer. I think it should work fine, but I would appreciate if anybody
	could check it or suggest any better way to do it. And now I also
	realized this kernel will segfault on a 486/386 (cmpxchg8b appeared on
	the pentium first), I will fix it tomorrow (not very high prio to fix
	it) with a spinlock if the kernel is compiled for 386/486, scalability
	of 486/386 SMP doesn't matter much :) In the meantime I'd appreciate
	any feedback on this bugfix, thanks.


Andrea
