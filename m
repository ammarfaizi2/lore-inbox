Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313730AbSDHSlr>; Mon, 8 Apr 2002 14:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313731AbSDHSlq>; Mon, 8 Apr 2002 14:41:46 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:24063 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S313730AbSDHSlp>; Mon, 8 Apr 2002 14:41:45 -0400
Date: Mon, 8 Apr 2002 11:40:01 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <Pine.LNX.3.96.1020408141616.22382A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0204081138490.27634-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

watch out for the write cycle limits of your flash. they're pretty low
power (at least compared to anything mechanical) but if you're not careful
you can go through their write capability pretty fast.

David Lang



 On Mon, 8 Apr 2002, Bill Davidsen wrote:

> Date: Mon, 8 Apr 2002 14:31:41 -0400 (EDT)
> From: Bill Davidsen <davidsen@tmr.com>
> To: Richard Gooch <rgooch@ras.ucalgary.ca>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: faster boots?
>
> On Mon, 8 Apr 2002, Richard Gooch wrote:
>
> > Bill Davidsen writes:
> > > On Sun, 7 Apr 2002, Richard Gooch wrote:
> > >
> > >
> > > > But I *want* to write while the drive is spun down. And leave it spun
> > > > down until the system is RAM starved (or some threshold is reached).
> > >
> > >   The threshold I hit is how much think time I want to risk. I have
> > > no problem spinning down the drive after inactivity, but the idea of
> > > investing several hours making little changes in a program or
> > > proposal document and then maybe losing them... batteries are just
> > > not that expensive.
> >
> > It's not $$$ I'm concerned about. It's mass.
>
>   The "I" in my posting referred to my personal preference which is safety
> over what to me is a minor inconvenience.
>
>   After looking at disk accesses for a while I *think* diddling bdflush
> parameters will prevent disk writes for quite a while if you don't do
> reads of uncached data. So far I'm just catting /proc/partitions once a
> minute and doing a diff to the previous. looks like a write every ten
> minutes or so, what I set in bdflush, probably of syslog mumbling, since
> the system is relatively quiescent at the moment.
>
>   Does anyone have a thought on power consumption of flash chips? I have a
> 20MB compact flash I use as an auxilary backup for critical stuff, "just
> in case" and I bet I could put enough on a 64MB to keep the hard drive
> spun down for hours, if I were interested in doing so.
>
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
