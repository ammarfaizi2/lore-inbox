Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRJEWXD>; Fri, 5 Oct 2001 18:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRJEWWw>; Fri, 5 Oct 2001 18:22:52 -0400
Received: from astcc-132.astound.net ([24.219.123.215]:23556 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S274194AbRJEWWn>; Fri, 5 Oct 2001 18:22:43 -0400
Date: Fri, 5 Oct 2001 15:23:16 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Sean Swallow <sean@swallow.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20268 UDMA troubles
In-Reply-To: <Pine.LNX.4.33.0110051254070.15665-100000@lsd.nurk.org>
Message-ID: <Pine.LNX.4.10.10110051522120.4222-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Sean Swallow wrote:

> Andre,
> 
> Thank you for the reply.
> 
> I was wondering if both controllers (PDC20268 and PDC20267) should show up
> when I cat /proc/ide/pdc202xx ?
> 
> I'm not disabling the BURST_BIT, I think the driver is, but only on the
> second card. Thus, I can't get udma5 on all 4 chains.
> 
> This is from dmesg:
> 
> PDC20267: IDE controller on PCI bus 00 dev 40
> PDC20267: chipset revision 2
> PDC20267: not 100% native mode: will probe irqs later
> PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
>     ide2: BM-DMA at 0x1080-0x1087, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0x1088-0x108f, BIOS settings: hdg:DMA, hdh:pio
> PDC20268: IDE controller on PCI bus 00 dev 50
> PDC20268: chipset revision 2
> PDC20268: not 100% native mode: will probe irqs later
> PDC20268: (U)DMA Burst Bit DISABLED Primary MASTER Mode Secondary MASTER
> Mode.
>     ide4: BM-DMA at 0x10d0-0x10d7, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0x10d8-0x10df, BIOS settings: hdk:pio, hdl:pio
> 
> Let me know if you need more information.
> 
> cheers,
> 
> -- 
> Sean J. Swallow
> pgp (6.5.2) keyfile @ https://nurk.org/keyfile.txt
> 
> 
> On Thu, 4 Oct 2001 andre@linux-ide.org wrote:
> 
> >
> > There is nothing wrong with the procfs.
> > The HOST performs a sense mode on the contents of the taskfile registers
> > when loading a setfeature to change the transfer rate.  Mode 5 is the
> > same
> > timings as Mode 4; however, the internal base clocks are different.
> >
> > Also why are we disabling the BUSRT BIT?
> >
> >
> 

The procfs api does not parse several cards at this time.

Cheers,

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Tel: (510) 857-0055 x103
38875 Cherry Street                           Fax: (510) 857-0010
Newark, CA 94560                              Web: www.aslab.com

