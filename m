Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289602AbSAWBDN>; Tue, 22 Jan 2002 20:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289604AbSAWBDD>; Tue, 22 Jan 2002 20:03:03 -0500
Received: from h225-81.adirondack.albany.edu ([169.226.225.80]:34947 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S289602AbSAWBCs>;
	Tue, 22 Jan 2002 20:02:48 -0500
Date: Tue, 22 Jan 2002 20:02:48 -0500
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
Cc: Urban Widmark <urban@teststation.com>
Subject: Re: via-rhine timeouts
Message-ID: <20020123010248.GB835@bouncybouncy.net>
In-Reply-To: <20020122234201.GA835@bouncybouncy.net> <Pine.LNX.4.33.0201230107420.4854-100000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201230107420.4854-100000@cola.teststation.com>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 01:37:05AM +0100, Urban Widmark wrote:
> On Tue, 22 Jan 2002, Justin A wrote:
> 
> > I've been getting many errors due to timeouts, everything was fine while
> > I was at home, but here at school it's a major problem:
> 
> You did get them at home too? (with the same (type of) hardware?)
>
(checks his logs) no, first time I got that message was at school.
(I just found out something, read the end of this email)
> 
> > Jan 22 18:10:34 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
> > timed out
> > Jan 22 18:10:34 bouncybouncy kernel: eth0: Transmit timed out, status
> > 0000, PHY 
> > status 782d, resetting...
> > 
> > Jan 22 18:10:34 bouncybouncy kernel: eth0: reset did not complete in 10
> > ms.
> > 
> > once it complains about that, it stops working until I reboot.
> 
> 10ms is a very long time. Normally the hardware resets a lot faster than
> that, and when it doesn't I suspect it is in some really bad state.
> 
> You are not the first to report this. And it is a message that could be
> caused by a lot of things, I guess.

It only does that after resetting the card over and over again, perhaps
it tries to reset it again before its ready?

> 
> But I have finally managed to get these timeouts to happen on my VT6102
> too (using an evil combination of running a remote Internet Explorer over
> VNC). I have planned to examine it, but I probably won't get around to
> that for at least a couple of weeks.
> 
> Some ideas you could try:
> + The via-rhine driver at
>   http://www.scyld.com/network/ethercard.html
>   (the one in the kernel is almost the same as this one)

I tried to build that, the compile command it had didn't work, it ended
up thinking it was compiled for 2.4.13. Probably need to have it include
/usr/src/linux/include/linux or something.

> + Move the card to another slot (remove/re-arrange other cards in the box)
It's built into the motherboard:)

> + Since it appears to be load related, perhaps it can be hidden by slowing
>   things down (eg add a small udelay() to via_rhine_start_tx)
> 
> (or you could try to figure out what the driver is doing when these 
>  things happen.)
> 
> /Urban
> 

I just found this in my old logs:
Nov 18 19:01:14 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 18 19:01:14 bouncybouncy kernel: eth0: transmit timed out, Tx_status 00 status 2000 Tx FIFO room 520.

That was with my old motherboard, and an isa 3c509.

The 'smart' hubs here have had many problems in the past, I think they
are still supposed to be replaced soon with normal switches.  Could it
just be that the hub gets confused up and the card resets itself for no
reason?

-Justin
