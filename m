Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263958AbTDWFgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 01:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263960AbTDWFgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 01:36:09 -0400
Received: from [195.95.38.160] ([195.95.38.160]:56561 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S263958AbTDWFgI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 01:36:08 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org, devilkin-ml@blindguardian.org
Subject: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Wed, 23 Apr 2003 07:47:11 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304230747.27579.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Kernels 2.5.6[78] hang when the pcmcia yenta_socket is initialised.

The last message I get is this:

Apr 23 06:54:22 laptop kernel: Linux Kernel Card Services 3.1.22
Apr 23 06:54:22 laptop kernel:   options:  [pci] [cardbus] [pm]
Apr 23 06:54:22 laptop kernel: Intel PCIC probe: not found.
Apr 23 06:54:22 laptop kernel: PCI: Found IRQ 11 for device 00:03.0
Apr 23 06:54:22 laptop kernel: PCI: Sharing IRQ 11 with 00:03.1
Apr 23 06:54:22 laptop kernel: PCI: Sharing IRQ 11 with 00:07.2
Apr 23 06:54:22 laptop kernel: Yenta IRQ list 0698, PCI irq11
Apr 23 06:54:22 laptop kernel: Socket status: 30000020
Apr 23 06:54:22 laptop kernel: PCI: Found IRQ 11 for device 00:03.1
Apr 23 06:54:22 laptop kernel: PCI: Sharing IRQ 11 with 00:03.0
Apr 23 06:54:22 laptop kernel: PCI: Sharing IRQ 11 with 00:07.2
Apr 23 06:54:22 laptop kernel: Yenta IRQ list 0698, PCI irq11
Apr 23 06:54:23 laptop kernel: Socket status: 30000010


After this, the system becomes unresponsive. Reboot is possible using the 
SysRq keys.

System information:

System:
Dell Latitude CPx J 650MHz - Pentium 3 650

Distribution:
Debian Unstable (Sid)

Hardware:
00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 00bb
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 00bb
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00001800-000018ff
        I/O window 1: 00001c00-00001cff
        16-bit legacy interface ports at 0001

To reproduce: boot with any 2.5.6[78] kernel with pcmcia as modules, and have 
it loaded through pcmcia-cs at bootup

It works fine on kernel 2.5.66.

DK
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+pijspuyeqyCEh60RAl/7AJwOq6hubHFvffLFVO6RJ+yttCGoZgCfU4zS
fOYYQnc7w12OKOe50rx8WuE=
=Wuuf
-----END PGP SIGNATURE-----

