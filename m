Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271402AbTG2Lu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271407AbTG2Lu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:50:58 -0400
Received: from luli.rootdir.de ([213.133.108.222]:31445 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S271402AbTG2Lux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:50:53 -0400
Date: Tue, 29 Jul 2003 13:50:36 +0200
From: Claas Langbehn <claas@rootdir.de>
To: linux-kernel@vger.kernel.org
Subject: VIA_IDE vt8235 is not using full speed
Message-ID: <20030729115036.GA1546@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Fre Aug  1 13:43:15 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test1-ac3 i686
X-No-archive: yes
X-Uptime: 13:43:15 up  3:53,  8 users,  load average: 0.15, 0.17, 0.12
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


i am wondering, why my Seagate ST3120023A is not using UDMA100
as it should. The system bios displayed UDMA100, but /proc/ide/via
says 88MB/s. I have got an 80pin UDMA-133 cable to the harddisk.


Bye, claas

--

# dmesg 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
  ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
  ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
hda: ST3120023A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-12101B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1 p2
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12


$ cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.37
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
Transfer Mode:       UDMA       PIO       DMA       PIO
Address Setup:      120ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          22ns     600ns     120ns     600ns
Transfer Rate:   88.8MB/s   3.3MB/s  16.6MB/s   3.3MB/s

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
	Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6
	   
