Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276953AbRJIDTi>; Mon, 8 Oct 2001 23:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277010AbRJIDT3>; Mon, 8 Oct 2001 23:19:29 -0400
Received: from [216.191.240.114] ([216.191.240.114]:21638 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S276953AbRJIDTU>;
	Mon, 8 Oct 2001 23:19:20 -0400
Date: Mon, 8 Oct 2001 23:17:00 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Scott Laird <laird@internap.com>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
        Bernd Eckenfels <ecki@lina.inka.de>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110081717030.5961-100000@laird.sea.internap.com>
Message-ID: <Pine.GSO.4.30.0110082241170.5996-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Oct 2001, Scott Laird wrote:

>
>
> On Mon, 8 Oct 2001, jamal wrote:
> >
> > Several things to note/observe:
> > - They use some very specialized piece of hardware (with two PCI buses).
>
> Huh?  It was just an L440GX, which was probably the single most common PC
> server board for a while in 1999-2000.  Most of VA Linux's systems used
> them.  I wouldn't call them "very specialized."
>

Ok, sorry you are right, not very high end, but not exactly cheap even at
the time to have a motherboard with two PCI busses (i for one would have
been delighted to have had access to one even today);
Nevertheless, impressive numbers still.
I could do achieve MLFR of ~200Kpps on an elcheapo PII with 4port znyx
cards on an ASUS that has a single PCI bus; and from what Donald Becker
was saying we could probably do better with 4 interface cards rather than
a single 4-port card due to bus mastership issues.
I suppose thats why Robert can pull more packets on only two gige NICs on
a single bus. He's more than likely hitting PCI bottlenecks at this point.
A second PCI bus with a second set of cards should help (dis)prove this
theory.

> > - Roberts results on a single PCI bus hardware was showing ~360Kpps
> > routing vs clicks 435Kpps. This is not "far off" given the differences in
> > hardware. What would be really interesting is to have the click folks
> > post their latency results. I am curious as to what a purely polling
> > scheme they have would achieve (as opposed to NAPI which is a mixture of
> > interupts and polls).
>
> Their 'TOCS00' paper lists a 29us one-way latency on page 22.
>

Thats a very good number. I wonder what it means though and at what rates
those numbers are extracted. For example some of the tests i run on the
znyx card with only two ports generating traffic -- you can observe a
rough latency of around 33us upto about the MLFFR and then the latency
jumps sharply to hunderds of us. Infact at 147Kpps input, you observe
anywhere in the range of upto 800us although we are clearly flat at the
MLFFR throughput on the output. These numbers might also be affected by
the latency measurement scheme used,

> Click looks interesting, much more so then most academic network projects,
> but I'm still not sure if it'd really be useful in most "real"

agreed, although i think we need to have more research of the type that
click is bringing ...

> environments.  It looks too flexible for most people to manage.  It'd be
> an interesting addition to my test lab, though :-).

indeed.

cheers,
jamal

