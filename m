Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289592AbSAWAhc>; Tue, 22 Jan 2002 19:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289594AbSAWAhW>; Tue, 22 Jan 2002 19:37:22 -0500
Received: from fungus.teststation.com ([212.32.186.211]:8714 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S289592AbSAWAhM>; Tue, 22 Jan 2002 19:37:12 -0500
Date: Wed, 23 Jan 2002 01:37:05 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Justin A <justin@bouncybouncy.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine timeouts
In-Reply-To: <20020122234201.GA835@bouncybouncy.net>
Message-ID: <Pine.LNX.4.33.0201230107420.4854-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Justin A wrote:

> I've been getting many errors due to timeouts, everything was fine while
> I was at home, but here at school it's a major problem:

You did get them at home too? (with the same (type of) hardware?)

> Jan 22 18:10:34 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
> timed out
> Jan 22 18:10:34 bouncybouncy kernel: eth0: Transmit timed out, status
> 0000, PHY 
> status 782d, resetting...
> 
> Jan 22 18:10:34 bouncybouncy kernel: eth0: reset did not complete in 10
> ms.
> 
> once it complains about that, it stops working until I reboot.

10ms is a very long time. Normally the hardware resets a lot faster than
that, and when it doesn't I suspect it is in some really bad state.

You are not the first to report this. And it is a message that could be
caused by a lot of things, I guess.


But I have finally managed to get these timeouts to happen on my VT6102
too (using an evil combination of running a remote Internet Explorer over
VNC). I have planned to examine it, but I probably won't get around to
that for at least a couple of weeks.

Some ideas you could try:
+ The via-rhine driver at
  http://www.scyld.com/network/ethercard.html
  (the one in the kernel is almost the same as this one)
+ Move the card to another slot (remove/re-arrange other cards in the box)
+ Since it appears to be load related, perhaps it can be hidden by slowing
  things down (eg add a small udelay() to via_rhine_start_tx)

(or you could try to figure out what the driver is doing when these 
 things happen.)

/Urban

