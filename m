Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTHaXV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTHaXV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:21:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4832
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263056AbTHaXV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:21:57 -0400
Date: Mon, 1 Sep 2003 01:22:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831232224.GF24409@dualathlon.random>
References: <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk> <20030831230219.GD24409@dualathlon.random> <20030831230728.GA4918@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831230728.GA4918@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 04:07:28PM -0700, Larry McVoy wrote:
> On Mon, Sep 01, 2003 at 01:02:19AM +0200, Andrea Arcangeli wrote:
> > On Sun, Aug 31, 2003 at 11:52:39PM +0100, Alan Cox wrote:
> > > How about because any undergraduate can do the mathematical proof its
> > > not possible. Unless he controls the ISP end of the link random bursts
> > > of traffic, pingfloods, anything not respecting requests to slow down
> > > will lose voice traffic.
> > 
> > they are legitimate tcp connections, not udp or icmp. I'm not saying you
> > can control pingfloods or udp floods or syn floods.
> 
> I'll try this one more time and then I'm giving up because as far as I 
> can tell you haven't tried this with a busy server, I think you said you
> did shaping on your home machine or something.  Hardly the same thing.

the only difference I believe is that the connections are originated by
my end, but that only changes the syn packet that normally accounts for
a non significant amount of the bandwidth. And while this is located in
a house, this isn't what I would call an home user usage.

> How about a series of tiny HTTP requests?  All 1.0, no connection reuse.

on the long run, the way I recommend you to act, is to have a script
that turns the traffic shaping on on demand before/after using voip, so
you won't hurt the bkbits.net userbase when you're not at the phone. So
you will fix the unprofessional thing during conf calls completely and
the community should be ok with reasonably short slowdowns while you're
at the phone (if only voip would run under linux too you could automate it).

Just try for a test with my script changing it to give 1kbyte/sec both
ways (not 64k/16k) to everything but voip. I think I already posted all
the needed information you need to make it work. You will need to rework
the iptables rules carefully though, to include all the traffic but voip.

Hope this helps you too (I couldn't live without it),

Andrea
