Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbUCCNOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 08:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUCCNOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 08:14:39 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:1543 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261577AbUCCNOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 08:14:37 -0500
Subject: RE: Desktop Filesystem Benchmarks in 2.6.3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Mike Gigante <mg@sgi.com>
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       David Weinehall <david@southpole.se>,
       Andrew Ho <andrewho@animezone.org>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>, Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
In-Reply-To: <KHEHKKKAAILFJGJCHDCAAEFFEKAA.mg@sgi.com>
References: <KHEHKKKAAILFJGJCHDCAAEFFEKAA.mg@sgi.com>
Content-Type: text/plain
Message-Id: <1078319654.1113.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 03 Mar 2004 14:14:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 11:24, Mike Gigante wrote:
> On Wednesday 03 March 2004 10:43, Felipe Alfaro Solana wrote:
> > But XFS easily breaks down due to media defects. Once ago I used XFS,
> > but I lost all data on one of my volumes due to a bad block on my hard
> > disk. XFS was unable to recover from the error, and the XFS recovery
> > tools were unable to deal with the error.
> 
> A single bad-block rendered the entire filesystem non-recoverable 
> for XFS? Sounds difficult to believe since there is redundancy such
> as multiple copies of the superblock etc.

You should believe it... It was a combination of a power failure and
some bad disk sectors. Maybe it was just a kernel bug, after all, as
this happened with 2.5 kernels: during kernel bootup, the kernel invoked
XFS recovery but it failed due to media errors.

> I can believe you lost *some* data, but "lost all my data"??? -- I 
> believe that you'd have to had had *considerably* more than 
> "a bad block" :-)

It was exactly one disk block, at least that's what the low-level HDD
diagnostic program for my IBM/Hitachi laptop drive told me. In fact, the
HDD diagnostic was able to recover the media defects.

That could have been one of those very improbable cases, but I lost the
entire volume. Neither the kernel nor XFS tools were able to recover the
XFS volume. However, I must say that I didn't try every single known way
of performing the recovery, but recovery with ext2/3 is pretty
straightforward.

As I said, it could have been a kernel bug, or maybe I simply didn't
understand the implications of recovery, but xfs_repair was totally
unable to fix the problem. It instructed me to use "dd" to move the
volume to a healthy disk and retry the operation, but it was not easy to
do that as I explained before.

