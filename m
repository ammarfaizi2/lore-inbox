Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282597AbRLVVfj>; Sat, 22 Dec 2001 16:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282664AbRLVVf3>; Sat, 22 Dec 2001 16:35:29 -0500
Received: from monster.gotadsl.co.uk ([213.208.127.236]:51330 "EHLO
	monster.gotadsl.co.uk") by vger.kernel.org with ESMTP
	id <S282597AbRLVVfT>; Sat, 22 Dec 2001 16:35:19 -0500
Subject: Re: IDE Harddrive Performance
From: Craig Knox <crg@monster.gotadsl.co.uk>
To: Jim Radford <radford@blackbean.org>
Cc: Adam Keys <akeys@post.cis.smu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20011222182043.GA4474@blackbean.org>
In-Reply-To: <20011222182043.GA4474@blackbean.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Dec 2001 21:36:17 +0000
Message-Id: <1009056978.1163.2.camel@crgs.lowerrd.prv>
Mime-Version: 1.0
X-Scanner: exiscan *16HtnO-00032o-00*3mkwuMDLuvw* (monster.gotadsl.co.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-22 at 18:20, Jim Radford wrote:
> > hda: Maxtor 93073U6, ATA DISK drive
> > hdc: Maxtor 90840D6, ATA DISK drive
>  
> > /dev/hda:
> >  Timing buffered disk reads:  64 MB in 86.98 seconds =753.46 kB/sec
> > /dev/hdc:
> >  Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec
> 
> I'm in the same boat with my Maxtor 54098U8.  It has been getting
> /dev/hda:
>  Timing buffered disk reads:  64 MB in 115.29 seconds =568.44 kB/sec
> Same results with 2.4.9 - 2.4.17.
> VP_IDE: VIA vt82c686a (rev 14) IDE UDMA66 controller on pci00:07.1
> 
> # hdparm /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 4865/255/63, sectors = 78165360, start = 0
>  busstate     =  1 (on)

Haven't had any trouble 2.4.x - 2.4.17 using the same model drive.
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER 
hde: Maxtor 54098U8, ATA DISK drive
hdg: Maxtor 54098U8, ATA DISK drive

with 2.4.17 I get ~28.96MB/sec with hdparm -t /dev/hdx

# hdparm /dev/hde
multicount	= 16 (on)
I/O support	=  3 (32bit w/sync)
unmaskirq	=  0 (off)
using_dma	=  1 (on)
keepsettings	=  0 (off)
nowerr		=  0 (off)
readonly	=  0 (off)
readahead	=  8 (on)
geometry	= 4111/255/63, sectors = 66055248, start = 0


