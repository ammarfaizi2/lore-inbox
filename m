Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVLROMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVLROMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 09:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVLROMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 09:12:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61713 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932305AbVLROMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 09:12:05 -0500
Date: Sun, 18 Dec 2005 15:12:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Poole <mdpoole@troilus.org>
Cc: 7eggert@gmx.de, Andi Kleen <ak@suse.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051218141206.GC23349@stusta.de>
References: <5k9sD-5yh-13@gated-at.bofh.it> <5knFp-kU-51@gated-at.bofh.it> <5korL-1xX-33@gated-at.bofh.it> <5kpRh-3sK-11@gated-at.bofh.it> <5kq0L-3FB-37@gated-at.bofh.it> <5kOma-4K1-23@gated-at.bofh.it> <5kRk3-xO-11@gated-at.bofh.it> <E1EnrYH-00019M-Ep@be1.lrz> <20051218122818.GB23349@stusta.de> <87k6e2ldt3.fsf@graviton.dyn.troilus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6e2ldt3.fsf@graviton.dyn.troilus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 08:44:56AM -0500, Michael Poole wrote:
> Adrian Bunk writes:
> 
> > On Sun, Dec 18, 2005 at 06:57:44AM +0100, Bodo Eggert wrote:
> > > 
> > > Would you run a desktop with an nfs server on xfs on lvm on dm on SCSI?
> > > Or a productive server on -mm?
> > > 
> > > IMO it's OK to push 4K stacks in -mm, but one week of no error reports from
> > > a few testers don't make a reliable system.
> > > [...]
> > 
> > It isn't that 4k stacks were completely untested.
> > 
> > Fedore enables it for a long time.
> > 
> > Even RHEL4 always uses 4k stacks - and RHEL is a distribution many 
> > people use on their production servers.
> 
> As was pointed out previously in this thread, at least one
> configuration that is known to have problems with 4k stacks is simply
> not supported by RHEL.  How many more are like that?

s/is known/was known/

XFS got fixed and Neil's patch should fix the rest of the problem.

My count of bug reports for problems with 4k stacks after Neil's patch
went into -mm is still at 0.

4k stacks are always used by Fedora.
4k stacks are always used by RHEL4.

Granted, there might be some small areas that are not covered by such
distributions.

You ask "How many more are like that?".
That's exactly the question I want answers for by always enabling it 
in -mm.

-mm is a pretty experimental kernel and everything using it knows about 
this. Many -mm kernels contain more than hundred new patches compared to 
the previous -mm kernel, and some of these patches are of the quality 
"compiles with some specific options set and might not always crash your 
kernel". A patch like always enabling 4k stacks that is essentially 
already used by at least one popular desktop distribution (Fedora) and 
at least one popular server distriution (RHEL4) already had _far_ more 
than the average testing coverage for patches in -mm, so WTF is the 
problem?

> Michael Poole

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

