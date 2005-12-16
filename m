Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVLPOMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVLPOMH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLPOMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:12:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6162 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932277AbVLPOMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:12:05 -0500
Date: Fri, 16 Dec 2005 15:12:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216141206.GZ23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <Pine.LNX.4.64.0512151746270.1678@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512151746270.1678@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 05:49:45PM -0800, Zwane Mwaikambo wrote:
> On Thu, 15 Dec 2005, Adrian Bunk wrote:
> 
> > On Thu, Dec 15, 2005 at 02:00:13PM -0800, Andrew Morton wrote:
> > 
> > > Supporting 8k stacks is a small amount of code and nobody has seen a need
> > > to make changes in there for quite a long time.  So there's little cost to
> > > keeping the existing code.
> > > 
> > > And the existing code is useful:
> > > 
> > > a) people can enable it to confirm that their weird crash was due to a
> > >    stack overflow.
> > > 
> > > b) If I was going to put together a maximally-stable kernel for a
> > >    complex server machine, I'd select 8k stacks.  We're still just too
> > >    squeezy, and we've had too many relatively-recent overflows, and there
> > >    are still some really deep callpaths in there.
> > 
> > a1) People turn off 4k stacks and never report the problem / noone 
> >     really debugs and fixes the reported problem.
> > 
> > Me threatening people with enabling 4k stacks for everyone already 
> > resulted in several fixes.
> 
> How about this, we apply this patch and perhaps add some debug option to 
> enable 8k by changing THREAD_SIZE. This way we have the seperate interrupt 
> stacks and 8k stacks for when someone suspects a stack overflow.

You can always manually change THREAD_SIZE using a text editor.

My count of bug reports for problems with in-kernel code with 4k stacks 
after Neil's patch went into -mm is still at 0.

Either there are no problems left or noone pays attention to them since 
disabling 4k stacks "fixed" the problem. And not having an option makes 
it more likely that we get reports for and people interested in fixes 
for the latter.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

