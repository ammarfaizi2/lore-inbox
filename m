Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbULKUCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbULKUCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 15:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbULKUCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 15:02:55 -0500
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:8676 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S262007AbULKUCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 15:02:52 -0500
Date: Sat, 11 Dec 2004 15:02:48 -0500
From: Jim Paris <jim@jtan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI IRQ problems -- update
Message-ID: <20041211200248.GA22393@jim.sh>
References: <20041211173538.GA21216@jim.sh> <1102783555.7267.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102783555.7267.37.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The PIIX should be in legacy mode by default in which case it would be
> on IRQ 14/15 only. Can you post boot messages ?

Sure.  This is with the PIIX interrupt rerouted to IRQ 5:
  https://jim.sh/svn/jim/devl/toughbook/log/irq5
Portions of note:

Linux version 2.6.10-rc3 (jim@hypnosis) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #6 Sat Dec 11 11:33:57 EST 2004
...
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-1 of IDE controller 0000:00:1f.1
...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...

> > I'm not sure how to get to the root cause of the problem, though.  For
> > starters: where _should_ the INTA of the IDE card go, if anywhere?  If
> 
> Quite possibly nowhere. IDE controllers have two modes one in which they
> are normal PCI devices (and use INTA) and one in which they are "legacy"
> compatible and use IRQ14/15 directly so they work with pre-PCI operating
> systems.

OK, I see.  Does Linux leave it in legacy mode even when using a
specific driver like piix?  Do you know how I can get more information
on the state of it at boot, to see if BIOS did leave it in legacy
mode? 

-jim
