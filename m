Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVGNAG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVGNAG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGNAGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:06:15 -0400
Received: from laska.dorms.spbu.ru ([195.19.252.72]:46056 "EHLO
	laska.dorms.spbu.ru") by vger.kernel.org with ESMTP id S261804AbVGNAEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:04:14 -0400
Date: Thu, 14 Jul 2005 04:04:12 +0400
From: Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru>
To: linux-kernel@vger.kernel.org
Subject: agpgart/drm problem
Message-ID: <20050714040412.4bac9a14@laska>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

agpgart initialization problem, so the drm do not work.
The problem appear on all 2.6.x. 

There is a messages from the kernel
===================================
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Unknown aperture size from AGP bridge (0x3)
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-via: probe of 0000:00:00.0 failed with error -22
[drm] Initialized drm 1.0.0 20040925
[drm:drm_fill_in_dev] *ERROR* Cannot initialize the agpgart module.
DRM: Fill_in_dev failed.


lspci -v
=========
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host
Bridge (rev 80) Subsystem: VIA Technologies, Inc. VT8377 [KT400/KT600
AGP] Host Bridge Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [80] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00
[Normal decode]) Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e6000000-e8ffffff
        Prefetchable memory behind bridge: e4000000-e5ffffff
        Capabilities: [80] Power Management version 2

00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08) Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at ec108000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at a000 [size=64]
        Memory at ec000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 20000000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

00:0a.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S
Audio Controller] (rev 02) Subsystem: Yamaha Corporation DS-XG PCI Audio
CODEC Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at ec100000 (32-bit, non-prefetchable) [size=32K]
        I/O ports at a400 [size=64]
        I/O ports at a800 [size=4]
        Capabilities: [50] Power Management version 1

00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
[Millennium] (rev 01) (prog-if 00 [VGA]) Flags: stepping, medium devsel,
IRQ 5 Memory at ea000000 (32-bit, non-prefetchable) [size=16K]
        Memory at eb000000 (32-bit, prefetchable) [size=8M]
        Expansion ROM at 20100000 [disabled] [size=64K]

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149
(rev 80) Subsystem: VIA Technologies, Inc.: Unknown device 3149
        Flags: bus master, medium devsel, latency 32, IRQ 16
        I/O ports at ac00 [size=8]
        I/O ports at b000 [size=4]
        I/O ports at b400 [size=8]
        I/O ports at b800 [size=4]
        I/O ports at bc00 [size=16]
        I/O ports at c000 [size=256]
        Capabilities: [c0] Power Management version 2

00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP]) Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE Flags: bus
master, medium devsel, latency 32, IRQ 16 I/O ports at c400 [size=16]
Capabilities: [c0] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 81) (prog-if 00 [UHCI]) Subsystem: VIA Technologies,
Inc. VT6202 [USB 2.0 controller] Flags: bus master, medium devsel,
latency 32, IRQ 18 I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 81) (prog-if 00 [UHCI]) Subsystem: VIA Technologies,
Inc. VT6202 [USB 2.0 controller] Flags: bus master, medium devsel,
latency 32, IRQ 18 I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 81) (prog-if 00 [UHCI]) Subsystem: VIA Technologies,
Inc. VT6202 [USB 2.0 controller] Flags: bus master, medium devsel,
latency 32, IRQ 18 I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 81) (prog-if 00 [UHCI]) Subsystem: VIA Technologies,
Inc. VT6202 [USB 2.0 controller] Flags: bus master, medium devsel,
latency 32, IRQ 18 I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if
20 [EHCI]) Subsystem: VIA Technologies, Inc. USB 2.0
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at ec109000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800
South] Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60) Subsystem: Unknown
device 16f3:4765 Flags: medium devsel, IRQ 20
        I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 78) Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded
Ethernet Controller on VT8235 Flags: bus master, medium devsel, latency
32, IRQ 21 I/O ports at e000 [size=256]
        Memory at ec10a000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP
(rev 01) (prog-if 00 [VGA]) Subsystem: Matrox Graphics, Inc. Millennium
G550 Dual Head DDR 32Mb Flags: bus master, medium devsel, latency 64, IRQ
17 Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
        Memory at e7000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at e6020000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0


Mikhail Kshevetskiy

PS: please CC me, as I am not in list
