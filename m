Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUGVX0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUGVX0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUGVX0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:26:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59334 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266124AbUGVXZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:25:47 -0400
Date: Fri, 23 Jul 2004 01:25:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040722232540.GH19329@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de> <20040722152839.019a0ca0.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722152839.019a0ca0.pj@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 03:28:39PM -0700, Paul Jackson wrote:

> > There's much worth in having a very stable kernel.
>...
> Now, I repeat, this is at the head end.  End users who want stability
> aren't feeding directly off kernel.org anyway.

It depend on your definition of "end users" and "stability".

You might be right for people buying for many $$$ distributions with 
support to run Oracle on it.

But I know many people who run ftp.kernel.org kernels on many 
workstations and small servers e.g. in universities.

> The affect downstream on real users is this.  If the head end operates
> in big chunky style, then as this big change flows downstream, it makes
> transitions for distros, service providers and middlemen more costly and
> difficult, creating expenses that must be passed on to the end user.

Currently there's one transition to a new major release of the kernel 
every few years. You wait until a new major release of the kernel has 
matured, test whether both the transition and the new kernel work, and 
update the kernel.

An update to a new minor version of the kernel was until now relatively 
cheep since breakages that require further investigation were relatively 
seldom.

And what happens if you are a distribution, kernel 2.6.15 is the current 
kernel containing many important updates, but $nontrivial_feature added 
in 2.6.10 broke $architecture your distribution supports. This means you 
have to support both kernel versions with security updates creating  
expenses that must be passed on to the end user.

I vaguely remember such issues in the past like DECstation support 
was broken since 2.4.20, and some m68k subarchs that were at least until 
recently not working in any kernel more recent than 2.2 .

Such breakages might occur more often in the future during a stable 
series.

> Yes - damming up the flow of changes creates stability.  But if you're a
> middleman, you don't need Linus to choose where to build the dam, and
> when to open the flood gates.  It's more efficient for you to choose for
> yourself when to do that damming, based on your particular resources and
> customer needs, rather than have to deal with hundred year floods and
> draughts imposed on you by Zeus.
> 
> The end user always gets their stability, if only because they won't
> upgrade a system that is "working".

How do such end users get security updates?

> And every change at the head end is disruptive for some poor slob.
> The only perfectly compatible change is no change at all.  We delude
> ourselves if we think we can separate the "safe" fixes and additions
> from the "unsafe" incompatible changes.  Better that we should expend
> some energy on smoothing out and minimizing the cost of change to those
> downstream from us.  This needs to be done the old-fashioned way, one
> change at a time.
> 
> The question is whether we impose, on all those downstream from us,
> occasional hundred year floods, or do we provide a steady stream, and
> let them build their own little beaver dams, as suits their various and
> diverse needs and business cycles.
>...

But what to do if some part of the kernel (let's call it "XFS") has some 
problems (let's call it "Oops") with a new feature (let's call it "4kb 
stacks on i386") introduced in a kernel during a stable kernel series 
(let's call it "2.6.6") and this isn't fixed by the maintainers (let's  
call them "SGI") for some time (let's call it "until now")?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

