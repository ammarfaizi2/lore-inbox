Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTHaOoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbTHaOoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:44:44 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19664
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262052AbTHaOon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:44:43 -0400
Date: Sun, 31 Aug 2003 16:45:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831144505.GS24409@dualathlon.random>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 02:15:12PM +0100, Alan Cox wrote:
> On Sul, 2003-08-31 at 03:56, Larry McVoy wrote:
> > I'm pretty convinced we can't solve the problem at our end.  Maybe we can
> 
> For bursts of traffic you can't.

what's the difference of rejecting packets in software, or because the
link can't handle them? Assume the guaranteed bandwidth is much lower
than what the link can provide (very common here during the day), the
isp will have to do the software thing anyways to balance the bandwidth
across the different ip.

it works flawlessy for me and it's the same problem (I also use
streaming services), and they're unusable until I turn the shaping on,
I'm sure that if you use the script and you change 1kbyte/sec to
everything but voip it'll work fine for you too, since basically
everything else won't pass anymore, it will take ages to open an html
page and all the bkbits.net users will hang, and the link will be idle
99% of the time, so voip will take it over as much as it can. I don't
think it's a matter of "if it works or not", I think it's a matter of
how much you're ok to lose in terms of global bandwith for all the other
services but voip.

the only annoying problem I run into, is that tc is missing a flush
operation (like iptables -F) but I never need to tweak it anymore so I
don't mind too much.

Andrea
