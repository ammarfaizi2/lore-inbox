Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSIBJ0x>; Mon, 2 Sep 2002 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318249AbSIBJ0x>; Mon, 2 Sep 2002 05:26:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42431 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318248AbSIBJ0w>;
	Mon, 2 Sep 2002 05:26:52 -0400
Date: Mon, 2 Sep 2002 11:30:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
Message-ID: <20020902093049.GB1023@suse.de>
References: <Pine.LNX.4.44L.0208161340000.1430-100000@imladris.surriel.com> <3D5D32D4.475C6719@wanadoo.fr> <1029611747.4647.3.camel@irongate.swansea.linux.org.uk> <3D732C6F.FCABFAE0@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D732C6F.FCABFAE0@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02 2002, Jean-Luc Coulon wrote:
> Alan Cox wrote:
> > 
> >  "On Fri, 2002-08-16 at 18:13, Jean-Luc Coulon wrote:
> > > At boot time, I get the messages :
> > >
> > > Aug 16 11:34:19 f5ibh kernel: ALI15X3: simplex device: DMA disabled
> > > Aug 16 11:34:19 f5ibh kernel: ide0: ALI15X3 Bus-Master DMA disabled
> > > (BIOS)
> > 
> > Linux did the simplex device check. Your ALi controller only permits DMA
> > on one of the devices at a time. What is attached to the ALi controller
> > ? Also does 2.4.19 base enable DMA correctly ?
> > 
> What is the simplex device check ? You will find thereafter a copy of
> the syslog while booting 2.4.19, it seems that it accepts both with DMA
> enabled.
> 
> > If sSep  2 09:00:51 f5ibh kernel: ALI15X3: chipset revision 193
> f5ibh kernel: ALI15X3: not 100%% native mode: will probe irqs later
> f5ibh kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA,
> hdb:DMA
> f5ibh kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio,
> hdd:pio
> f5ibh kernel: hda: QUANTUM FIREBALLP LM30, ATA DISK drive
> fibh kernel: hdb: ST3491A, ATA DISK drive
> f5ibh kernel: hdc: GoldStar CD-RW CED-8083B, ATAPI CD/DVD-ROM drive
> f5ibh kernel: hdd: CREATIVECD3621E, ATAPI CD/DVD-ROM drive
> f5ibh kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> f5ibh kernel: ide1 at 0x170-0x177,0x376 on irq 15
> f5ibh kernel: blk: queue c023d544, I/O limit 4095Mb (mask 0xffffffff)
> f5ibh kernel: hda: 58633344 sectors (30020 MB) w/1900KiB Cache,
> CHS=3649/255/63, UDMA(33)
> f5ibh kernel: blk: queue c023d680, I/O limit 4095Mb (mask 0xffffffff)
> f5ibh kernel: hdb: 836070 sectors (428 MB) w/120KiB Cache,
> CHS=899/15/62, DMA

Are you sure this is a 2.4.19 boot? It's either 2.4.20-preX (X >= 2) or
2.4.19 with block-highmem

-- 
Jens Axboe

