Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbSKLILB>; Tue, 12 Nov 2002 03:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSKLILB>; Tue, 12 Nov 2002 03:11:01 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:8135 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265880AbSKLILA>; Tue, 12 Nov 2002 03:11:00 -0500
Message-ID: <3DD0B928.3000900@attbi.com>
Date: Tue, 12 Nov 2002 00:17:44 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 -- OOPS -- sleeping function called from illegal context at
 mm/page_alloc.c:417
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ohci1394: $Rev: 601 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[febfc000-febfc7ff]  Max 
Packet=[2048]
Debug: sleeping function called from illegal context at mm/page_alloc.c:417
Call Trace:
 [<c013c62a>] __alloc_pages+0x26a/0x270
 [<c02a7556>] __ide_dma_count+0x16/0x20
 [<c02a7222>] __ide_dma_read+0xe2/0xf0
 [<c013c64f>] __get_free_pages+0x1f/0x60
 [<c0118a7f>] dup_task_struct+0x8f/0xd0
 [<c01192b6>] copy_process+0x96/0x8b0
 [<c010ac33>] do_IRQ+0x103/0x120
 [<c0119b18>] do_fork+0x48/0x150
 [<c01071e5>] kernel_thread+0x95/0xb0
 [<d08db8b0>] nodemgr_host_thread+0x0/0xb0 [ieee1394]
 [<c0107138>] kernel_thread_helper+0x0/0x18
 [<c011b10d>] printk+0x11d/0x180
 [<d08dbbe2>] nodemgr_add_host+0x72/0xf0 [ieee1394]
 [<d08db8b0>] nodemgr_host_thread+0x0/0xb0 [ieee1394]
 [<d08d86de>] highlevel_add_host+0x2e/0x60 [ieee1394]
 [<d08d8154>] hpsb_add_host+0x44/0x70 [ieee1394]
 [<d08e4f96>] ohci1394_pci_probe+0x4b6/0x5a0 [ohci1394]
 [<d08e3300>] ohci_irq_handler+0x0/0x4e0 [ohci1394]
 [<d08e62b2>] .rodata.str1.1+0x0/0x8e [ohci1394]
 [<d08e6fc0>] ohci1394_pci_driver+0x0/0x94 [ohci1394]
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<c0211f7e>] pci_device_probe+0x5e/0x70
 [<d08e6f80>] ohci1394_pci_tbl+0x0/0x38 [ohci1394]
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<c025fca5>] bus_match+0x45/0x80
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<c025fdf2>] driver_attach+0x72/0x90
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<d08e6ffc>] ohci1394_pci_driver+0x3c/0x94 [ohci1394]
 [<c02600fc>] bus_add_driver+0x6c/0x90
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<d08e62bb>] .rodata.str1.1+0x9/0x8e [ohci1394]
 [<d08e700c>] ohci1394_pci_driver+0x4c/0x94 [ohci1394]
 [<c0260831>] driver_register+0x91/0xa0
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<c02120b4>] pci_register_driver+0x44/0x60
 [<d08e6fe8>] ohci1394_pci_driver+0x28/0x94 [ohci1394]
 [<d08e53f3>] ohci1394_init+0x13/0x40 [ohci1394]
 [<d08e6fc0>] ohci1394_pci_driver+0x0/0x94 [ohci1394]
 [<c011c1ad>] sys_init_module+0x4dd/0x620
 [<d08e2060>] E 
__insmod_ohci1394_O/lib/modules/2.5.47/kernel/drivers/ieee1394/ohci1394.o_M3DD0B6FE_V132399+0x60/0x80 
[ohci1394]
 [<d08e6544>] .kmodtab+0x0/0xc [ohci1394]
 [<d08e2060>] E 
__insmod_ohci1394_O/lib/modules/2.5.47/kernel/drivers/ieee1394/ohci1394.o_M3DD0B6FE_V132399+0x60/0x80 
[ohci1394]
 [<c01092a3>] syscall_call+0x7/0xb

ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 44900404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 44900404
ieee1394: Host added: Node[00:1023]  GUID[0030dd80000540e1]  [Linux 
OHCI-1394]


