Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135699AbRDSOus>; Thu, 19 Apr 2001 10:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135239AbRDSOuj>; Thu, 19 Apr 2001 10:50:39 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:37131 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S135699AbRDSOu3>; Thu, 19 Apr 2001 10:50:29 -0400
Date: Thu, 19 Apr 2001 10:51:16 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PNP BIOS and parport_pc - dma found but not used
In-Reply-To: <E14qCql-00070F-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0104190947320.1315-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan!

> > The setting is BIOS is to use irq 7 and dma 3. I normally use "options
> > parport_pc io=0x378 irq=7 dma=3" in /etc/modules.conf, but this time I
> > commented them out hoping that the driver will ask BIOS.
> >
> > PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=-1
>
> Do you have it set in the BIOS itself to use DMA mode and to use DMA 3. The
> PnPBIOS should be reflecting your BIOS choices if I understand rightly

Yes, it is set in BIOS to use ECP, EPP, IRQ 7 and DMA 3.

There is another interesting line in the log that you didn't quote. The
driver actually knows about DMA 3:

0x378: ECP settings irq=7 dma=3

Just in case, that board is Asus P5A-B with the latest BIOS:
P5A-B BIOS ver. 1010, 05/31/2000

For comparison, I took a board with VIA chipset and PhoenixBIOS 4.0
Release 6.0, and it works properly with another 2.4.3-ac9 kernel:

Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=3
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)

-- 
Regards,
Pavel Roskin

