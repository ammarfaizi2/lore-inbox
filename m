Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbTIAQMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbTIAQMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:12:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9889
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263001AbTIAQMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:12:40 -0400
Date: Mon, 1 Sep 2003 18:13:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901161316.GH11503@dualathlon.random>
References: <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk> <20030831230219.GD24409@dualathlon.random> <20030831230728.GA4918@work.bitmover.com> <20030831232224.GF24409@dualathlon.random> <1062416635.13372.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062416635.13372.17.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 12:43:56PM +0100, Alan Cox wrote:
> On Llu, 2003-09-01 at 00:22, Andrea Arcangeli wrote:
> > the only difference I believe is that the connections are originated by
> > my end, but that only changes the syn packet that normally accounts for
> > a non significant amount of the bandwidth. And while this is located in
> > a house, this isn't what I would call an home user usage.
> 
> Each ACK that has caused previous delays generally opens up a 64K window
> so you get bursts of data incoming. A sequence of acks can cause the

the congestion avoidance shouldn't allow what you say. It sends a few
packets immediatly (cwnd starts > 1 recently), and that's why
non-keepalive connections are bad, but after that the congestion window
will remain low if we drop the packets.

> incoming pipe to fill enough to screw up voip very easily.
> 
> Window bending stuff does help and certainly the packeteer boxes use it
> to good effect. I've never tried that on Linux but even then Im dubious
> that just cutting the routes down to an 8K window would help

The only object of my posts was to try to correct the misinformation
that was spreading from Larry's posts that implied you had to buy a
speparate connection to shape the bitkeeper connections doing clones of
the tree. That's what I and everybody else understood. Now apparently he
was wrong and the hurting factor aren't the bitkeeper clients cloning
the tree but the webserver. So I'm glad to have reached my object.

Andrea
