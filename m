Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273495AbRJDS0I>; Thu, 4 Oct 2001 14:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277103AbRJDSZr>; Thu, 4 Oct 2001 14:25:47 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:38586 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S273495AbRJDSZg>;
	Thu, 4 Oct 2001 14:25:36 -0400
Date: Thu, 4 Oct 2001 14:23:04 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Simon Kirby <sim@netnation.com>, Ingo Molnar <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBC8692.9F48DA85@candelatech.com>
Message-ID: <Pine.GSO.4.30.0110041416190.10825-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Ben Greear wrote:

> jamal wrote:
> >
> > On Wed, 3 Oct 2001, Ben Greear wrote:
> >
> > > The tulip driver only started working for my DLINK 4-port NIC after
> > > about 2.4.8, and last I checked the ZYNX 4-port still refuses to work,
> > > so I wouldn't consider it a paradigm of stability and grace quite yet.
> >
> > The tests in www.cyberus.ca/~hadi/247-res/ were done with 4-port znyx
> > cards using 2.4.7.
> > What kind of problems are you having? Maybe i can help.
>
> Mostly problems with auto-negotiation it seems.  Earlier 2.4 kernels
> just would never go 100bt/FD.  Later (broken) versions would claim to
> be 100bt/FD, but they still showed lots of collisions and frame errors.
>
> I'll try the ZYNX on the latest kernel in the next few days and let you
> know what I find...

Please do.

>
> > My point is that the API exists. Driver owners could use it; this
> > discussion seems to have at least helped to point in the existence of the
> > API. Alexey had the hardware flow control in there since 2.1.x .., us
> > that at least. In my opinion, Ingos patch is radical enough to be allowed
> > in when we are approaching stability. And it is a lazy way of solving the
> > problem
>
> The API has been there since 2.1.x, and yet few drivers support it?  I
> can see why Ingo decided to fix the problem generically.

That logic is convoluted.

> > > cat /proc/net/softnet_stat
> > > 2b85c320 0000d374 6524ce48 00000000 00000000 00000000 00000000
00000000 0$
> > > 2b8b5e29 0000d615 653eba32 00000000 00000000 00000000 00000000
00000000 0$
>
> So you're priting out counters in HEX??  This seems one place where a nice
> base-10 number would be appropriate :)

Its mostly for formating reasons:
2b85c320 is 730186528 (and wont fit in one line)

cheers,
jamal

