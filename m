Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272129AbRHXPQ7>; Fri, 24 Aug 2001 11:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRHXPQs>; Fri, 24 Aug 2001 11:16:48 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:28082 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S272114AbRHXPQn>;
	Fri, 24 Aug 2001 11:16:43 -0400
Message-ID: <3B866FDE.4003F3DD@candelatech.com>
Date: Fri, 24 Aug 2001 08:16:46 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: Bernhard Busch <bbusch@biochem.mpg.de>, linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
In-Reply-To: <Pine.LNX.4.21.0108241630060.17009-100000@tux.rsn.bth.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson wrote:
> 
> On Fri, 24 Aug 2001, Bernhard Busch wrote:
> 
> > Hi
> >
> >
> > I have tried to use ethernet  network interfaces bonding to increase
> > peformance.
> >
> > Bonding is working fine, but the performance is rather poor.
> > FTP between 2 machines ( kernel 2.4.4 and 4 port DLink 100Mbit ethernet
> > card)
> > results in a transfer rate of 3MB/s).
> >
> > Any Hints?
> 
> I've seen this too, it doesn't have anything to do with bonding, it's the
> fact that you are sending packets out several interfaces at once that's
> the cause. Same thing happend to me when transmitting at high speeds on
> two interfaces at once without bonding. And you are using 4 interfaces so
> I can imagine that it will be even worse than I saw.
> 
> And bonding on my two eepro100 in another machine works perfectly,
> no problem maxing out at aproximatly 200Mbit.

I've run a sustained 10Mbps tx & rx on 8 ports (2 of the Dlink 4-port NICs)
for over 24 hours on a 2.4.7 kernel.  I was not using bonding though.  I'm guessing you're
seeing lots of carrier errors, as the tulip driver used to be very bad
at...uh..working.  Try a 2.4.6 kernel or better and I bet your problem
goes away...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
