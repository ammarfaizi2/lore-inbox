Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSGAWv7>; Mon, 1 Jul 2002 18:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSGAWv7>; Mon, 1 Jul 2002 18:51:59 -0400
Received: from [213.4.129.129] ([213.4.129.129]:54584 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id <S316576AbSGAWv5>;
	Mon, 1 Jul 2002 18:51:57 -0400
Date: Tue, 2 Jul 2002 00:56:32 +0200
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, Lionel.Bouton@inet6.fr
Subject: Re: [BUG] IDE error in (un)stable trees
Message-Id: <20020702005632.16515807.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.33.0207011837530.835-100000@coffee.psychology.mcmaster.ca>
References: <20020629155725.7557a45f.diegocg@teleline.es>
	<Pine.LNX.4.33.0207011837530.835-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002 18:44:26 -0400 (EDT)
Mark Hahn <hahn@physics.mcmaster.ca> escribió:

> 
> that's a pretty odd device DID.  is this a pretty old chipset?
> does lspci -vx show 0x1039:0x5513 as this device's vid:did?
> if so, it should really work with recent kernels, assuming they're
> compiled sanely.  have you done the .config yourself, and if so,
> do you have CONFIG_BLK_DEV_SIS5513 and CONFIG_IDEDMA_PCI_AUTO:?


lspci -vx:

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
c1) (prog-if 8a [Master SecP PriP])	Subsystem: Unknown device 0040:0000
	Flags: bus master, fast devsel, latency 32, IRQ 14
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at 1000 [size=16]
00: 39 10 13 55 07 00 00 00 c1 8a 01 01 00 20 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 10 00 00 00 00 00 00 00 00 00 00 40 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00


CONFIG_BLK_DEV_SIS5513 and CONFIG_IDEDMA_PCI_AUTO are set.

I remember a thing, a message i get on every boot, now i realise why my
ide chipset doesn't work well:(I've cc-ed all people again so they can
read this)

PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 4 of device 00:01.1

-->00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(rev c1) (prog-if 8a [Master SecP PriP])

I guess the matter is here? Where came this error from?



Diego Calleja


