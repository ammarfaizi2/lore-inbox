Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBZUuI>; Mon, 26 Feb 2001 15:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBZUuA>; Mon, 26 Feb 2001 15:50:00 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:25062 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129104AbRBZUtu>; Mon, 26 Feb 2001 15:49:50 -0500
Message-Id: <5.0.2.1.2.20010226124747.02678da8@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 26 Feb 2001 12:47:56 -0800
To: linux-kernel@vger.kernel.org (Linux Kernel)
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Fwd: Re: timeout waiting for DMA
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Date: Mon, 26 Feb 2001 12:47:30 -0800
>To: Jason Rappleye <rappleye@cse.Buffalo.EDU>
>From: Jasmeet Sidhu <jsidhu@arraycomm.com>
>Subject: Re: timeout waiting for DMA
>
>I had the same exact problem last night using the IBM drives and the ULTRA 
>ata/100 controller from Promise.  Could this be due to an irq conflict?
>
>kernel: hda: timeout waiting for DMA
>kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>kernel: hdi: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>
>and after a few messages my system freazes and can only be brought up by a 
>hard reset.  Could this be due to faulty cables as well?  or is there 
>something else that is messing up?  I was suspecting an IRQ problem, maybe 
>USB is using the same irq (nothing on the USB ports though)... but I am 
>not certain.  Anybody else out there with similar problems?  Any Solutions?
>
>This was suing Kernel 2.4.2 with ac3 patch.  Is there a need to apply 
>Andre Hedrick's ide patches from kernel 2.4.1?
>
>Jasmeet
>
>
>At 03:41 PM 2/26/2001 -0500, you wrote:
>
>>Hi,
>>
>>I'm running kernel 2.4.2 on an SGI 1100 (dual PIIIs) with a Serverworks
>>III LE based motherboard. The disk is a Seagate ST330630A. The disk has
>>DMA enabled at boot time :
>>
>>hda: ST330630A, ATA DISK drive
>>hda: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=3720/255/63, UDMA(33)
>>
>>(also verified using hdparm)
>>
>>but after a while (eg partway through running bonnie with a 1GB file) I
>>get the following errors:
>>
>>Feb 24 22:51:02 nash2 kernel: hda: timeout waiting for DMA
>>Feb 24 22:51:02 nash2 kernel: ide_dmaproc: chipset supported ide_dma_timeout
>>func only: 14
>>Feb 24 22:51:02 nash2 kernel: hda: irq timeout: status=0x58 { DriveReady
>>SeekComplete DataRequest }
>><repeats a few times>
>>Feb 24 22:51:32 nash2 kernel: hda: DMA disabled
>>
>>I can reenable DMA without any problems, but after some additional disk
>>activity (eg running bonnie again), the error occurs again.
>>
>>Additional information on my hardware is given below. Any suggestions on
>>how this can be resolved?
>>
>>Thanks,
>>
>>Jason
>>
>>hdparm -i /dev/hda
>>
>>/dev/hda:
>>
>>  Model=ST330630A, FwRev=3.21, SerialNo=3CK0JDFE
>>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
>>  BuffType=0(?), BuffSize=2048kB, MaxMultSect=16, MultSect=off
>>  DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
>>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=59777640
>>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
>>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
>>  UDMA modes: mode0 mode1 *mode2 mode3 mode4
>>
>>Relevant portion of /proc/pci:
>>
>>   Bus  0, device  15, function  1:
>>     IDE interface: PCI device 1166:0211 (ServerWorks) (rev 0).
>>       Master Capable.  Latency=64.
>>       I/O at 0x3080 [0x308f].
>>
>>Relevant portion of lspci -v:
>>
>>00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a
>>[Master SecP PriP])
>>         Flags: bus master, medium devsel, latency 64
>>         I/O ports at 3080 [size=16]
>>
>>
>>--
>>Jason Rappleye
>>rappleye@buffalo.edu
>>http://www.ccr.buffalo.edu/jason.htm
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>- - -
>Jasmeet Sidhu
>Unix Systems Administrator
>ArrayComm, Inc.
>jsidhu@arraycomm.com
>www.arraycomm.com


- - -
Jasmeet Sidhu
Unix Systems Administrator
ArrayComm, Inc.
jsidhu@arraycomm.com
www.arraycomm.com


