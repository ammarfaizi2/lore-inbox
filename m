Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSGDO3g>; Thu, 4 Jul 2002 10:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317423AbSGDO3f>; Thu, 4 Jul 2002 10:29:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10766 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317422AbSGDO3e>; Thu, 4 Jul 2002 10:29:34 -0400
Date: Thu, 4 Jul 2002 15:32:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
Message-ID: <20020704153200.E11601@flint.arm.linux.org.uk>
References: <20020704130243.A11601@flint.arm.linux.org.uk> <Pine.LNX.3.96.1020704091340.4082D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020704091340.4082D-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Thu, Jul 04, 2002 at 09:33:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 09:33:19AM -0400, Bill Davidsen wrote:
> On Thu, 4 Jul 2002, Russell King wrote:
> > And you expect Linus to track every single feature and fix that exists in
> > 2.6 and 2.7?
> 
> The maintainer should have a handle on the serious problems in 2.6, and
> should be able to tell Linus who needs to look at a problem before moving
> on.

"tell Linus who needs to look at a problem" is an interesting concept.
I think many people here will know you can't do that with Linus.  Linus
makes his own decisions about what is important to x86 and no more.

> Not having a development kernel didn't work well for 2.2, it didn't
> work well in 2.4, and now some people say "we've always done it that way"
> while others say "we'll do it better this time."

There are two problems here:

1. Some maintainers won't have time to follow two trees.
2. Other maintainers continue to develop against stable trees and try to
   push their new features into stable trees.

> It's my feeling that trying something else would be a good thing, if 2.6
> doesn't get attention 2.7 could always be frozen after it exists, and
> you would still avoid having totally new featues shoved in 2.6.

Then 2.6 gets more stuff fixed and 2.7 bitrots.  It doesn't make the
problem go away.

> If 2.6 is so buggy that it takes your full time to fix, it should still
> be 2.5.

*I* can't make those decisions; they're out of my control.

> And it should take your full time. And that wouldn't be one bit
> different than if 2.7 wasn't out, would it?

The problem here is that 2.7 kicks off.  Changes are made that impact
the architecture specific code that need fixing up.  Lots of changes
happen.  These may be generic changes impacting the architecture specific
interfaces, or they may be changes that require architecture drivers to
be fixed.  Either way they need work, and there are a hell of a lot of
them over time.  This time around, I'm tracking 2.5 closely because I
don't want to spend massive amounts of time trying to fit ARM stuff into
an interface that it doesn't fit well.  I'd rather work *with* people
during design stages and sort the problems out as they come up.

Now think about what one person has to do when there's a stable tree and
a development tree...  Not only do they have to do all the above, but
they also have to handle the pressure of their respective communities
to merge developmental patches/large changes into the stable kernel.
They have to track bugs, and get stuff fixed.  Yada yada yada.

I'm completely happy the way 2.4/2.5 happened.  It worked well for me.
However, at present I'm completely ignoring the 2.4.19pre and rc stuff
at the moment because _I_ don't have time to follow it; all my recent
2.4 patches are against 2.4.18.  I hardly ever push 2.4 ARM stuff to
Marcelo.  And I don't see this changing.  So the 2.4 ARM stuff in
Marcelo's tree is set for a life of bitrot.

Ok, so 2.4 is rather stable.  Now think about the situation where 2.4
and 2.5 happen simultaneously.  I'll probably end up ignoring the stable
kernel series completely.

> If I understand what you do, it is limited to things related to your
> architecture, and not general bugs like IDE eats the filesystems, stuff
> won't compile as modules, smp locks up under high network multicast load,
> etc. Unless changes in 2.6 break your area, which will be MUCH less likely
> if new features are going in 2.7, I really wouldn't expect it to take all
> your time.

I end up doing *everyhing* (and people wonder why I sometimes get pissed
off when things change...)  An architecture maintainer isn't limited to
just the architecture specific code.  They normally get to play with
drivers and the internals of many of the kernels subsystems.  Eg, I tend
to touch at least the following areas:

1. IDE drivers.
2. SCSI drivers.
3. Network drivers.
4. Serial drivers.
5. Framebuffer drivers.
6. Filesystems.
7. MM subsystem cache and TLB stuff.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

