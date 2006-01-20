Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWATMcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWATMcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWATMcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:32:22 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:56070 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S1750919AbWATMcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:32:21 -0500
Date: Fri, 20 Jan 2006 13:32:02 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: linux-kernel@vger.kernel.org
Subject: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060120123202.GA1138@epio.fluido.as>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_epio-3603-1137760322-0001-2"
Content-Disposition: inline
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_epio-3603-1137760322-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Best regards to all and everyone. I just purchased a new RS480 (Radeon
XPress200)-based motherboard. It is a Sapphire Pure Performance
PP-A9RS480. Mine is equipped with an Athlon64 3200+. I am attaching
the output of lspci -v

When booting with kernels from 2.6.15-rc1 up (tested with 2.6.15-rc1,
2.6.15-rc5, 2.6.15 and 2.6.16-rc1), the boot process freezes after
displaying messages retated to registering io schedulers:

...
...
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered

There is no OOPS of any kind. The disk activity led remains on. With
both 2.6.14 and 2.6.14.6, boot regularly continues with:

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
nbd: registered device at major 43
...
...

I tried to enable all debug options in configure, but no new message
appears. 

Important: I obtain the same result (frozen after "io scheduler cfq
registered") when booting with a 100MB netinst debian sid bootdisk,
downloaded last night. An older (9 month old) Ubuntu bootdisk boots
perfectly. Both cd's are AMD64-specific.

I will be very happy to provide any further info, or to make any
test. Please CC me in your answers if you can.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)

--=_epio-3603-1137760322-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspciout

0000:00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
	Subsystem: ATI Technologies Inc RS480 Host Bridge
	Flags: bus master, 66MHz, medium devsel, latency 64

0000:00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fde00000-fdefffff
	Prefetchable memory behind bridge: 00000000d8000000-00000000dff00000
	Capabilities: <available only to root>

0000:00:11.0 IDE interface: ATI Technologies Inc ATI 437A Serial ATA Controller (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ATI Technologies Inc ATI 437A Serial ATA Controller
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 5
	I/O ports at ff00 [size=8]
	I/O ports at fe00 [size=4]
	I/O ports at fd00 [size=8]
	I/O ports at fc00 [size=4]
	I/O ports at fb00 [size=16]
	Memory at fe02f000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at 40000000 [disabled] [size=512K]
	Capabilities: <available only to root>

0000:00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ATI Technologies Inc ATI 4379 Serial ATA Controller
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	I/O ports at fa00 [size=8]
	I/O ports at f900 [size=4]
	I/O ports at f800 [size=8]
	I/O ports at f700 [size=4]
	I/O ports at f600 [size=16]
	Memory at fe02e000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at 40080000 [disabled] [size=512K]
	Capabilities: <available only to root>

0000:00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller (prog-if 10 [OHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller (prog-if 10 [OHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller (prog-if 20 [EHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 10)
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: 66MHz, medium devsel
	I/O ports at 0400 [size=16]
	Memory at fe02a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI (prog-if 8a [Master SecP PriP])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 64
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at f400 [size=16]
	Capabilities: <available only to root>

0000:00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (prog-if 01 [Subtractive decode])
	Flags: bus master, VGA palette snoop, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fdd00000-fddfffff
	Prefetchable memory behind bridge: fdc00000-fdcfffff

0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 01)
	Subsystem: PC Partner Limited: Unknown device 5215
	Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 11
	Memory at fe029000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: <available only to root>

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

0000:01:05.0 VGA compatible controller: ATI Technologies Inc RS480 [Radeon Xpress 200G Series] (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Flags: bus master, 66MHz, medium devsel, latency 255, IRQ 11
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at ee00 [size=256]
	Memory at fdef0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at fde00000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:01:05.1 Display controller: ATI Technologies Inc: Unknown device 5854
	Subsystem: PC Partner Limited: Unknown device 0a57
	Flags: 66MHz, medium devsel
	Memory at <unassigned> (32-bit, prefetchable) [disabled]
	Memory at fde20000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: <available only to root>

0000:02:05.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
	Subsystem: Technotrend Systemtechnik GmbH Technotrend-Budget / Hauppauge WinTV-NOVA-S DVB card
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at fddff000 (32-bit, non-prefetchable) [size=512]

0000:02:06.0 Multimedia controller: Philips Semiconductors SAA7133 Video Broadcast Decoder (rev d0)
	Subsystem: Pinnacle Systems Inc.: Unknown device 002e
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at fddfe000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: <available only to root>

0000:02:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 23)
	Subsystem: LSI Logic / Symbios Logic LSI53C810AE PCI to SCSI I/O Processor
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at da00 [size=256]
	Memory at fddfd000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:02:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Flags: bus master, slow devsel, latency 64, IRQ 11
	I/O ports at df00 [size=64]
	Capabilities: <available only to root>

0000:02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: PC Partner Limited: Unknown device 8169
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 3
	I/O ports at dc00 [size=256]
	Memory at fddfc000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at fdc00000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: PC Partner Limited: Unknown device 3044
	Flags: bus master, stepping, medium devsel, latency 64, IRQ 11
	Memory at fddfb000 (32-bit, non-prefetchable) [size=2K]
	I/O ports at de00 [size=128]
	Capabilities: <available only to root>


--=_epio-3603-1137760322-0001-2--
