Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311762AbSCNUjA>; Thu, 14 Mar 2002 15:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311763AbSCNUiq>; Thu, 14 Mar 2002 15:38:46 -0500
Received: from mug.sys.Virginia.EDU ([128.143.6.251]:41221 "EHLO
	mug.sys.virginia.edu") by vger.kernel.org with ESMTP
	id <S311762AbSCNUig>; Thu, 14 Mar 2002 15:38:36 -0500
Date: Thu, 14 Mar 2002 20:38:36 -0500 (EST)
From: David Forrest <drf5n@mug.sys.virginia.edu>
To: <linux-kernel@vger.kernel.org>
Subject: K7S5A SIS735 ext2fs corruption
Message-ID: <Pine.LNX.4.33.0203142014160.7770-100000@mug.sys.virginia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this has been on the list before, but I wanted to whine a bit, and
collect what I've seen because I havent seen it resolved

lkml: 2001-12-30 UMOUNTING in 2.4.17 / Ext2 Partitions destroyed (3x)
lkml: 2001-10-25 Repeatable File Corruption (ECS K7S5A w/SIS735)

http://www.geocities.com/mrathlon2000/   and
http://pub65.ezboard.com/fk7s5amotherboardforumfrm10.showMessage?topicID=2.topic
suggests a couple hardware fixes, and blames corruptions on high speeds
and a bad resistor choice.

My ECS k7s5a with the SIS735 Athalon 1.4 chipset has corrupted a couple of
my disks

I was using 2.4.17, and the dma modes kicked in automatically.  I thought
I had it managed with the boot parameter of 'ide=nodma', since that
eliminatated errors like
status=0x51 { DriveReady SeekComplete Error }
error=0x84 { BadCRC DriveStatusError }

These were with the drives in the hdparm output below.

I don't have this board up and running right now, but could throw some old
stuff into it and see how it goes.

Dave,
-- 
 Dave Forrest                                   drf5n@virginia.edu
 (434)296-7283h 924-3954w      http://mug.sys.virginia.edu/~drf5n/


{root@mug:~}# /usr/sbin/hdparm -i /dev/hd[ad]

/dev/hda:

 Model=IBM-DHEA-38451, FwRev=HP8OA20C, SerialNo=SH0SH0S4378
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=28
 BuffType=DualPortCache, BuffSize=472kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=16514064
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : ATA-3 X3T10 2008D revision 1 : ATA-1 ATA-2 ATA-3


/dev/hdd:

 Model=WDC WD205BA, FwRev=16.13M16, SerialNo=WD-WM9490019722
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq
}
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=40088160
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4



