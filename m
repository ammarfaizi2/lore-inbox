Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133012AbRD1Paj>; Sat, 28 Apr 2001 11:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132633AbRD1Pa3>; Sat, 28 Apr 2001 11:30:29 -0400
Received: from cox.ee.ed.ac.uk ([129.215.80.253]:18596 "EHLO
	postbox.ee.ed.ac.uk") by vger.kernel.org with ESMTP
	id <S133012AbRD1PaS>; Sat, 28 Apr 2001 11:30:18 -0400
From: Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>
X-At: Department of Electrical Engineering, The University of Edinburgh
Date: Sat, 28 Apr 2001 16:30:04 +0100 (BST)
Message-Id: <200104281530.f3SFU4Y09756@hop2-ee-net2.ee.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 breaks dhcpcd with Realtek 8139
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dhcpcd stops working if I install 2.4.4.  Replacing the 2.4.4 version of
8139too.c with the 2.4.3 version and leaving everything else exactly
the same gets things working again.  Configuring the interface by hand
after dhcpcd has timed out also works.  Has anyone else seen this?

ISC DHCP 2.0, kernel compiled with gcc 2.95.2

lspci:
  00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8139 (rev 10)

Boot messages with 2.4.3 version:
  8139too Fast Ethernet driver 0.9.15c loaded
  PCI: Found IRQ 5 for device 00:12.0
  eth0: RealTek RTL8139 Fast Ethernet at 0xc9804f00, 00:10:a7:05:8e:da, IRQ 5
  eth0:  Identified 8139 chip type 'RTL-8139C'

Boot messages with 2.4.4 version:
  8139too Fast Ethernet driver 0.9.16
  PCI: Found IRQ 5 for device 00:12.0
  eth0: RealTek RTL8139 Fast Ethernet at 0xc9804f00, 00:10:a7:05:8e:da, IRQ 5
  eth0:  Identified 8139 chip type 'RTL-8139C'



Michael Gordon
