Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbULVIkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbULVIkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbULVIkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:40:45 -0500
Received: from webmail1.spymac.net ([195.225.149.201]:31660 "EHLO
	webmail1.spymac.net") by vger.kernel.org with ESMTP id S261898AbULVIkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:40:23 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: binary
Mime-Version: 1.0
From: surya <surya_prabhakar@spymac.com>
To: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Subject: Re: DVD-RW writes but doesn't read
Reply-To: surya_prabhakar@spymac.com
X-Mailer: AtMail 4.02
X-Origin: 82.3.32.74
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
X-Uidl: 110370481982764011
Date: Wed, 22 Dec 2004 01:40:19 -0700
Message-Id: <20041222084022.4CD2B4C079@webmail1.spymac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even I had the same problem - It wasnt reading the written dvd-r/rw .But then
Once I tried closing the session after a burn(not closing disk) .
Then it started to show up the files .This is on 2.6.9 . But now the dvd drive
stopped reading cd's anymore ;-(

-surya


Norbert van Nobelen wrote:

>Did you try one of the disks you have written with it in another dvdplayer 
>yet?
>
>If the written dvds really work, then it is clearly a miracle (-:. The first 
>thing the drive does, is a read action to see if it has an empty disc or 
>something like multisession. If the drive reading is so terrible, that action 
>should fail most of the time too.
>
>
>On Wednesday 22 December 2004 00:33, you wrote:
>
>>Hi Jens et al
>>
>>I have a laptop DVD-RW that is working fine when burning but has endless
>>streams of errors with any kernel I try when trying to read anything
>>(cd/dvd audio/video/data).
>>
>>hdc: command error: status=0x51 { DriveReady SeekComplete Error }
>>hdc: command error: error=0x50
>>ide: failed opcode was 100
>>end_request: I/O error, dev hdc, sector 571832
>>Buffer I/O error on device hdc, logical block 71479
>>
>>If I'm persistent I can read the data off the drive but I'll probably
>>kill the drive in the process. It doesn't matter what iosched I use but I
>>use cfq by default. I've tried disabling dma and so on without success. Any
>>ideas?
>>
>>Con
>>
>>
>>Here is some relevant data
>>
>>lspci -vvv
>>
>>00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
>>Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
>>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>Stepping- SERR- FastB2B-
>>        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>><TAbort- <MAbort- >SERR- <PERR-
>>        Latency: 0
>>        Interrupt: pin A routed to IRQ 10
>>        Region 0: I/O ports at <unassigned>
>>        Region 1: I/O ports at <unassigned>
>>        Region 2: I/O ports at <unassigned>
>>        Region 3: I/O ports at <unassigned>
>>        Region 4: I/O ports at 1100 [size=16]
>>        Region 5: Memory at 3e000000 (32-bit, non-prefetchable) [size=1K]
>>
>>
>>hdparm -i /dev/hdc
>>
>>/dev/hdc:
>>
>> Model=MATSHITADVD-RAM UJ-820S, FwRev=1.00, SerialNo=
>> Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>> RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>> BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>> (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>> IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>> PIO modes:  pio0 pio1 pio2 pio3 pio4
>> DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
>> UDMA modes: udma0 udma1 *udma2
>> AdvancedPM=no
>> Drive conforms to: device does not report version:
>>
>> * signifies the current active mode
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>





