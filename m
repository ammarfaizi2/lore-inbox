Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270450AbRHNFJq>; Tue, 14 Aug 2001 01:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270452AbRHNFJh>; Tue, 14 Aug 2001 01:09:37 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.11.31.247]:35200 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S270450AbRHNFJ1>; Tue, 14 Aug 2001 01:09:27 -0400
Message-ID: <3B78B27C.59002F77@home.com>
Date: Tue, 14 Aug 2001 00:09:16 -0500
From: Jordan <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Trouble rebooting/halting SMP box with 2.4.x
Content-Type: multipart/mixed;
 boundary="------------6E8727D8DCCC6AC98FA2BF42"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6E8727D8DCCC6AC98FA2BF42
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ever since about 2.4.5 I have only had two or three kernels which could
sucessfully and consistently reboot/halt my machine.  The board is a
dual processor Tyan Tiger 230 running with 1 GB of Registered ECC RAM
set up to use 4-way interleave in the BIOS.  The last kernel to
successfully reboot/halt this box was 2.4.6-ac2.  Whether I use ACPI,
updated ACPI straight from Intel's site, APM (with power management
turned on, using either software or real-mode power off) or nothing at
all init will start going into runlevel 0 or 6 and then at the end of
the scripts when it normally powers itself off or reboots the kernel
displays "INIT: there are no more processes left at this runleve" and
all I can do to reboot is a SysRq-S,U,B.  I doubt that it is my init
scripts which have become messed up since while the kernel barfs on
pretty much any other set up it will work perfectly with the same
scripts and 2.4.6-ac2 using ACPI.  Thank you for any help regarding why
this happens and how to fix it.

Jordan Breeding

Files included:

lspci --> `lspci -vxxx`
dmidecode --> `dmidecode`
x86info --> `x86info --all`
--------------6E8727D8DCCC6AC98FA2BF42
Content-Type: text/plain; charset=us-ascii;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Flags: bus master, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 91 06 06 00 10 a2 c4 00 00 06 00 08 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fc d8 48 b6 01 00 40 40 88 88 10 10 20 20 30 30
60: ff ea 02 20 d6 d6 d6 d6 03 2a 86 0d 18 37 af 66
70: 40 88 cc 0c 0e 81 d2 00 00 f4 09 00 00 00 00 00
80: 0f 40 00 00 c0 00 00 00 03 00 c0 37 25 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 6e 02 14 00
b0: 63 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 04 22 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e4000000-e7ffffff
	Capabilities: [80] Power Management version 2
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 a0 a0 00 00
20: 00 e8 f0 e9 00 e4 f0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00
40: 48 cd 60 44 04 72 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 02 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Tyan Computer: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f1 10 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 08 01 00 00 00 80 60 ee 01 01 c4 00 00 00 00 f3
50: 02 06 34 00 00 70 5b a0 1f 06 ff 08 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 05 10 01 12 00 00 f0 40 00 00 00 00
80: 00 00 00 00 00 0d 00 00 00 60 00 02 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 41 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at b000 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b0 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00
40: 0b 02 09 35 1c 1f c0 00 20 20 77 20 10 00 20 22
50: 07 e4 07 e0 14 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 f0 d3 37 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 06 11 71 05 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 07 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 04 00 00
40: 00 12 03 00 c2 00 3c fc 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 07 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 04 00 00
40: 00 12 03 00 c6 00 30 cc 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 57 30
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00
40: 20 84 49 00 fa 70 00 00 01 40 00 00 00 00 00 00
50: 00 ff ff 88 10 0c 00 00 00 ff ff 00 06 11 57 30
60: 00 00 00 00 00 00 00 00 01 00 02 00 00 00 00 00
70: 01 60 00 00 01 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 50 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 40 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 01)
	Subsystem: CMD Technology Inc PCI0649
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at bc00 [size=8]
	I/O ports at c000 [size=4]
	I/O ports at c400 [size=8]
	I/O ports at c800 [size=4]
	I/O ports at cc00 [size=16]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
00: 95 10 49 06 07 00 90 82 01 00 04 01 00 40 00 00
10: 01 bc 00 00 01 c0 00 00 01 c4 00 00 01 c8 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 95 10 49 06
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 02 04
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
50: 40 ec 00 40 3f 40 3f 0c 3f 40 00 3f 00 00 00 00
60: 01 00 22 06 00 60 00 f0 00 00 00 00 00 00 00 00
70: 08 00 00 f0 9c b5 9f 7f 08 80 00 f0 e4 53 ca 35
80: 00 00 00 00 00 00 00 00 00 00 00 00 95 10 49 06
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d000 [size=128]
	Memory at eb000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
00: b7 10 00 92 07 00 10 82 74 00 00 02 08 20 00 00
10: 01 d0 00 00 00 00 00 eb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 fe
e0: 00 40 00 b7 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at d400 [size=128]
	Memory at eb001000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
00: b7 10 00 92 07 00 10 82 74 00 00 02 08 20 00 00
10: 01 d4 00 00 00 10 00 eb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 fe
e0: 00 40 00 b7 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at d800 [size=32]
	Capabilities: [dc] Power Management version 1
00: 02 11 02 00 05 00 90 02 08 00 01 04 00 20 80 00
10: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 27 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 01 02 14
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at dc00 [size=8]
	Capabilities: [dc] Power Management version 1
00: 02 11 02 70 05 00 90 02 08 00 80 09 00 20 80 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 Modem: Lucent Microelectronics Venus Modem (V90, 56KFlex) (prog-if 03 [Hayes/16650])
	Subsystem: Lucent Microelectronics Venus Modem (V90, 56KFlex)
	Flags: bus master, medium devsel, latency 0, IRQ 11
	Memory at eb002000 (32-bit, non-prefetchable) [size=256]
	I/O ports at e000 [size=256]
	I/O ports at e400 [size=256]
	I/O ports at e800 [size=8]
	Capabilities: [f8] Power Management version 2
00: c1 11 80 04 07 00 90 82 00 03 03 07 00 00 00 00
10: 00 20 00 eb 01 e0 00 00 01 e4 00 00 01 e8 00 00
20: 00 00 00 00 00 00 00 00 40 00 00 00 c1 11 80 04
30: 00 00 00 00 f8 00 00 00 00 00 00 00 0b 01 fc 0e
40: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
50: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
60: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
70: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
80: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
90: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
a0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
b0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
c0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
d0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
e0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
f0: 03 03 03 03 03 03 03 03 01 00 22 e4 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0018
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 7
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	I/O ports at a000 [size=256]
	Memory at e9000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2
00: 02 10 46 50 87 00 b0 02 00 00 00 03 08 20 00 00
10: 08 00 00 e4 01 a0 00 00 00 00 00 e9 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 18 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 07 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 5c 20 00 07 02 00 1f 00 02 00 00 01 00 02 02
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--------------6E8727D8DCCC6AC98FA2BF42
Content-Type: text/plain; charset=us-ascii;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

SMBIOS present.
DMI 2.2 present.
46 structures occupying 1289 bytes.
DMI table at 0x000F0800.
Handle 0x0000
	DMI type 0, 19 bytes.
	BIOS Information Block
		Vendor Award Software International, Inc.
		Version 6.00 PG
		Release 134900238
		BIOS base 0xE0000
		ROM size 192K
		Capabilities:
			Flags: 0x000000007FCBDE90
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor VIA Technologies, Inc.
		Product VT82C694X
		Version  
		Serial Number  
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor  
		Product 694XDP-686B
		Version  
		Serial Number  
Handle 0x0003
	DMI type 3, 13 bytes.
	Chassis Information Block
		Vendor  
		Product  
		Version  
		Serial Number  
		Asset Tag  
Handle 0x0004
	DMI type 4, 32 bytes.
Handle 0x0005
	DMI type 4, 32 bytes.
Handle 0x0006
	DMI type 5, 24 bytes.
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_0
		Banks: 0 1
		Speed: 70nS
		Type: 
		Installed Size: 256Mbyte
		Enabled Size: 256Mbyte
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_1
		Banks: 2 3
		Speed: 70nS
		Type: 
		Installed Size: 256Mbyte
		Enabled Size: 256Mbyte
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_2
		Banks: 4 5
		Speed: 70nS
		Type: 
		Installed Size: 256Mbyte
		Enabled Size: 256Mbyte
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_3
		Banks: 6 7
		Speed: 70nS
		Type: 
		Installed Size: 256Mbyte
		Enabled Size: 256Mbyte
Handle 0x000B
	DMI type 7, 19 bytes.
	Cache
		Socket: Internal Cache
		L1 Internal Cache: write-back
		L1 Cache Size: 32K
		L1 Cache Maximum: 32K
		L1 Cache Type: Synchronous 
Handle 0x000C
	DMI type 7, 19 bytes.
	Cache
		Socket: Internal Cache
		L1 Internal Cache: write-back
		L1 Cache Size: 32K
		L1 Cache Maximum: 32K
		L1 Cache Type: Synchronous 
Handle 0x000D
	DMI type 7, 19 bytes.
	Cache
		Socket: External Cache
		L2 External Cache: write-back
		L2 Cache Size: 2048K
		L2 Cache Maximum: 256K
		L2 Cache Type: Synchronous 
Handle 0x000E
	DMI type 7, 19 bytes.
	Cache
		Socket: External Cache
		L2 External Cache: write-back
		L2 Cache Size: 2048K
		L2 Cache Maximum: 256K
		L2 Cache Type: Synchronous 
Handle 0x000F
	DMI type 8, 9 bytes.
Handle 0x0010
	DMI type 8, 9 bytes.
Handle 0x0011
	DMI type 8, 9 bytes.
Handle 0x0012
	DMI type 8, 9 bytes.
Handle 0x0013
	DMI type 8, 9 bytes.
Handle 0x0014
	DMI type 8, 9 bytes.
Handle 0x0015
	DMI type 8, 9 bytes.
Handle 0x0016
	DMI type 8, 9 bytes.
Handle 0x0017
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit ISA 
		Slot Features: 5v 
Handle 0x0018
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit ISA 
		Slot Features: 5v 
Handle 0x0019
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit ISA 
		Slot Features: 5v 
Handle 0x001A
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit ISA 
		Slot Features: 5v 
Handle 0x001B
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x001C
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x001D
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x001E
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x001F
	DMI type 9, 13 bytes.
	Card Slot
		Slot: AGP
		Type: 32bit AGP 2x 
		Status: In use.
		Slot Features: 5v 
Handle 0x0020
	DMI type 8, 9 bytes.
Handle 0x0021
	DMI type 13, 22 bytes.
Handle 0x0022
	DMI type 16, 15 bytes.
Handle 0x0023
	DMI type 17, 21 bytes.
Handle 0x0024
	DMI type 17, 21 bytes.
Handle 0x0025
	DMI type 17, 21 bytes.
Handle 0x0026
	DMI type 17, 21 bytes.
Handle 0x0027
	DMI type 19, 15 bytes.
Handle 0x0028
	DMI type 20, 19 bytes.
Handle 0x0029
	DMI type 20, 19 bytes.
Handle 0x002A
	DMI type 20, 19 bytes.
Handle 0x002B
	DMI type 20, 19 bytes.
Handle 0x002C
	DMI type 32, 11 bytes.
Handle 0x002D
	DMI type 127, 4 bytes.

--------------6E8727D8DCCC6AC98FA2BF42
Content-Type: text/plain; charset=us-ascii;
 name="x86info"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x86info"

x86info v1.3.  Dave Jones 2001
Feedback to <davej@suse.de>.

Found 2 CPUs
eax in: 0, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 49656e69
eax in: 1, eax = 00000686 ebx = 00000002 ecx = 00000000 edx = 0383fbff
eax in: 2, eax = 03020101 ebx = 00000000 ecx = 00000000 edx = 0c040882
Vendor ID: "GenuineIntel"; Max CPUID level 2

Intel-specific functions
Family: 6 Model: 8 Type 0 [Celeron / Pentium III (Coppermine) Original OEM]
Stepping: 6
Reserved: 0

Feature flags 0383fbff:
FPU    Floating Point Unit
VME    Virtual 8086 Mode Enhancements
DE     Debugging Extensions
PSE    Page Size Extensions
TSC    Time Stamp Counter
MSR    Model Specific Registers
PAE    Physical Address Extension
MCE    Machine Check Exception
CX8    COMPXCHG8B Instruction
APIC   On-chip Advanced Programmable Interrupt Controller present and enabled
SEP    Fast System Call
MTRR   Memory Type Range Registers
PGE    PTE Global Flag
MCA    Machine Check Architecture
CMOV   Conditional Move and Compare Instructions
FGPAT  Page Attribute Table
PSE-36 36-bit Page Size Extension
MMX    MMX instruction set
FXSR   Fast FP/MMX Streaming SIMD Extensions save/restore
XMM    Streaming SIMD Extensions instruction set
Instruction TLB: 4KB pages, 4-way set assoc, 32 entries
Instruction TLB: 4MB pages, fully assoc, 2 entries
Data TLB: 4KB pages, 4-way set assoc, 64 entries
L2 unified cache: Sectored, 32 byte cache line, 8 way set associative, 256K
Instruction cache: 16KB, 4-way set assoc, 32 byte line size
Data TLB: 4MB pages, 4-way set assoc, 8 entries
Data cache: 16KB, 2-way or 4-way set assoc, 32 byte line size
Erk, MCG_CTL not present!
eax in: 0, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 49656e69
eax in: 1, eax = 00000686 ebx = 00000002 ecx = 00000000 edx = 0383fbff
eax in: 2, eax = 03020101 ebx = 00000000 ecx = 00000000 edx = 0c040882
Vendor ID: "GenuineIntel"; Max CPUID level 2

Intel-specific functions
Family: 6 Model: 8 Type 0 [Celeron / Pentium III (Coppermine) Original OEM]
Stepping: 6
Reserved: 0

Feature flags 0383fbff:
FPU    Floating Point Unit
VME    Virtual 8086 Mode Enhancements
DE     Debugging Extensions
PSE    Page Size Extensions
TSC    Time Stamp Counter
MSR    Model Specific Registers
PAE    Physical Address Extension
MCE    Machine Check Exception
CX8    COMPXCHG8B Instruction
APIC   On-chip Advanced Programmable Interrupt Controller present and enabled
SEP    Fast System Call
MTRR   Memory Type Range Registers
PGE    PTE Global Flag
MCA    Machine Check Architecture
CMOV   Conditional Move and Compare Instructions
FGPAT  Page Attribute Table
PSE-36 36-bit Page Size Extension
MMX    MMX instruction set
FXSR   Fast FP/MMX Streaming SIMD Extensions save/restore
XMM    Streaming SIMD Extensions instruction set
Instruction TLB: 4KB pages, 4-way set assoc, 32 entries
Instruction TLB: 4MB pages, fully assoc, 2 entries
Data TLB: 4KB pages, 4-way set assoc, 64 entries
L2 unified cache: Sectored, 32 byte cache line, 8 way set associative, 256K
Instruction cache: 16KB, 4-way set assoc, 32 byte line size
Data TLB: 4MB pages, 4-way set assoc, 8 entries
Data cache: 16KB, 2-way or 4-way set assoc, 32 byte line size
Erk, MCG_CTL not present!
999MHz processor (estimate).


--------------6E8727D8DCCC6AC98FA2BF42--

