Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131732AbRAGNGK>; Sun, 7 Jan 2001 08:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131740AbRAGNGA>; Sun, 7 Jan 2001 08:06:00 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:28173 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S131732AbRAGNFn>; Sun, 7 Jan 2001 08:05:43 -0500
Date: Sun, 7 Jan 2001 21:02:00 +0800
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
Message-Id: <200101071302.f07D20102863@silk.corp.fedex.com>
To: cw@f00f.org, sourav@cs.cmu.edu
Subject: Re: Speed of the network card
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from pcmcia-cs-3.1.22/PCMCIA-HOWTO
4.3.2.  Comments about specific cards
  o  16-bit PCMCIA cards have a maximum performance of 1.5-2 MB/sec.
     That means that any 16-bit 100baseT card (i.e., any card that uses
     the pcnet_cs, 3c574_cs, smc91c92_cs, or xirc2ps_cs driver) will
     never achieve full 100baseT throughput.  Only CardBus network
     adapters can fully exploit 100baseT data rates.


Jeff


On Sun, Jan 07, 2001 at 04:30:30AM -0500, Sourav Ghosh wrote:

    I would like to determine the banwidth the card is getting from
    the network.

/proc/net/dev exports counters; you can monitor those -- I'm sure
there are perfomance program that do exactly this.

    For an ethernet, it could be either 10Mbps or 100Mbps, is there
    any way of knowing from inside the kernel how much is the
    bandwidth the card is actually receiving from the network,
    especially when it is capable of getting either 10Mbps or
    100Mbps?

The kernel counts packets and bytes; you need to work out bandwidth
in userland from that.


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
