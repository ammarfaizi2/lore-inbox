Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265191AbSKINsU>; Sat, 9 Nov 2002 08:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265420AbSKINsU>; Sat, 9 Nov 2002 08:48:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50913 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265191AbSKINsT>;
	Sat, 9 Nov 2002 08:48:19 -0500
Date: Sat, 9 Nov 2002 14:54:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021109135446.GA2551@suse.de>
References: <200211091300.32127.conman@kolivas.net> <200211091612.08718.conman@kolivas.net> <20021109112135.GB31134@suse.de> <200211100009.55844.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211100009.55844.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10 2002, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> >On Sat, Nov 09 2002, Con Kolivas wrote:
> >> >You're showing a big shift in behaviour between 2.4.19 and 2.4.20-rc1.
> >> >Maybe it doesn't translate to worsened interactivity.  Needs more
> >> >testing and anaysis.
> >>
> >> Sounds fair enough. My resources are exhausted though. Someone else have
> >> any thoughts?
> >
> >Try setting lower elevator passover values. Something ala
> >
> ># elvtune -r 64 /dev/hda
> >
> >(or whatever your drive is)
> 
> Heres some more data:
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> 2420rc1r64 [3]          575.0   12      43      10      8.05
> 
> That's it then. Should I run a family of different values and if so
> over what range?

The default is 2048. How long does the io_load test take, or rather how
many tests are appropriate to do? To get a good picture of how it looks
you should probably try: 0, 8, 16, 64, 128, 512. Once you get some of
these results, it will be easier to determine which area(s) would be
most interesting to further explore.

There's also the write passover, I don't think it will have much impact
on this test though.

-- 
Jens Axboe

