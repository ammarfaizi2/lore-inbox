Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVEXXR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVEXXR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVEXXR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 19:17:29 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:8964 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262154AbVEXXRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 19:17:19 -0400
Date: Tue, 24 May 2005 16:21:55 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050524232155.GB17781@nietzsche.lynx.com>
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <42930E79.1030305@cybsft.com> <42934674.30406@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42934674.30406@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 01:21:24AM +1000, Nick Piggin wrote:
> Maybe there are damn few because it is hard to get right within
> the framework of a general posix environment. Or maybe its
> because it has a comparatively small userbase (compared to say
> mid/small servers and desktops). Which are neither completely
> invalid reasons against its inclusion in Linux.

Rest assured RTOS companies are going to flip when this gets
to the mainstream. You might not be aware of this, but this is
probably end up being the single most important patch in the
software industry when it hits the mainstream. There's been
an over emphasis on desktop/server and really persistent lack
of understanding of the embedded market and growth within it.

One of the main reasons why Linux isn't used for more embedded
systems is the lack of hard RT abilities. With this patch, it
has a chance to hit a large section of future consumer devices,
audio/video, with the performance of frame accurate SGI IRIX
boxes. SGI XFS supports some of these features but is under
utilized at this moment partially as a side effect of poor
Linux latency performance. As app folks start to use this more
the more various subcomponents will get fixed.

There's a lot of bad X11 and other app code out there in
userspace.

There's active work in for getting the userspace mutex stuff
down, robust mutexes, so that the RT app folks can have a lot
more solid development environment for traditional RT applications.
However, traditional applications aren't where the excitement
is.

The non-traditional stuff, SGI and friends, is really where I
have my interests because I'm sick of jumping/droppy media
applications. Current schedulers, particularly the priority
based ones, aren't suitable for temporally partitioning run-away
applications from other apps. Introducing the RT patch so that
the scheduler has high resolution material to control along with
an appropriate frame driven scheduler can fullfill this need.
It is in a lot of ways like introducing multitasking OSes for
the first time to people who are use to MSDOS. Multimedia apps
tended to collide with each other in that regard.

With this, Linux has a strong possibility be a top gaming/multimedia
platform almost over night with retuned apps and such. Microsoft
can't do anything about it when this happens and we're so close
right now to pull it off. Having a fully preemptive core is
the precondition for all of this work.

> But I want to be clear that I haven't read or thought about the
> code in question too much, and I don't have any opinions on it
> yet. So please nobody involve me in a flamewar about it :)

The code is pretty mild for the most part and fixes a lot of
preexisting hacks (spin-waiting in drivers) in the kernel. If
anything it's triggered some preexisting bugs and stressed the
system in ways that would still be difficult to trigger in SMP
scenarios.

It's not terribly intrusive, nor does it alter the basic
concurrency structures of the kernel. If you'd like me to, I can
explain this patch to you in private. :) I was working on a
parallel project to Ingo's patches and got pretty far, but have
abandoned it for Ingo's stuff since he's knows the kernel much
better than I do, fixes things faster, etc...

bill

