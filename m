Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129967AbQLSSJE>; Tue, 19 Dec 2000 13:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbQLSSI4>; Tue, 19 Dec 2000 13:08:56 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:63387 "EHLO
	shookay.e-steel.com") by vger.kernel.org with ESMTP
	id <S129595AbQLSSId>; Tue, 19 Dec 2000 13:08:33 -0500
Date: Tue, 19 Dec 2000 12:38:02 -0500
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org
Subject: Sound problem with AC97 module
Message-ID: <20001219123802.B23357@shookay.e-steel.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@shookay.e-steel.com>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	  Hello!

I have a Dell precision 220 at work with an built-in sound card. The
problem I have is that I continiously get these error messages in my logs:

Dec 14 18:21:02 shookay kernel: DMA overrun on send
Dec 14 18:21:02 shookay kernel: i810_audio: drain_dac, dma timeout?

I have joined output of the module and output of lspci. My motherboard's
chipset is an i820.

If I can give further help or debugging stuff, please let me know!

Regards, Mathieu.

Here the output of the soundcard module:
========================================
Dec 14 17:13:25 shookay kernel: Intel 810 + AC97 Audio, version 0.01, 13:38:36 Dec 12 2000
Dec 14 17:13:25 shookay kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Dec 14 17:13:25 shookay kernel: i810: Intel ICH 82801AA found at IO 0xdc80 and 0xd800, IRQ 17
Dec 14 17:13:25 shookay kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881)

Here the output of lspci:
=========================
00:00.0 Host bridge: Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 03)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corporation 82820 820 (Camino) Chipset PCI to AGP Bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: f0000000-f1ffffff

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fa000000-fbffffff

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation 82801AA IDE
	Flags: bus master, medium devsel, latency 0
	I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation 82801AA USB
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
	Subsystem: Intel Corporation 82801AA SMBus
	Flags: medium devsel, IRQ 17
	I/O ports at dcd0 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at d800 [size=256]
	I/O ports at dc80 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems: Unknown device 5a40
	Flags: 66Mhz, medium devsel, IRQ 16
	Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f0000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at 80000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0

02:07.0 SCSI storage controller: Adaptec AHA-2940U2/W
	Subsystem: Adaptec: Unknown device 2180
	Flags: bus master, medium devsel, latency 64, IRQ 16
	BIST result: 00
	I/O ports at ec00 [size=256]
	Memory at fafff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fb000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1

02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Flags: bus master, medium devsel, latency 64, IRQ 18
	I/O ports at e880 [size=128]
	Memory at faffec00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fb000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
