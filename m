Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTFLDF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 23:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbTFLDF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 23:05:58 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55424
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264692AbTFLDFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 23:05:55 -0400
Date: Thu, 12 Jun 2003 05:20:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21rc8aa1
Message-ID: <20030612032021.GB1571@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version has some experimental change to the blkdev layer (latency
fixes from Chris and Nick too plus the backout of the rc6 latency change
to see if we can fix it w/o generating overscheduling, especially
because it doesn't sound the right fix), so I would recommend some
beating before doing anything critical with it. I would expect it as
worse to deadlock with some task in D state. It worked fine for me so
far but I didn't run big stress yet. In theory it should be better, but
I just wanted to give a warning until it is better tested ;).

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/

Changlog diff between 2.4.21rc4aa1 and 2.4.21rc8aa1:

Only in 2.4.21rc8aa1: 00_cpufreq-1

	Merged cpufreq (still doesn't allow my laptop to choose a random
	frequency like 100mhz, ideal for reading lots of text, so it's
	pretty useless to me).

Only in 2.4.21rc8aa1: 00_cs46xx-u32-1

	Use large enough type from Chip Salzenberg.

Only in 2.4.21rc4aa1: 00_extraversion-23
Only in 2.4.21rc8aa1: 00_extraversion-24
Only in 2.4.21rc4aa1: 00_sched-O1-aa-2.4.19rc3-11.gz
Only in 2.4.21rc8aa1: 00_sched-O1-aa-2.4.19rc3-12.gz
Only in 2.4.21rc4aa1: 20_rcu-poll-7
Only in 2.4.21rc8aa1: 20_rcu-poll-8
Only in 2.4.21rc8aa1: 30_105_seekdir-fix-1
Only in 2.4.21rc4aa1: 70_alloc_inode-2
Only in 2.4.21rc4aa1: 82_x86_64-suse-11
Only in 2.4.21rc8aa1: 82_x86_64-suse-12
Only in 2.4.21rc8aa1: 93_NUMAQ-10
Only in 2.4.21rc4aa1: 93_NUMAQ-9
Only in 2.4.21rc4aa1: 9920_kgdb-7.gz
Only in 2.4.21rc8aa1: 9920_kgdb-8.gz
Only in 2.4.21rc4aa1: 9925_kmsgdump-0.4.4-1.gz
Only in 2.4.21rc8aa1: 9925_kmsgdump-0.4.4-2.gz
Only in 2.4.21rc4aa1: 9985_blk-atomic-8
Only in 2.4.21rc8aa1: 9985_blk-atomic-9
Only in 2.4.21rc4aa1: 9999_sched_yield_scale-1
Only in 2.4.21rc8aa1: 9999_sched_yield_scale-2

	Rediffed.

Only in 2.4.21rc4aa1: 9910_shm-largepage-12.gz
Only in 2.4.21rc8aa1: 9910_shm-largepage-13.gz

	Allow up to 128G on 64bit archs per file using vmalloc and 64G on 32bit
	archs using kmalloc(128K).

Only in 2.4.21rc8aa1: 00_floppy-smp-race-and-queuesize-1

	Fix longstanding smp race in the floppy from Jens. Otherwise
	it can skip processing of queued requests.

Only in 2.4.21rc8aa1: 00_ppp-ioctl-memleak-1

	Fix memleak in a ppp ioctl (in error conditions).

Only in 2.4.21rc4aa1: 50_uml-patch-2.4.19-50-1.gz
Only in 2.4.21rc8aa1: 50_uml-patch-2.4.20-5-1.gz

	Update to latest UML version.

Only in 2.4.21rc4aa1: 51_uml-aa-12
Only in 2.4.21rc8aa1: 51_uml-aa-13
Only in 2.4.21rc4aa1: 51_uml-o1-4
Only in 2.4.21rc8aa1: 51_uml-o1-5
Only in 2.4.21rc4aa1: 56_uml-pte-highmem-6
Only in 2.4.21rc8aa1: 56_uml-pte-highmem-7
Only in 2.4.21rc8aa1: 57_uml-kernel-thread-1
Only in 2.4.21rc4aa1: 59_uml-compat-2.5-3

	Fixed pte handling so that uml actually works too ;)

Only in 2.4.21rc4aa1: 9980_fix-pausing-2
Only in 2.4.21rc8aa1: 9980_fix-pausing-5

	Fixed smp race condition in submit_bh (though nearly impossible to
	trigger) and put some BUG_ON to verify nobody calls writepage w/o a
	reference on the page (SetPageUptodate needs it too). Also converted
	the logic to what Andrew suggested long ago, that is to unplug the
	queue rather than to wakeup the waiter, to avoid the race. This has
	the benefit of not generating the wakeup flood in __get_request_wait
	that would otherwise generate more wakeups than rq.count (and that
	would render the wait_request waiters not exact FIFO anymore). This
	also required to move the hook after the add_request since the unplug
	doesn't happen on the waiter synchronized by the spinlock anymore.

Only in 2.4.21rc4aa1: 9981_elevator-lowlatency-4
Only in 2.4.21rc8aa1: 9981_elevator-lowlatency-5

	Backout the wake-all done in 2.4.21rc6 wait_for_request mainline that
	IMHO hides the real problem and replaced it with a wake_up_nr(rq.count).

	Also merged Chris's (fixed) version of Nick's patch that throttles
	users outside the waitqueue too (as I also suggested indipendently on
	l-k).

Only in 2.4.21rc8aa1: 9999900_ikd-1

	Merged the core part of the IKD patch (all the mcount part). Missing
	is the memleak detector that is painful to maintain as way too
	intrusive and kdb (since kgdb is already available). The kernel tracer
	also must be converted to the new /proc hooks.

Only in 2.4.21rc8aa1: 9999901_O_DIRECT-1

	Merged a patch from Stephen C. Tweedie that allows O_DIRECT writes
	I/O to run in parallel (not serialized anymore by the i_sem).

Andrea
