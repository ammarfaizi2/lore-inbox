Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276364AbRJURV3>; Sun, 21 Oct 2001 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRJURVT>; Sun, 21 Oct 2001 13:21:19 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:31246 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276364AbRJURVH>;
	Sun, 21 Oct 2001 13:21:07 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110211721.VAA31390@ms2.inr.ac.ru>
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
To: saw@saw.sw.com.sg (Andrey Savochkin)
Date: Sun, 21 Oct 2001 21:21:32 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, cfriesen@nortelnetworks.com
In-Reply-To: <20011020145515.A17623@castle.nmd.msu.ru> from "Andrey Savochkin" at Oct 20, 1 02:55:15 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> What do you think will happen when a broadcast ARP request for 1.2.3.4
> arrives to both eth0 and eth2?

Nothing. Linuxes attached to the segment even will not notice this.
Just check and guess why. :-)

Windows will dump a funny popup saying that someone uses
their address, but however will continue to work. Probably
with short periods of service deaths if the router is not a router
really, but drops everything instead.


> How can it be done better?

I permanently remind that the situation when a part of protocol
is firewalled, and part of it has _no_ firewall hooks does not smell well.
Proxy arp rules are essentially some underdeveloped private ARP-only
firewall rules.

So, if you rely on core facilities, believe to them and do not break
them with some additional filters.

If you broke them f.e. announcing a pseudo-router with forwarding
enabled but dropping everything with a firewall rule, ARP must not
take care of this. That part of code which drops IP is responsible
for ARPing being in sync to its rules.

Alexey
