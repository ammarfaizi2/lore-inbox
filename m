Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266979AbSLRRAx>; Wed, 18 Dec 2002 12:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbSLRRAx>; Wed, 18 Dec 2002 12:00:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:47795 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266979AbSLRRAu>;
	Wed, 18 Dec 2002 12:00:50 -0500
Message-ID: <3E00AB9B.E390199E@digeo.com>
Date: Wed, 18 Dec 2002 09:08:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
References: <20021218164119.GC27695@suse.de> <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 17:08:43.0734 (UTC) FILETIME=[1E991F60:01C2A6B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 18 Dec 2002, Dave Jones wrote:
> > On Wed, Dec 18, 2002 at 10:40:24AM -0300, Horst von Brand wrote:
> >  > [Extremely interesting new syscall mechanism tread elided]
> >  >
> >  > What happened to "feature freeze"?
> >
> > *bites lip* it's fairly low impact *duck*.
> 
> However, it's a fair question.
> 
> I've been wondering how to formalize patch acceptance at code freeze, but
> it might be a good idea to start talking about some way to maybe put
> brakes on patches earlier, ie some kind of "required approval process".
> 
> I think the system call thing is very localized and thus not a big issue,
> but in general we do need to have something in place.
> 
> I just don't know what that "something" should be. Any ideas? I thought
> about the code freeze require buy-in from three of four people (me, Alan,
> Dave and Andrew come to mind) for a patch to go in, but that's probably
> too draconian for now. Or is it (maybe start with "needs approval by two"
> and switch it to three when going into code freeze)?
> 

It does sound a little bureacratic for this point in development.

The first thing we need is a set of widely-understood guidelines.
Such as:

Only
	- bugfixes
	- speedups
	- previously-agreed-to or in-progress features
	- totally new things (new drivers, new filesystems)

Once everyone understands this framework then it becomes easy to
decide what to drop, what not.

So right now, sysenter is "in".  Later, even "speedups" falls off
the list and sysenter would at that stage be "out".

Can it be that simple?
