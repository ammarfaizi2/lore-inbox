Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262150AbSJJXE1>; Thu, 10 Oct 2002 19:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbSJJXE1>; Thu, 10 Oct 2002 19:04:27 -0400
Received: from [195.223.140.120] ([195.223.140.120]:13347 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262150AbSJJXEY>; Thu, 10 Oct 2002 19:04:24 -0400
Date: Fri, 11 Oct 2002 01:09:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20pre10aa1
Message-ID: <20021010230945.GB1251@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre10aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre10aa1/

changelog:

Only in 2.4.20pre10aa1: 00_backout-pre9-list_t-removal-1

	resurrect list_t.

Only in 2.4.20pre10aa1: 00_extraversion-10
Only in 2.4.20pre8aa2: 00_extraversion-9
Only in 2.4.20pre8aa2: 00_sched-O1-aa-2.4.19rc3-4.gz
Only in 2.4.20pre10aa1: 00_sched-O1-aa-2.4.19rc3-5.gz
Only in 2.4.20pre8aa2: 00_thinkpad-1
Only in 2.4.20pre10aa1: 00_thinkpad-2.gz
Only in 2.4.20pre8aa2: 05_vm_05_zone_accounting-1
Only in 2.4.20pre10aa1: 05_vm_05_zone_accounting-2
Only in 2.4.20pre8aa2: 60_pagecache-atomic-5
Only in 2.4.20pre10aa1: 60_pagecache-atomic-6
Only in 2.4.20pre8aa2: 93_NUMAQ-5
Only in 2.4.20pre10aa1: 93_NUMAQ-6
Only in 2.4.20pre8aa2: 97_i_size-corruption-fixes-1
Only in 2.4.20pre10aa1: 97_i_size-corruption-fixes-2

	Rediffed.

Only in 2.4.20pre10aa1: 00_i8k-compile-1

	Should fix i8k compilation reported on l-k.

Only in 2.4.20pre10aa1: 00_ip_conntrack-ack-seq-1

	Check the sequence number of the final ack of the 3-way handshake.
	(from Martin Renold)

Only in 2.4.20pre10aa1: 00_ipv6-route-fix-1

	Avoid losing the route. (from YOSHIFUJI Hideaki)

Only in 2.4.20pre10aa1: 00_isofs-options-elseif-1

	Fix isofs option parsing. (from Chris Mason)

Only in 2.4.20pre10aa1: 00_module-locking-fix-1

	Fix module locking, the get_module_info was running without
	locks so it was racing and oopsing while walking the list.
	The previous locking was broken as well by walking lists
	and scheduling in between (releasing the big kernel lock).
	The big kernel locks is now replaced by a proper semaphore.

Only in 2.4.20pre8aa2: 00_o_direct-read-overflow-write-locking-xfs-1

	Merged in mainline.

Only in 2.4.20pre10aa1: 00_skb-frag-1

	nr_frags initialization fix.

Only in 2.4.20pre10aa1: 00_vmalloc-leak-fix-1

	Avoid leaking vmalloc metadata.

Only in 2.4.20pre8aa2: 20_sched-o1-fixes-2
Only in 2.4.20pre10aa1: 20_sched-o1-fixes-4

	Fix race condition that destabilized the scheduler.

Only in 2.4.20pre10aa1: 86_x86_64-tsc-hpet-pit-1

	Newer gettimeofday code (new hpet/tsc/pit combinations).

Only in 2.4.20pre8aa2: 90_ext3-commit-interval-3
Only in 2.4.20pre10aa1: 90_ext3-commit-interval-5

	Use bdflush_interval() instead of 5*HZ when commit option isn't passed
	to mount (the mount option will override bdflush_interval()).

Only in 2.4.20pre8aa2: 90_proc-mapped-base-3
Only in 2.4.20pre10aa1: 90_proc-mapped-base-4

	Add x86-64 and s390x support (so binaries in 32bit compatibility
	mode will be able to change the mapped base, the proc entry is a noop
	for all 64bit tasks even if it will showup for them too [common code
	cannot differentiate between 32bit and 64bit tasks, there's simply
	no API for it]).

Only in 2.4.20pre10aa1: 9900_aio-11.gz
Only in 2.4.20pre8aa2: 9900_aio-9.gz

	With rawio map at most KIO_MAX_SECTORS at time (or kmalloc
	can even fail in the I/O routine that will try to write
	the kvec).

	unplug the queue asynchronously after io_submit so io_submit won't
	block to start the I/O and aio-rawio will work correctly.

Only in 2.4.20pre8aa2: 9910_shm-largepage-4.gz
Only in 2.4.20pre10aa1: 9910_shm-largepage-5.gz

	Fix MAX_ORDER for non PAE compiles, so largepages can be easily
	preallocated at boot and the bigpages= will work also without PAE.

	Enable largepages as backing store of shmfs files when
	shm-use-bigpages sysctl is set to 2.

Only in 2.4.20pre8aa2: 9960_cyclone-1
Only in 2.4.20pre10aa1: 9960_cyclone-3

	Fix a few bugs in the cyclone support and use it for udelay too.
	Still it's not autodetected because the summit support isn't
	included in mainline.

Only in 2.4.20pre10aa1: 9970_corename-1.gz

	Patch from Michael Sinz to name corefiles differently (configurable via
	sysctl).  BTW, make sure to never use the syscall by number or it has
	few chances to work correctly, sysctl by name will work fine.

	http://www.sinz.org/Michael.Sinz/Linux/

	The following format options are available in that string:

	      %P   The Process ID (current->pid)
	      %U   The UID of the process (current->uid)
	      %N   The command name of the process (current->comm)
	      %H   The nodename of the system (system_utsname.nodename)
	      %%   A "%"

Andrea
