Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276118AbRJDP4L>; Thu, 4 Oct 2001 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276480AbRJDP4B>; Thu, 4 Oct 2001 11:56:01 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:50111 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S276248AbRJDPzp>;
	Thu, 4 Oct 2001 11:55:45 -0400
Message-ID: <3BBC8692.9F48DA85@candelatech.com>
Date: Thu, 04 Oct 2001 08:56:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Simon Kirby <sim@netnation.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110040742191.9341-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> On Wed, 3 Oct 2001, Ben Greear wrote:
> 
> > The tulip driver only started working for my DLINK 4-port NIC after
> > about 2.4.8, and last I checked the ZYNX 4-port still refuses to work,
> > so I wouldn't consider it a paradigm of stability and grace quite yet.
> 
> The tests in www.cyberus.ca/~hadi/247-res/ were done with 4-port znyx
> cards using 2.4.7.
> What kind of problems are you having? Maybe i can help.

Mostly problems with auto-negotiation it seems.  Earlier 2.4 kernels
just would never go 100bt/FD.  Later (broken) versions would claim to
be 100bt/FD, but they still showed lots of collisions and frame errors.

I'll try the ZYNX on the latest kernel in the next few days and let you
know what I find...

> My point is that the API exists. Driver owners could use it; this
> discussion seems to have at least helped to point in the existence of the
> API. Alexey had the hardware flow control in there since 2.1.x .., us
> that at least. In my opinion, Ingos patch is radical enough to be allowed
> in when we are approaching stability. And it is a lazy way of solving the
> problem

The API has been there since 2.1.x, and yet few drivers support it?  I
can see why Ingo decided to fix the problem generically.  I think it would
be great if his code printed a log message upon trigger that basically said:
"You should get yourself a NAPI enabled driver that does flow-control if
possible."  That may give the appropriate visibility to the issue and let
the driver writers improve their drivers accordingly...

Ben

> 
> cheers,
> jamal
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
