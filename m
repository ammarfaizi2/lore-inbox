Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbTHaXMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTHaXMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:12:40 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44255
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263044AbTHaXMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:12:38 -0400
Date: Mon, 1 Sep 2003 01:13:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831231305.GE24409@dualathlon.random>
References: <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <20030831225639.GB16620@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831225639.GB16620@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 03:56:39PM -0700, Larry McVoy wrote:
> Yet you keep insisting it will work.  Why?  What is the theory that says
> you can keep the other end of the T1 line from being congested when you
> don't have control over that router?  And that router has several 100Mbit

it's absolutely trivial, your end only needs to drop 99% of your
outgoing acks and their incoming packets for every connection but voip
while you are at the phone, you won't kill the connections but everybody
but your voip will work. the exponential backoff and sstrash on the
other and will rate limit everything immediatly.

you will definitely control the other end.

Anyways, I was only trying to help, I know how it works, it works
perfectly for me, and the reason everything makes perfect sense is that
this directory exists in Alan's tree too:

	2.4.22ac1/net/sched/

All assuming you're not under attack, if that's the case you should
contact your ISP since that's unfixable on your end.

Andrea
