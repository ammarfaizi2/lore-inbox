Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAIURx>; Tue, 9 Jan 2001 15:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131945AbRAIURn>; Tue, 9 Jan 2001 15:17:43 -0500
Received: from borg.denalics.net ([209.112.170.15]:34822 "HELO
	borg.denalics.net") by vger.kernel.org with SMTP id <S129835AbRAIURf>;
	Tue, 9 Jan 2001 15:17:35 -0500
Date: Tue, 9 Jan 2001 11:25:14 -0900 (AKST)
From: "Christopher E. Brown" <cbrown@denalics.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <E14FKDI-00033e-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101091114590.15451-100000@borg.denalics.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Alan Cox wrote:

> > Um, what about people running their box as just a VLAN router/firewall?
> > That seems to be one of the principle uses so far.  Actually, in that case
> > both VLAN and IP traffic would come through, so it would be a tie if VLAN
> > came first, but non-vlan traffic would suffer worse.
> 
> Why would someone filter between vlans when any node on each vlan can happily
> ignore the vlan partitioning


	Think VLANing switch clusters.  Say 4 switches connected by
GigE on 4 floors or in 4 separate building.  Now, across these
switches 20 VLANS are running, with the switches enforcing VLAN
partitioning.  The client PCs know nothing about it, as each one
resides within a single VLAN.

	Now we have our Linux box with 2 x 100Mbit FD links to the
switch cluster running 10 VLANS per interface, and an external
DS1/SDSL/whatever connection.  We now have 20 separate zones with
different security controls per zone, with per switchport control over
who resided in what group.  Or even forget the routing and just
plugging a Linux box to a companies 200VLAN setup to provide
DHCP/whatever.

	I must say, I *hate* VLANs for this use, it is a horrible
thing to do that wastes massive amounts of bandwidth on simulating a
local broadcast domain across a much larger area, but oh well.  As
long as we have stupid managers and brain dead sales persons not much
will change.  Are there better things to do than VLAN?  YES!  Will we
get stuck with needing VLANs in the real world?  YES!


---
        The roaches seem to have survived, but they are not routing packets
correctly.
        --About the Internet and nuclear war.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
