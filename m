Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278448AbRJ1PlK>; Sun, 28 Oct 2001 10:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278527AbRJ1PlB>; Sun, 28 Oct 2001 10:41:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:56436 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278448AbRJ1Pks>; Sun, 28 Oct 2001 10:40:48 -0500
Date: Sun, 28 Oct 2001 16:41:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14pre3aa2
Message-ID: <20011028164108.E1396@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I merged some bits from mainline to trigger swapout earlier to see if it
helps , but still no anon pages in the lru, it's easy to add them back
in the lru as soon as we verify the largemem works ok too.

As usual it is been tested on high end hardware kindly provided by
www.osdlab.org.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre3aa2/
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre3aa2.bz2

Only in 2.4.14pre3aa1: 00_rcu-poll-1
Only in 2.4.14pre3aa2: 00_rcu-poll-2

	Don't waste an additional cacheline, move the quiescent sequence number
	in the schedule_data so rcu become zerocost in terms of cpu cache and
	memory bandwith in the fast path.

Only in 2.4.14pre3aa1: 10_numa-sched-12
Only in 2.4.14pre3aa2: 10_numa-sched-13

	rediffed due rcu-poll changes.

Only in 2.4.14pre3aa1: 10_vm-5
Only in 2.4.14pre3aa2: 10_vm-6

	Merged max_mapped*10 logic from Linus, still not adding anon pages
	from the lru, so we can see the difference, I can readd the anon
	pages to the lru anytime as soon as it's clear what's better.

Andrea
