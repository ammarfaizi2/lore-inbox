Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKXPZv>; Fri, 24 Nov 2000 10:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129145AbQKXPZm>; Fri, 24 Nov 2000 10:25:42 -0500
Received: from styx.suse.cz ([195.70.145.226]:35057 "EHLO kerberos.suse.cz")
        by vger.kernel.org with ESMTP id <S129091AbQKXPZ1>;
        Fri, 24 Nov 2000 10:25:27 -0500
Date: Fri, 24 Nov 2000 11:57:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kafu Nagai <nkafu@easynews.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent ide patches and DMA
Message-ID: <20001124115743.D1104@suse.cz>
In-Reply-To: <200011232109.NAA29837@mail11.bigmailbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011232109.NAA29837@mail11.bigmailbox.com>; from nkafu@easynews.com on Thu, Nov 23, 2000 at 01:09:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 01:09:35PM -0800, Kafu Nagai wrote:
> With recent ide patches, the ide driver seems to try to use DMA mode even for a drive which dosen't support it. CONFIG_IDEDMA_PCI_AUTO is enabled but even so with the stock kernel this dosen't happen. older patches didn't have this behavior either. Is this change intentional ?
> 
> hdc: 333630 sectors (171 MB) w/32KiB Cache, CHS=1011/15/22, DMA
> Partition check:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
>  hdc:hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x04 { DriveStatusError }
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x04 { DriveStatusError }
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x04 { DriveStatusError }
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x04 { DriveStatusError }
> hdc: DMA disabled
> ide1: reset: success
>  hdc1
> 
> ~ $ hdparm -i /dev/hdc
>  
> /dev/hdc:
>  
>  Model=QUANTUM ELS170A, FwRev=4.20, SerialNo=166304085456
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>5Mbs RotSpdTol>.5% }
>  RawCHS=1011/15/22, TrkSize=11264, SectSize=512, ECCbytes=4
>  BuffType=3(DualPortCache), BuffSize=32kB, MaxMultSect=8, MultSect=off
>  DblWordIO=no, OldPIO=2, DMA=no
>  CurCHS=1011/15/22, CurSects=333629, LBA=no                                         

Which chipset are you using?

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
