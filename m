Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263224AbTCYSSg>; Tue, 25 Mar 2003 13:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263226AbTCYSSf>; Tue, 25 Mar 2003 13:18:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21902 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263224AbTCYSSa>; Tue, 25 Mar 2003 13:18:30 -0500
Date: Tue, 25 Mar 2003 13:29:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: poster@unix-ag.org
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: System time warping around real time problem - please help
In-Reply-To: <1048615957.2576.12.camel@rtfm>
Message-ID: <Pine.LNX.4.53.0303251324210.29729@chaos>
References: <1048609931.1601.49.camel@rtfm>  <Pine.LNX.4.53.0303251152080.29361@chaos>
 <1048615957.2576.12.camel@rtfm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Fionn Behrens wrote:

> On Die, 2003-03-25 at 18:07, Richard B. Johnson wrote:
> > On Tue, 25 Mar 2003, Fionn Behrens wrote:
>
> > > I have got an increasingly annoying problem with our fairly new (fall
> > > '02) Dual Athlon2k+ Gigabyte 7dpxdw linux system running 2.4.20.
>
> > I am using the exact same kernel (a lot of folks are). There
> > is no such jumping on my system.
> > Try this program:
>
> [... prg1.c ...]
>
> > If this shows time jumping around you have one of either:
> >
> > (1)	Bad timer channel 0 chip (PIT).
> > (2)	Some daemon trying to sync time with another system.
> > (3)	You are traveling too close to the speed of light.
>
> It just exits immediately with exit code 1. (*shrug*)
>

Hmmm. Note that the for(;;) { } provides no exit path.
So, you probably have some bad RAM or your CPU is too
hot (broken fan??), or something like that.


> > Now, your script shows time in fractional seconds.
> >
> > > 1048608745.61 > 1048608745.60
> >
> > You can modify the program to do this:
>
> [... prg2.c ...]
>
> > There should be no jumping around -- and there isn't on
> > any system I've tested this on.
>
> When I run this code it begins to put out Prev N New M lines.
>
> Prev 1048615862810879.000000 New 1048615862759879.000000
> Prev 1048615862870879.000000 New 1048615862819878.000000
> Prev 1048615862900879.000000 New 1048615862849902.000000
> Prev 1048615862960882.000000 New 1048615862909875.000000
> [-------- cut --------]
>
> After a few seconds of run time random processes on my machine begin to
> crash, or I get kernel oopses and kernel freezes. Looks very much like
> heavy use of gettimeofday() causes random writes in system memory.
>

Looks very much like you have a real bad hardware problem.


>
> E.g. which type of hardware problem?
>

Look inside and see if your CPU fan has stopped. Also move your RAM
sticks around after wiping any dirt off the contacts. Since the
machine used to work last fall, It's probably just a FAN or RAM
problems.


> Thanks a million for your help so far, it is great to experience how
> fast people are respoding!
>
> I'll evaluate that other suggestion about TSC_DISABLE now and will get
> back to you as soon as I can tell you more.
>

I doubt that this will help you, but it's worth trying.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

