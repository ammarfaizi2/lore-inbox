Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135271AbRA0Tbc>; Sat, 27 Jan 2001 14:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135316AbRA0TbW>; Sat, 27 Jan 2001 14:31:22 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:32529 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S135271AbRA0TbE>; Sat, 27 Jan 2001 14:31:04 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: routing between different subnets on same if.
Date: Sat, 27 Jan 2001 19:31:56 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <94v7nc$28g$1@ncc1701.cistron.net>
In-Reply-To: <20010127193234.A1166@MourOnLine.dnsalias.org> <Pine.LNX.4.32.0101271839130.15191-100000@rossi.itg.ie> <20010127194659.A1326@MourOnLine.dnsalias.org>
X-Trace: ncc1701.cistron.net 980623916 2320 195.64.65.67 (27 Jan 2001 19:31:56 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010127194659.A1326@MourOnLine.dnsalias.org>,
 <patrick.mourlhon@wanadoo.fr> wrote:
>On Sat, 27 Jan 2001, Paul Jakma wrote:
>
>> On Sat, 27 Jan 2001 patrick.mourlhon@wanadoo.fr wrote:
>> 
>> > Hi Paul,
>> >
>> > I just think you might look for aliasing on your linux box.
>> 
>> i have the aliasing, the aliased machine can ping IP's on both
>> subnets. The machine is supposed to be a router though and clients on
>> both subnets are setup to use it as their default router.. but it
>> doesn't route... it notices that both IP's are on the same link and so
>> just sends ICMP redirects. which doesn't help. :(
>> 
>> i need linux to completely route between 2 IP's even though they are
>> on the same link.

Did you enable forwarding with echo 1 > /proc/sys/net/ipv4/ip_forward ?

>did you install routed on the linux machine ?

Routed is a daemon which speaks RIP to other routers. That isn't
needed at all in this case.

Mike.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
