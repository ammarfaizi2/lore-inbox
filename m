Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264069AbRFKKhL>; Mon, 11 Jun 2001 06:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264070AbRFKKgv>; Mon, 11 Jun 2001 06:36:51 -0400
Received: from cerberus.knvb.nl ([195.109.189.2]:17165 "EHLO cerberus.knvb.nl")
	by vger.kernel.org with ESMTP id <S264069AbRFKKgn>;
	Mon, 11 Jun 2001 06:36:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Derkjan de Haan <derkjan.de.haan@knvb.nl>
To: alan@lxorguk.ukuu.org.uk
Subject: 3Com pcmcia network card stopped working in 2.4.5-ac12
Date: Mon, 11 Jun 2001 12:37:01 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01061112370100.01029@flaptop.zeis.knvb.nl>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

I'd like to report that starting with 2.4.5-ac12 my pcmcia network card 
(3CXFEM656C) doesn't get initialized correctly. I'm using Redhat 7.1

When using modules:

Jun 11 08:34:54 flaptop kernel: PCI: PCI BIOS revision 2.10 entry at 0xfc0be, 
last bus=1
Jun 11 08:34:54 flaptop kernel: PCI: Using configuration type 1
Jun 11 08:34:54 flaptop kernel: PCI: Probing PCI hardware
Jun 11 08:34:54 flaptop kernel: Unknown bridge resource 2: assuming 
transparent Jun 11 08:34:54 flaptop kernel: PCI: Using IRQ router PIIX 
[8086/7110] at 00:07.0
Jun 11 08:34:54 flaptop kernel:   got res[10000000:10000fff] for resource 0 
of Texas Instruments PCI1225
Jun 11 08:34:54 flaptop kernel:   got res[10001000:10001fff] for resource 0 
of Texas Instruments PCI1225 (#2)
Jun 11 08:34:54 flaptop kernel: Limiting direct PCI/PCI transfers.
Jun 11 08:34:55 flaptop kernel: Linux Kernel Card Services 3.1.22
Jun 11 08:34:55 flaptop kernel:   options:  [pci] [cardbus] [pm]
Jun 11 08:34:56 flaptop kernel: PCI: Found IRQ 11 for device 00:03.0
Jun 11 08:34:56 flaptop kernel: PCI: The same IRQ used for device 00:03.1
Jun 11 08:34:56 flaptop kernel: PCI: The same IRQ used for device 00:07.2
Jun 11 08:34:56 flaptop kernel: PCI: Found IRQ 11 for device 00:03.1
Jun 11 08:34:56 flaptop kernel: PCI: The same IRQ used for device 00:03.0
Jun 11 08:34:56 flaptop kernel: PCI: The same IRQ used for device 00:07.2
Jun 11 08:34:56 flaptop kernel: Yenta IRQ list 0498, PCI irq11
Jun 11 08:34:56 flaptop kernel: Socket status: 30000020
Jun 11 08:34:56 flaptop kernel: Yenta IRQ list 0498, PCI irq11
Jun 11 08:34:56 flaptop kernel: Socket status: 30000006
Jun 11 08:34:53 flaptop ifup: Delaying eth0 initialization.
Jun 11 08:34:53 flaptop network: Bringing up interface eth0:  failed
Jun 11 08:34:56 flaptop kernel: cs: cb_alloc(bus 2): vendor 0x10b7, device 
0x6564
Jun 11 08:34:56 flaptop kernel:   got res[1000:10ff] for resource 0 of PCI 
device 10b7:6564
Jun 11 08:34:56 flaptop kernel:   got res[10800000:1080007f] for resource 1 
of PCI device 10b7:6564
Jun 11 08:34:56 flaptop kernel:   got res[10800080:108000ff] for resource 2 
of PCI device 10b7:6564
Jun 11 08:34:56 flaptop kernel:   got res[10400000:1041ffff] for resource 6 
of PCI device 10b7:6564
Jun 11 08:34:56 flaptop kernel: PCI: Enabling device 02:00.0 (0000 -> 0003)
Jun 11 08:34:56 flaptop kernel:   got res[1400:14ff] for resource 0 of PCI 
device 10b7:6565
Jun 11 08:34:56 flaptop kernel:   got res[10800100:108001ff] for resource 1 
of PCI device 10b7:6565
Jun 11 08:34:56 flaptop kernel:   got res[10800200:1080027f] for resource 2 
of PCI device 10b7:6565
Jun 11 08:34:56 flaptop kernel: PCI: Enabling device 02:00.1 (0000 -> 0003)
Jun 11 08:34:56 flaptop pcmcia:  cardmgr.
Jun 11 08:34:56 flaptop cardmgr[456]: starting, version is 3.1.22
Jun 11 08:34:57 flaptop rc: Starting pcmcia:  succeeded
Jun 11 08:34:57 flaptop cardmgr[456]: watching 2 sockets
Jun 11 08:34:57 flaptop kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jun 11 08:34:57 flaptop kernel: cs: IO port probe 0x0100-0x04ff: excluding 
0x280-0x287 0x2f8-0x2ff 0x378-0x37f 0x3f8-0x3ff 0x4d0-0x4d7
Jun 11 08:34:57 flaptop kernel: cs: IO port probe 0x1000-0x17ff: clean.
Jun 11 08:34:57 flaptop kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jun 11 08:34:57 flaptop cardmgr[456]: initializing socket 0
Jun 11 08:34:57 flaptop cardmgr[456]: socket 0: 3Com 3CXFEM656C w/Winmodem
Jun 11 08:34:57 flaptop cardmgr[456]: executing: 'modprobe cb_enabler'
Jun 11 08:34:57 flaptop /etc/hotplug/pci.agent: ... no drivers for PCI slot
Jun 11 08:34:57 flaptop cardmgr[456]: executing: 'modprobe 3c59x'
Jun 11 08:34:59 flaptop cardmgr[456]: get dev info on socket 0 failed: 
Resource temporarily unavailable

The interesting thing is, that after a /etc/init.d/pcmcia restart, the 
interface comes up.

When compiled into kernel:

Jun 11 09:09:21 flaptop kernel: Linux Kernel Card Services 3.1.22
Jun 11 09:09:21 flaptop kernel:   options:  [pci] [cardbus] [pm]
Jun 11 09:09:21 flaptop kernel: PCI: Found IRQ 11 for device 00:03.0
Jun 11 09:09:21 flaptop kernel: PCI: The same IRQ used for device 00:03.1
Jun 11 09:09:21 flaptop kernel: PCI: The same IRQ used for device 00:07.2
Jun 11 09:09:21 flaptop kernel: PCI: Found IRQ 11 for device 00:03.1
Jun 11 09:09:21 flaptop kernel: PCI: The same IRQ used for device 00:03.0
Jun 11 09:09:21 flaptop kernel: PCI: The same IRQ used for device 00:07.2
Jun 11 09:09:21 flaptop kernel: Intel PCIC probe: not found.
Jun 11 09:09:21 flaptop kernel: Yenta IRQ list 0698, PCI irq11
Jun 11 09:09:21 flaptop kernel: Socket status: 30000020
Jun 11 09:09:21 flaptop kernel: Yenta IRQ list 0698, PCI irq11
Jun 11 09:09:21 flaptop kernel: Socket status: 30000006
Jun 11 09:09:21 flaptop kernel: cs: cb_alloc(bus 2): vendor 0xffff, device 
0xffff
Jun 11 09:09:21 flaptop kernel: PCI: device 02:00.0 has unknown header type 
7f, ignoring.

I'll gladly provide additional logging or whatever may be needed.


regards,

Derkjan
