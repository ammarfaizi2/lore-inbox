Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTKBKsa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 05:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTKBKsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 05:48:30 -0500
Received: from luli.rootdir.de ([213.133.108.222]:44267 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S261639AbTKBKs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 05:48:28 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.16 (Clear:SA:0(-8.2/5.0):. Processed in 1.067402 secs)
Date: Sun, 2 Nov 2003 11:48:18 +0100
From: Claas Langbehn <claas@rootdir.de>
To: linux-kernel@vger.kernel.org
Cc: jf1@IMERGE.co.uk, B.Zolnierkiewicz@elka.pw.edu.pl,
       James@superbug.demon.co.uk, Knut_Petersen@t-online.de
Subject: RE: VIA IDE performance under 2.6.0-test7/8? (and test9)
Message-ID: <20031102104818.GA1981@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Mi Nov  5 11:41:29 CET 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test9-mm1 i686
X-No-archive: yes
X-Uptime: 11:41:29 up  1:09,  4 users,  load average: 0.61, 0.20, 0.13
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


If I cat /proc/ide/via it shows that my harddisc is only
using 88,8 MB/s, but it is an U100-disc. hdparm show that
its using udma5, is this all correct, or should /proc/ide/via
show 99,9 MB/s ?


----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.38
South Bridge:                       VIA vt8235
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xdc00
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:      120ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          22ns     600ns      60ns     600ns
Transfer Rate:   88.8MB/s   3.3MB/s  33.3MB/s   3.3MB/s



# hdparm -i /dev/hda

/dev/hda:

 Model=ST3120023A, FwRev=3.33, SerialNo=3KA1ERGQ
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 

 * signifies the current active mode



Regards, claas
