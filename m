Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265665AbSJXUmt>; Thu, 24 Oct 2002 16:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSJXUmt>; Thu, 24 Oct 2002 16:42:49 -0400
Received: from [202.89.69.154] ([202.89.69.154]:65244 "EHLO manage.24online")
	by vger.kernel.org with ESMTP id <S265665AbSJXUmr>;
	Thu, 24 Oct 2002 16:42:47 -0400
Subject: Re: [vortex-bug] 3Com Cardbus 3CXFE575CT IRQ Problems
From: Dionysius Wilson Almeida <dwilson@yenveedu.com>
To: Donald Becker <becker@scyld.com>
Cc: vortex-bug@scyld.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210241633550.1190-100000@beohost.scyld.com>
References: <Pine.LNX.4.44.0210241633550.1190-100000@beohost.scyld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Oct 2002 02:19:14 +0530
Message-Id: <1035492554.1407.2.camel@debianlap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 02:11, Donald Becker wrote:
> On 24 Oct 2002, Dionysius Wilson Almeida wrote:
> 
> > I'm running Debian Woody with kernel 2.4.19 with cardbus and hotplug
> > support.  I've a 3Com 3CXFE575CT pcmcia card and I'm trying to get it to
> > work on my system. It seems that the card is unable to find a usable
> > IRQ.
> 
> As you likely already know, this is a kernel / BIOS issue, not a 3Com
> driver issue.  This problem will exist with any CardBus card that uses
> interrupts (almost every device).
> 
> > I've disabled Plug-n-Play in the BIOS of my Sony VAIO PCG-FX140
> > Laptop but still the card is not able to get any usable IRQs. I also
> > booted with pci=biosirq but still no progress.
> 
> You can also try "noapic", although that's almost never a issue on a
> laptop.  (It's more likely to be an issue on a desktop with a
> PCI-CardBus adapter.) 
I will try this "noapic" and see if that helps.

> > 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and
> > Memory Controller Hub (rev 11)
> > 	Subsystem: Sony Corporation: Unknown device 80df
> ...
> > 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 03)
> > (prog-if 00 [Normal decode])
> > 	Flags: bus master, fast devsel, latency 0
> > 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> ...
> > 01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394
> 
> Does the FireWire work properly?  It's sitting on the same secondary PCI
> bus as the CardBus.
> 
Yeah the firewire disk works fine when Plug-n-Play in the BIOS is
disabled.

> > 01:02.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> > 	Subsystem: Sony Corporation: Unknown device 80df
> ...
> > 	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
> > 01:02.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> > 	Subsystem: Sony Corporation: Unknown device 80df
> ..
> > 01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet
> > Controller (rev 03)
> > 	Subsystem: Intel Corp.: Unknown device 3013
> > 	Flags: bus master, medium devsel, latency 66, IRQ 9
> 
> Presumably this is work fine as well.
Yeah the in-built ethernet controller works fine too.

thanks for your inputs...

regards,

-Wilson


