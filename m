Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266579AbRGXB3c>; Mon, 23 Jul 2001 21:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266583AbRGXB3M>; Mon, 23 Jul 2001 21:29:12 -0400
Received: from hibernia.clubi.ie ([212.17.32.129]:53914 "HELO
	fogarty.jakma.org") by vger.kernel.org with SMTP id <S266579AbRGXB3E>;
	Mon, 23 Jul 2001 21:29:04 -0400
Date: Tue, 24 Jul 2001 02:29:10 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, <sourav@csa.iisc.ernet.in>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Arp problem
In-Reply-To: <3B5CCD1C.B969411F@candelatech.com>
Message-ID: <Pine.LNX.4.33.0107240222130.10839-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
X-Dumb-Filters: aryan marijuiana cocaine heroin hardcore cum pussy porn teen tit sex lesbian group
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001, Ben Greear wrote:

> You'll have to draw a diagram or do a better job of describing
> your network:  I have no idea what you're trying to do!

same wire, 2 logical nets, linux box has one card listening on both
nets. i want it to fully route between them (because the windows
boxes can't).



linux:eth0		192.168.x			windows / linux
      eth0:1		192.168.y			windows / linux


i can not for the life of me get linux to fully route packets between
eth0 and eth0:1. in the end i had to add a second NIC, eth1.

note that linux clients have absolutely no problem with redirects and
192.168.x subnet boxes have no problem talking to 192.168.y boxes.
windows however apparently needs someone to route the packets.

> I think you could use VLANs for what you want to do, but if your
> windows boxes can't handle ICMP-redirects, they probably can't
> handle VLANs either...

nope.. (plus my switch seems to get flaky just with plain adaptive
partitioning within the switch, so i wouldn't trust it with anything
fancy like VLAN)

ultimately i want to make the subnets be physically distinct. but
that'll take time. in the meantime i need linux to route packets
between logical subnets - not send redirects.

> Ben

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Human beings were created by water to transport it uphill.

