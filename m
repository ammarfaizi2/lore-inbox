Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285345AbRLSQFv>; Wed, 19 Dec 2001 11:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbRLSQFl>; Wed, 19 Dec 2001 11:05:41 -0500
Received: from bigspace.hitnet.RWTH-Aachen.DE ([137.226.181.2]:15144 "EHLO
	bigspace.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S285345AbRLSQFe>; Wed, 19 Dec 2001 11:05:34 -0500
Date: Wed, 19 Dec 2001 17:05:29 +0100
From: Thomas Deselaers <thomas@deselaers.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Message-ID: <20011219160529.GA3930@leukertje.hitnet.rwth-aachen.de>
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de> <20011219155538.BF29F3B92@dnph.phys.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011219155538.BF29F3B92@dnph.phys.msu.su>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 06:55:38PM +0300, Oleg Artamonov wrote:
> Thomas Deselaers ???????:
> > /dev/hdc:
> >  Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec
> >
> > What would be a value I can expect from my hardware?
> 
>   I have a Maxtor D541X (20Gbytes, 5400rpm), and its results are about 
> 37MB/sec... Motherboard is Epox 8KTA3 with VIA 686B southbridge (HDD runs in 
> UDMA5 mode).
> 
> > And what might result in higher speeds?
> 
>   Did you enable UltraDMA2 (P2B-S supports only UDMA2, not UDMA4 nor UDMA5)? 
> 32-bit transfer? What 'hdparm /dev/hda' and 'hdpram -i /dev/hda' says?

Here are the results, and maybe I should have told, that I am using 2.4.16
without any further patches applied. 

It seems that I have udma2 enabled.

leukertje:/home/thomasd# hdparm /dev/hdc

/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 7297/255/63, sectors = 117231408, start = 0
 busstate     =  1 (on)
leukertje:/home/thomasd# hdparm -i /dev/hdc

/dev/hdc:

 Model=MAXTOR 4K060H3, FwRev=A08.1500, SerialNo=373120024159
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2000kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=117231408
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
 AdvancedPM=no WriteCache=enabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 ATA-4
ATA-5 


thomas

-- 
thomas@deselaers.de «<>» JabberID on request «<>» GPG/PGP key on request
  «< Unless stated otherwise everything I write is just my opinion >»
