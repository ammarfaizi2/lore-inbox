Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131214AbRAXES5>; Tue, 23 Jan 2001 23:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132115AbRAXESs>; Tue, 23 Jan 2001 23:18:48 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:12624 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131214AbRAXESl>; Tue, 23 Jan 2001 23:18:41 -0500
Message-ID: <3A6E573D.5210644C@sgi.com>
Date: Tue, 23 Jan 2001 20:17:01 -0800
From: Linda Walsh <law@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Florin Andrei <florin@sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 disk speed 66% slowdown...
In-Reply-To: <Pine.LNX.4.10.10101231625290.11205-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mine was actually out of a stock 2.2.17 -- I tried your patch in an attempt
to fix a disk problem - but the disk was just going bad and the slow speeds were
coming from the automatic sector remapping.  

pardon my ignorance, but where do you get UDMA-100-66?

Here is the hdparm -i output on 2.4:

/dev/hda:
 
 Model=IBM-DARA-225000, FwRev=SHAOA54A, SerialNo=SQASQ202564
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=3(DualPortCache), BuffSize=418kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=49577472
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2 mode3 mode4
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4 

UDMA mode (2) seems to be identical to before.


Andre Hedrick wrote:
> 
> On Tue, 23 Jan 2001, Florin Andrei wrote:
> 
> > Linda Walsh wrote:
> > >
> > > The REAL problem was in disk performance.  The apm made no difference:
> >
> >       Same problem here. I had a huge HDD performance drop when upgrading
> > from 2.2.18 to 2.4.0
> >       It's an Intel i815 motherboard, and the HDD is Ultra-ATA.
> 
> ER, were you getting UDMA-100-66 out of 2.2.18 stock?
> Now what are you getting in 2.4.0?

-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
