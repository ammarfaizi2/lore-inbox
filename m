Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRIVNP2>; Sat, 22 Sep 2001 09:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbRIVNPS>; Sat, 22 Sep 2001 09:15:18 -0400
Received: from [195.223.140.107] ([195.223.140.107]:1268 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S269641AbRIVNPJ>;
	Sat, 22 Sep 2001 09:15:09 -0400
Date: Sat, 22 Sep 2001 15:14:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Robert Love <rml@tech9.net>, Andre Pang <ozone@algorithm.com.au>,
        linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
Subject: Re: ksoftirqd? (Was: Re: [PATCH] Preemption Latency Measurement Tool)
Message-ID: <20010922151453.B976@athlon.random>
In-Reply-To: <1000939458.3853.17.camel@phantasy> <1001131036.557760.4340.nullmailer@bozar.algorithm.com.au> <1001139027.1245.28.camel@phantasy> <200109221301.f8MD1n129687@mailc.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109221301.f8MD1n129687@mailc.telia.com>; from roger.larsson@norran.net on Sat, Sep 22, 2001 at 02:56:58PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 02:56:58PM +0200, Roger Larsson wrote:
> Hi,
> 
> We have a new kid on the block since we started thinking of a preemptive 
> kernel.
> 
> ksoftirqd...
> 
> Running with nice 19 (shouldn't it really be -19?)
> Or have a RT setting? (maybe not since one of the reasons for
> softirqd would be lost - would be scheduled in immediately)
> Can't a high prio or RT process be starved due to missing
> service (bh) after an interrupt?

It cannot be starved, if ksoftirqd is never scheduled the do_softirq()
will be run by the next timer irq or apic_timer irq.

> This will not show up in latency profiling patches since
> the kernel does what is requested...
> 
> Previously it was run directly after interrupt,
> before returning to the interrupted process...

It is still the case, that's also the common case actually.

Andrea
