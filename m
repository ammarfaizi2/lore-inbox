Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUJTObL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUJTObL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUJTO2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:28:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:24307 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S270383AbUJTOXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:23:40 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: James Stevenson <james@stev.org>
Subject: Re: ATA/133 Problems with multiple cards
Date: Wed, 20 Oct 2004 16:23:21 +0200
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <kernelnewbies@nl.linux.org>
References: <Pine.LNX.4.44.0410201211481.5805-100000@beast.stev.org>
In-Reply-To: <Pine.LNX.4.44.0410201211481.5805-100000@beast.stev.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410201623.21321.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 13:18, James Stevenson wrote:
>
> I had them all flashed to the latest current version which was
> 2.20.0.15 when i started having problems. Each card was verified to
> that version as well. Some did have older firmware on them.
>
> The same problems were seen before / after flashign the card. As
> far as i could tell the promise bios will run form the first card
> and init the other cards it could be configuring something there
> which nobody else is aware of. However this only showed drives /
> drive interfaces form the first 2 cards never the 3rd card. After
> the bios has init'ed the carss the bios doesnt run on any other
> cards.

Yes, this is true, but shouldn't harm. See below.

> When booting the machine will 3 cards and no drives attached the
> bios is loaded and unloaded 3 times. This is why i belave something
> is getting enable / disabled on the other cards by the bios.

Hmm, I'm running 3 TX2/100 (even with different revisions) without 
big problems here:

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)

<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>VP_IDE: IDE controller at PCI slot 00:07.1
<6>VP_IDE: chipset revision 6
<6>VP_IDE: not 100%% native mode: will probe irqs later
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
<6>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
<6>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
<6>PDC20268: IDE controller at PCI slot 00:09.0
<6>PDC20268: chipset revision 2
<6>PDC20268: not 100%% native mode: will probe irqs later
<6>PDC20268: ROM enabled at 0xdffe0000
<6>    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
<6>    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
<6>PDC20268: IDE controller at PCI slot 00:0a.0
<6>PDC20268: chipset revision 2
<6>PDC20268: not 100%% native mode: will probe irqs later
<6>PDC20268: ROM enabled at 0xdffd0000
<6>    ide4: BM-DMA at 0xb400-0xb407, BIOS settings: hdi:pio, hdj:pio
<6>    ide5: BM-DMA at 0xb408-0xb40f, BIOS settings: hdk:pio, hdl:pio
<6>PDC20268: IDE controller at PCI slot 00:0b.0
<6>PDC20268: chipset revision 1
<6>PDC20268: not 100%% native mode: will probe irqs later
<6>PDC20268: ROM enabled at 0xdffb0000
<6>    ide6: BM-DMA at 0xa000-0xa007, BIOS settings: hdm:pio, hdn:pio
<6>    ide7: BM-DMA at 0xa008-0xa00f, BIOS settings: hdo:pio, hdp:pio
<4>hda: MAXTOR 6L080J4, ATA DISK drive
<4>hdb: MAXTOR 6L080J4, ATA DISK drive
<4>blk: queue c046ad40, I/O limit 4095Mb (mask 0xffffffff)
<4>blk: queue c046aea4, I/O limit 4095Mb (mask 0xffffffff)
<4>hdc: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive
<4>hde: Maxtor 6Y120L0, ATA DISK drive
<4>blk: queue c046b688, I/O limit 4095Mb (mask 0xffffffff)
<4>hdg: Maxtor 6Y120L0, ATA DISK drive
<4>blk: queue c046bb2c, I/O limit 4095Mb (mask 0xffffffff)
<4>hdi: Maxtor 6Y120L0, ATA DISK drive
<4>blk: queue c046bfd0, I/O limit 4095Mb (mask 0xffffffff)
<4>hdk: Maxtor 6Y120L0, ATA DISK drive
<4>blk: queue c046c474, I/O limit 4095Mb (mask 0xffffffff)
<4>hdm: SAMSUNG SP0802N, ATA DISK drive
<4>blk: queue c046c918, I/O limit 4095Mb (mask 0xffffffff)
<4>hdo: MAXTOR 6L080J4, ATA DISK drive
<4>blk: queue c046cdbc, I/O limit 4095Mb (mask 0xffffffff)
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0xec00-0xec07,0xe802 on irq 17
<4>ide3 at 0xe400-0xe407,0xe002 on irq 17
<4>ide4 at 0xc400-0xc407,0xc002 on irq 18
<4>ide5 at 0xbc00-0xbc07,0xb802 on irq 18
<4>ide6 at 0xb000-0xb007,0xac02 on irq 19
<4>ide7 at 0xa800-0xa807,0xa402 on irq 19
<4>hda: attached ide-disk driver.
<4>hda: host protected area => 1
<6>hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, UDMA(33)
<4>hdb: attached ide-disk driver.
<4>hdb: host protected area => 1
<6>hdb: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, UDMA(33)
<4>hde: attached ide-disk driver.
<4>hde: host protected area => 1
<6>hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(100)
<4>hdg: attached ide-disk driver.
<4>hdg: host protected area => 1
<6>hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(100)
<4>hdi: attached ide-disk driver.
<4>hdi: host protected area => 1
<6>hdi: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(100)
<4>hdk: attached ide-disk driver.
<4>hdk: host protected area => 1
<6>hdk: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(100)
<4>hdm: attached ide-disk driver.
<4>hdm: host protected area => 1
<6>hdm: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=9733/255/63, UDMA(100)
<4>hdo: attached ide-disk driver.
<4>hdo: host protected area => 1
<6>hdo: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, UDMA(100)
<6>ide-floppy driver 0.99.newide
<6>Partition check:
<6> hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 >
<6> hdb: hdb1 hdb2
<6> hde: hde1 hde2 hde3 < hde5 hde6 hde7 hde8 hde9 >
<6> hdg: hdg1 hdg2 hdg3 < hdg5 hdg6 hdg7 hdg8 hdg9 >
<6> hdi: hdi1 hdi2 hdi3 < hdi5 hdi6 hdi7 hdi8 hdi9 >
<6> hdk: hdk1 hdk2 hdk3 < hdk5 hdk6 hdk7 hdk8 hdk9 >
<6> hdm:hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>blk: queue c046c918, I/O limit 4095Mb (mask 0xffffffff)
<4>PDC202XX: Primary channel reset.
<4>ide6: reset: success
<4> hdm1 hdm2
<6> hdo:hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>blk: queue c046cdbc, I/O limit 4095Mb (mask 0xffffffff)
<4>PDC202XX: Secondary channel reset.
<4>ide7: reset: success
<4> hdo1 hdo2

Besides these error messages, the drives seem to work fine, although 
as I investigated now, the dma modes look strange:

/dev/hdk:

 Model=Maxtor 6Y120L0, FwRev=YAR41VW0, SerialNo=Y41NTM7E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null): 

OK

/dev/hdm:

 Model=SAMSUNG SP0802N, FwRev=TK100-23, SerialNo=0709J1FW732061
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156368016
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 *udma3 udma4 udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: (null): 

Strange..

/dev/hdo:

 Model=MAXTOR 6L080J4, FwRev=A93.0500, SerialNo=664174010137
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156355584
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5 udma6 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1: 

Also strange..

These drives on the third controller are used only sporadic. 
The first 4 build a RAID5 array with hot spare and are used 
heavily (main server for diskless clients, mail, imap, samba, 
etc...) and the system sports 67 days uptime ATM :-).

Pete


