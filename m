Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274742AbRIUCON>; Thu, 20 Sep 2001 22:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274743AbRIUCOD>; Thu, 20 Sep 2001 22:14:03 -0400
Received: from mailg.telia.com ([194.22.194.26]:51399 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S274742AbRIUCNy>;
	Thu, 20 Sep 2001 22:13:54 -0400
Message-Id: <200109210214.f8L2E8R27561@mailg.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Fri, 21 Sep 2001 04:08:14 +0200
X-Mailer: KMail [version 1.3.1]
Cc: oxymoron@waste.org (Oliver Xymoron),
        Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=),
        stefan@space.twc.de (Stefan Westerfeld), rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <E15kEjB-0006n9-00@the-village.bc.nu> <200109210143.f8L1hnm08604@mailb.telia.com> <200109210157.f8L1vwm15951@mailb.telia.com>
In-Reply-To: <200109210157.f8L1vwm15951@mailb.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing to follow up to myself...

> >
> > Hmm..
> >
> > The yield we do in __alloc_pages is it really correct?
> > 1. Suppose it is not we that are the problem.
> > 2. Suppose there are lots of other processes that gets to run.
> > 3. If kswapd had higher prio, it would start to run without us giving
> > up...
> >
> > I have to try...
>
> They were already gone in -pre12!
> But I was running -pre10...
> Others?
> Dieter is running -pre12...
> I will test it anyways...
>

Unexpected result, but interesting.
Things got MUCH WORSE!
>From nearly no problem to hardly enjoyable.
(pre10 with preemptive kernel but no schedule in __alloc_pages,
 actual if statement removed)
Maybe it is closer to what Dieter gets...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
