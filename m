Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRCVK1t>; Thu, 22 Mar 2001 05:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131963AbRCVK1k>; Thu, 22 Mar 2001 05:27:40 -0500
Received: from munk.apl.washington.edu ([128.95.96.184]:29958 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S131973AbRCVK1V>; Thu, 22 Mar 2001 05:27:21 -0500
Date: Thu, 22 Mar 2001 02:23:10 -0800 (PST)
From: Brian Dushaw <dushaw@munk.apl.washington.edu>
To: William Park <parkw@better.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA vt82c686b  and UDMA(100)
In-Reply-To: <20010322010507.A3170@better.net>
Message-ID: <Pine.LNX.4.30.0103220217480.3867-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No luck with either William's or Agus's suggestions.  Still 11 MB/s
transfer rate, dma enabled or not.  The motherboard is a newer IWILL.

dmesg outputs:
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD300BB-00AUA1, ATA DISK drive
hdc: Hewlett-Packard CD-Writer Plus 9100b, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: WDC WD300BB-00AUA1, 28629MB w/2048kB Cache, CHS=3649/255/63, UDMA(100)

hdparm -i /dev/hda outputs:
 Model=WDC WD300BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6R3063544
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=58633344
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 mode4 *mode5

hdparm -t /dev/hda outputs:
/dev/hda:
 Timing buffered disk reads:  64 MB in  5.66 seconds = 11.31 MB/sec

[sigh...]

I suppose it could be the Western Digital disk - I seem to recall that
linux has a difficult history with WD (a comment that may merely start
an unfounded rumour...)

B.D.

On Thu, 22 Mar 2001, William Park wrote:

> On Wed, Mar 21, 2001 at 08:40:21PM -0800, Brian Dushaw wrote:
> > Dear Linux Kernel Wisemen,
> >    I have been following the discussion of the VIA vt82c686b chipset
> > and the troubles people have had in getting UDMA(100) to work.  This
> > is to report that I have now tried the 2.4.2-ac20 kernel and the
> > 2.2.18 kernel with Andre's patch (dated March 20) and neither of
> > them get the disk speed up to where it ought to be.  hdparm -t reports
> > back 11 MB/s or so for either kernel.
> >    VIA82CXXX enabled, and I also tried the ide0=ata66 flag, in desparation.
> >    At boot up both kernels report the disk as UDMA(100) - everything
> > seems to be peachy keen, but for the sluggish disk performance.
> >
> > Merely a report from the front lines,
>
> Try 'hdparm -d1 -t', and see what you get.
>
> :wq --William Park, Open Geometry Consulting, Linux/Python, 8 CPUs.
>

-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Brian Dushaw
Applied Physics Laboratory
University of Washington
1013 N.E. 40th Street
Seattle, WA  98105-6698
(206) 685-4198   (206) 543-1300
(206) 543-6785 (fax)
dushaw@apl.washington.edu

Web Page:  http://staff.washington.edu/dushaw/index.html

