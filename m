Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTIAAuw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTIAAuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:50:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23689 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262885AbTIAAuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:50:51 -0400
Date: Mon, 1 Sep 2003 01:50:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901005041.GC31531@mail.jlokier.co.uk>
References: <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <20030831225639.GB16620@work.bitmover.com> <20030831231305.GE24409@dualathlon.random> <20030901001819.GC29239@mail.jlokier.co.uk> <20030901002815.GB11503@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901002815.GB11503@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Depending on the connect/sec of the http server (not bkbits, for the
> largest part of the conversation I couldn't know about the http server,
> Larry only mentioned the bkbits.net clone until recently), the
> "reservation" margin will have to change: the less connect/sec the
> smaller margin Larry will need to reserve, the more connect/sec the
> bigger marging will be necessary.

Hi Andrea,

Above a certain connection rate, no amount of margin is enough.  The
connections are a SYN flood.

You need to take into account the peak rate, which varies from second
to second, due to simple statistics plus the tendency of the net to
make traffic burstier than it started.

Above a certain number of packets/sec, competing VoIP traffic degrades
- a little added latency is equivalent to dropping with VoIP.  That
translates to dropouts in the audio.  Acceptable for hackers talking
over a flakey line, but not corporate telephony.

At Larry's server, inbound connection rate resembles a low-level SYN
flood, which is enough to poke holes in VoIP latency.

Of course the real problem is lack of end to end QoS between Larry's
nodes.  Two T1s is just a workaround :)

-- Jamie
