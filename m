Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130782AbRBNWQb>; Wed, 14 Feb 2001 17:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbRBNWQW>; Wed, 14 Feb 2001 17:16:22 -0500
Received: from think.faceprint.com ([166.90.149.11]:13843 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S130782AbRBNWQM>; Wed, 14 Feb 2001 17:16:12 -0500
Message-ID: <3A8B0388.70834CC2@faceprint.com>
Date: Wed, 14 Feb 2001 17:15:36 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-ac13 tulip problems
In-Reply-To: <E14TA9M-0006FE-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I just booted to 2.4.1-ac13, and was fine for a couple minutes.  Then
> > all network connectivity went away, and I had this sitting in syslog:
> > Hence, I'm back to 2.4.1-ac12, and sending this in.  No other noticible
> > problems in my short-lived uptime ;-)
> 
> I guess the pnic fixes have a side effect we didnt want. What kind of tulip
> do you have (lspci -v ?)

oops, i guess that would have been helpful, eh? ;-)  It's a Netgear
FA310TX.  Here's lspci output:

patience:~# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Flags: bus master, medium devsel, latency 0
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e0800000-e1dfffff
        Prefetchable memory behind bridge: e1f00000-e3ffffff
        Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Flags: bus master, stepping, medium devsel, latency 0

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 05)
        Subsystem: Creative Labs CT4760 SBLive!
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at a400 [size=32]
        Capabilities: [dc] Power Management version 1

00:09.1 Input device controller: Creative Labs SB Live! (rev 05)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at a000 [size=8]
        Capabilities: [dc] Power Management version 1

00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
        Subsystem: Netgear FA310TX
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at 9800 [size=256]
        Memory at e0000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:0d.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device 62a0
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 9
        BIST result: 00
        I/O ports at 9400 [size=256]
        Memory at df800000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 9000 [size=8]
        I/O ports at 8800 [size=4]
        I/O ports at 8400 [size=8]
        I/O ports at 8000 [size=4]
        I/O ports at 7800 [size=64]
        Memory at df000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 05) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head
32Mb
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at e2000000 (32-bit, prefetchable) [size=32M]
        Memory at e1000000 (32-bit, non-prefetchable) [size=16K]
        Memory at e0800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at e1ff0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0


Nathan
