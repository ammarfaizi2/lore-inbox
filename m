Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbTFSVRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbTFSVRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:17:51 -0400
Received: from [65.37.109.202] ([65.37.109.202]:46746 "EHLO
	wizardsworks.wizardsworks.org") by vger.kernel.org with ESMTP
	id S265770AbTFSVRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:17:49 -0400
Date: Thu, 19 Jun 2003 14:32:10 -0700 (PDT)
From: Sir Ace <chandleg@wizardsworks.org>
To: linux-video@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ issues....
In-Reply-To: <Pine.LNX.4.44.0306191413140.12281-100000@wizardsworks.org>
Message-ID: <Pine.LNX.4.44.0306191430300.12281-100000@wizardsworks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I sent this to both the video, and normal lists, because my issue is video
but it seems to be a problem outside of the video sub-system:

2.5.72 yeilds these:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3147] at 00:11.0
PCI: IRQ 0 for device 00:05.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 00:09.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 00:09.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 00:09.1
PCI: Sharing IRQ 11 with 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: IRQ 0 for device 00:09.2 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 00:0c.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 00:0e.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 00:0f.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 00:10.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Enabling device 00:0c.0 (0004 -> 0007)
PCI: IRQ 0 for device 00:0c.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 5 for device 00:0c.0
PCI: Sharing IRQ 5 with 00:09.0

What I have is 4 Osprey 100 Vid cap cards. {Bt848}
I've done a lot of work to tear through this so, please forgive the length
of this mail...

Kernel linux-2.4.18-17.7.x {puke, redhat yes I know}
with bt support built in, I got {or similar}:

bttv1: irq: SCERR risc_count=3530a82c
bttv1: irq: SCERR risc_count=3530a834
bttv1: irq: SCERR risc_count=3530a82c
bttv1: irq: SCERR risc_count=3530a834
bttv1: irq: SCERR risc_count=3530a82c
bttv1: aiee: error loops
bttv1: irq: SCERR risc_count=3530a82c
bttv1: aiee: error loops
bttv1: resetting chip

Since I am recording live video streams from these inputs, I am screwed
when the chip resets, because in that instant the device dissappears.
It does come back once the IC reset is done, but that is too long to save
the app that is useing it.

Anyway:
2.4.21 Stock with compiled in bt support does the same
2.4.21 Stock with bt as a module is the same:
2.4.21 with no bt support, but using bttv standalone drivers 0.7.97 is the same:
2.4.21 with no bt support, but using bttv standalone drivers 0.7.106 is the same:

2.4.21 with no bt support, but using bttv standalone drivers 0.9.10 yields:
bttv0: timeout: risc=34a6d03c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv3: timeout: risc=358a203c, bits: HSYNC OFLOW
bttv3: reset, reinitialize
bttv1: timeout: risc=34a6c03c, bits: HSYNC OFLOW
bttv1: reset, reinitialize

2.5.72 when detecting the cards shows the output at the top of this mail:
and this latre on:
bttv0: timeout: risc=37cd803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
bttv3: timeout: risc=37cc903c, bits: HSYNC OFLOW
bttv3: reset, reinitialize

I have no alternative to fixing it because I am not putting windows on the
machine.....  So please help ;)  I'll send whatever info anyone wants, but
I need to know what you need to figure out what's up.....   I don't know
enough to help fix it other than giving info.

  --Sir Ace



