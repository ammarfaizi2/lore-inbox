Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291934AbSBTPlU>; Wed, 20 Feb 2002 10:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291935AbSBTPlL>; Wed, 20 Feb 2002 10:41:11 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51468 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291934AbSBTPkv>; Wed, 20 Feb 2002 10:40:51 -0500
Date: Wed, 20 Feb 2002 10:39:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Paulo J. Matos" <pocm@rnl.ist.utl.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: Connecting through parallel port
In-Reply-To: <87d6z03hnq.fsf@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020220103456.23280C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2002, Paulo J. Matos wrote:

> I have a LAN at home and know I just got another computer to
> connect to the LAN, I also found a parallel-parallel cable. The
> network is ethernet, is it possible to connect the new computer
> using the parallel ports of the computers to the server of the
> LAN so that this new computer is able to have access to the
> internet and the rest of stuff?
> What do I need to configure in the kernel?
> Is there any how-to out there that answers this question?

There was a protocol called PLIP which did just what you want. I've used
it many times for laptop install (Patrick even fixed it in Slackware at my
request).

Unfortunately, while the feature is still in recent 2.[45] kernels, it
appears to be broken. The last laptop I installed needed a network card to
get working.

Note that using good cable and short runs you can push PPP over the serial
ports at 230400bps, and possibly even use the bonding driver (or EQL) to
hang several in parallel. I would think that was fast enough for casual
use, although PL/IP was faster. I think the parport stuff is the cause,
and it may be that only the config info need be changed, I just haven't
chased it.

Anyone having a fix or info that there's a workaround, fel free to expand
on this!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

