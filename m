Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313713AbSDHRiI>; Mon, 8 Apr 2002 13:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313714AbSDHRiH>; Mon, 8 Apr 2002 13:38:07 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46853 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313713AbSDHRiG>; Mon, 8 Apr 2002 13:38:06 -0400
Date: Mon, 8 Apr 2002 13:35:35 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Anssi Saari <as@sci.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
In-Reply-To: <20020408154732.GA10271@sci.fi>
Message-ID: <Pine.LNX.3.96.1020408133036.22155A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Anssi Saari wrote:

> On Mon, Apr 08, 2002 at 10:54:29AM -0400, Bill Davidsen wrote:
> > On Mon, 8 Apr 2002, Anssi Saari wrote:
> > 
> > > [1.] One line summary of the problem:    
> > > CD burning at 16x uses excessive CPU, although DMA is enabled
> > 
> >   That's a hint things are not working as you expect...
> >  
> > > [2.] Full description of the problem/report:
> > > My system seems to use a lot of CPU time when writing CDs at 16x. The
> > > system is unable to feed the burning software's buffer fast enough when
> > > burning software (cdrecord 1.11a20, cdrdao 1.1.5) is run as normal user.
> > > If run as root, system is almost unresponsive during the burn.
> > 
> >   With all the information you provided, you have totally not quatified
> > how much CPU you find "excessive."
> 
> I didn't really know how to put it. Maybe system load would be better. But
> the actual problem is, I effectively can't burn audio and other types
> at 16x in Linux, while there is no problem in some other operating systems
> with the same hardware and applications.
> 
> Here're some time figures from cdrdao:
> 
> cdrdao simulate -n --speed 8 foo.cue  2.62s user 3.37s system 1% cpu 6:41.86 total
> cdrdao simulate -n --speed 12 foo.cue  2.78s user 29.91s system 12% cpu 4:31.71 total
> cdrdao simulate -n --speed 16 foo.cue  2.67s user 128.77s system 52% cpu 4:10.68 total
> 
> So yes, system time goes up quite steeply.


  Okay, this is good information. At the risk of asking a dumb question,
are you sure that both the burner and the source drive ar using DMA? And
that they are on separate cables (controllers)? Usually the high system
time indicated either PIO in use or some path looping in the kernel.
 
> cdrdao simulate -n --speed 16 foo.cue  2.75s user 75.18s system 58% cpu
> 2:13.22 total

  That's still high. My only fast burners are in the office, if I get back
during the week I'll run a test at 16 and 24x and see what I find.

  This would be a good question for the CD writing list,
cdwrite@other.debian.org.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

