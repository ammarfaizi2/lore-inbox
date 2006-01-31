Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWAaP6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWAaP6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWAaP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:58:07 -0500
Received: from [212.76.85.204] ([212.76.85.204]:30212 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750912AbWAaP6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:58:05 -0500
From: Al Boldi <a1426z@gawab.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] VM: I have a dream...
Date: Tue, 31 Jan 2006 18:56:17 +0300
User-Agent: KMail/1.5
Cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com> <200601301621.24051.a1426z@gawab.com> <8F530CA8-1AC8-4AE5-8F1E-DC6518BD7D42@mac.com>
In-Reply-To: <8F530CA8-1AC8-4AE5-8F1E-DC6518BD7D42@mac.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601311856.17569.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Jan 30, 2006, at 08:21, Al Boldi wrote:
> > Bryan Henderson wrote:
> >>>> So we know it [single level storage] works, but also that people
> >>>> don't seem to care much for it
> >>>
> >>> People didn't care, because the AS/400 was based on a proprietary
> >>> solution.
> >>
> >> I don't know what a "proprietary solution" is, but what we had was
> >> a complete demonstration of the value of single level storage, in
> >> commercial use and everything,  and other computer makers (and
> >> other business units of IBM) stuck with their memory/disk split
> >> personality.  For 25 years, lots of computer makers developed lots
> >> of new computer architectures and they all (practically speaking)
> >> had the memory/disk split.  There has to be a lesson in that.
> >
> > Sure there is lesson here.  People have a tendency to resist
> > change, even though they know the current way is faulty.
>
> Is it necessarily faulty?  It seems to me that the current way works
> pretty well so far, and unless you can prove a really strong point
> the other way, there's no point in changing.  You have to remember
> that change introduces bugs which then have to be located and removed
> again, so change is not necessarily cheap.

Faulty, because we are currently running a legacy solution to workaround an 
8,16,(32) arch bits address space limitation, which does not exist in 
64bits+ archs for most purposes.

Trying to defend the current way would be similar to rejecting the move from 
16bit to 32bit. Do you remember that time?  One of the arguments used was:  
the current way works pretty well so far.

The advice here would be:  wake up and smell the coffee.

There is a lot to gain, for one there is no more swapping w/ all its related 
side-effects.  You're dealing with memory only.  You can also run your fs 
inside memory, like tmpfs, which is definitely faster.  And there may be 
lots of other advantages, due to the simplified architecture applied.

> >>> With todays generically mass-produced 64bit archs, what's not to
> >>> care about a cost-effective system that provides direct mapped
> >>> access into  linear address space?
> >>
> >> I don't know; I'm sure it's complicated.
> >
> > Why would you think that the shortest path between two points is
> > complicated, when you have the ability to fly?
>
> Bad analogy.

If you didn't understand it's meaning.  The shortest path meaning accessing 
hw w/o running workarounds; using 64bits+ to fly over past limitations.

> >> But unless the stumbling block since 1980 has been that it was too
> >> hard to get/make a CPU with a 64 bit address space, I don't see
> >> what's different today.
> >
> > You are hitting the nail right on it's head here. Nothing moves the
> > masses like mass-production.
>
> Uhh, no, you misread his argument: If there were other reasons that
> this was not done in the past than lack of 64-bit CPUS, then this is
> probably still not practical/feasible/desirable.

Uhh?
The point here is: Even if there were 64bit archs available in the past, this 
did not mean that moving into native 64bits would be commercially viable, 
due to its unavailability on the mass-market.

So with 64bits widely available now, and to let Linux spread its wings and 
really fly, how could tmpfs merged w/ swap be tweaked to provide direct 
mapped access into this linear address space?

Thanks!

--
Al

