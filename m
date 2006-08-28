Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWH1F43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWH1F43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 01:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWH1F43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 01:56:29 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16259 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751386AbWH1F42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 01:56:28 -0400
From: Jan De Luyck <ml_linuxkernel_20060528@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.17.11] strange pcie errors/warnings on Abit KN9-SLI mainboard
Date: Mon, 28 Aug 2006 07:55:55 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608280755.56015.ml_linuxkernel_20060528@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(running 2.6.17.11 vanilla on Debian SID)

I recently acquired a new pc, with an ABIT KN9-SLI mainboard, using an AMD64x2 
AM2 processor.

System boots fine, but I have some messages/errors in the dmesg that I'm worried 
about. Googling around for them didn't really show up much.

First:

Aug 27 15:35:04 whocares kernel: PCI-DMA: Disabling IOMMU.

IOMMU is (as far as I can see) enabled:
whocares:/var/log# cat /usr/src/build/linux-2.6/.config | grep IOMMU
CONFIG_GART_IOMMU=y

I can't really determine if this is normal. According to the code it seems that 
this is disabled by default when you don't have AGP? (I'm not a kernel-coder, so 
I may be very wrong on this)

Second:

Aug 27 15:35:04 whocares kernel: PCI: Setting latency timer of device 0000:00:0a.0 to 64
Aug 27 15:35:04 whocares kernel: pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS
Aug 27 15:35:04 whocares kernel: assign_interrupt_mode Found MSI capability
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0a.0:pcie00]
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0a.0:pcie03]
Aug 27 15:35:04 whocares kernel: PCI: Setting latency timer of device 0000:00:0b.0 to 64
Aug 27 15:35:04 whocares kernel: pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
Aug 27 15:35:04 whocares kernel: assign_interrupt_mode Found MSI capability
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0b.0:pcie00]
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0b.0:pcie03]
Aug 27 15:35:04 whocares kernel: PCI: Setting latency timer of device 0000:00:0c.0 to 64
Aug 27 15:35:04 whocares kernel: pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
Aug 27 15:35:04 whocares kernel: assign_interrupt_mode Found MSI capability
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0c.0:pcie00]
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0c.0:pcie03]
Aug 27 15:35:04 whocares kernel: PCI: Setting latency timer of device 0000:00:0d.0 to 64
Aug 27 15:35:04 whocares kernel: pcie_portdrv_probe->Dev[0378:10de] has invalid IRQ. Check vendor BIOS
Aug 27 15:35:04 whocares kernel: assign_interrupt_mode Found MSI capability
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0d.0:pcie00]
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0d.0:pcie03]
Aug 27 15:35:04 whocares kernel: PCI: Setting latency timer of device 0000:00:0e.0 to 64
Aug 27 15:35:04 whocares kernel: pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
Aug 27 15:35:04 whocares kernel: assign_interrupt_mode Found MSI capability
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0e.0:pcie00]
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0e.0:pcie03]
Aug 27 15:35:04 whocares kernel: PCI: Setting latency timer of device 0000:00:0f.0 to 64
Aug 27 15:35:04 whocares kernel: pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
Aug 27 15:35:04 whocares kernel: assign_interrupt_mode Found MSI capability
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0f.0:pcie00]
Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0f.0:pcie03]

Any ideas what might be wrong? If anything is wrong, that is.

Thanks!

Jan
-- 
Q:	How do you keep a moron in suspense?
