Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282935AbRK0Ubi>; Tue, 27 Nov 2001 15:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282933AbRK0Ub3>; Tue, 27 Nov 2001 15:31:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11272 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282931AbRK0UbY>; Tue, 27 Nov 2001 15:31:24 -0500
Date: Tue, 27 Nov 2001 15:24:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Default outgoing IP address?
In-Reply-To: <Pine.LNX.4.40.0111261612390.15983-100000@waste.org>
Message-ID: <Pine.LNX.3.96.1011127151949.31174F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Oliver Xymoron wrote:

> On a machine with multiple interfaces, is it possible to set the default
> outgoing IP address to something other than the address for the interface
> on the outgoing route?
> 
> For instance, a machine acts as a gateway, with addresses A and B, where A
> faces the world (but isn't in DNS) and B is the canonical address.
> Outgoing connections from the machine should appear to come from B.

If you mean having multiple IP addresses on the same NIC, sure you can do
that, see the section on DNAT in iptables. However, if you have multiple
NICs, you do not want to send a packet from one which has the IP of the
other, as your router is very likely to become confused and get its ARP
table in a twist.

You can force packets out one NIC or the other, usually using iproute, but
I don't think that's what you have in mind, is it? In any case, doable.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

