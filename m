Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272466AbRIRQJN>; Tue, 18 Sep 2001 12:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272415AbRIRQJD>; Tue, 18 Sep 2001 12:09:03 -0400
Received: from lilly.ping.de ([62.72.90.2]:2831 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S272467AbRIRQIo>;
	Tue, 18 Sep 2001 12:08:44 -0400
Date: 18 Sep 2001 18:06:25 +0200
Message-ID: <20010918180625.A1941@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random> <20010918173515.B6698@planetzork.spacenet> <20010918174434.I19092@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010918174434.I19092@athlon.random>; from andrea@suse.de on Tue, Sep 18, 2001 at 05:44:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:44:34PM +0200, Andrea Arcangeli wrote:
> On Tue, Sep 18, 2001 at 05:35:15PM +0200, jogi@planetzork.ping.de wrote:
> > Since I am not using md there are not that much changes left between
> > -pre10 and -pre11. Or do you think that it is caused by the console
> > locking changes?
> 
> certainly not from the console locking changes. Can you just go back to
> pre10 and verify you don't get those skips to just to be 100% sure the
> userspace config is the same?

Ok, -pre10 is ok. There xmms did hang once for about a second, and at that
time I was building a kernel (make -j4), reniced top, starting mozilla,
StarOffice, Netscape, mutt (reading in mailbox with >200 emails in qmail
format).

With -pre11 much less is required.

> The only scheduler change in pre11 is this one:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre10aa1/00_sched-rt-fix-1
> 
> which should be infact a bugfix for rt threads, also discussed on l-k
> recently, so it's not clear how this odd regression happened.
> 
> You can try to back it out and see if helps just in case.

I will test this tomorrow and let you know about the results.

   JOgi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
