Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272710AbTHKOJZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272692AbTHKOHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:07:10 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:22008 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S272680AbTHKODn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:03:43 -0400
Subject: Re: [PATCH]O14int
From: Martin Schlemmer <azarah@gentoo.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308111943.49235.kernel@kolivas.org>
References: <200308090149.25688.kernel@kolivas.org>
	 <200308111608.18241.kernel@kolivas.org> <3F375EBD.5030106@cyberone.com.au>
	 <200308111943.49235.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060610284.13256.69.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 15:58:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 11:43, Con Kolivas wrote:
> On Mon, 11 Aug 2003 19:15, Nick Piggin wrote:
> > Con Kolivas wrote:
> > >On Mon, 11 Aug 2003 15:44, Martin Schlemmer wrote:
> > >>On Sat, 2003-08-09 at 11:04, Con Kolivas wrote:
> > >>>On Sat, 9 Aug 2003 01:49, Con Kolivas wrote:
> > >>>>More duck tape interactivity tweaks
> > >>>
> > >>>s/duck/duct
> > >>>
> > >>>>Wli pointed out an error in the nanosecond to jiffy conversion which
> > >>>>may have been causing too easy to migrate tasks on smp (? performance
> > >>>>change).
> > >>>
> > >>>Looks like I broke SMP build with this. Will fix soon; don't bother
> > >>>trying this on SMP yet.
> > >>
> > >>Not to be nasty or such, but all these patches have taken
> > >>a very responsive HT box to one that have issues with multiple
> > >>make -j10's running and random jerkyness.
> > >
> > >A UP HT box you mean? That shouldn't be capable of running multiple make
> > > -j10s without some noticable effect. Apart from looking impressive, there
> > > is no point in having 30 cpu heavy things running with only 1 and a bit
> > > processor and the machine being smooth as silk; the cpu heavy things will
> > > just be unfairly starved in the interest of appearance (I can do that
> > > easily enough). Please give details if there is a specific issue you
> > > think I've broken or else I wont know about it.
> >
> > Yeah make -j10s won't be without impact, but I think for a lot of
> > interactive stuff they don't need a lot of CPU, just to get it
> > in a timely manner. And Martin did say it had been responsive.
> > Sounds like in this case your changes are causing the interactive
> > stuff to get less CPU or higher scheduling latency?
> 
> Sigh..,
> 
> No, it sounds to me like things are expiring faster than on default. He didn't 
> say make -j10, it was multiple -j10s. This is one where you simply cannot let 
> the scheduler keep starving the make -j10s indefinitely for X; on a server or 
> multiuser box X will simply cause unfair starvation. I'm trying to find a 
> workaround for this without rewriting whole sections of the scheduler code, 
> but I'm just not sure I should be trying to optimise for a desktop that runs 
> loads >16 per cpu. (I'll keep trying though, but if there is no workaround 
> that remains fair it wont happen)
> 

Con, you are doing great work for UP desktop systems.
All I am saying is I do not think that there will be
an golden middle way.  If I disable SMP, it works much
as expected for the short time I tested.  I guess I am just
voicing what a few people have said - maybe there should
be a choice for what sheduler - UP or SMP.


Cheers,

-- 
Martin Schlemmer


