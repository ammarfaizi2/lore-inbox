Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbSKSPPY>; Tue, 19 Nov 2002 10:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266240AbSKSPPX>; Tue, 19 Nov 2002 10:15:23 -0500
Received: from ifup.net ([217.160.130.191]:7331 "HELO sit0.ifup.net")
	by vger.kernel.org with SMTP id <S265865AbSKSPPW>;
	Tue, 19 Nov 2002 10:15:22 -0500
Date: Tue, 19 Nov 2002 16:22:44 +0100
From: Karsten Desler <soohrt@soohrt.org>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021119152244.GA26989@sit0.ifup.net>
References: <20021119105955.A23008@pc9391.uni-regensburg.de> <20021119102338.GA24510@sit0.ifup.net> <20021119113300.C23008@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119113300.C23008@pc9391.uni-regensburg.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe U would try 2.5.48, just to see if it works then.

I tried 2.5.48 but Linux didn't detect ide3,4,5,6.
---
DEV: registering device: ID = '00:0e.0', name = Triones Technologies HPT374
kobject 00:0e.0: registering
  parent is pci0
bus pci: add device 00:0e.0
DEV: registering device: ID = '00:0e.1', name = Triones Technologies HPT374 (#2)
kobject 00:0e.1: registering
  parent is pci0
bus pci: add device 00:0e.1
[..]
bus type 'ide' registered
HPT374: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:0e.1
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
PCI: Found IRQ 10 for device 00:0e.1
PCI: Sharing IRQ 10 with 00:0e.0
---
2.5.47 won't boot.

2.5.46 is working:
---
Linux version 2.5.46 (root@pikelot) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Tue Nov 19 15:19:44 CET 2002
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:0e.1
HPT374: chipset revision 7
HPT374: not 100%% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:DMA, hdh:DMA
PCI: Found IRQ 10 for device 00:0e.1
PCI: Sharing IRQ 10 with 00:0e.0
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xc800-0xc807, BIOS settings: hdi:DMA, hdj:DMA
    ide5: BM-DMA at 0xc808-0xc80f, BIOS settings: hdk:DMA, hdl:DMA
hdg: MAXTOR 4K080H4, ATA DISK drive
hdh: WDC WD800AB-00CBA0, ATA DISK drive
ide3 at 0xac00-0xac07,0xb002 on irq 10
hdi: MAXTOR 4K080H4, ATA DISK drive
hdj: WDC WD800AB-00CBA0, ATA DISK drive
ide4 at 0xb800-0xb807,0xbc02 on irq 10
hdk: MAXTOR 4K080H4, ATA DISK drive
hdl: MAXTOR 4K080H4, ATA DISK drive
ide5 at 0xc000-0xc007,0xc402 on irq 10
---

> When I'm back home in about 7 hours, I'll check my bios settings, maybe this 
> could help you.

That would be great, thanks.

  Karsten
