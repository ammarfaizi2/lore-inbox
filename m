Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282937AbRK0UmI>; Tue, 27 Nov 2001 15:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282939AbRK0Ul6>; Tue, 27 Nov 2001 15:41:58 -0500
Received: from waste.org ([209.173.204.2]:31878 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282938AbRK0Uls>;
	Tue, 27 Nov 2001 15:41:48 -0500
Date: Tue, 27 Nov 2001 14:41:28 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Default outgoing IP address?
In-Reply-To: <Pine.LNX.3.96.1011127151949.31174F-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.40.0111271435500.10341-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Bill Davidsen wrote:

> On Mon, 26 Nov 2001, Oliver Xymoron wrote:
>
> > On a machine with multiple interfaces, is it possible to set the default
> > outgoing IP address to something other than the address for the interface
> > on the outgoing route?
> >
> > For instance, a machine acts as a gateway, with addresses A and B, where A
> > faces the world (but isn't in DNS) and B is the canonical address.
> > Outgoing connections from the machine should appear to come from B.
>
> If you mean having multiple IP addresses on the same NIC, sure you can do
> that, see the section on DNAT in iptables. However, if you have multiple
> NICs, you do not want to send a packet from one which has the IP of the
> other, as your router is very likely to become confused and get its ARP
> table in a twist.
>
> You can force packets out one NIC or the other, usually using iproute, but
> I don't think that's what you have in mind, is it? In any case, doable.

I have a host which has canonical address foo, which also happens to be a
gateway. Foo happens to be on the local side of the gateway, so when
initiating connections, they appear to be from the gateway interface
address, bar. This is inconvenient because bar is an address on a network
I don't have DNS authority over, etc., so it'd be nice if outgoing
connections by default would appear to come from foo.

I'll take a look at iproute.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

