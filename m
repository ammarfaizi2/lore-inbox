Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269340AbUIIEmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269340AbUIIEmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 00:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269343AbUIIEmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 00:42:17 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:55644 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269340AbUIIEmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 00:42:14 -0400
Message-ID: <9dda3492040908214277f3d454@mail.gmail.com>
Date: Thu, 9 Sep 2004 00:42:13 -0400
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm4
Cc: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

IT8212 driver fails to recognize RAID0 setup. The driver is built in
as module (it8212).

The drives are WDC 120gigers on primary channel as master/slave
configured for RAID0.

>From dmesg:

IT8212: IDE controller at PCI slot 0000:01:0c.0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 17 (level, high) -> IRQ 17
IT8212: chipset revision 16
IT8212: 100% native mode on irq 17
    ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:DMA, hdf:pio
it8212: controller in RAID mode.
    ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Integrated Technology Express Inc, ATA DISK drive
ide2 at 0x8810-0x8817,0x8c02 on irq 17
hde: max request size: 128KiB
hde: 0 sectors (0 MB), CHS=0/0/0
hde: cache flushes not supported
hde: INVALID GEOMETRY: 0 PHYSICAL HEADS?
Probing IDE interface ide3...

lsmod shows:

it8212                  6336  0 [permanent]

lspci -v:

01:0c.0 RAID bus controller: Integrated Technology Express, Inc.
IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be
IT8212, embedded seems (rev 10)
        Subsystem: Integrated Technology Express, Inc.: Unknown device 0001
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 17
        I/O ports at 8810 [size=8]
        I/O ports at 8c00 [size=4]
        I/O ports at 9010 [size=8]
        I/O ports at 9400 [size=4]
        I/O ports at 9800 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [80] Power Management version 2

The board is Gigabyte GA-7NNXP.

Under mm3 kernel, RAID0 was working when using the now dropped iteraid driver.

Paul

-- 
FreeBSD the Power to Serve!
