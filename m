Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310228AbSCGIUh>; Thu, 7 Mar 2002 03:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310229AbSCGIU1>; Thu, 7 Mar 2002 03:20:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:26469 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310228AbSCGIUP>; Thu, 7 Mar 2002 03:20:15 -0500
Date: Thu, 7 Mar 2002 09:21:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre2aa1
Message-ID: <20020307092119.A25470@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa1.gz
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa1/

The alone vm-29 against 2.4.19pre2 can be downloaded from here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre2/vm-29

Only in 2.4.19pre2aa1: 00_TCDRAIN-1

	drain/flush pty fixes from Michael Schroeder.

Only in 2.4.19pre1aa1: 00_VM_IO-2
Only in 2.4.19pre2aa1: 00_VM_IO-3
Only in 2.4.19pre1aa1: 00_block-highmem-all-18b-4.gz
Only in 2.4.19pre2aa1: 00_block-highmem-all-18b-5.gz
Only in 2.4.19pre1aa1: 00_flush_icache_range-2
Only in 2.4.19pre2aa1: 00_flush_icache_range-3
Only in 2.4.19pre1aa1: 00_module-gfp-5
Only in 2.4.19pre2aa1: 00_module-gfp-6
Only in 2.4.19pre1aa1: 00_nfs-2.4.17-pathconf-1
Only in 2.4.19pre2aa1: 00_nfs-2.4.17-pathconf-2
Only in 2.4.19pre1aa1: 00_lvm-1.0.2-1.gz
Only in 2.4.19pre2aa1: 00_lvm-1.0.2-2.gz
Only in 2.4.19pre1aa1: 00_silent-stack-overflow-14
Only in 2.4.19pre2aa1: 00_silent-stack-overflow-15
Only in 2.4.19pre1aa1: 20_numa-mm-1
Only in 2.4.19pre2aa1: 20_numa-mm-2
Only in 2.4.19pre1aa1: 10_compiler.h-2
Only in 2.4.19pre2aa1: 10_compiler.h-3

	Rediffed.

Only in 2.4.19pre2aa1: 00_alpha-lseek-1

	Export right interface for lseek/sys_lseek.

Only in 2.4.19pre2aa1: 00_ffs_compile_failure-1

	Fix compilation failure with gcc 3.1 due a kernel bug.
	From Andi Kleen and Jan Hubicka.

Only in 2.4.19pre2aa1: 00_gcc-3_1-compile-1

	Fix compilation failure with gcc 3.1.

Only in 2.4.19pre2aa1: 00_kiobuf_init-1

	Optimize kiobuf initialization. From Intel and Hubert Mantel.

Only in 2.4.19pre2aa1: 00_nfs-fix_create-1

	New nfs fix from Trond.

Only in 2.4.19pre2aa1: 00_proc-sig-race-fix-1

	Fix /proc signal SMP race from Chris Mason.

Only in 2.4.19pre1aa1: 00_rwsem-fair-26
Only in 2.4.19pre1aa1: 00_rwsem-fair-26-recursive-7
Only in 2.4.19pre2aa1: 00_rwsem-fair-27
Only in 2.4.19pre2aa1: 00_rwsem-fair-27-recursive-8

	Fixed 64bit bug s/int/long/ in down_read. Thanks to
	Jeff Wiedemeier and Andreas Schwab for providing
	testcases on such bug.

Only in 2.4.19pre2aa1: 00_sd-cleanup-1

	Rest of the sd cleanups from Pete Zaitcev.

Only in 2.4.19pre2aa1: 00_shmdt-retval-1

	Fix shmdt retval from Andreas Schwab.


Only in 2.4.19pre1aa1: 10_nfs-o_direct-3
Only in 2.4.19pre2aa1: 10_nfs-o_direct-4

	New version from Trond.

Only in 2.4.19pre1aa1: 10_no-virtual-2

	Obsoleted by mainline.

Only in 2.4.19pre1aa1: 10_vm-28
Only in 2.4.19pre2aa1: 10_vm-29

	Make sure to free memclass-realted-metadata for pages out of the
	memclass (bh headers in short).  kmem_cache_shrink as well in the
	max_mapped path now. Added other sysctls and minor tuning.

	Changed the wait_table stuff, first of all have it per-node (no point
	of per-zone), then let it scale more with the ram in the machine (the
	amount of ram used for the wait table is ridicolously small and it
	mostly depends on the amount of the I/O, not on the amount of ram, so
	set up a low limit instead of an high limit). The hashfn I wasn't
	very confortable with. This one is the same of pagemap.h, and it's
	not that huge on the 64bit archs.  If something it had to be a mul.
	This hashfn ensures to be contigous on the cacheline for physically
	consecutive pages, and once the pages are randomized they just provide
	enough randomization, we just need to protect against the bootup when
	it's more likely the pages are physically consecutive.

Only in 2.4.19pre1aa1: 20_pte-highmem-14
Only in 2.4.19pre2aa1: 20_pte-highmem-15

	Initialize the kmap functionality eary during boot, right
	after the mem init, so pte_alloc and in turn ioremap can be used
	in the driver init functions.

Only in 2.4.19pre1aa1: 50_uml-patch-2.4.17-12.gz
Only in 2.4.19pre2aa1: 50_uml-patch-2.4.18-2.gz

	New revision from Jeff at user-mode-linux.sourceforge.net.

Only in 2.4.19pre1aa1: 70_xfs-2.gz
Only in 2.4.19pre2aa1: 70_xfs-4.gz

	Rediffed.

Andrea
