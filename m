Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263220AbTCYSBb>; Tue, 25 Mar 2003 13:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263224AbTCYSBb>; Tue, 25 Mar 2003 13:01:31 -0500
Received: from fionet.com ([217.172.181.68]:6528 "EHLO service")
	by vger.kernel.org with ESMTP id <S263220AbTCYSB3>;
	Tue, 25 Mar 2003 13:01:29 -0500
Subject: Re: System time warping around real time problem - please help
From: Fionn Behrens <fionn@unix-ag.org>
Reply-To: poster@unix-ag.org
To: linux-kernel@vger.kernel.org
Cc: root@chaos.analogic.com
In-Reply-To: <Pine.LNX.4.53.0303251152080.29361@chaos>
References: <1048609931.1601.49.camel@rtfm>
	 <Pine.LNX.4.53.0303251152080.29361@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: United Fools of Bugaloo
Message-Id: <1048615957.2576.12.camel@rtfm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 19:12:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 2003-03-25 at 18:07, Richard B. Johnson wrote:
> On Tue, 25 Mar 2003, Fionn Behrens wrote:

> > I have got an increasingly annoying problem with our fairly new (fall
> > '02) Dual Athlon2k+ Gigabyte 7dpxdw linux system running 2.4.20.

> I am using the exact same kernel (a lot of folks are). There
> is no such jumping on my system.
> Try this program:

[... prg1.c ...]

> If this shows time jumping around you have one of either:
> 
> (1)	Bad timer channel 0 chip (PIT).
> (2)	Some daemon trying to sync time with another system.
> (3)	You are traveling too close to the speed of light.

It just exits immediately with exit code 1. (*shrug*)

> Now, your script shows time in fractional seconds.
> 
> > 1048608745.61 > 1048608745.60
> 
> You can modify the program to do this:

[... prg2.c ...]

> There should be no jumping around -- and there isn't on
> any system I've tested this on.

When I run this code it begins to put out Prev N New M lines.

Prev 1048615862810879.000000 New 1048615862759879.000000
Prev 1048615862870879.000000 New 1048615862819878.000000
Prev 1048615862900879.000000 New 1048615862849902.000000
Prev 1048615862960882.000000 New 1048615862909875.000000
[-------- cut --------]

After a few seconds of run time random processes on my machine begin to
crash, or I get kernel oopses and kernel freezes. Looks very much like
heavy use of gettimeofday() causes random writes in system memory.

> > Software crashes are regularly - naturally. No programmer expects system
> > timers going back in time.

> Hmmm, software should never crash. Even if the timers jump backwards
> as you say, they should eventually time-out. If you have crashes, this
> may point to other hardware problems as well.

E.g. which type of hardware problem?

Thanks a million for your help so far, it is great to experience how
fast people are respoding!

I'll evaluate that other suggestion about TSC_DISABLE now and will get
back to you as soon as I can tell you more.

Kind regards,
		F. Behrens
