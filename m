Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUJKSLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUJKSLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267504AbUJKSLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:11:53 -0400
Received: from web11206.mail.yahoo.com ([216.136.131.188]:15884 "HELO
	web11206.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269187AbUJKSKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:10:31 -0400
Message-ID: <20041011181027.58868.qmail@web11206.mail.yahoo.com>
Date: Mon, 11 Oct 2004 11:10:27 -0700 (PDT)
From: todd nguyen <toddnguyen@yahoo.com>
Subject: Re: Oops in loading cardbus bridge drivers in kernel version 2.6.9-rc1
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, majordomo@vger.kernel.org,
       toddnguyen@yahoo.com
In-Reply-To: <20041007101438.B10716@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,
  Here is the output for lspci -vv.  I hope someone
out there can give me advice.  Please let me know if
additional information I should post.  
Thanks in advance,

==================lspci -vv====================
00:00.0 Host bridge: Intel Corp. 82855PM Processor to
I/O Controller (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable)
[size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to
AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01,
sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset-
FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub
#1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at bf80 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub
#2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at bf40 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub
#3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at bf20 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev
01) (prog-if 20 [EHCI])
	Subsystem: Dell Computer Corporation: Unknown device
011d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at f4fffc00 (32-bit,
non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI
Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast
>TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02,
sec-latency=32
	I/O behind bridge: 0000d000-0000efff
	Memory behind bridge: f6000000-fbffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset-
FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface
Controller (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA
Storage Controller (rev 01) (prog-if 8a [Master SecP
PriP])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at bfa0 [size=16]
	Region 5: Memory at 40000000 (32-bit,
non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp.
82801DB AC'97 Audio Controller (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device
011d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at b800 [size=256]
	Region 1: I/O ports at bc40 [size=64]
	Region 2: Memory at f4fff800 (32-bit,
non-prefetchable) [size=512]
	Region 3: Memory at f4fff400 (32-bit,
non-prefetchable) [size=256]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies
Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 02)
(prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device
011d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop+ ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable)
[size=128M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at fcff0000 (32-bit,
non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 Ethernet controller: Broadcom Corporation
NetXtreme BCM5705M Gigabit Ethernet (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device
865d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at faff0000 (64-bit,
non-prefetchable) [size=64K]
	Capabilities: <available only to root>

02:01.0 CardBus bridge: O2 Micro, Inc.: Unknown device
7113 (rev 20)
	Subsystem: Dell Computer Corporation: Unknown device
011d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40001000 (32-bit,
non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06,
sec-latency=176
	Memory window 0: 40400000-407ff000 (prefetchable)
	Memory window 1: 40800000-40bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset-
16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:01.1 CardBus bridge: O2 Micro, Inc.: Unknown device
7113 (rev 20)
	Subsystem: Dell Computer Corporation: Unknown device
011d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40002000 (32-bit,
non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a,
sec-latency=176
	Memory window 0: 40c00000-40fff000 (prefetchable)
	Memory window 1: 41000000-413ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset-
16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


===============================================
--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Wed, Oct 06, 2004 at 03:56:45PM -0700, todd
> nguyen wrote:
> > " Unable to handle kernel NULL pointer dereference
> at
> > virtual address 00000008"  Can anyone give me some
> > pointer on why I'm seeing this error?
> 
> Something for the PCI people to look at I think... 
> However, you might
> consider including _full_ lspci -vv information
> rather than just a
> subset.
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   -
> http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      -
> http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core
> 



		

