Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269035AbRHBPaa>; Thu, 2 Aug 2001 11:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269029AbRHBPaU>; Thu, 2 Aug 2001 11:30:20 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12412 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269035AbRHBPaL>; Thu, 2 Aug 2001 11:30:11 -0400
Date: Thu, 2 Aug 2001 17:30:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8pre3aa1
Message-ID: <20010802173058.C24436@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff between 2.4.7aa1 and 2.4.8pre3aa1 (besides moving on top of
2.4.8pre3aa1). Possibly the vm is screwedup in 2.4.8pre3 so 2.4.8pre3aa1
could behave very badly too (possibly the blkdev in pagecache could hide
problems with the buffercache so please make sure to stress the
buffercache with fs fs metadata too).

Only in 2.4.8pre3aa1: 00_backout-local_bh_enable-debug-1

	Drop some leftover. However I recommend all people with the aic driver
	to apply my debugging patch that I posted to l-k in reply to Alexey and
	to fix the bug instead of hiding and forgetting it (smp_call_function
	*must* be recalled with irq enabled!!!).

Only in 2.4.7aa1: 00_free_shortage-bool-1

	Dropped, it was a minor optimization and it rejected with some vm
	update.

Only in 2.4.8pre3aa1: 00_gcc-30-aironet-1
Only in 2.4.7aa1: 00_gcc-30-extern-static-1
Only in 2.4.8pre3aa1: 00_gcc-30-extern-static-2
Only in 2.4.7aa1: 00_gcc-30-reiserfs-1

	Some s/extern/static/ merged in mainline so dropped or updated the
	rest.

Only in 2.4.7aa1: 00_ircomm-t39m-1
Only in 2.4.7aa1: 00_max_readahead-1
Only in 2.4.7aa1: 00_net_rx_softirq-optimize-1
Only in 2.4.7aa1: 00_softirq-fixes-5

	Merged in mainline.

Only in 2.4.7aa1: 00_o_direct-10
Only in 2.4.8pre3aa1: 00_o_direct-11

	Bugfix from Ken to update the inode size correctly.

Only in 2.4.8pre3aa1: 00_softirq-fixes-6_wait-network-fixes-1

	Workaround the fact not all netif_rx callers know they have to run
	do_softirq() if they run in normal kernel context (will be dropped as
	soon as the lowlevel drivers learnt that in mainline, this is just a
	*very* temporary thing).

Only in 2.4.7aa1: 40_blkdev-pagecache-7
Only in 2.4.8pre3aa1: 40_blkdev-pagecache-8

	Move to 1k granularity to be backwards compatible. Some other backwards
	compatible change like ignoring O_APPEND to workaround buggy programs.

Only in 2.4.7aa1: 30_tux
Only in 2.4.8pre3aa1: 60_atomic-alloc-3
Only in 2.4.8pre3aa1: 60_atomic-lookup-4
Only in 2.4.8pre3aa1: 60_net-exports-1
Only in 2.4.8pre3aa1: 60_pagecache-atomic-1
Only in 2.4.8pre3aa1: 60_tux-3
Only in 2.4.8pre3aa1: 60_tux-data-1
Only in 2.4.8pre3aa1: 60_tux-dprintk-1
Only in 2.4.8pre3aa1: 60_tux-exports-1
Only in 2.4.8pre3aa1: 60_tux-kstat-2
Only in 2.4.8pre3aa1: 60_tux-process-1
Only in 2.4.8pre3aa1: 60_tux-syscall-1
Only in 2.4.8pre3aa1: 60_tux-sysctl-2
Only in 2.4.8pre3aa1: 60_tux-vfs-2
Only in 2.4.8pre3aa1: 61_tux-logger-1
Only in 2.4.8pre3aa1: 62_tux-uml-1

	Tux moved out of the separate directory and applied as last thing.

Andrea
