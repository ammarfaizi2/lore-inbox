Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbRGYUyH>; Wed, 25 Jul 2001 16:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267317AbRGYUx6>; Wed, 25 Jul 2001 16:53:58 -0400
Received: from noella.mindsec.com ([209.172.192.12]:4002 "EHLO
	noella.mindsec.com") by vger.kernel.org with ESMTP
	id <S267314AbRGYUxn>; Wed, 25 Jul 2001 16:53:43 -0400
Date: Wed, 25 Jul 2001 13:53:49 -0700 (PDT)
From: Erik <eparker@mindsec.com>
To: <linux-kernel@vger.kernel.org>
Subject: route problem.. kernel/driver ?
Message-ID: <Pine.GSO.4.33.0107251342100.14023-100000@noella.mindsec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



Hi all,

I'm experiencing by far the strangest problem I've ever encountered in
Linux.. I'm kind of left with no where to turn for ideas on what might be
happening, I thought maybe there is a slight change it is an actual bug.


First, the system.. A single process PIII-450 (katmai).

Linux 2.2.19 i686

The machine has 4 Network interfaces. a Dual intel etherexpress pro.. an
onboard 3c905, and a pci netgear card. (all 10/100)

The onboard, and dual intel work fine.. using the correct
drivers.

eth0: 3Com 3c905B Cyclone 100baseTx at 0xcc00
eth1: Intel PCI EtherExpress Pro100 82557
eth2: Intel PCI EtherExpress Pro100 82557
eth3: Lite-On 82c168 PNIC rev 32 at 0xc800,

The netgear is using the tulip driver.. (eth3)

Here is the strange part.. The machine has two default routes set..

0.0.0.0         4.10.10.1       0.0.0.0         UG        0 0          0 eth3
0.0.0.0         64.10.10.1      0.0.0.0         UG        0 0          0 eth1


This problem is random.. Usually every 30 minutes to 4 hours..  The route
on eth3 just stops working.. You can still ping 4.10.10.1.. but you can't
get to this machine via that interface, and it can't route through it.

if you issue a:

route delete default gw 4.10.10.1 ; route add default gw 4.10.10.1

It all of a sudden works again.. The route table is identical to how it
was prior. Arp tables are the same before and after.. No errors in any
logs, or on screen.. Just random.

I'm at a loss.. Any thoughts?



---
Erik Parker
---

