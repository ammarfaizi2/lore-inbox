Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131553AbQLHUO5>; Fri, 8 Dec 2000 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132641AbQLHUOn>; Fri, 8 Dec 2000 15:14:43 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:61174 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S132644AbQLHUO1>; Fri, 8 Dec 2000 15:14:27 -0500
Date: Fri, 8 Dec 2000 11:43:50 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: davej@suse.de
cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, Rainer Mager <rmager@vgkk.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
In-Reply-To: <Pine.LNX.4.21.0012080321180.13163-100000@neo.local>
Message-ID: <Pine.LNX.4.21.0012081140070.24557-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000 davej@suse.de wrote:

> On Thu, 7 Dec 2000, Jeff V. Merkey wrote:
> 
> > I think there may be a case when a process forks, that the MMU or some
> > other subsystem is either not setting the page bits correctly, or
> > mapping in a bad page.  It's a LEVEL I bug in 2.4 is this is the case,
> > BTW.  In core dumps (I've looked at 2 of them from SSH) it barfs right
> > after executing fork() or one of the exec functions and at some places
> > in the code where there's not any obvious coding bugs.  Looks like some
> > type of mapping problem.  I reported it three months ago, but it was
> > pretty much ignored.
> > 
> > Linus needs to add this one to the pre-12 list -- looks like some type
> > of mapping bug.
> 
> Now that you mention it, every app that has bombed has been the type
> that forks a lot. MpegTV, gtv, and make spring to mind. All apps drive
> the CPU load up quite a lot, which was why I initially suspected
> overheating. I don't see it on my other 2.4 boxes though which is
> suspicious. But they don't get as much of a beating as this, which was
> up until last week my main workstation.

Just to add some input and insight on here, I loaded the system down with
some FFT algorithms, and then ran an 8-way kernel compile. The machine in
question is a dual P3/600 with 512MB RAM, 2.4.0-test11. The load
skyrocketed to a mere 13.6. xmms was still running, didn't skip even
once. The FFT algorithms didn't bitch at all. Neither did the kernel
compile. In fact, it compiled without a hitch...

I dunno what to say about these boxes that segfault all the
time... Probably just bad hardware somewhere along the lines.

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
