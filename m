Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281877AbRLDAUt>; Mon, 3 Dec 2001 19:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284927AbRLDAS0>; Mon, 3 Dec 2001 19:18:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35849 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S284759AbRLCQU4>; Mon, 3 Dec 2001 11:20:56 -0500
Date: Mon, 3 Dec 2001 11:14:23 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge the problem!
In-Reply-To: <20011130.142843.31639840.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1011203110304.21357A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Jessica Blank <jessica@twu.net>
>    Date: Fri, 30 Nov 2001 08:35:35 -0600 (CST)
> 
>    	It is high time this problem is acknowledged and FIXED. I am
>    forced to share a network with a bunch of NT servers, some of which get
>    plenty of traffic-- enough so that they manage to crowd out my machine to
>    the tune of 600ish ms ping times to the Linux box versus only **70**
>    (!!!!!!) to the Windows box.

Okay, I acknowledge the problem and admit you don't understand networking.
You have confused the slowstart feature (TCP) with ping (ICMP). TCP and
ICMP are what are called protocols. Slowstart has nothing to do with ICMP.

I will add that if you do an ifconfig I suspect you will see collisions on
your interface, resulting in poor performance. This is caused by running
the interface half duplex, and should not be used unless you are connected
to a type of obsolete hardware known as a hub, instead of a switch. If you
connect to a switch you should see zero collisions.

Finally, even 70ms is really poor ping time, I get better than that
between Albany NY and San Jose CA! Local ping time, even between Pentium
class utility machines on a thinnet (10Mbit half duplex technology) is
70-1400us on a somewhat loaded network.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

