Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbULUXjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbULUXjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbULUXjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:39:19 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:6279 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261900AbULUXjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:39:09 -0500
Message-ID: <cone.1103672037.983890.28853.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: DVD-RW writes but doesn't read
Date: Wed, 22 Dec 2004 10:33:57 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens et al

I have a laptop DVD-RW that is working fine when burning but has endless 
streams of errors with any kernel I try when trying to read anything (cd/dvd 
audio/video/data).

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
ide: failed opcode was 100
end_request: I/O error, dev hdc, sector 571832
Buffer I/O error on device hdc, logical block 71479

If I'm persistent I can read the data off the drive but I'll probably 
kill the drive in the process. It doesn't matter what iosched I use but I 
use cfq by default. I've tried disabling dma and so on without success. Any 
ideas?

Con


Here is some relevant data

lspci -vvv

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA 
Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1100 [size=16]
        Region 5: Memory at 3e000000 (32-bit, non-prefetchable) [size=1K]


hdparm -i /dev/hdc

/dev/hdc:

 Model=MATSHITADVD-RAM UJ-820S, FwRev=1.00, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no
 Drive conforms to: device does not report version:

 * signifies the current active mode


