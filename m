Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUAPTlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUAPTlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:41:18 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:65001 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265746AbUAPTkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:40:40 -0500
Date: Fri, 16 Jan 2004 20:40:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nforce2 66MHz IDE without idebus=xx and "Athlon-xp powersaving system lock"
Message-ID: <20040116194034.GA24256@ucw.cz>
References: <200401161352.25732.murilo_pontes@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161352.25732.murilo_pontes@yahoo.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 01:52:25PM +0000, Murilo Pontes wrote:

> If all Nvidia Nforce2 based systems have 2 pci buses (First is 66mhz for onboard devices and
> second is 33mhz for pci expansion slots) and IDE controller work in 66mhz,
> will be change kernel to start IDE controller in 66mhz mode automatic?

The IDE controller base clock is 33MHz on the NForce2, although the ide
controller itself is connected to the HyperTransport link, running at
200 MHz or so.

> dmesg
> ================================================
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> NFORCE2: IDE controller at PCI slot 0000:00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
> NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: Maxtor 6E040L0, ATA DISK drive
> hdb: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: max request size: 128KiB
> hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
> ==================================================
> 
> lspci -v
> ===================================================
> 00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
>         Flags: bus master, 66Mhz, fast devsel, latency 0
>         I/O ports at f000 [size=16]
>         Capabilities: [44] Power Management version 2
> ====================================================

This 66 MHz and the above 33 MHz numbers are completely unrelated. Just
forget about setting idebus to anything else than it is default. Bigger
numbers mean _slower_ performance anyway.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
