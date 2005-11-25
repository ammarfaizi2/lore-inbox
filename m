Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbVKYAUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbVKYAUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 19:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbVKYAUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 19:20:09 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:55439 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161079AbVKYAUH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 19:20:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WYI92SFH0JEmJvg9RT0CCxa7NsNTFztgLhalbYFnd+fHH2SH+K7eZvLeEAJTm4vM4mxVXQvRFBuua6iJ5QfDyQocXbsksfVsH0+XoK4EHuHyimR0QPEo9blBjKafvvWnN15ASvo8cGjdOhx8nucJJDsDhHjGpvtF7zmrOxGvhOA=
Message-ID: <5a4c581d0511241620p5b46c918o93047b0b6d0aa554@mail.gmail.com>
Date: Fri, 25 Nov 2005 01:20:05 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc2-git4 on Dell D610 - PCI resource allocation failure
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another one from the new Latitude D610... both the latest FC4
 kernel and 2.6.15-rc2-git4 fail to allocate PCI resources - not
 sure whether FC4 also gets the "Ignore bogus resource" one
 which is here taken from the 2.6.15-rc2-git4 dmesg ring:

[17179572.144000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[17179572.144000] PCI: Failed to allocate I/O resource #7:1000@10000
for 0000:00:1e.0

[root@sandman ~]# lspci -v
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00
[VGA])        Subsystem: Dell: Unknown device 0182
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at dff00000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at ec38 [size=8]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at dfec0000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2

00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 03)
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, fast devsel, latency 0
        Memory at dff80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2

00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: dfd00000-dfdfffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at bf80 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at bf60 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at bf40 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at bf20 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, medium devsel, latency 0, IRQ 11
        Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
(prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=04, sec-latency=32
        Memory behind bridge: dfc00000-dfcfffff
        Prefetchable memory behind bridge: 0000000088000000-0000000089f00000
        Capabilities: [50] #0d [0000]

00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at ed00 [size=256]
        I/O ports at ec40 [size=64]
        Memory at dfebfe00 (32-bit, non-prefetchable) [size=512]
        Memory at dfebfd00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
        Subsystem: Conexant: Unknown device 5423
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at ee00 [size=256]
        I/O ports at ec80 [size=128]
        Capabilities: [50] Power Management version 2

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 03)
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, medium devsel, latency 0

00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller (rev 03) (prog-if 80 [Master])
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 5
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at bfa0 [size=16]
        Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 03)
        Subsystem: Dell: Unknown device 0182
        Flags: medium devsel, IRQ 10
        I/O ports at 10c0 [size=32]

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev 01)
        Subsystem: Dell Latitude D610
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at dfdf0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
        Capabilities: [d0] Express Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [13c] Virtual Channel

03:01.0 CardBus bridge: Texas Instruments PCI6515 Cardbus Controller
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, medium devsel, latency 168, IRQ 5
        Memory at dfc00000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
        Memory window 0: 88000000-89fff000 (prefetchable)
        Memory window 1: 8a000000-8bfff000
        I/O window 0: 00001400-000014ff
        I/O window 1: 00001800-000018ff
        16-bit legacy interface ports at 0001

03:01.5 Communication controller: Texas Instruments PCI6515 SmartCard Controller
        Subsystem: Dell: Unknown device 0182
        Flags: medium devsel, IRQ 5
        Memory at dfcfd000 (32-bit, non-prefetchable) [size=4K]
        Memory at dfcfe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

03:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
        Subsystem: Intel Corporation: Unknown device 2722
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at dfcff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2


Anything else I can provide, just ask...

Thanks in advance, ciao,

--alessandro

 "So much can happen by accident
  No rhyme, no reason - no one's innocent"

   (Steve Wynn - "Under The Weather")
