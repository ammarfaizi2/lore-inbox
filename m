Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316005AbSEOH1b>; Wed, 15 May 2002 03:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316010AbSEOH1a>; Wed, 15 May 2002 03:27:30 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:50692
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S316005AbSEOH13>; Wed, 15 May 2002 03:27:29 -0400
Date: Wed, 15 May 2002 09:27:20 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Andre LeBlanc <ap.leblanc@shaw.ca>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: No Network after Compiling, 2.4.19-pre8 under Debian Woody (Long Message)
Message-ID: <20020515092720.A13317@bouton.inet6-interne.fr>
Mail-Followup-To: Andre LeBlanc <ap.leblanc@shaw.ca>,
	bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox> <20020514202912.GA18544@outpost.ds9a.nl> <000c01c1fba2$1779da60$2000a8c0@metalbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 04:50:13PM -0700, Andre LeBlanc wrote:
> [...]
> hda: 60046560 sectors (30744 MB) w/2048KiB Cache, CHS=3971/240/63, UDMA(100)
> 
> hdb: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, DMA
> 
> Uniform CD-ROM driver Revision: 3.12
> 
> hdc: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)
> 
> [...]
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> hdb: DMA disabled
> 
> ide0: reset: success
> 

Your CDROM drive doesn't play well with your hard drive with 2.4 kernels.
2.4 enables UDMA (which 2.2 doesn't) for your hard drive transfers and CRC
errors show up.

When your network will be sorted out, I'd be interested by the result of the
following commands after the above errors and channel reset:

hdparm /dev/hda
hdparm -i /dev/hda
hdparm /dev/hdb
hdparm -i /dev/hdb

Then put your CDROM drive on the secondary channel with your DVD and see if the
error messages go away or focus on the DVDROM drive instead.

LB.
