Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269974AbRHEQ2E>; Sun, 5 Aug 2001 12:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269975AbRHEQ1o>; Sun, 5 Aug 2001 12:27:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18542 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269974AbRHEQ1g>; Sun, 5 Aug 2001 12:27:36 -0400
Date: Sun, 5 Aug 2001 18:28:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: jeremy@classic.engr.sgi.com
Subject: blkdev-pagecache-11
Message-ID: <20010805182825.H21840@athlon.random>
In-Reply-To: <20010802150529.A24436@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010802150529.A24436@athlon.random>; from andrea@suse.de on Thu, Aug 02, 2001 at 03:05:29PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This new update 1) runs get_super after fsync_dev in invalidate_device
to avoid sleeping before the lock_super in case do_sync == 1, 2)
replaces the softblocksize bugcheck in ll_rw_block with an hardblocksize
bugcheck, now the softblocksize is a purerly filesystem thing, completly
unrelated to the other ways of doing I/O (this fixes false positives of
such bugcheck after a mount of a 4k fs).

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.8pre4/blkdev-pagecache-10

as usual you must apply the o_direct patch first (the o_direct patch
has no updates and it stays at the -11 revision):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.8pre4/o_direct-11

Andrea
