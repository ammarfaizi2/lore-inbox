Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314139AbSDZTmb>; Fri, 26 Apr 2002 15:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314140AbSDZTma>; Fri, 26 Apr 2002 15:42:30 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:61714 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314139AbSDZTma>; Fri, 26 Apr 2002 15:42:30 -0400
Date: Fri, 26 Apr 2002 21:42:19 +0200
From: tomas szepe <kala@pinerecords.com>
To: linux-kernel@vger.kernel.org
Cc: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: 2.4.19-pre7-ac2: Promise Ultra100TX2 broken
Message-ID: <20020426214218.A27868@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a (up 4 days, 13:55)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the late 2.4.19-preX-acY the support for the Promise
> Ultra100TX2 is broken.

Apparently not for everyone. I'm using one such card with
a 20G Western Digital drive on 2.4.19-pre7-ac2 w/o any problems
apart from having to pass 'ide2=ata66' to get the driver to
allow me to use UDMA4/5 (yes, the drive *is* attached using
an 80-wire cable). The U100TX2's BIOS rev. is 2.20.0.11.

kala@liv:~$ uname -a
Linux liv 2.4.19-pre7-ac2-O1-2 #1 Tue Apr 23 19:16:09 CEST 2002 i686 unknown

kala@liv:~$ /sbin/lspci
00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:04.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:04.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:06.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d68 (rev 02)
00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0d.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45)

<snip> -- dmesg excerpt --
PDC20268: IDE controller on PCI bus 00 dev 30
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ATA-66/100 forced bit set (WARNING)!!
    ide2: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD205BA, ATA DISK drive
ide2 at 0xfcb8-0xfcbf,0xfcca on irq 9
hde: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
Partition check:
 hde: [PTBL] [2495/255/63] hde1 hde2 hde3 hde4
<snip> -- dmesg excerpt --

root@liv:~# hdparm -i /dev/hde

/dev/hde:

 Model=WDC WD205BA, FwRev=16.13M16, SerialNo=WD-WM9491625969
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=40088160
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4

Email me should you need my '.config'.

Seeya,
Tomas

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
