Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbTCOEyQ>; Fri, 14 Mar 2003 23:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbTCOEyQ>; Fri, 14 Mar 2003 23:54:16 -0500
Received: from mail-5.tiscali.it ([195.130.225.151]:8087 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S261389AbTCOEyP>;
	Fri, 14 Mar 2003 23:54:15 -0500
Date: Sat, 15 Mar 2003 06:05:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre5aa2
Message-ID: <20030315050503.GA1252@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre5aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre5aa2/

diff between 2.4.21pre5aa1 and 2.4.21pre5aa2:

Only in 2.4.21pre5aa1: 00_extraversion-20
Only in 2.4.21pre5aa2: 00_extraversion-21

	Rediffed.

Only in 2.4.21pre5aa1: 00_smp-timers-not-deadlocking-1
Only in 2.4.21pre5aa2: 00_smp-timers-not-deadlocking-2

	Fixed smp race in mod_timer() with a spinlock-by-hand, so it
	doesn't break all the callers. Thanks to Andrew to point it out.

Only in 2.4.21pre5aa1: 60_tux-timer_t-2.gz

	Was empty. (thanks Marc-Christian ;)

Only in 2.4.21pre5aa1: 9999_fsync-msync-async-errors-1

	Dropped, before it can be re-included this should be addressed:

	1) the write failures must be propagated to the mapping both for the
	   metadata and the data for the write()s too, without requiring the bh
	   to be collected by the vm before the info is propagated
	2) all writepages/prepare_write must set the mapping->error before
	   unlocking the page

	Without those fixes it remains a best-effort, not 100% reliable in
	reporting async I/O errors, just like w/o the patch in the first place.

	Thanks to Andrew to point out the writepage race in vmscan (part of
	point 2).

Andrea
