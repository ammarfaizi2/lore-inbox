Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSINNcI>; Sat, 14 Sep 2002 09:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSINNcI>; Sat, 14 Sep 2002 09:32:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21439 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316610AbSINNcG>;
	Sat, 14 Sep 2002 09:32:06 -0400
Date: Sat, 14 Sep 2002 15:36:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: 34-bk current ide problems - unexpected interrupt
Message-ID: <20020914133619.GI935@suse.de>
References: <200209120838.44092.tomlins@cam.org> <20020913060647.GH1847@suse.de> <200209132142.23964.tomlins@cam.org> <200209132258.21297.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209132258.21297.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13 2002, Ed Tomlinson wrote:
> On September 13, 2002 09:42 pm, Ed Tomlinson wrote:
> > Hi,
> >
> > To check if the problem I am seeing is with the port to 2.5 I tried
> > 2.4.20-pre5-ac4 and 2.4.20-pre5-ac6.  Both booted correctly.
> >
> > Now to try 2.5.34+bk without Andrew's mm patch.  If that fails what
> > debugging info would help solve the unexpected interrupt problem?
> 
> to summerize
> 
> 2.4.20-pre5-ac4	works
> 2.4.20-pre5-ac5	works
> 2.5.34-mm1		works	(without Jens ide port of pre5-ac4)
> 2.5.34-mm2		fails with unexpected interrupt loop
> 2.5.34-bk current	fails with unexpected interrupt loop

Hmm, I just plopped in a 20267 here and it works perfectly:

PDC20267: IDE controller at PCI slot 00:0c.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:DMA
hde: IBM-DTLA-307030, ATA DISK drive
ide2 at 0xb400-0xb407,0xb002 on irq 16
hde: host protected area => 1
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63,
UDMA(100)
 hde: hde1 hde2 < hde5 >

> Removing the printk from ide.c does _not_ cure the problem.   The ide
> setting between 2.4 and 2.5 were as identical as I can make them.

Can you please send me the config settings?

> Notice that 2.4 orders the boot differently.  Wonder if this is significant?

That's expected.

-- 
Jens Axboe

