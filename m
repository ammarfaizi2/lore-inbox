Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSGOBmZ>; Sun, 14 Jul 2002 21:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317280AbSGOBmZ>; Sun, 14 Jul 2002 21:42:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38662 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317276AbSGOBmY>; Sun, 14 Jul 2002 21:42:24 -0400
Date: Sun, 14 Jul 2002 21:39:12 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
In-Reply-To: <Pine.LNX.4.44.0207141026440.4252-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.3.96.1020714212910.21185A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, dean gaudet wrote:

> On Sat, 13 Jul 2002, David S. Miller wrote:
> 
> >
> > You have to use specific source-routing settings in conjuntion with
> > enabling arp_filter in order for arp_filter to have any effect.
> >
> > This is a FAQ.
> 
> a couple google queries yielded no answer to this faq... is there a posted
> example somewhere?

Clearly FAQ means frequently asked, not answered. I can't find the
appropriate patch, clearly some people regard allowing source routing to
be a benefit.
 
> is the default behaviour of use to anyone?  this question comes up like
> every other month.

Yes, it's useful to hackers to send a packet to your external interface
with the address of your internal internal interface, if the packet is
accepted it might bypass some of your firewall protections. I assume the
source routing settings David mentions are the normal "if the destination
IP is not this machine log and drop the packet." With a few possible
exceptions for packets other than normal tcp/udp. That's why the bogus arp
is harmeful, the requestor then tries to use the mac address for the wrong
IP and the packets just get dropped by the firewall code.

Like you, I can't see why it would be anything but a bug to do what is
essentially proxy arp by default.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

