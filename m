Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRANIcP>; Sun, 14 Jan 2001 03:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbRANIcF>; Sun, 14 Jan 2001 03:32:05 -0500
Received: from [64.160.188.242] ([64.160.188.242]:25099 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129867AbRANIb4>; Sun, 14 Jan 2001 03:31:56 -0500
Date: Sun, 14 Jan 2001 00:31:54 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Tony Parsons <mpsons@cix.compulink.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <memo.318705@cix.compulink.co.uk>
Message-ID: <Pine.LNX.4.21.0101140010470.17798-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   /dev/ide/host0/bus0/target0/lun0:hda: dma_intr: status=0x51 { 
> > DriveReady SeekComplete Error }   hda: dma_intr: error=0x84 { 
> > DriveStatusError BadCRC }   hda: dma_intr: status=0x51 { DriveReady 
> > SeekComplete Error }   hda: dma_intr: error=0x84 { DriveStatusError 
> > BadCRC }   hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
> ...
> >   00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 
> > 02)
> >   00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
> >   00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] 
> > (rev 22)
> >   00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] 
> > (rev 10)
> >   00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
> >   00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
> >   00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
> > ACPI] (rev 30)

Good! I'm not the only ome getting this error! Mine is also a VT82C686
though mine is a VT82C686A (352 BGA). This is on an MSI Model 694D Pro
motherboard running dual PIII-733 FC-PGA 133MHz Coppermines. RAM is 4
256MB PC133 unbuffered 7ns non mixed-cell DIMMs. I bring up the RAM and
CPU info because this board is also giving me random SIG11 errors even
though all equipment passes lab testing.

I was beginning to think the board was flaky until i saw this
posting.  Almost exactly matche smy errors. Also, since I'm using the
Promise PDC20265 (rev 2) ATA33/66 + 100 controller on the mobo, I wasn't sure
if my errors were stemming from that. The 2.4.0 kernel driver picks up
the controller fine and it's only under heavy I/O (aka dd if=/dev/hdc
of=/root/testdd.img bs=1024M count=2k ) that it REALLY goes nuts and
drops loses it's lunch all over the floor. Accessing a standard 48X CDROM 
in the same manner doesn't kill the kernel but I get quite a few
DriveReady errors like you got. I'm wondering if this is just a flaky
chipset or if this is a Promise controller issue. This is one reason i'm
extremely interested in what controller you have on your board, and if you
are using it. 

I also had to remove the USB support totally since it would stream errors
at me about usb devices not accepting new addresses. 
Funny thing is, I don't have any USB devices attached to the machine!
Thought address assignments were only when you attached devices.

Anyone else out there with troubles with either of these 3 items?

David D.W. Downey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
