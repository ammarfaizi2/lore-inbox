Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270113AbRHGHFY>; Tue, 7 Aug 2001 03:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270112AbRHGHFO>; Tue, 7 Aug 2001 03:05:14 -0400
Received: from imladris.infradead.org ([194.205.184.45]:54033 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S270111AbRHGHFI>;
	Tue, 7 Aug 2001 03:05:08 -0400
Date: Tue, 7 Aug 2001 08:04:58 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <200108062346.BAA09011@kufel.dom>
Message-ID: <Pine.LNX.4.33.0108070757460.11974-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej.

First, what's with the crazy addresses for Linux-Kernel mailing list
and the various correspondants?

 >>>> One of my systems has SIX ethernet cards, these being three ISA
 >>>> and two PCI NE2000 clones and a DEC Tulip. Here's the relevant
 >>>> section of modules.conf on the system in question:

 >>>>  Q> alias eth0 ne
 >>>>  Q> options eth0 io=0x340
 >>>>  Q> alias eth1 ne
 >>>>  Q> options eth1 io=0x320
 >>>>  Q> alias eth2 ne
 >>>>  Q> options eth2 io=0x2c0
 >>>>  Q> alias eth3 ne2k-pci
 >>>>  Q> alias eth4 ne2k-pci
 >>>>  Q> alias eth5 tulip

 >> However, if the cards are controlled by different drivers, you can
 >> influence the order they are detected in by your choice of entries in
 >> modules.conf - in the example above, the ISA cards are always eth0,
 >                                                         ^^^^^^

 >> eth1 and eth2, the NE2k-pci cards are always eth3 and eth4, and the
 >> tulip card is always eth5, simply because that's what the said file
 >> says.

 > Not always. You are wrong here, I'm afraid:

 > Lets assume that eth0-eth3 are not initialized at boot time and
 > your init scripts attempt to initialize eth4 ...

Then I get an entry for eth4 in the `ifconfig` output, with NO entries
for `eth0` through `eth3`, exactly as expected.

Note that the `ifconfig` command refers to the interfaces by name, and
it's the settings in modules.conf that decide what type of interface
that name refers to. That mapping can't be changed by any interface
configuration or initialisation command, and the names used are those
as given.

 > To avoid such problems one probably should add a lot of
 > pre-install parameters in modules.conf.

What problems?

Best wishes from Riley.

