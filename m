Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264200AbTE0WCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTE0WCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:02:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52609
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264200AbTE0WCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:02:09 -0400
Date: Wed, 28 May 2003 00:15:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21rc4aa1
Message-ID: <20030527221551.GA1453@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc4aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc4aa1/

changelog diff between 2.4.21rc2aa1 and 2.4.21rc4aa1:

Only in 2.4.21rc2aa1: 00_F_DUPFD-fcntl-rlimit-1

	Obsoleted by an old patch from Rusty in mainline
	(was harmless, just a duplicated check, noticed by
	Al Viro)

Only in 2.4.21rc2aa1: 00_extraversion-22
Only in 2.4.21rc4aa1: 00_extraversion-23
Only in 2.4.21rc2aa1: 40_o_direct-reiserfs-1
Only in 2.4.21rc4aa1: 40_o_direct-reiserfs-2

	Rediffed.

Only in 2.4.21rc4aa1: 00_fcntl-dupfd-unsigned-long-cleanups-1

	Cleanup for the sign issue and removed worthless check.
	From Andrew Morton.

Only in 2.4.21rc4aa1: 00_ksoftirqd-max-loop-networking-1

	Loop N = 8 times before waking ksoftirqd. That may be
	too much but I want to try if still the lots of people complains about
	suprious ksoftirqd wakes. Once ksoftirqd is runnable don't loop more
	than once (like it's rescheduling, the bulk of the work has to happen
	in ksoftirqd still, we can't do more than just one pass if it's running
	or we risk very huge unfariness, i.e. like w/o ksoftirqd at all).

Only in 2.4.21rc4aa1: 00_max-threads-pid-nr-1

	Don't create more threads than the pid space
	on 64bit, from Egenera.

Only in 2.4.21rc2aa1: 00_panic-export-1
Only in 2.4.21rc4aa1: 00_panic-export-2

	Merged in mainline (except one last bit).

Only in 2.4.21rc4aa1: 00_profile-read-efault-1

	Return -EFAULT if the profile is buffer is invalid,
	from Daniele Bellucci.

Only in 2.4.21rc2aa1: 00_remove_inode_page-prune_icache-smp-race-1

	Merged in mainline.

Only in 2.4.21rc4aa1: 00_scsi-scan-new-devices-2

	Add an hook to trigger a rescan of the scsi devices,
	from Egenera.

Only in 2.4.21rc2aa1: 30_irq-balance-13
Only in 2.4.21rc4aa1: 30_irq-balance-14

	First assume ksoftirqd running as an idle cpu from irq balancing
	purposes. The softirq load statistically follows the hardirq load, so
	by going away from ksoftirqd, we may generate a suprious bouncing
	across different cpus.

	Secondly change irq routing with HT only if the whole physical cpu is
	idle.

Only in 2.4.21rc2aa1: 9985_blk-atomic-7
Only in 2.4.21rc4aa1: 9985_blk-atomic-8

	The blk-atomic + varyio wasn't right in its first untested version,
	the refile had to be a few lines below, this is right and slightly
	tested on my 4-way.

Only in 2.4.21rc2aa1: 9995_frlock-gettimeofday-5
Only in 2.4.21rc4aa1: 9995_frlock-gettimeofday-6

	Fixed a few missing includes.

Only in 2.4.21rc4aa1: 9999_dm-1

	Merge the device mapper (and in turn the mempool and in turn
	stop ext3 from abusing the lowlevel b_private).

Only in 2.4.21rc4aa1: 9999_truncate-nopage-race-1

	Fix the race between truncate and the page faults
	found by Paul Mackerras. the fix uses the sequence
	locks (i.e. frlocks since I was too lazy to rename them
	in 2.4) to ensure after a truncate none "anonymous" page can be left
	mapped. That could generate userspace memory corruption (not kernel
	crashes but still potential data loss). Thanks to Daniel McNeil and
	Andrew for the help in cleaning up the fix. The design of the fix
	allows performance to be unaffected. Crossing fingers that the inode
	always exists ;).

Andrea
