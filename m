Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272371AbTGaAao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272369AbTGaAao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:30:44 -0400
Received: from tomts19.bellnexxia.net ([209.226.175.73]:60847 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S272384AbTGaA2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:28:49 -0400
Date: Wed, 30 Jul 2003 20:28:48 -0400
From: Marc Heckmann <mh@nadir.org>
To: linux-kernel@vger.kernel.org
Subject: UP IO-APIC fix in 2.4.22-pre?
Message-ID: <20030731002847.GA3549@nadir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was just wondering about the bugfix for UP IO-APIC that is in 2.4-ac
and that went into 2.5:

http://linux.bkbits.net:8080/linux-2.5/cset@1.1455.1.9

Will it make it into 2.4.22? From what I understand this fixes the
following problem that many of us are seeing:

hda: dma_timer_expiry: dma status == 0x24
hda: lost interrupt
hda: dma_intr: bad DMA status (dma_stat=30)
hda: dma_intr: status=0x50 { DriveReady SeekComplete }

this is on a Via chipset ATA133 capable board with 2 ATA133 Western
Digital drives in a raid1 configuration. kernel is 2.4.21 patched ACPI
and UP-APIC enabled.

lspci -v output:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
        Subsystem: Giga-byte Technology: Unknown device 5000
        Flags: bus master, 66Mhz, medium devsel, latency 176
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Capabilities: [80] Power Management version 2

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 248, IRQ 17
        I/O ports at d000 [size=32]
        Capabilities: [dc] Power Management version 1

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 176
        I/O ports at d400 [size=8]
        Capabilities: [dc] Power Management version 1

00:0b.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 54) (prog-if 00 [VGA])
        Flags: medium devsel, IRQ 19
        Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Flags: bus master, medium devsel, latency 176, IRQ 7
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Flags: bus master, medium devsel, latency 176, IRQ 12
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Flags: bus master, medium devsel, latency 176, IRQ 11
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: Giga-byte Technology: Unknown device 5001
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology: Unknown device 5002
        Flags: bus master, medium devsel, latency 176, IRQ 255
        I/O ports at e400 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
        Subsystem: Giga-byte Technology: Unknown device a002
        Flags: medium devsel, IRQ 11
        I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2

00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 176, IRQ 18
        I/O ports at ec00 [size=256]
        Memory at ed001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2


thanks.

-m
