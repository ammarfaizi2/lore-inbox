Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130230AbQKXXjW>; Fri, 24 Nov 2000 18:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130392AbQKXXjM>; Fri, 24 Nov 2000 18:39:12 -0500
Received: from mail6.bigmailbox.com ([209.132.220.37]:24081 "EHLO
        mail6.bigmailbox.com") by vger.kernel.org with ESMTP
        id <S130230AbQKXXjB>; Fri, 24 Nov 2000 18:39:01 -0500
Date: Fri, 24 Nov 2000 15:08:34 -0800
Message-Id: <200011242308.PAA30772@mail6.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [193.250.237.8]
From: "Kafu Nagai" <nkafu@easynews.com>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent ide patches and DMA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


440BX with PIIX4 on BP6


>On Thu, Nov 23, 2000 at 01:09:35PM -0800, Kafu Nagai wrote:
>> With recent ide patches, the ide driver seems to try to use DMA mode even for a drive which dosen't support it. CONFIG_IDEDMA_PCI_AUTO is enabled but even so with the stock kernel this dosen't happen. older patches didn't have this behavior either. Is this change intentional ?
>> 
>> hdc: 333630 sectors (171 MB) w/32KiB Cache, CHS=1011/15/22, DMA
>> Partition check:
>>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
>>  hdc:hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hdc: dma_intr: error=0x04 { DriveStatusError }
>> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hdc: dma_intr: error=0x04 { DriveStatusError }
>> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hdc: dma_intr: error=0x04 { DriveStatusError }
>> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hdc: dma_intr: error=0x04 { DriveStatusError }
>> hdc: DMA disabled
>> ide1: reset: success
>>  hdc1
>> 
>> ~ $ hdparm -i /dev/hdc
>>  
>> /dev/hdc:
>>  
>>  Model=QUANTUM ELS170A, FwRev=4.20, SerialNo=166304085456
>>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>5Mbs RotSpdTol>.5% }
>>  RawCHS=1011/15/22, TrkSize=11264, SectSize=512, ECCbytes=4
>>  BuffType=3(DualPortCache), BuffSize=32kB, MaxMultSect=8, MultSect=off
>>  DblWordIO=no, OldPIO=2, DMA=no
>>  CurCHS=1011/15/22, CurSects=333629, LBA=no                                         
>
>Which chipset are you using?
>
>-- 
>Vojtech Pavlik
>SuSE Labs


------------------------------------------------------------
Free Web space and web based email @EASYNEWS.COM


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
