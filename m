Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTAYVfb>; Sat, 25 Jan 2003 16:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTAYVfb>; Sat, 25 Jan 2003 16:35:31 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:13064
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262258AbTAYVfa>; Sat, 25 Jan 2003 16:35:30 -0500
Date: Sat, 25 Jan 2003 16:44:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Shawn Starr <spstarr@sh0n.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PROBLEM[2.5.59][-mm4] - DMA Disabled & UDMA wrong mode
In-Reply-To: <200301251328.24971.spstarr@sh0n.net>
Message-ID: <Pine.LNX.4.44.0301251623380.10776-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, Shawn Starr wrote:

> With 2.5.59-mm4 I've seen DMA being disabled. I don't know if this is occuring 
> in vanilla 2.5.59.
> Also, the UDMA33 is wrong, this A7M266-D supports UDMA100 and the drive itself 
> is a UDMA(133) but since ive not heard of any UDMA133 controllers it's using 
> 100.

You can't have DMA disabled and still be doing UDMA33

> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD7441: IDE controller at PCI slot 00:07.1
> AMD7441: chipset revision 4
> AMD7441: not 100%% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD_IDE: Advanced Micro Devic AMD-768 [Opus] IDE (rev04) UDMA100 controller on 
> pci00:07.1
>      ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
> hda: MAXTOR 6L060J3, ATA DISK drive
> hda: DMA disabled

That driver is just a bit noisy i believe, kind of like the VIA one. 
Have you tried latest 2.4-ac's IDE code? It looks like a fair chunk of 
amd74xx came into 2.5 from somewhere, possibly -ac

	Zwane
-- 
function.linuxpower.ca


