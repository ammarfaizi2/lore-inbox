Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274739AbRIUB6N>; Thu, 20 Sep 2001 21:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274740AbRIUB6D>; Thu, 20 Sep 2001 21:58:03 -0400
Received: from mailb.telia.com ([194.22.194.6]:22541 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S274739AbRIUB5s>;
	Thu, 20 Sep 2001 21:57:48 -0400
Message-Id: <200109210157.f8L1vwm15951@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Fri, 21 Sep 2001 03:53:08 +0200
X-Mailer: KMail [version 1.3.1]
Cc: oxymoron@waste.org (Oliver Xymoron),
        Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=),
        stefan@space.twc.de (Stefan Westerfeld), rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <E15kEjB-0006n9-00@the-village.bc.nu> <200109210143.f8L1hnm08604@mailb.telia.com>
In-Reply-To: <200109210143.f8L1hnm08604@mailb.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 September 2001 03.38, Roger Larsson wrote:
> On Friday 21 September 2001 03.03, Alan Cox wrote:
> > > If this analysis is correct:
> > > We really need to run RT processes with RT priorities!
> > >
> > > It is also possible that multimedia applications needs to be rewritten
> > > = to
> >
> > I dont believe this is an application problem. Applications allocating
> > memory can end up doing page outs for other people. Its really important
> > they dont get stuck doing a huge amount of pageout work for someone else.
> > Thats one thing I seem to be seeing with the 10pre11 VM.
> >
> > Sound cards have a lot of buffering, we are talking 64-128Kbytes + on
> > card buffers. Thats 0.25-0.5 seconds at 48Khz 16bit stereo
>
> Hmm..
>
> The yield we do in __alloc_pages is it really correct?
> 1. Suppose it is not we that are the problem.
> 2. Suppose there are lots of other processes that gets to run.
> 3. If kswapd had higher prio, it would start to run without us giving up...
>
> I have to try...
>


They were already gone in -pre12!
But I was running -pre10...
Others?
Dieter is running -pre12...
I will test it anyways...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
