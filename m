Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSG3F54>; Tue, 30 Jul 2002 01:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318214AbSG3F54>; Tue, 30 Jul 2002 01:57:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:39506 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318213AbSG3F5z>; Tue, 30 Jul 2002 01:57:55 -0400
Date: Tue, 30 Jul 2002 08:02:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc3aa4
Message-ID: <20020730060218.GB1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Async-io is completely untested, if somebody adapts the user libs and
test it I'd love to hear if it really works :). thanks.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa4.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa4/

Only in 2.4.19rc3aa4: 00_coherent-oops-locking-1

	Lock around the printk in mm/fault.c too (from Benjamin LaHaise).

Only in 2.4.19rc3aa3: 00_extraversion-2
Only in 2.4.19rc3aa4: 00_extraversion-3

	Bump extraversion (popular request).

Only in 2.4.19rc3aa4: 00_stack-overflow-detection-1

	Detect stack overflows dynamically during irqs (from Benjamin LaHaise)

Only in 2.4.19rc3aa4: 05_vm_20_cleanups-1

	Avoid a few minor compile warnings.

Only in 2.4.19rc3aa3: 10_rawio-vary-io-10
Only in 2.4.19rc3aa4: 10_rawio-vary-io-11

	Fix typo.

Only in 2.4.19rc3aa3: 10_sched-o1-hyperthreading-1
Only in 2.4.19rc3aa4: 10_sched-o1-hyperthreading-2

	Fix another typo, and reorganized algorithm
	from J.A. Magallon.

Only in 2.4.19rc3aa4: 50_uml-patch-2.4.18-47.gz
Only in 2.4.19rc3aa3: 52_uml-sys-read-write-3
Only in 2.4.19rc3aa4: 52_uml-sys-read-write-4

	Latest uml updates from Jeff.

Only in 2.4.19rc3aa3: 70_xfs-1.1-4.gz
Only in 2.4.19rc3aa4: 70_xfs-1.1-5.gz

	Rediffed.

Only in 2.4.19rc3aa3: 90_module-oops-tracking-2
Only in 2.4.19rc3aa4: 90_module-oops-tracking-3

	Fix a typo (noticed with an impressive low latency by Keith Owens ;)

Only in 2.4.19rc3aa4: 9900_aio-1.gz

	Merged async-io from Benjamin LaHaise after purifying it from the
	/proc/libredhat.so mess that made it not binary compatible with 2.5.

	While merging I did a number of cleanups and fixes, to mention a few of
	them I fixed a shell root exploit in map_user_kvect by using
	get_user_pages (that honours VM_MAYWRITE), it avoids corruption of
	KM_IRQ0 by doing spin_lock_irq in aio_read_evt, and a number of other
	minor not security and not stability related changes.  Left out the
	networking async-io, it can be merged trivially at a later stage (if
	needed :).

	This breaks all archs except x86 again. I just took care of the most
	obvious bits like highmem and kmap-types in the kiovec api, but still
	the wtd semaphores are missing and they go down to asm. So to compile
	on alpha s390 and s390x for now you can simply backout this patch
	called 9900__aio-1.gz and it should work fine then.

Only in 2.4.19rc3aa4: 9900_aio-API-x86-1

	Implement a real API to use async-io with true registered syscalls
	(to avoid the not 2.5 forward compatible dynamic syscalls and
	/proc/libredhat.so hack).

	Patch for 2.5 to register the true syscalls in mainline is here:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.5/2.5.29/aio-api-1

Andrea
