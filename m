Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTHaPog (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTHaPog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:44:36 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28626
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262321AbTHaPo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:44:28 -0400
Date: Sun, 31 Aug 2003 17:44:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831154450.GV24409@dualathlon.random>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 04:31:32PM +0100, Alan Cox wrote:
> On Sul, 2003-08-31 at 15:45, Andrea Arcangeli wrote:
> > On Sun, Aug 31, 2003 at 02:15:12PM +0100, Alan Cox wrote:
> > > On Sul, 2003-08-31 at 03:56, Larry McVoy wrote:
> > > > I'm pretty convinced we can't solve the problem at our end.  Maybe we can
> > > 
> > > For bursts of traffic you can't.
> > 
> > what's the difference of rejecting packets in software, or because the
> > link can't handle them? Assume the guaranteed bandwidth is much lower
> 
> 
> It doesn't work when you dont control incoming. As a simple extreme
> example if I pingflood you from a fast site then no amount of shaping
> your end of the link will help, it has to be shaped at the ISP end.

sure, that's why I said it won't work with synflood. I just doubt the
ping/syn floods distributed denial of services are an high percentage of
the traffic passing through on bkbits.net. I though it was legitimate
traffic, and I assume bitkeeer is somehow efficient in handling the
transfer, by using a single tcp connection for the whole transfer of the
data, just like pserver/cvs-ssh do. For example if bitkeeper would open
a new tcp connection for each file (similar to cvsps -p -g w/o the
--cvs-direct option that I asked for), it would be much harder to shape
that traffic. But I understood the traffic that hurts is all in
established state for several seconds, so it should be technically
possible to stop it to around 1kbyte/sec globally to give an huge margin
to voip.

Andrea
