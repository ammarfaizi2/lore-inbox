Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRDSQ5X>; Thu, 19 Apr 2001 12:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRDSQ5N>; Thu, 19 Apr 2001 12:57:13 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:27804 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S131472AbRDSQ5B>;
	Thu, 19 Apr 2001 12:57:01 -0400
Date: Thu, 19 Apr 2001 09:56:54 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Nicholas Petreley <nicholas@petreley.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More ATA100 oddity
In-Reply-To: <20010419093609.A7170@petreley.com>
Message-ID: <Pine.LNX.4.33.0104190943570.9918-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

udma 5 is ata100 udma4 is 66 so it's seeing your disk fine...

as far as the 27MB/s goes, it actually testing the disk and that's
what it got for throughput... that's acutally a pretty good number, on the
diamondmax 80 I get 23MB/s

/dev/hde:

 Model=Maxtor 98196H8, FwRev=ZAH814Y0, SerialNo=V80H9YCC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

/dev/hde:
 Timing buffered disk reads:  64 MB in  2.77 seconds = 23.10 MB/sec

using promise ultra-100

On Thu, 19 Apr 2001, Nicholas Petreley wrote:

> I just noticed something odd. (I'm using 2.4.3-ac9 on an
> ASUS A7V, Athlon 1000 mHz)
>
>
> (1) As noted in other messages, my machine boots up the Promise
> chipset as UDMA(100)
>
>
> hde: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=79406/16/63, UDMA(100)
>
>
> (2) hdparm recognizes it as UDMA5 with 27 MB/sec speed
>
>
> /dev/hde:
>
>  Model=Maxtor 54098H8, FwRev=DAC10SC0, SerialNo=K80EP5NC Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16,MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes,LBAsects=80041248
>  IORDY=on/off, tPIO={min:120,w/IORDY:120},tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>  Timing buffered disk reads:  64 MB in  2.31 seconds = 27.71 MB/sec
>
>
>
> (3) /proc/ide/pdc202xx sees it as UDMA 4
>
>
>
>                                 PDC20265 Chipset.
> ------------------------------- General Status ---------------------------------
> Burst Mode                           : enabled
> Host Mode                            : Normal
> Bus Clocking                         : 33 PCI Internal
> IO pad select                        : 10 mA
> Status Polling Period                : 1
> Interrupt Check Status Polling Delay : 2
> --------------- Primary Channel ---------------- Secondary Channel -------------
>                 enabled                          enabled
> 66 Clocking     enabled                          disabled
>            Mode PCI                         Mode PCI
>                 FIFO Empty                       FIFO Empty
> --------------- drive0 --------- drive1 -------- drive0---------- drive1 ------
> DMA enabled:    yes              no              no             no
> DMA Mode:       UDMA 4           NOTSET          NOTSET         NOTSET
> PIO Mode:       PIO 4            NOTSET           NOTSET        NOTSET
>
>
>
> Oh, and by the way, ACPI support has never powered off this
> machine.  Ever.  But I use apm and I'm happy.
>
>
> -Nick
>
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


