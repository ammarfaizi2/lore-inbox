Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286234AbRLTNMz>; Thu, 20 Dec 2001 08:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286235AbRLTNMo>; Thu, 20 Dec 2001 08:12:44 -0500
Received: from ntmail.avint.net ([198.165.75.239]:36369 "EHLO NTMAIL.avint.net")
	by vger.kernel.org with ESMTP id <S286234AbRLTNMa>;
	Thu, 20 Dec 2001 08:12:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Brendan Pike <spike@superweb.ca>
Reply-To: spike@superweb.ca
Organization: Linux User
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Date: Thu, 20 Dec 2001 09:12:28 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01122009122800.27161@spikes>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well i really cant explain this,

[root@spikes spike]# /sbin/hdparm -t /dev/hda
/dev/hda:
Timing buffered disk reads:  64 MB in  6.65 seconds =  9.62 MB/sec

[root@spikes spike]# cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x47 IDE 0x6
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xe000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns      60ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s  33.0MB/s   3.3MB/s

[root@spikes spike]# /sbin/hdparm -i /dev/hda

/dev/hda:

 Model=FUJITSU MPG3409AT E, FwRev=82B9, SerialNo=VH06T1408HST
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80063424
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

[root@spikes spike]# /sbin/hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4983/255/63, sectors = 80063424, start = 0


Kernel 2.4.16 without patches.
