Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281738AbRLBSP6>; Sun, 2 Dec 2001 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRLBSPs>; Sun, 2 Dec 2001 13:15:48 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:274 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S281738AbRLBSPi>; Sun, 2 Dec 2001 13:15:38 -0500
Date: Sun, 2 Dec 2001 13:15:36 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Erik Elmore <lk@bigsexymo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: EXT3 - freeze ups during disk writes
In-Reply-To: <Pine.LNX.4.33.0112021116190.13663-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10112021310480.29688-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in other mail I asked Erik about the disk's mode: it is PIO,
so the pathetic speed and crippling VM/Ext2 performance is 
entirely expected.  I'm guessing he's missing CONFIGs of either
the chipset-specific driver or one of:
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y


> > I've seen a couple of reports where ext3 appears to exacerbate
> > the effects of poor hdparm settings.  What is your raw disk
> > throughput, from `hdparm -t /dev/hda'?
> 
> `hdparm -t /dev/hda` reports:
> 
> # hdparm -t /dev/hda
> 
> /dev/hda:
>  Timing buffered disk reads:  64 MB in 16.76 seconds =  3.82 MB/sec

