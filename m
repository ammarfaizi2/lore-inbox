Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293038AbSB1J1q>; Thu, 28 Feb 2002 04:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSB1JZm>; Thu, 28 Feb 2002 04:25:42 -0500
Received: from unicef.org.yu ([194.247.200.148]:59915 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S293206AbSB1JYT>;
	Thu, 28 Feb 2002 04:24:19 -0500
Date: Thu, 28 Feb 2002 10:20:15 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lonely wolf <wolfy@pcnet.ro>, Mark Hahn <hahn@physics.mcmaster.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: disk transfer speed problem
In-Reply-To: <E16gDmU-0006PG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202281007410.14351-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Feb 2002, Alan Cox wrote:

> Date: Wed, 27 Feb 2002 23:46:42 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: lonely wolf <wolfy@pcnet.ro>
> Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
>
> > > >  Timing buffered disk reads:  64 MB in  3.24 seconds = 19.75 MB/sec
> > >
> > > well, 109 MB/s is pretty low for buffer-cache reads; this reflects
> > > the relative crippled-ness of your cpu/dram/chipset.
> >
> > well... i would't name a Celeron 900 MHz crippled. PC133 is the best the
> > board gets... and now the speed is lower then the previous server which was
> > an Athlon 600 pluggede in an Asus VIA KX133 based mobo.
>
> I get 25MB/sec off my i815 board. It is pretty starved - I seem stuck at
> about 25MB/sec total even doing hdparm across both controllers.
>
> Using an external video card might make a small difference
> -
on kernel 2.2.20 with andre ata100 patches ported from 2.2.19 to 2.2.20
on asus i815 board.
Kernel 2.4.17 results are similar about 35MB/sec

I got this results, machine is under small workload.

root@MEGANET:~# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.96 seconds =133.33 MB/sec
 Timing buffered disk reads:  64 MB in  1.73 seconds = 36.99 MB/sec

root@MEGANET:~# hdparm -i /dev/hda

/dev/hda:

 Model=MAXTOR 6L040J2, FwRev=A93.0500, SerialNo=662131534628
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78177792
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3
ATA-4
ATA-5

root@MEGANET:~# hdparm -v /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4866/255/63, sectors = 78177792, start = 0

other details:

Intel machine check reporting enabled on CPU#0.
128K L2 cache (4 way)
CPU: L2 Cache: 128K
CPU: Intel Pentium III (Coppermine) stepping 0a
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf0e30
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i815 chipset
agpgart: AGP aperture is 32M @ 0xfc000000

Zoran


