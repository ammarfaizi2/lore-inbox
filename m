Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTIABKe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTIABKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:10:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41190
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262540AbTIABK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:10:27 -0400
Date: Mon, 1 Sep 2003 03:10:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901011055.GE11503@dualathlon.random>
References: <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <20030831225639.GB16620@work.bitmover.com> <20030831231305.GE24409@dualathlon.random> <20030901001819.GC29239@mail.jlokier.co.uk> <20030901002815.GB11503@dualathlon.random> <20030901005041.GC31531@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901005041.GC31531@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 01:50:41AM +0100, Jamie Lokier wrote:
> Andrea Arcangeli wrote:
> > Depending on the connect/sec of the http server (not bkbits, for the
> > largest part of the conversation I couldn't know about the http server,
> > Larry only mentioned the bkbits.net clone until recently), the
> > "reservation" margin will have to change: the less connect/sec the
> > smaller margin Larry will need to reserve, the more connect/sec the
> > bigger marging will be necessary.
> 
> Hi Andrea,
> 
> Above a certain connection rate, no amount of margin is enough.  The
> connections are a SYN flood.
> 
> You need to take into account the peak rate, which varies from second
> to second, due to simple statistics plus the tendency of the net to
> make traffic burstier than it started.
> 
> Above a certain number of packets/sec, competing VoIP traffic degrades
> - a little added latency is equivalent to dropping with VoIP.  That
> translates to dropouts in the audio.  Acceptable for hackers talking
> over a flakey line, but not corporate telephony.
> 
> At Larry's server, inbound connection rate resembles a low-level SYN
> flood, which is enough to poke holes in VoIP latency.

Yes. if you check my very first email in this thread, you will see I
said "it has to work, unless you're under syn-flood ;)".

this is obvious, I'm not arguing about that. From Larry's description of
the problem it couldn't be a syn flood, but it was a bkbits.net clone
thing or checkout or whatever non syn intensive.

now apparently bkbits.net has nothing to do with it, and it's all about
the http server. Then of course the syn overhead may become noticeable
but things have changed totally from the original description of the
problem (the bkbits.net clone thing).

however keep in mind you will somehow throttle the number of syns too,
unless every single syn arrives to the webserver from a different user
(unlikely).

Andrea
