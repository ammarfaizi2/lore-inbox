Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSKTDnT>; Tue, 19 Nov 2002 22:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSKTDnT>; Tue, 19 Nov 2002 22:43:19 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:30737 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S265637AbSKTDnS>;
	Tue, 19 Nov 2002 22:43:18 -0500
Message-ID: <3DDAF6FC.4060003@iinet.net.au>
Date: Wed, 20 Nov 2002 13:44:12 +1100
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE performance slowdown in 2.5
References: <3DDAF40B.9000002@iinet.net.au>
In-Reply-To: <3DDAF40B.9000002@iinet.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nero wrote:

> With 2.5.47, I get 22mb/s using hdparm -t /dev/hda, and close to 40mb/s
> when running 2.4.x
> Is this at all expected?
> Info from hdparm:
>
> [13:19:08] root@debian:/proc# hdparm -v /dev/hda
> /dev/hda:
>   multcount    =  0 (off)
>   IO_support   =  1 (32-bit)
>   unmaskirq    =  1 (on)
>   using_dma    =  1 (on)
>   keepsettings =  0 (off)
>   readonly     =  0 (off)
>   readahead    = 256 (on)
>   geometry     = 50765/16/63, sectors = 117231408, start = 0
>
>
> [13:18:51] root@debian:/proc# hdparm -i /dev/hda
> /dev/hda:
>
>   Model=ST360021A, FwRev=3.05, SerialNo=3HR01F5W
>   Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>   RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>   BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=off
>   CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=117231408
>   IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>   PIO modes:  pio0 pio1 pio2 pio3 pio4
>   DMA modes:  mdma0 mdma1 mdma2
>   UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>   AdvancedPM=no WriteCache=enabled
>   Drive conforms to: device does not report version:  1 2 3 4 5
>
> Info from dmesg:
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> VP_IDE: IDE controller at PCI slot 00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>      ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: C/H/S=28733/16/255 from BIOS ignored
> hda: ST360021A, ATA DISK drive
> hda: DMA disabled
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: RICOH CD-R/RW MP7163A, ATAPI CD/DVD-ROM drive
> hdd: CD-ROM 32X/AKU, ATAPI CD/DVD-ROM drive
> hdc: DMA disabled
> hdd: DMA disabled
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63,
> UDMA(100)
>   hda: hda1 < hda5 > hda2 hda3
> hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
>
>
> (Why does it say DMA disabled there [for hda], yet hdparm says its
> enabled? I checked that there is no init script changing settings on the
> drives.)

Forgot to mention, the filesystem is ReiserFS 3.

