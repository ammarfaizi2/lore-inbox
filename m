Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313461AbSC2Pkp>; Fri, 29 Mar 2002 10:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313460AbSC2Pkd>; Fri, 29 Mar 2002 10:40:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26640 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313459AbSC2Pk1>; Fri, 29 Mar 2002 10:40:27 -0500
Date: Fri, 29 Mar 2002 10:37:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, vojtech@ucw.cz,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 pre-UDMA PIIX bug
In-Reply-To: <3CA47378.70208@evision-ventures.com>
Message-ID: <Pine.LNX.3.96.1020329103625.22866A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Martin Dalecki wrote:

> >   333		T = 1000000000 / piix_clock;
> >   334		UT = T / umul;
> 
> I think that it should be just sufficient to add the
> following test just in front of the offending calculartion.
> 
> if (umul == 0)
>    ++umul;

- 334               UT = T / umul;
+ 334               UT = T / (umul || 1);

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

