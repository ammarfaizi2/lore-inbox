Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286719AbRLVIWO>; Sat, 22 Dec 2001 03:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286721AbRLVIWH>; Sat, 22 Dec 2001 03:22:07 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:22257 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S286719AbRLVIVw>; Sat, 22 Dec 2001 03:21:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: Thomas Deselaers <thomas@deselaers.de>
Subject: Re: IDE Harddrive Performance
Date: Sat, 22 Dec 2001 02:21:59 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de>
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011222082147.CCTE6450.rwcrmhc52.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 19, 2001 09:32, Thomas Deselaers wrote:
> I do have an Asus P2B-S Mainboard and since a week I have a Maxtor 60 GB
> 5400 rpm Harddrive (MAXTOR 4K060H3).

I am experiencing extremely shoddy performance with a similar disk/chipset 
combination.  I am on an Asus P2B-DS board (440BX) with the following disk 
setup.

hda: Maxtor 93073U6, ATA DISK drive
hdc: Maxtor 90840D6, ATA DISK drive
hdd: Maxtor 90840D6, ATA DISK drive

I am barely experiencing the same performance you are, after enabling all the 
stuff that's been discussed in this thread.    I'd like to determine if this 
disk is dying or if there is something seriously wrong with my kernel.  I did 
not seem to experience anything until I went to 2.4.16.  hdd seems to be 
headed for the heap, as all tests on it fail.  I am stumped; I've read the 
manual and the threads and still haven't extracted proper performance.  All 
help is appreciated.

Thanks,
AKK

Following is the information on the other disks and the hdparm test results:

# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in 86.98 seconds =753.46 kB/sec

# hdparm /dev/hda ; hdparm -i /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3736/255/63, sectors = 60030432, start = 0
 busstate     =  1 (on)

/dev/hda:

 Model=Maxtor 93073U6, FwRev=FA500S60, SerialNo=G607E80C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60030432
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4 
ATA-5


/dev/hdc:
 Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec

/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1021/255/63, sectors = 16406208, start = 0
 busstate     =  1 (on)

/dev/hdc:

 Model=Maxtor 90840D6, FwRev=WAS82739, SerialNo=K606M2WA
 Config={ Fixed }
 RawCHS=16276/16/63, TrkSize=0, SectSize=0, ECCbytes=29
 BuffType=DualPortCache, BuffSize=256kB, MaxMultSect=16, MultSect=16
 CurCHS=16276/16/63, CurSects=16406208, LBA=yes, LBAsects=16406208
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no WriteCache=enabled
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4
-- 
akk~

