Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279997AbRKIS7F>; Fri, 9 Nov 2001 13:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280021AbRKIS6z>; Fri, 9 Nov 2001 13:58:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15204 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S279997AbRKIS6n>; Fri, 9 Nov 2001 13:58:43 -0500
Date: Fri, 9 Nov 2001 19:59:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15pre1aa1
Message-ID: <20011109195900.E22594@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre1aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre1aa1/

Only in 2.4.14pre7aa2: 00_alpha-cc-1
Only in 2.4.14pre7aa2: 00_alpha-cc-1-freq-dev-1
Only in 2.4.14pre7aa2: 00_increase-logbuffer-2

	In mainline.

Only in 2.4.14pre7aa2: 00_netconsole-2.4.10-C2-1.bz2
Only in 2.4.15pre1aa1: 00_netconsole-2.4.10-C2-2.bz2

	Rediffed.

Only in 2.4.14pre7aa2: 10_vm-12
Only in 2.4.15pre1aa1: 10_vm-13

	Latest vm updates. Most important if we take a swapin on
	an exclusive swap cache that is getting swapped out (so
	locked) we don't need to lock_page or to do_wp_page, we
	can takeover the swapcache despite it's locked, if it's
	exclusive. This is possible because we can learn if it's exlcusive
	without the need of taking the page lock thanks to latest Linus's saner
	locking recent changes. So this update still delivers non blocking minor
	swapin faults, _but_ without wasteful cows.

	Also merged anon pages into the lru, now that the race I spotted in
	release_page_cache is fixed in 2.4.15pre1 (fixed by Linus, thanks!).

Only in 2.4.14pre7aa2: 50_uml-patch-2.4.13-3.bz2
Only in 2.4.15pre1aa1: 50_uml-patch-2.4.13-5.bz2

	Latest Jeff's update.

Only in 2.4.14pre7aa2: 60_atomic-lookup-4
Only in 2.4.15pre1aa1: 60_atomic-lookup-5

	Rediffed.

Only in 2.4.14pre7aa2: 60_tux-2.4.13-ac5-A5.bz2
Only in 2.4.15pre1aa1: 60_tux-2.4.13-ac5-B0.bz2

	Latest Ingo's update (didn't checked if this fixes the trivial
	kernel-wise hostname DoS yet).

	Tux is obviously potentially less safe than any userspace webserver [in
	this case it DoS the while machine, it's not enough to restart the
	webserver like you could do if the same overflow bug was in an
	userspace webserver], and of course security wise there's no chroot
	that can help if the kernel overflows.

	The advantage of Tux is that it can reach higher performance by saving
	the cost of syscalls, tlb flushing, 4M global pagetables, and by using
	internal kernel functionalities without being slowed down by user
	protection API and by being able to use _all_ kernel internal
	functionalities even if an user API is missing (like for cpus_allowed
	and zerocopy parsing in the dma buffer etc...).  But it's by no means
	"safer" than its userspace counterparts, period. Or more precisely: if
	it is safer it's not because it's in kernel but it's because Ingo wrote
	it :).

Andrea
