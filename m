Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSJSJa3>; Sat, 19 Oct 2002 05:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbSJSJa3>; Sat, 19 Oct 2002 05:30:29 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1284 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S261950AbSJSJaW>;
	Sat, 19 Oct 2002 05:30:22 -0400
Date: Sat, 19 Oct 2002 11:36:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Robert Love <rml@tech9.net>, Neil Conway <nconway.list@ukaea.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4: variable HZ
Message-ID: <20021019093610.GA16046@alpha.home.local>
References: <1034966657.722.838.camel@phantasy> <Pine.LNX.3.95.1021018152117.150B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021018152117.150B-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 03:38:43PM -0400, Richard B. Johnson wrote:
> If you are not using ELAN, CLOCK_TICK_RATE is 1193180.

well, in fact it's 1193181.666... (14318180/12).

> If your HZ is 100, you have 1193180/100 = 1193.18, not too exact.

you meant 1000, I suppose ?

> if you use 500, you get 1193180/500 = 2386.36 which has twice as much
> round-off. If you use 1193180/512 = 2330.43, even a higher fractional
> part.

those interested can try 511 Hz (/2334.994) or 1900 Hz (/627.990) which
has the double advantage of being multiple of 100 Hz and have a little
drift due to frac part (/628 gives 1899.97 Hz, and /627 gives 1903.001 Hz).
If you don't need a multiple of 100 Hz, I noticed that dividing by 5709
gives 209.0001 Hz.

I'm also wondering why we never use the RTC as an interrupt source. Are
there any incompatible PCs ?

Cheers,
Willy

