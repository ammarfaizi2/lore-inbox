Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292701AbSBUS1U>; Thu, 21 Feb 2002 13:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292702AbSBUS1K>; Thu, 21 Feb 2002 13:27:10 -0500
Received: from smtp-1.llnl.gov ([128.115.250.81]:28059 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id <S292701AbSBUS0y>;
	Thu, 21 Feb 2002 13:26:54 -0500
Date: Thu, 21 Feb 2002 10:26:47 -0800 (PST)
From: "Tom Epperly" <tepperly@llnl.gov>
X-X-Sender: epperly@tux06.llnl.gov
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal
 instructions"
In-Reply-To: <E16dxoe-0007l6-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202211010270.19681-100000@tux06.llnl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Alan Cox wrote:

> Almost every other report I have ever seen that looked like that one has
> always turned out to be hardware related. The randomness in paticular
> tends to be a pointer to thinks like cache faults.

Is there any way to test this?
 
> You do have ECC main memory which is good.
> 
> What other hardware is in the machine ?

1. SCSI harddisk plugged into the motherboard
2. Floppy drive plugged into the motherboard
3. CD-ROM and a never used Zip disk drive plugged into IDE2 on the 
   motherboard
4. Sound Blaster live sound code plugged into a PCI slot.
5. nVidia Corp NV15 GL (Quadro2) plugged into the AGP slot.

No USB ports are in use. The video output, mouse and keyboard are plugged 
into a KVM switch.  There is also a CAT-5 cable attached to the network 
jack.  Otherwise, there are no other external connections outside of the 
power cable.

By running without the X11 server, I hoped to remove the nVidia board as a 
source of trouble.

$ /sbin/lspci
00:00.0 Host bridge: Intel Corporation 82850 860 (Wombat) Chipset Host Bridge (MCH) (rev 04)
00:01.0 PCI bridge: Intel Corporation 82850 850 (Tehama) Chipset AGP Bridge (rev 04)
00:02.0 PCI bridge: Intel Corporation 82860 860 (Wombat) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 04)
00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 04)
00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 04)
00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 04)
00:1f.5 Multimedia audio controller: Intel Corporation 82801BA(M) AC'97 Audio (rev 04)
01:00.0 VGA compatible controller: nVidia Corporation NV15 GL (Quadro2) (rev a4)
02:1f.0 PCI bridge: Intel Corporation 82806AA PCI64 Hub PCI Bridge (rev 03)
03:00.0 PIC: Intel Corporation 82806AA PCI64 Hub Advanced Programmable Interrupt Controller (rev 01)
03:0e.0 SCSI storage controller: Adaptec 7892P (rev 02)
04:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
04:0c.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
04:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
04:0d.1 Input device controller: Creative Labs SB Live! (rev 08)

Tom

--
------------------------------------------------------------------------
Tom Epperly
Center for Applied Scientific Computing   Phone: 925-424-3159
Lawrence Livermore National Laboratory      Fax: 925-424-2477
L-661, P.O. Box 808, Livermore, CA 94551  Email: tepperly@llnl.gov
------------------------------------------------------------------------

