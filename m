Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbTGVVIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTGVVIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:08:34 -0400
Received: from dp.samba.org ([66.70.73.150]:27012 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269392AbTGVVIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:08:32 -0400
Date: Wed, 23 Jul 2003 07:22:33 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: avaya silver wireless card (orinoco driver) and pcmcia in 2.5.74
Message-ID: <20030722212233.GF9996@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Arkadiusz Miskiewicz <arekm@pld-linux.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030712104611.GB22021@arm.t19.ds.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712104611.GB22021@arm.t19.ds.pwr.wroc.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 12:46:11PM +0200, Arkadiusz Miskiewicz wrote:
> Hi,
> 
> I'm using 2.5.74 kernel, hotplug-2003_05_01-3 and pcmcia-cs-3.2.3-1.

Are you using the in-kernel PCMCIA controller drivers, or the ones
from the pcmcia-cs package?

With the in-kernel drivers I'm unable to reproduce this on 2.5.75.

> Now after putting pcmcia card into slot new interface arrives (eth1)
> and cards works quite well.
> 
> Jul 12 11:21:54 mobarm Linux Kernel Card Services 3.1.22
> Jul 12 11:21:54 mobarm options:  [pci] [cardbus] [pm]
> Jul 12 11:21:54 mobarm Yenta IRQ list 0800, PCI irq5
> Jul 12 11:21:54 mobarm Socket status: 30000411
> Jul 12 11:21:54 mobarm cs: IO port probe 0x0c00-0x0cff: clean.
> Jul 12 11:21:54 mobarm cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x87f
> Jul 12 11:21:54 mobarm cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x3f8-
> 0x40f 0x4d0-0x4d7
> Jul 12 11:21:54 mobarm cs: IO port probe 0x0a00-0x0aff: clean.
> Jul 12 11:21:54 mobarm cs: memory probe 0xa0000000-0xa0ffffff: clean.
> Jul 12 11:21:54 mobarm orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> Jul 12 11:21:54 mobarm orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and other
> s)
> Jul 12 11:21:54 mobarm eth1: Station identity 001f:0001:0008:000a
> Jul 12 11:21:54 mobarm eth1: Looks like a Lucent/Agere firmware version 8.10
> Jul 12 11:21:54 mobarm eth1: Ad-hoc demo mode supported
> Jul 12 11:21:54 mobarm eth1: IEEE standard IBSS ad-hoc mode supported
> Jul 12 11:21:54 mobarm eth1: WEP supported, 104-bit key
> Jul 12 11:21:54 mobarm eth1: MAC address 00:02:2D:4A:FE:4C
> Jul 12 11:21:54 mobarm eth1: Station name "HERMES I"
> Jul 12 11:21:54 mobarm eth1: ready
> Jul 12 11:21:54 mobarm eth1: index 0x01: Vcc 5.0, irq 11, io 0x0100-0x013f
> 
> Unfortunately after getting it out of slot interface eth1 disappears
> but I get:
> Jul 12 11:22:50 mobarm orinoco_lock() called with hw_unavailable (dev=cbae5800)
> Jul 12 11:23:00 mobarm unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> Jul 12 11:23:10 mobarm unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> Jul 12 11:23:20 mobarm unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> Jul 12 11:23:31 mobarm unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> [..]
> 
> Putting card back into slot doesn't cause any effect. I need to reboot
> to get it working again.
> 
> 

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
