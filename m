Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316243AbSE3Bl3>; Wed, 29 May 2002 21:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316239AbSE3Bke>; Wed, 29 May 2002 21:40:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2907 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316163AbSE3Bjk>; Wed, 29 May 2002 21:39:40 -0400
Date: Thu, 30 May 2002 03:40:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre9aa1
Message-ID: <20020530014009.GC1383@dualathlon.random>
In-Reply-To: <20020530010125.GA1383@dualathlon.random> <20020530013200.GB14918@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 06:32:00PM -0700, William Lee Irwin III wrote:
> On Thu, May 30, 2002 at 03:01:25AM +0200, Andrea Arcangeli wrote:
> > NOTE: this release is highly experimental, while it worked solid so far
> > it's not well tested yet, so please don't use in production
> > environments! (yet :)
> > The o1 scheduler integration will take a few weeks to settle and to
> > compile on all archs. I would suggest the big-iron folks to give this
> > kernel a spin, in particular for o1, shm-rmid fix, p4/pmd fix,
> > inode-leak fix. The only rejected feature is been the node-affine
> > allocations of per-cpu data structures in the numa-sched (matters only
> > for numa, but o1 is more sensible optimization for numa anyways).
> > Currently only x86 and alpha compiles and runs as expected. x86-64,
> > ia64, ppc, s390*, sparc64 doesn't compile yet. uml worst of all compiles
> > but it doesn't run correctly :), however it runs pretty well too, simply
> > it hangs sometime and you've to press a key in the terminal and then it
> > resumes as if nothing has happened.
> 
> I noticed what looked like missed wakeups in tty code in early 2.4.x
> ports of the O(1) scheduler, though I saw a somewhat different failure
> mode, that is, the terminal echo would remain one character behind
> forever (and if it happened again, more than one). I never got a real
> answer to this, unfortunately, as it appeared to go away after a certain
> revision of the scheduler. The failure mode you describe is slightly
> different, but perhaps related.

interesting, a tty problem could explain it probably, but being it
reproducible only with uml it should be still some uml internal that
broke, not a generic bug, there are no changes to the tty code and it's
unlikely that only the tty code broke due a generic o1 bug and that
additionally it is reproducible only in uml.

> 
> And thanks for looking into shm, I understand that area is a bit
> painful to work around, but fixes are certainly needed there.

you're very welcome.

Andrea
