Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314681AbSEXS3g>; Fri, 24 May 2002 14:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSEXS3f>; Fri, 24 May 2002 14:29:35 -0400
Received: from [209.184.141.163] ([209.184.141.163]:12015 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S314681AbSEXS3f>;
	Fri, 24 May 2002 14:29:35 -0400
Subject: 2.4 Kernel Perf discussion [Was Re: [BUG] 2.4 VM sucks. Again]
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <435570000.1022263849@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 24 May 2002 13:29:30 -0500
Message-Id: <1022264970.10464.12.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 13:10, Martin J. Bligh wrote:
> > Also, adjusting the bdflush parms greatly increases stability I've found
> > in this respect.
> 
> What exactly did you do to them? Can you specify what you're set to
> at the moment (and anything you found along the way in tuning)?

I actually changed the defaults of the bdflush parms before compiling. I
don't have that info right now because I had to dismantle my system in a
hurry, was a try-buy from Dell at the time, and we weren't authorized to
buy yet.

At any rate, I found, at the time, (2.4.17-pre5-aa2-xfs I think), that
the defaults for bdflush when running dbench would just *destroy* the
system. Changing the bdflush parms to be about 60% full, and flushing to
30%, while potentially wasteful, was indeed an improvement. 

IOzone benchmarks also show distinct improvements in this regard as
well, but I never had such terrible kswapd/bdflush issues with that test
as I did with dbench, to begin with. 

The test system was a Dell 6450 with 8GB ram and P3 Xeon 700Mhz 2MB
cache procs. I expect far greater peformance from the P4 Xeon 1.6GHz 1MB
Cache procs though. In that scenario, we will only be using 4GB ram
probably. That test will be internal to us and should start in the next
couple weeks (I hope). I'll be charged with making the system testing as
immaculate as possible so we have crisp information to use in our
decision making process as we move from Sun to x86.

> > Problem is, my tests are *unofficial* but I plan to do something perhaps
> > at OSDL and see what we can show in a max single-box config with real
> > hardware, etc. 
> 
> Great stuff, I'm very interested in knowing about any problems you find.
> We're doing very similar things here, anywhere from 8-32 procs, and
> 4-32Gb of RAM, both NUMA and SMP.

As soon as I can get time on their systems to do 4/8-way testing, I'll
make my benches available. Should be good stuff. :)

> Thanks,
> 
> Martin.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
