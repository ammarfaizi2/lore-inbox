Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268307AbTAMVDv>; Mon, 13 Jan 2003 16:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268314AbTAMVDv>; Mon, 13 Jan 2003 16:03:51 -0500
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:45704
	"EHLO efix.biz") by vger.kernel.org with ESMTP id <S268307AbTAMVDs>;
	Mon, 13 Jan 2003 16:03:48 -0500
Subject: Re: Linux 2.4.21-pre3-ac3 and KT400
From: Edward Tandi <ed@efix.biz>
To: Roger Luethi <rl@hellgate.ch>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030113210245.GB1327@k3.hellgate.ch>
References: <1042489183.2617.28.camel@wires.home.biz>
	 <20030113210245.GB1327@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1042492357.2819.37.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Jan 2003 21:12:37 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 21:02, Roger Luethi wrote:
> On Mon, 13 Jan 2003 20:19:43 +0000, Edward Tandi wrote:
> > I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard. The
> > [...]
> > 4) Does anyone know whether I can get the ethernet interface to work
> > using stock kernel net device drivers (yes VIA supply the source, but
> > I'd rather use stock drivers)? I thought it was the via-rhine driver,
> > but it doesn't seem to recognise the chip. Anyone got it working?
> 
> IIRC the KT400 comes with a VT8235 south bridge, so current stock kernel
> should work (minus some bugs that still need fixing). What does lspci -vn
> say? Anything in the kernel log when you try to load via-rhine?
> 

I have the via-rhine driver built into the kernel (Y) not (M). Nothing
shows in dmesg or /var/log/messages.

lspci output below. Thanks,

Ed-T.



lspci:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168

> 00:09.0 Ethernet controller: BROADCOM Corporation: Unknown device 4401
(rev 01)

00:0a.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device
5811 (rev 04)
00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c810 (rev 02)
00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
00:10.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev
82)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3177
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
0250 (rev a3)

lspci -vn:
00:00.0 Class 0600: 1106:3189
        Subsystem: 1043:807f
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 Class 0604: 1106:b168
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e6000000-e75fffff
        Prefetchable memory behind bridge: e7700000-efffffff
        Capabilities: [80] Power Management version 2

00:09.0 Class 0200: 14e4:4401 (rev 01)
        Subsystem: 1043:80a8
        Flags: bus master, fast devsel, latency 32, IRQ 10
        Memory at e5800000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at e76f0000 [disabled] [size=16K]
        Capabilities: [40] Power Management version 2

00:0a.0 Class 0c00: 11c1:5811 (rev 04) (prog-if 10)
        Subsystem: dead:0800
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:0d.0 Class 0100: 1000:0001 (rev 02)
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d800 [size=256]
        Memory at e4800000 (32-bit, non-prefetchable) [size=256]

00:0f.0 Class 0200: 11ad:0002 (rev 20)
        Subsystem: 1385:f004
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d400 [size=256]
        Memory at e4000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:10.0 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1043:808c
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1043:808c
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1043:808c
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 Class 0c03: 1106:3104 (rev 82) (prog-if 20)
        Subsystem: 1043:808c
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at e3800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 Class 0601: 1106:3177
        Subsystem: 1043:808c
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1043:808c
        Flags: bus master, medium devsel, latency 32
        I/O ports at b000 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1043:8095
        Flags: medium devsel, IRQ 9
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2

01:00.0 Class 0300: 10de:0250 (rev a3)
        Subsystem: 10b0:03ea
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
        Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Memory at e7800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at e77e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0


