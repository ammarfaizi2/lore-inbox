Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130167AbQK3QM7>; Thu, 30 Nov 2000 11:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130188AbQK3QMu>; Thu, 30 Nov 2000 11:12:50 -0500
Received: from windsormachine.com ([206.48.122.28]:11275 "EHLO
        router.windsormachine.com") by vger.kernel.org with ESMTP
        id <S130167AbQK3QM3>; Thu, 30 Nov 2000 11:12:29 -0500
Message-ID: <3A267541.D1AED8E9@windsormachine.com>
Date: Thu, 30 Nov 2000 10:41:54 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gvlyakh@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA for triton again...
In-Reply-To: <E141VYN-000PiF-00@f11.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> computer: Chipset 430FX / Triton / PIIX, disk Western Digital Caviar AC21600H Firmware code F6 (no UDMA, some WD docs show DMA mw2, some PIO4...), kernel 2.2.17 with ide patch and PIIX enabled, DMA by default, generic DMA, and couple others. Did not try 'bad DMA-firmware (EXPERIMENTAL)'. dmesg (relevant - in my view - lines):
> BIOS DOES identify the hard disk and the CD-ROM correctly, although it is pretty old and no newer version is available.

Running a basically similar system here, DataExpert 8551, with a modified Award (was originally an ami) bios from http://exp8551.mypage.org.
Chipset is a 430FX, Same hard drive as what you have.  Pentium 133, 48 meg ram.  Kernel 2.2.17 with raid patch, and ide patch.  Shares the ide cable with a WDC 850 meg drive as slave.

monitor:~# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)

> hdparm -d1 returns:
>  /dev/hda:
>   setting using_dma to 1 (on)
>   HDIO_SET_DMA failed: Operation not permitted
>   using_dma    =  0 (off)
>

/dev/hda:

 Model=WDC AC21600H, FwRev=24.09P07, SerialNo=WD-WM3362938634
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=3148/16/63, TrkSize=57600, SectSize=600, ECCbytes=22
 BuffType=DualPortCache, BuffSize=128kB, MaxMultSect=16, MultSect=off
 CurCHS=3148/16/63, CurSects=3173184, LBA=yes, LBAsects=3173184
 IORDY=on/off, tPIO={min:160,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2

so my firmware is actually one version older than yours, and allows me to set DMA.  And has the associated speed increase/lower cpu

>   Model=DW CCA1206H0                            , FwRev=420.P980,
>  SerialNo=DWW-3M63

What brand is your motherboard?

Mike Dresser

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
