Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbSKLCLn>; Mon, 11 Nov 2002 21:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSKLCLn>; Mon, 11 Nov 2002 21:11:43 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:22424 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S266095AbSKLCLm>;
	Mon, 11 Nov 2002 21:11:42 -0500
Message-ID: <1037067509.3dd064f549014@kolivas.net>
Date: Tue, 12 Nov 2002 13:18:29 +1100
From: Con Kolivas <conman@kolivas.net>
To: mark walters <kanelephant@yahoo.co.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
References: <20021112020710.44554.qmail@web20702.mail.yahoo.com>
In-Reply-To: <20021112020710.44554.qmail@web20702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting mark walters <kanelephant@yahoo.co.uk>:

>  --- Con Kolivas <conman@kolivas.net> wrote: 
> > 
> > I agree. Fortunately I don't think it's as bad a
> > tradeoff as these numbers make
> > out. The load accounting in contest (johntest?) is
> > still relatively bogus. Apart
> > from saying it's more or less loads I dont think the
> > scale of the numbers are
> > accurate.
> 
> 
> Is the number of loads the total number of loads done
> during the kernel compile or the number of loads per
> unit time during the kernel compile? I was guessing
> the former. (Andrew appeared to be guessing the
> latter?)

Number of loads = (total loads) * (kernel compile time) / (load run time)

And the load run time is impossible to fix because of the variable time it takes
to kill the load.

The load will be doing more work while the kernel is not compiling. Thus it will
always overestimate. At some stage I need to completely rewrite everything with
the ability of the load itself to know when to start and stop counting load
iterations; and I'm not even sure I can do that.

Con
