Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267194AbRGKDXW>; Tue, 10 Jul 2001 23:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbRGKDXM>; Tue, 10 Jul 2001 23:23:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45573 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267195AbRGKDWz>; Tue, 10 Jul 2001 23:22:55 -0400
Date: Tue, 10 Jul 2001 22:51:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dirk Wetter <dirkw@rentec.com>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: dead mem pages -> dead machines
In-Reply-To: <Pine.LNX.4.33.0107101002450.24405-100000@monster000.rentec.com>
Message-ID: <Pine.LNX.4.21.0107102246110.2021-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jul 2001, Dirk Wetter wrote:

> 
> On Tue, 10 Jul 2001, Mark Hahn wrote:
> 
> 
> > my point, perhaps to terse, was that you shouldn't run 4.3G of job on
> > a 4G machine, and expect everything to necessarily work.
> 
> then i expect to have 300M+ swapped out and not 2.6GB. so what?
> 
> > > > they should all have the same priority, so swapping is distributed.
> > > > currently sda5 fills (and judging by the 5, it's not on the fast
> > > > part of the disk) before sdb1 is used.
> > >
> > > well, that's the symptom, but not the disease, medically speaking.
> >
> > no, it's actually orthogonal, mathematically speaking:
> > your swap configuration is inefficient
> 
> i am complaining about the fact that the machines start paging
> heavily without a reason and you are telling me that my swap
> config is wrong?
> 
> > note also that swap listed as in use is really just allocated,
> > not necessarily used.  the current VM preemptively assigns idle pages
> > to swapcache; whether they ever get written out is another matter.
> 
> it IS used. after submitting the jobs the nodes were dead for a while since
> they were swapping like hell.
> 
> > you should clearly run "vmstat 1" to see whether there's significant
> > si/so.  it would be a symptom if there was actually a lot of *both*
> > si and so (thrashing).
> 
> they were so dead, i couldn't even type on the console. load was up
> to 30, culprit at that point was kswapd.

Dirk, 

Can you boot the kernel with "profile=2" and use the "readprofile" tool to
check where the kernel is wasting its time ? (take a look at the
readprofile man page)

Let me machine stay in the "unusable" state for quite some time before
reading the statistics.

