Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130824AbRCMLMA>; Tue, 13 Mar 2001 06:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130829AbRCMLLv>; Tue, 13 Mar 2001 06:11:51 -0500
Received: from [24.93.35.226] ([24.93.35.226]:32274 "EHLO mail.houston.rr.com")
	by vger.kernel.org with ESMTP id <S130824AbRCMLLk>;
	Tue, 13 Mar 2001 06:11:40 -0500
X-Envelope-Sender: vojtech@suse.cz
Date: Tue, 17 Oct 2000 19:50:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Francesc Oller <francesc@mat.upc.es>
Cc: debian-user@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: problems with udma66
Message-ID: <20001017195014.A5038@suse.cz>
In-Reply-To: <39EC2474.32D7@mat.upc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <39EC2474.32D7@mat.upc.es>; from Francesc Oller on Tue, Oct 17, 2000 at 12:05:40PM +0200
X-Mailing-List: <debian-user@lists.debian.org> archive/latest/113061
X-Loop: debian-user@lists.debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

No chance getting this to work on 2.2 now, try 2.4.0, it should work.
I hope to fix 2.2 later ...

Vojtech

On Tue, Oct 17, 2000 at 12:05:40PM +0200, Francesc Oller wrote:
> Hi all,
> 
> I'm trying to use UDMA66 in my computer but haven't suceeded
> until now.
> 
> Configuration:
> 
> Epox EP-MVP3G2 with VIA MVP3 AGPset, K6-3D 450Mhz
> hda: Seagate ST313021A, ATA66 capable. hdparm -iI /dev/hda says:
> 
> /dev/hda:
> 
>  Model=ST313021A, FwRev=3.03, SerialNo=3CT0A95K
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=0(?), BuffSize=512kB, MaxMultSect=32, MultSect=off
>  DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=25434228
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
>  UDMA modes: mode0 mode1 mode2 mode3 *mode4
> 
> 
>  Model=TS130312 A, FwRev=.330, SerialNo=C30T9AK5
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=0(?), BuffSize=512kB, MaxMultSect=32, MultSect=?32?
>  DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=25434228
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
>  UDMA modes: mode0 mode1 mode2 mode3 *mode4
> 
> I use Debian GNU/Linux 2.2, kernel 2.2.17-ide with Andre Hedrick's IDE
> patches applied.
> 
> kernel at boot time says:
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.30
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: not 100% native mode: will probe irqs later
> VT 82C597 Apollo VP3
>  Chipset Core ATA-33
> Split FIFO Configuration:  8 Primary buffers, threshold = 1/2
>                            8 Second. buffers, threshold = 1/2
>     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
> ide0: VIA Bus-Master (U)DMA Timing Config Success
>     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
> ide1: VIA Bus-Master (U)DMA Timing Config Success
> hda: ST313021A, ATA DISK drive
> hdb: ST1144AT, ATA DISK drive
> hdc: CD-ROM 48X/AKU, ATAPI CDROM drive
> hdd: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: ST313021A, 12419MB w/512kB Cache, CHS=1583/255/63
> hdb: ST1144AT, 124MB w/16kB Cache, CHS=1001/15/17
> hdc: ATAPI 48X CD-ROM drive, 128kB Cache
> 
> In this preconfigured kernel CONFIG_IDEDMA_AUTO is disabled so
> DMA is disabled at boot time.
> 
> I've a secondary HD which is an old IDE drive. hdparm -iI /dev/hdb says:
> 
> /dev/hdb:
> 
>  Model=ST1144AT, FwRev=rev 5.50, SerialNo=00KA8945150000000000
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>5Mbs RotSpdTol>.5% }
>  RawCHS=1001/15/17, TrkSize=9792, SectSize=576, ECCbytes=7
>  BuffType=3(DualPortCache), BuffSize=16kB, MaxMultSect=0
>  DblWordIO=yes, OldPIO=0, DMA=yes, OldDMA=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
> 
> 
>  Model=TS1144TA, FwRev=er v.505, SerialNo=00AK9854510000000000
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>5Mbs RotSpdTol>.5% }
>  RawCHS=1001/15/17, TrkSize=9792, SectSize=576, ECCbytes=7
>  BuffType=3(DualPortCache), BuffSize=16kB, MaxMultSect=0
>  DblWordIO=yes, OldPIO=0, DMA=yes, OldDMA=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
> 
> Questions:
> 
> 1.- If I execute hdparm -d1 -X34 (DMA mode 2), the kernel starts
> panicking
> and halts. Why? (after that, I haven't even tried -X68 (UDMA66))
> 
> 2.- How come the kernel recognizes 'VT 82C597 Apollo VP3' instead of the
> more
> logical 'VT 82C598 Apollo MVP3'?
> 
> 3.- I guess that since beginning with kernel 2.2, CONFIG_IDEDMA_AUTO is
> disabled by default, there must be some faulty HD/IDE controller combos
> out there when working in U/DMA mode. Whose fault is it? ST313021A works
> perfectly in UDMA33 with ALI15X3 chipset.
> 
> 4.- Would you recommend to put the old IDE drive as slave? does it slow
> down the access to the ATA66 one?
> 
> Please, CC to my e-adress.
> 
> cheers
> 
> Francesc Oller
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs


-- 
Unsubscribe?  mail -s unsubscribe debian-user-request@lists.debian.org < /dev/null
