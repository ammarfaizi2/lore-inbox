Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266817AbSKOWIb>; Fri, 15 Nov 2002 17:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266818AbSKOWIa>; Fri, 15 Nov 2002 17:08:30 -0500
Received: from fantomas.webnet.pl ([195.205.113.35]:3456 "EHLO
	fantomas.webnet.pl") by vger.kernel.org with ESMTP
	id <S266817AbSKOWI3>; Fri, 15 Nov 2002 17:08:29 -0500
Message-ID: <3DD571F1.3010502@wfmh.org.pl>
Date: Fri, 15 Nov 2002 23:15:13 +0100
From: Miloslaw Smyk <thorgal@wfmh.org.pl>
Organization: W.F.M.H.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021109
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ian Chilton <ian@ichilton.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Anyone use HPT366 + UDMA in Linux?
References: <20021115123541.GA1889@buzz.ichilton.co.uk> <1037371184.19971.0.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1037371184.19971.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Alan Cox wrote:

> If it still doesnt work in 2.4.20-rc1-ac2 or later please send me a
> detailed bug report

All versions of hpt366.c newer than 0.18 (namely 0.22, 0.33 and 0.34) do not 
work on my setup, but hang during "partition check" on boot. I've tried 
changing UDMA mode in HPT BIOS, but it does not seem to affect anything and 
the drives are still recognized as "UDMA(100)". The latest kernel I tried 
was 2.4.20-rc-ac4, but it behaved just the same.

My setup is (all info gathered on 2.4.17 which is the last kernel version I 
can successfully boot with and which btw has been working flawlessly for a 
long time):

 From dmesg:

HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:DMA
     ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:DMA
hdf: IC35L040AVER07-0, ATA DISK drive
hdh: IC35L040AVER07-0, ATA DISK drive
hdf: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(44)
hdh: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(44)


fantomas:/home/thorgal# hdparm -i /dev/hdf

/dev/hdf:

  Model=IC35L040AVER07-0, FwRev=ER4OA44A, SerialNo=SX0SXM07352
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80418240
  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 *udma3 udma4 udma5
  AdvancedPM=yes: disabled (255) WriteCache=enabled
  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5

Drive /dev/hdh is identical sans SerialNo.


Please tell me what other info I can provide to help you.

Best regards,
Milek
-- 
mailto:thorgal@wfmh.org.pl    |  "Man in the Moon and other weird things" -
http://wfmh.org.pl/~thorgal/  |  see it at http://wfmh.org.pl/~thorgal/Moon/
        PLEASE UPDATE YOUR ADDRESSBOOK WITH MY NEW EMAIL ADDRESS.


