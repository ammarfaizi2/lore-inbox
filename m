Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275005AbTHFMyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 08:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275006AbTHFMyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 08:54:50 -0400
Received: from sea2-f5.sea2.hotmail.com ([207.68.165.5]:49425 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S275005AbTHFMys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 08:54:48 -0400
X-Originating-IP: [194.7.240.2]
X-Originating-Email: [lode_leroy@hotmail.com]
From: "lode leroy" <lode_leroy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.70: freeze while write()ing to /dev/hda1
Date: Wed, 06 Aug 2003 14:54:47 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F533UKyM25IFKq000424fa@hotmail.com>
X-OriginalArrivalTime: 06 Aug 2003 12:54:47.0385 (UTC) FILETIME=[EA730490:01C35C19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops... forgot to mention my system details in my previous mail:

i686, 64MB ram, 10GB harddisk

lspci -v

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
        Flags: bus master, medium devsel, latency 64
        Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller 
(A,B step)
        Flags: bus master, fast devsel, latency 16, IRQ 255
        I/O ports at 1800 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Flags: bus master, medium devsel, latency 0

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 82)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet 
Adapter
        Flags: bus master, medium devsel, latency 173, IRQ 11
        I/O ports at 1000 [size=256]
        Memory at ec000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2

00:01.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller(rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] SiS7001 USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at ec001000 (32-bit, non-prefetchable) [size=4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller(rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] Onboard USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at ec002000 (32-bit, non-prefetchable) [size=4K]

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS 
PCI Audio Accelerator (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS PCI Audio 
Accelerator
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 1400 [size=256]
        Memory at ec003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual 
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ec100000-ec1fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff

00:08.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 02)
        Flags: medium devsel, IRQ 5
        Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 
GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] SiS630 GUI 
Accelerator+3D
        Flags: 66Mhz, medium devsel
        BIST result: 00
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Memory at ec100000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at d000 [size=128]
        Capabilities: [40] Power Management version 1
        Capabilities: [50] AGP version 2.0

_________________________________________________________________


