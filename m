Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSK0QHb>; Wed, 27 Nov 2002 11:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSK0QHb>; Wed, 27 Nov 2002 11:07:31 -0500
Received: from boden.synopsys.com ([204.176.20.19]:40326 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S263279AbSK0QHa>; Wed, 27 Nov 2002 11:07:30 -0500
Date: Wed, 27 Nov 2002 17:14:32 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: fuzk@heaven.kiyavia.crimea.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prev. mail
Message-ID: <20021127161432.GA20066@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <20021127155439.922D7E012@heaven.kiyavia.crimea.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021127155439.922D7E012@heaven.kiyavia.crimea.ua>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 05:54:39PM +0200, fuzk@heaven.kiyavia.crimea.ua wrote:
> Problem: the system hangs
> The additional information: troubles with controller on hd (hardware problem)

you mean the kernel has to deal with broken hardware (the broken hdc)
in sane way instead of hanging, right?

> After recompiling kernel 2.4.18 with patch 2.4.19 wtere was a trouble:
> The system hangs after loading in place 'Partition check'. Fragment dmesg:
> hdc: SAMSUNG SV0511D, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
>  hdc:           /* hdc: <-- trouble */
> 
> In kernel 2.4.18 it was so:
> 
>  hdc:hdc: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdc: drive not ready for command
>  [PTBL] [620/255/63] hdc1 hdc2 hdc3

in case it's needed: "ide1=nodma" in kernel boot line.
Do you have intel piix support compiled in, btw?

> 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)

