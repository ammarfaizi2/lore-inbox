Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269804AbRH1APx>; Mon, 27 Aug 2001 20:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269831AbRH1APo>; Mon, 27 Aug 2001 20:15:44 -0400
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:24295
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S269804AbRH1AP3>; Mon, 27 Aug 2001 20:15:29 -0400
Date: Tue, 28 Aug 2001 12:15:39 +1200
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crashing with Abit KT7, 2.2.19+ide patches
Message-ID: <20010828121539.C28423@cone.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Tim Moore <timothymoore@bigfoot.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010827200106.A26175@cone.kiwa.co.nz> <3B8AD463.C196B9B6@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8AD463.C196B9B6@bigfoot.com>; from timothymoore@bigfoot.com on Mon, Aug 27, 2001 at 04:14:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 04:14:43PM -0700, Tim Moore wrote:
> > [nic@hoppa:~] dmesg | grep -i DMA
> > VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
> >     ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:DMA, hdd:pio
> > hda: ST320420A, 19458MB w/2048kB Cache, CHS=2480/255/63, UDMA(66)
> > hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
> > 
> > Aug 26 13:59:05 hoppa kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > Aug 26 13:59:05 hoppa kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 

I've discovered this comment by Andre Hedrick and another by Alan Cox:

http://marc.theaimsgroup.com/?l=linux-kernel&m=97528796025605&w=2

"This is what it tells you directly.  You have dirty crosstalk on your
ribbon.  Basically nothing is wrong, except you can not safely support
that transfer rate."

http://marc.theaimsgroup.com/?l=linux-kernel&m=99633759016613&w=2

"BadCRC is normally a cable error, but I'm suspicious that its also one
of the things caused by PCI bus problems on the VIA stuff"


The thing is though how can it be such a short step between a few CRC
errors and the IDE bus going into Autistic mode.



Nicholas


