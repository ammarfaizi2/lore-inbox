Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272867AbTHKRjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272875AbTHKRhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:37:14 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:53003
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S272867AbTHKRfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:35:41 -0400
Date: Mon, 11 Aug 2003 19:35:38 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3 problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)
Message-ID: <20030811173538.GA2604@man.beta.es>
References: <20030811102236.GA731@man.beta.es> <20030811114850.E32508@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811114850.E32508@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, what a quick reply, here goes the info you asked for, if you need any
more just ask for it.

> - does 2.6.0-test3 detect the card at boot ?
>   - if not, what are the complete kernel messages ?

Yes and no, I mean, it detects a card, but not the card it has in, it tries
to load memory_cs when I have a wireless card in, the card should load
hostap_cs, in fact if after booting I remove it and insert it twice, it
recognices the card well and tries to load hostap_cs.

Here are the messages it outputs:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: IRQ 10 for device 0000:01:09.0 doesn't match PIRQ mask - try
pci=usepirqmask
PCI: Found IRQ 11 for device 0000:01:09.0
PCI: Sharing IRQ 11 with 0000:00:1d.1
IRQ routing conflict for 0000:01:09.0, have irq 10, want irq 11
Yenta: CardBus bridge found at 0000:01:09.0 [1025:1024]
Yenta IRQ list 02b8, PCI irq10
Socket status: 30000811
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff
0xdc000-0x103fff

> - does 2.6.0-test3 detect it at every insertion after the first
>   "insert remove insert" cycle, or does it always need an even
>   number of insertions for it to be recognised?

It always needs an even number of insertions.

> - does 2.4 and 2.6-test3 yenta find the same IRQs ?

Seems so, these are the messages for yenta on 2.4.21:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 01:09.0
PCI: Sharing IRQ 11 with 00:1d.1
IRQ routing conflict for 01:09.0, have irq 10, want irq 11
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000007
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff
0xe0000-0xfffff

> - which version of pcmcia-cs are you using with 2.4 ?

3.2.2

> - which IRQ(s) does 2.4 i82365 use ?

The same ones as yenta, here you have the messages I get with it just in
case:

Linux PCMCIA Card Services 3.2.2
  kernel build: 2.4.21 #1 Sat Jun 14 19:43:14 CEST 2003
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 11 for device 01:09.0
PCI: Sharing IRQ 11 with 00:1d.1
IRQ routing conflict for 01:09.0, have irq 10, want irq 11
  O2Micro OZ6912 rev 00 PCI-to-CardBus at slot 01:09, mem 0x10001000
    host opts [0]: [pci/way] [pci irq 10] [lat 32/176] [bus 2/5]
    ISA irqs (default) = 3,4,5,7 PCI status changes

Hope this helps, if you need anything else, just ask for it.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
