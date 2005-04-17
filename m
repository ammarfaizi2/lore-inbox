Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVDQQyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVDQQyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 12:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDQQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 12:54:17 -0400
Received: from pop-a065c05.pas.sa.earthlink.net ([207.217.121.183]:5348 "EHLO
	pop-a065c05.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261365AbVDQQx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 12:53:56 -0400
From: TJ <systemloc@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: via82xx driver: reporting dxs_support experience
Date: Sun, 17 Apr 2005 12:53:24 -0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504171253.24389.systemloc@earthlink.net>
X-Length: 4469
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was using the 2.6.7 kernel without APIC or ACPI support, and the via82xx
driver worked perfectly, compiled as a module, without any options. I built a
new 2.6.7 kernel on the same hardware with APIC and ACPI support in the
kernel, as the board supports it, and the driver did not work correctly. When
sound was played, a short, 1 second long bit of the sound to be played was
looped. Possibly this is the clicking noise described by some people? The
driver works fine with this new kernel after adding the option
"dxs_support=1". I hope this interaction with ACPI and APIC sheds some light
on some of the troubles with this driver. I can provide more information if
anyone wants it. Please CC me, I'm not on the list.

TJ

Motherboard: MSI K7T266 Pro2

lspci -nv:

00:00.0 Class 0600: 1106:3099
        Subsystem: 1106:0000
        Flags: bus master, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 Class 0604: 1106:b099
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: dfc00000-dfcfffff
        Prefetchable memory behind bridge: dfa00000-dfafffff
        Capabilities: [80] Power Management version 2

00:06.0 Class 0200: 8086:100e (rev 02)
        Subsystem: 8086:002e
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 17
        Memory at dffc0000 (32-bit, non-prefetchable) [size=128K]
        Memory at dffa0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at d800 [size=64]
        Expansion ROM at dff80000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable
-

00:07.0 Class 0200: 1317:0985 (rev 11)
        Subsystem: 1317:0570
        Flags: bus master, medium devsel, latency 96, IRQ 18
        I/O ports at d400 [size=256]
        Memory at dfffbc00 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at dff60000 [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2

00:08.0 Class 0180: 105a:4d69 (rev 02) (prog-if 85)
        Subsystem: 105a:4d68
        Flags: bus master, 66Mhz, slow devsel, latency 96, IRQ 19
        I/O ports at ec00 [size=8]
        I/O ports at e800 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e000 [size=4]
        I/O ports at dc00 [size=16]
        Memory at dfffc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at dffe0000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1

00:09.0 Class 0180: 1095:0680 (rev 01)
        Subsystem: 1095:0680
        Flags: bus master, medium devsel, latency 96, IRQ 16
        I/O ports at d000 [size=8]
        I/O ports at cc00 [size=4]
        I/O ports at c800 [size=8]
        I/O ports at c400 [size=4]
        I/O ports at c000 [size=16]
        Memory at dfffbb00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at dfe80000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

00:11.0 Class 0601: 1106:3074
        Subsystem: 1106:0000
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1106:0571
        Flags: bus master, medium devsel, latency 32
        I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 Class 0401: 1106:3059 (rev 10)
        Subsystem: 4005:4710
        Flags: medium devsel, IRQ 28
        I/O ports at bc00 [size=256]
        Capabilities: [c0] Power Management version 2

-------------------------------------------------------
