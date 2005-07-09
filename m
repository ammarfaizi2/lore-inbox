Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVGIUuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVGIUuA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 16:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVGIUuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 16:50:00 -0400
Received: from [206.246.247.150] ([206.246.247.150]:19937 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261728AbVGIUt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 16:49:59 -0400
Date: Sat, 9 Jul 2005 16:49:52 -0400
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       scjody@modernduck.com
Subject: Re: [2.6 patch] drivers/ieee1394/: schedule unused EXPORT_SYMBOL's for removal
Message-ID: <20050709204952.GN29099@phunnypharm.org>
References: <20050709030734.GD28243@stusta.de> <200507090722.j697Mcrv015292@einhorn.in-berlin.de> <20050709075035.GA20151@phunnypharm.org> <20050709185557.GI28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709185557.GI28243@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 08:55:57PM +0200, Adrian Bunk wrote:
> On Sat, Jul 09, 2005 at 03:50:35AM -0400, Ben Collins wrote:
> 
> > Can we, instead of removing these, wrap then in a "Export full API" config
> > option? I've already got several reports from external projects that are
> 
> This will end in all distributions having this option enabled resulting 
> in no change compared to todays status quo.

Yeah, I've heard this over and over, but as someone who works with
distributing Linux, I can say it is utterly incorrect. Distributors are
looking to support as little as possible and make things as tight and
stable as possible. THe API is only there for people doing development
work of some sort, and those people are going to be building kernels from
scratch anyway. That's the people that will enable this option.

And if it's as you suggest, that there is so much demand on the
distributions by users to enable this option, then by all means that
should show that it needs to be there anyway, don't you think? Not only
that, the distributions could just as easily add patches to put them back,
in order to support it, so taking it out completely doesn't help anything.


> > using most of these exported symbols, and I'd hate to make it harder on
> > them to use our drivers (for internal projects or otherwise).
> 
> What are these external projects?
> 
> Is they are internal projects, re-adding the EXPORT_SYMBOL's should be 
> trivial for them.
> 
> If they aren't only internal internal project, why can't they simply be 
> merged (making all discussions about removal of the EXPORT_SYMBOL's they 
> use obsolete)?

These projects all fall in a lot of categories, from hobbyist, to
acedemics, to companies doing embedded systems (I've gotten feedback from
someone using linux1394 in next generation US fighter planes, and they
have some custom modules).

Allowing them to do as little changing to the kernel as possible makes
their life easier, and ensures that changes we get back are cleaner and
more useful. Plus for two of those three examples, they may be
distributing their work to classmates or other hobbyists. THis might be in
the way of a single driver file that can be compiled with a stock kernel,
and no one wants to say "oh, and you need to patch the ieee1394 drivers
before you can use my driver".

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
