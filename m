Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129633AbRBYTRm>; Sun, 25 Feb 2001 14:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRBYTRY>; Sun, 25 Feb 2001 14:17:24 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:2348 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129629AbRBYTRL>; Sun, 25 Feb 2001 14:17:11 -0500
Date: Sun, 25 Feb 2001 14:22:37 -0500
From: jerry <jdinardo@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ide / usb problem
Message-ID: <20010225142237.A84@ix.netcom.com>
In-Reply-To: <20010225060326.K127@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010225060326.K127@pervalidus>; from 0@pervalidus.net on Sun, Feb 25, 2001 at 06:03:26AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also am using the cable supplied with the mobo (Abit kt7) so I do not
think it is ASUS specific. More likey it is releated to the
VIA chipset and/or driver.

If I compile kernel with "Generic PCI bus-master DMA support"
and run "hdparm -d1 /dev/hda" I get 700% performance increase
on hdparm -t benchmark and I do not get any dma BadCRC errors.

It is only when I also compile in the VIA82CXXX option that I get the
    "hda: dma_intr:status=0x51 { DriveReady SeekComplete Error }"
    "hda: dma_intr:error=0x84 { DriveStatusError BadCRC }"
mesages (1000's of them).

Whether I get the messages or not, if I have dma enabled with 2.4.2
my usb mouse stops working .

jpd
> 	 
> > That indicates cable problems. The CRC will avoid bad transfers
> > as it will do retries
> 
> Oh my god. Are you sure it's a cable problem? I'm using the
> cable shipped by ASUS with my K7V and have the same problem:
> 
> devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x2
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide0: reset: success
> 
> Again, if it's really a cable problem, then ASUS is selling
> cables that don't work with UDMA66 (but they sell it as
> UDMA66).
> 
> I urge ASUS to explain this problem. If you do a search for
> BadCRC at any lkml archive, you should notice most complaints
> are from... VIA (and most seem to have an ASUS motherboard).
> 
> -- 
> 0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
