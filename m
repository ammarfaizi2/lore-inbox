Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbRGLIQs>; Thu, 12 Jul 2001 04:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbRGLIQb>; Thu, 12 Jul 2001 04:16:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7988 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267434AbRGLIQK>; Thu, 12 Jul 2001 04:16:10 -0400
Date: Thu, 12 Jul 2001 10:16:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7pre6aa1
Message-ID: <20010712101635.C779@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.7pre5aa1 and 2.4.7pre6aa1:

Only in 2.4.7pre5aa1: 00_bh-async-2
Only in 2.4.7pre6aa1: 00_bh-async-3

	Rediffed again due trivial rejects.

Only in 2.4.7pre5aa1: 00_drop___unlock_buffer-1
Only in 2.4.7pre5aa1: 00_drop_end_buffer_write-1
Only in 2.4.7pre5aa1: 00_kiobuf-backout-get_bh-1
Only in 2.4.7pre5aa1: 00_linus-brelse-fix-1

	Merged in mainline.

Only in 2.4.7pre6aa1: 00_iput-debug-1

	Minor debugging check.

Only in 2.4.7pre6aa1: 00_lvm-0.9.1_beta7-4_rwsem-fast-path-1

	Converted the semaphores in the lvm very fast path to rwsemaphores, so
	we never block on locks in the common case. I'd like to know
	if this makes a difference to Oracle users. It is incremental
	with lvm beta7 (that was just previously included into my tree).

Only in 2.4.7pre5aa1: 00_rwsem-14
Only in 2.4.7pre6aa1: 00_rwsem-15

	Temporarily turned off alpha optimizations because they don't fit into
	this framework, will turn them on ASAP.

Only in 2.4.7pre5aa1: 00_softirq-fixes-4
Only in 2.4.7pre6aa1: 00_softirq-fixes-5

	Dropped the definition of smp_mb__ for the atomic_t operations that are
	now in mainline (left the other parts).

Only in 2.4.7pre6aa1: 40_blkdev-pagecache-5

	Now fixed also initrd, and tested that reads and writes with part of
	the page beyond of the end of the device works (assuming userspace
	knows where the device ends without relying on the last
	readable/writeable byte, kernel doesn't destabilize if you write and
	read beyond the end though).

Andrea
