Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUCRAvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUCRAvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:51:06 -0500
Received: from mx3out.umbc.edu ([130.85.25.12]:33487 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id S262256AbUCRAvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:51:01 -0500
Date: Wed, 17 Mar 2004 19:50:59 -0500 (EST)
From: "Mustafa C. Kuscu" <Mustafa.Kuscu@umbc.edu>
X-X-Sender: kuscu1@linux2.gl.umbc.edu
To: linux-kernel@vger.kernel.org
Subject: irq assignment issue: TI 1410 + Serverworks 
Message-ID: <Pine.LNX.4.58L6.0403171932480.22647@linux2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AvMilter-Key: 1079571360:a4b1696093e29b7f83bd471ec48ca134
X-Avmilter: Message Skipped, too small
X-Processed-By: MilterMonkey Version 0.9 -- http://www.membrain.com/miltermonkey
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Problem: A "Texas Instruments 1410" PCI-PCMCIA bridge is not being
assigned any IRQ.
Chipset: Serverworks
Kernel: 2.4.20-30 (RH9-update), 2.4.25 (vanilla) -- neither assigns an IRQ
Box: 2 Dell Poweredge 600SC

[root@client1 root]# lspci
00:00.0 Host bridge: ServerWorks: Unknown device 0017 (rev 32)
00:00.1 Host bridge: ServerWorks: Unknown device 0017
00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
Controller (rev 02)
00:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
00:08.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0e.0 IDE interface: ServerWorks: Unknown device 0217 (rev a0)
00:0f.0 Host bridge: ServerWorks: Unknown device 0203 (rev a0)
00:0f.1 IDE interface: ServerWorks: Unknown device 0213 (rev a0)
00:0f.2 USB Controller: ServerWorks: Unknown device 0221 (rev 05)
00:0f.3 ISA bridge: ServerWorks: Unknown device 0227


Another (almost) identical box without the TI bridge shows the following:

[root@engr-84-251 root]# lspci
00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
Controller (rev 02)
00:07.0 Ethernet controller: Netgear GA630 (rev 01)
00:08.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0e.0 IDE interface: ServerWorks: Unknown device 0217 (rev a0)
00:0f.0 Host bridge: ServerWorks CSB6 South Bridge (rev a0)
00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0)
00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05)
00:0f.3 ISA bridge: ServerWorks GCLE-2 Host Bridge


So far, I have tried
  - kernels: 2.4.20 (redhat's latest) & 2.4.25
  - kernel options: pci=biosirq apic=off

The BIOS setup does *not* allow me to assign IRQ to the TI bridge. In the
setup screen, only the USB controller and the integrated ethernet
controller IRQs can be assigned.

Any suggestions?

Thanks,

     Mustafa C. Kuscu
     Computer Science and Electrical Engineering
     University of Maryland, Baltimore County

