Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSLBTvW>; Mon, 2 Dec 2002 14:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSLBTvW>; Mon, 2 Dec 2002 14:51:22 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:516 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264919AbSLBTvV>; Mon, 2 Dec 2002 14:51:21 -0500
Date: Mon, 2 Dec 2002 14:44:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [BUG]2.5.49-ac1 - more info on make error
In-Reply-To: <20021202182213.GC775@fs.tum.de>
Message-ID: <Pine.LNX.3.96.1021202143642.433K-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Adrian Bunk wrote:

> On Wed, Nov 27, 2002 at 03:45:24PM -0500, Bill Davidsen wrote:
> 
> >...
> Content-Description: config
> >...
> > CONFIG_HOTPLUG=y
> >...
> > #
> > # Tulip family network device support
> > #
> > CONFIG_NET_TULIP=y
> > CONFIG_DE2104X=y
> >...
> 
> ./drivers/net/tulip/de2104x.o(.data+0x74): undefined reference to `local 
> symbols in discarded section .exit.text'
> 
> 
> In drivers/net/tulip/de2104x.c the function de_remove_on is __exit but 
> the pointer to it is __devexit_p.
> 
> Two possible solutions:

Huh, not an hour after I said I hadn't heard anything I get two patches
and an explanation of what the base problem is, so I can apply it to any
other similar problems. I assumed that no one else was using this old
stuff.

Note: I have an old tulip card with a BNC and 10baseT connector on a
single card. I had assumed one or the other, but with 2.5 kernels the card
appears as two NICs, with separate io and irq addresses. Since I have to
support thinnet or replace a bunch of devices with network built in, and
cards which support BNC are getting scarce, this looks like a nice
semi-firewall solution.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

