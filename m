Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSGWRrn>; Tue, 23 Jul 2002 13:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318147AbSGWRrm>; Tue, 23 Jul 2002 13:47:42 -0400
Received: from [195.223.140.120] ([195.223.140.120]:36124 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318143AbSGWRrR>; Tue, 23 Jul 2002 13:47:17 -0400
Date: Tue, 23 Jul 2002 19:51:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc3aa1
Message-ID: <20020723175100.GC1117@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa1/

Changelog:

Only in 2.4.19rc3aa1: 00_net-softirq-1

	Lower AF_UNIX(/and similar local tranfers) latency.

Only in 2.4.19rc2aa1: 00_poll-speedup-1
Only in 2.4.19rc3aa1: 00_poll-speedup-2

	Return exporting a few methods (get_fd_set/zero_fd_set).

Only in 2.4.19rc3aa1: 00_relax-timer-sync-1

	Use rep;nop while waiting a timer to go away from the cpu.

Only in 2.4.19rc3aa1: 00_sched-O1-aa-2.4.19rc3-1.gz
Only in 2.4.19rc2aa1: 00_sched-O1-rml-2.4.19-pre9-2.gz
Only in 2.4.19rc2aa1: 02_sched-19pre8ac5-1
Only in 2.4.19rc2aa1: 02_sched-alpha-1
Only in 2.4.19rc2aa1: 02_sched-sparc64-1
Only in 2.4.19rc2aa1: 02_sched-x86-1
Only in 2.4.19rc2aa1: 10_o1-sched-64-cpu-1
Only in 2.4.19rc2aa1: 10_o1-sched-fixes-2
Only in 2.4.19rc2aa1: 10_o1-sched-updates-A4-3

	Synchronized with sched-2.4.19-rc2-A3 from Ingo, I didn't merge
	the new features, just the bugfixes. The major ones
	are my proposed change to sched_yield to just move sched_yield
	tasks directly into the expired queues that should fix
	sched_yield related hangs like with tomcat during java
	garbage collection, and various important performance fixes like the
	load_balancing that was completely broken in the previous
	implementations, and other fixes from Ingo like the wakeup_sync that
	was not honouring cpus_allowed and various minor optimizations.

Only in 2.4.19rc2aa1: 08_qlogicfc-template-aa-2
Only in 2.4.19rc3aa1: 08_qlogicfc-template-aa-3

	Deleted one more line during merging.

Only in 2.4.19rc2aa1: 10_parent-timeslice-10

	Now part of O1 sched, except Ingo apparently forgot a place
	in exit.c, that is included into 00_sched-O1-aa-2.4.19rc3-1.gz
	(with that fix added, it's completely equivalent to the previous
	parent-timeslice-10).

Only in 2.4.19rc3aa1: 50_uml-patch-2.4.18-41.gz
Only in 2.4.19rc3aa1: 50_uml-patch-2.4.18-42.gz

	Latest updates from Jeff.

Only in 2.4.19rc2aa1: 51_uml-o1-1
Only in 2.4.19rc3aa1: 51_uml-o1-2

	Merged some new bit from the 2.5 uml port to fix o1 sched hangs under
	uml.

Only in 2.4.19rc2aa1: 88_x86_64-poll-1

	Return using the exported symbols.

Only in 2.4.19rc2aa1: 90_buddyinfo-1
Only in 2.4.19rc3aa1: 90_buddyinfo-2

	New implementation from William Lee Irwin III.

Only in 2.4.19rc2aa1: 90_proc-mapped-base-1
Only in 2.4.19rc3aa1: 90_proc-mapped-base-2

	Show /proc/<pid>/mapped_base only on archs where it is significant.
	Enabled for x86 and s390 only so far. Wonder what to do on the 32/64
	bit archs like x86-64, s390x, ppc64, ia64, sparc64 where I cannot
	generally inherit the mapped base from a 64bit parent to a 32bit child.
	I guess it's ok that the /proc/<pid>/mapped_base isn't there so in
	32bit compatility mode the app will just use the default, since the
	whole point of those archs is to run those user apps in 64bit mode
	where mapped_base won't need to be dynamic.

Only in 2.4.19rc3aa1: 90_s390-aa-1

	Make it compile on s390.

Only in 2.4.19rc2aa1: 94_discontigmem-meminfo-1
Only in 2.4.19rc3aa1: 94_discontigmem-meminfo-2

	Fix meminfo node reporting.

Only in 2.4.19rc2aa1: 96_inode_read_write-atomic-1
Only in 2.4.19rc3aa1: 96_inode_read_write-atomic-2

	Use two sequence numbers for 486/386 SMP compiles and in general
	for SMP compiles of 32bit archs not providing (or not yet implementing :)
	64bit atomic get/set. (also renamed read_64bit to get_64bit for
	symmetry with set_64bit) Added some comment about preempt significant
	only for the 2.5 port of it.

Andrea
