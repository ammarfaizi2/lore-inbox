Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280784AbRKYJ0G>; Sun, 25 Nov 2001 04:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280799AbRKYJZq>; Sun, 25 Nov 2001 04:25:46 -0500
Received: from c1603961-a.bvrtn1.or.home.com ([65.12.251.105]:55682 "EHLO
	water.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S280784AbRKYJZZ>; Sun, 25 Nov 2001 04:25:25 -0500
From: Nathan Dabney <smurf@osdlab.org>
Date: Sun, 25 Nov 2001 01:25:07 -0800
To: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Cc: David Relson <relson@osagesoftware.com>
Subject: Re: Kernel Releases
Message-ID: <20011125012507.C6414@osdlab.org>
In-Reply-To: <3C0083A2.A817BFE@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C0083A2.A817BFE@kegel.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 09:37:38PM -0800, Dan Kegel wrote:
> David Relson <relson@osagesoftware.com> wrote:
> > With the recent problems, the working 
> > versions tend to be the -pre1 or -pre2 releases, not the released 
> > one.  With a bit of QA, I think we can have 2.4.x releases be the stable 
> > releases.  Here's how...
> > 
> > When the kernel maintainer, now Marcelo for 2.4, is ready to release the 
> > next kernel, for example 2.4.16, I suggest he switch from "pre?" to "-rc1" 
> > (as in release candidate).  A day or two with -rc1 will quickly show if it 
> > has a show stopper.  If so, then the minor fixes (and nothing else) go into 
> > -rc2.  A day or two ..., and either -rc3 appears or we have a stable 
> > release and 2.4.16 is ready to be released.
> > 
> > Let's go the extra distance and have the releases be usable, stable 
> > kernels!  It's what users want and it's within the abilities of the 
> > developers to produce.  Let's do it :-)
> 
> Hear, hear!  
> 
> Also, Marcelo should get in touch with the nice folks at stp@osdlab.org
> and find out what sort of regression tests they will be running on
> his kernels.  Perhaps he can wait for their feedback on the -rcX
> kernels before declaring them final.  (Not that they would have
> found the 2.4.15 problem with their current tests, but they'll
> catch a few things.)
> 
> - Dan

We will be running all the available tests (until that list gets too large
to be possible) on each kernel the morning after it's released.  That's
including pre/test/flyingmonkey/whatever.  The test requests after a kernel
release are currently automatic.

The regression tests we have planned are the majority of the tests available
under the Linux Test Project (sourceforge:LTP).  We have not however
finished setting these up for automation.

Marcelo is also already working with the lab on non-stp related projects.

QA on the Linux Kernel will happen.  However just like everything else in the 
Linux world, it won't be what you are used to.  (read: automatic bug
submissions to the LK list will NOT happen.)

One potential issue for waiting for these tests to finish before moving on
to the next release is the fact that while all the tests are /requested/ the
morning after a kernel hits kernel.org, they may not finish for days.  This is
because of other tests in the queues from developers or tests that take 
longer than a single day to complete.  My thoughts on this tend towards
having a short set of tests that can be considered a "smoke test" on the
kernel to verify a short list of basic QA items before the major tests are
ordered against a kernel.  This short list would catch most compile/boot
issues as well as a limited range of driver problems and a decent number of
kernel component performance areas.  I see the potential to have the STP
going in the background from the development effort and only becoming
visible to the LK list when we find problems or other things worth
commenting on.  I don't see a benefit for the development effort to be
driven or controlled by anything the QA process does or doesn't do.

It's a constant game of catch up and verification.  But at least the tools
are getting better.

-Nathan
