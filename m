Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129475AbQLATcQ>; Fri, 1 Dec 2000 14:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQLATcH>; Fri, 1 Dec 2000 14:32:07 -0500
Received: from windsormachine.com ([206.48.122.28]:54795 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129475AbQLATbu>; Fri, 1 Dec 2000 14:31:50 -0500
Message-ID: <3A27F570.D0FCB2E@windsormachine.com>
Date: Fri, 01 Dec 2000 14:01:04 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesus Cea Avion <jcea@argo.es>
CC: linux-kernel@vger.kernel.org, l-linux@calvo.teleco.ulpgc.es
Subject: Re: AX64 too (was: Re: Dma problems - Aopen Ax34pro VIA chipset seagate 
 drive)
In-Reply-To: <3A1A354D.3927.5A09E7EB@localhost> <3A27EE7A.549543D5@argo.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a motherboard with the same Via686a chipset, and i've never had a
problem with DMA when it's enabled.
Using a pair of 20 gig IBM drives on the secondary, and a 3.2 quantum primary,
17.2 gig maxtor.  All using DMA, all work.  Using ultra/33, I wasn't even
aware this chipset is ultra/66 capable, until last night.  Going to acquire an
ultra/66 cable, and test udma/66 mode tonight.  And find out what bios setting
makes the thing not _allow_ dma at all.

System used to be flaky with networking, did some memory timing adjustments,
seems to be ok now.
Celeron 300@450, 32 meg sdram.

/dev/hdc:

Model=IBM-DJNA-352030, FwRev=J58OA30K, SerialNo=GQ0GQF07566
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=1966kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39876480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  1.48 seconds = 86.49 MB/sec
 Timing buffered disk reads:  64 MB in  4.33 seconds = 14.78 MB/sec

Not too bad for an old 20 gig. Same speeds whether i have -c3 -u1 or not.

Turn DMA off, it gets slow though

/dev/hdc:
Timing buffer-cache reads:   128 MB in  1.50 seconds = 85.33 MB/sec
 Timing buffered disk reads:  64 MB in 14.90 seconds =  4.30 MB/sec

Jesus Cea Avion wrote:

> Please, if you respond, send me a copy to my mailbox, too.
>
> > Status: kernel 2.4.0-test10 (no patches added)
> > Problem: getting dma problems - having to run system with no dma
> > for disc access - seems to be a bus mastering problem.
> > Hardware: Aopen AX34Pro mother board, Via chipset with via686a,
> > Seagate Baracuda ATA66 20GB disc - Latest Bios for motherboard
> > Sony CDU4811 cdrom
>
> I have a comparable problem with an Aopen AX64 motherboard. Chipset
> via686a.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
