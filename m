Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287293AbSAZXMP>; Sat, 26 Jan 2002 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287306AbSAZXMG>; Sat, 26 Jan 2002 18:12:06 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:28401 "EHLO fep8.cogeco.net")
	by vger.kernel.org with ESMTP id <S287293AbSAZXMA>;
	Sat, 26 Jan 2002 18:12:00 -0500
Subject: VIA KT266 and SBLive! (emu10k1)
From: "Nix N. Nix" <nix@go-nix.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.14.17.03 (Preview Release)
Date: 26 Jan 2002 18:11:53 -0500
Message-Id: <1012086718.11336.91.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I understand (not well enough, perhaps) that there are some known
problems with a combination of Via chipset and SBLive!.  Indeed, I have
experienced these myself, in that sometimes, when a sound is about to
play (as when I roll up my GNOME panel), the speakers first emit a burst
of noise (sounds like a can of pop opening) before playing the sound.

On viaarena.com I read about worse problems when running Windows, but
the fact remains that the problems exist.  I was able to reduce the
problem somewhat by following someone's (from Via Arena) recommendation,
namely to move the DBLive! card to PCI slot 3.  The reason behind the
move, accordig to the group is to obtain a unique IRQ for the card. 
Well, my current IRQ setup (according to lspci -v) is as follows:

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: Asustek Computer, Inc.: Unknown device 8064
	Flags: bus master, medium devsel, latency 0
	Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if
00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: ee000000-efdfffff
	Prefetchable memory behind bridge: eff00000-fbffffff
	Capabilities: <available only to root>

00:06.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d800 [size=8]
	I/O ports at d400 [size=4]
	I/O ports at d000 [size=8]
	I/O ports at b800 [size=4]
	I/O ports at b400 [size=64]
	Memory at ed800000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 05)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at b000 [size=32]
	Capabilities: <available only to root>

00:0e.1 Input device controller: Creative Labs SB Live! (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at a800 [disabled] [size=8]
	Capabilities: <available only to root>

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at a400 [size=128]
	Memory at ed000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 8052
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	I/O ports at a000 [size=16]
	Capabilities: <available only to root>

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at 9800 [size=32]
	Capabilities: <available only to root>

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at 9400 [size=32]
	Capabilities: <available only to root>

00:11.4 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at 9000 [size=32]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1)
(prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 4015
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
	Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at efff0000 [disabled] [size=64K]
	Capabilities: <available only to root>

Unfortunately, the problem still surfaces occasionally.  Can you please
advise me on what I can do to (hopefully) eliminate this problem ?




Thanks.

