Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262942AbSJBDAT>; Tue, 1 Oct 2002 23:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262943AbSJBDAS>; Tue, 1 Oct 2002 23:00:18 -0400
Received: from smtprelay7.dc2.adelphia.net ([64.8.50.39]:12680 "EHLO
	smtprelay7.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S262942AbSJBDAJ>; Tue, 1 Oct 2002 23:00:09 -0400
Date: Tue, 1 Oct 2002 23:02:11 +0000
From: Robin Hall <the_herbman@adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: acpi bug?
Message-Id: <20021001230211.2e13ad4d.the_herbman@adelphia.net>
Organization: Adelphia
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting this when I boot in a couple of places. Everything seems to be working ok I just wanted to let some one know. I am using kernel 2.5.39

hda: WDC WD205BA, ATA DISK drive
Sleeping function called from illegal context at slab.c:1374
dffcfea8 c01434d2 c043e782 0000055e c152b534 c150f8e8 c150f8e0 04000000
       04000000 c02ffa10 c152b534 c010a37f c150f060 000001d0 00000010 04000000
       c152b534 c05d81e0 c152b534 c02f76b4 0000000e c02ffa10 04000000 c05d81f0
Call Trace:
 [<c01434d2>]__kmem_cache_alloc+0x1e2/0x1f0
 [<c02ffa10>]ide_intr+0x0/0x2e0
 [<c010a37f>]request_irq+0x6f/0xe0
 [<c02f76b4>]init_irq+0x174/0x450
 [<c02ffa10>]ide_intr+0x0/0x2e0
 [<c030f721>]__ide_dma_on+0x31/0x40
 [<c02f65e9>]piix_config_drive_xfer_rate+0x89/0x140
 [<c02f7ca8>]hwif_init+0xd8/0x260
 [<c02f73c4>]probe_hwif_init+0x24/0x70
 [<c030ec40>]ide_setup_pci_device+0x50/0x80
 [<c02f66d6>]piix_init_one+0x36/0x40
 [<c01050c3>]init+0x83/0x1b0
 [<c0105040>]init+0x0/0x1b0
 [<c0105705>]kernel_thread_helper+0x5/0x10

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14


And I get it here:

hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
Sleeping function called from illegal context at slab.c:1374
dffcfea8 c01434d2 c043e782 0000055e c152b5fc c150f8e8 c150f8e0 04000000
       04000000 c02ffa10 c152b5fc c010a37f c150f060 000001d0 00000044 04000000
       c152b5fc c05d87d4 c152b5fc c02f76b4 0000000f c02ffa10 04000000 c05d87e4
Call Trace:
 [<c01434d2>]__kmem_cache_alloc+0x1e2/0x1f0
 [<c02ffa10>]ide_intr+0x0/0x2e0
 [<c010a37f>]request_irq+0x6f/0xe0
 [<c02f76b4>]init_irq+0x174/0x450
 [<c02ffa10>]ide_intr+0x0/0x2e0
 [<c030f621>]__ide_dma_off_quietly+0x31/0x40
 [<c02f65d0>]piix_config_drive_xfer_rate+0x70/0x140
 [<c02f7ca8>]hwif_init+0xd8/0x260
 [<c02f73c4>]probe_hwif_init+0x24/0x70
 [<c030ec5f>]ide_setup_pci_device+0x6f/0x80
 [<c02f66d6>]piix_init_one+0x36/0x40
 [<c01050c3>]init+0x83/0x1b0
 [<c0105040>]init+0x0/0x1b0
 [<c0105705>]kernel_thread_helper+0x5/0x10

ide1 at 0x170-0x177,0x376 on irq 15

and here:
Uniform CD-ROM driver Revision: 3.12
Sleeping function called from illegal context at slab.c:1374
dffcff00 c01434d2 c043e782 0000055e c029d6b4 dfda4820 c0436e6f dfff0000
       00000000 00001000 00001000 c0140735 c150f060 000001d0 dfda4820 00000246
       00000000 00001000 c05117e0 c0140b40 00001000 00000002 dffce000 c029ea90
Call Trace:
 [<c01434d2>]__kmem_cache_alloc+0x1e2/0x1f0
 [<c029d6b4>]attach+0xa4/0xc0
 [<c0140735>]get_vm_area+0x25/0x140
 [<c0140b40>]__vmalloc+0x60/0x140
 [<c029ea90>]bus_for_each_dev+0x1a0/0x1d0
 [<c0140c40>]vmalloc+0x20/0x30
 [<c034145b>]sg_init+0xab/0x180
 [<c0314780>]scsi_register_device+0x140/0x180
 [<c01050c3>]init+0x83/0x1b0
 [<c0105040>]init+0x0/0x1b0
 [<c0105705>]kernel_thread_helper+0x5/0x10

uhci-hcd.c: USB Universal Host Controller Interface driver v2.0

and here also:

scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: IOMEGA    Model: ZIP 250           Rev: 90.V
  Type:   Direct-Access                      ANSI SCSI revision: 02
Sleeping function called from illegal context at slab.c:1374
c1569c1c c01434d2 c043e782 0000055e c0101e08 0001e5bb 00000000 dfff0000
       c0511b00 00001000 00001000 c0140735 c150f060 000001d0 001f8000 dfbdd400
       c0511b00 00001000 df6ebc00 c0140b40 00001000 00000002 df5c72d4 df5c7334
Call Trace:
 [<c01434d2>]__kmem_cache_alloc+0x1e2/0x1f0
 [<c0140735>]get_vm_area+0x25/0x140
 [<c0140b40>]__vmalloc+0x60/0x140
 [<c0140c40>]vmalloc+0x20/0x30
 [<c03418da>]sg_attach+0x32a/0x3e0
 [<c0140c40>]vmalloc+0x20/0x30
 [<c033bcc8>]sd_init+0x138/0x2b0
 [<c0313f97>]scsi_register_host+0x1b7/0x330
 [<c036e8a2>]storage_probe+0x842/0xb70
 [<c036768b>]uhci_submit_control+0x25b/0x2d0
 [<c035276a>]usb_device_probe+0xaa/0xe0
 [<c029d605>]probe+0x25/0x30
 [<c029d6fe>]found_match+0x2e/0x70
 [<c029d78f>]do_device_attach+0x4f/0x60
 [<c029ebae>]bus_for_each_drv+0xee/0x1e0
 [<c029d7e4>]device_attach+0x44/0x60
 [<c029d740>]do_device_attach+0x0/0x60
 [<c029dc75>]device_register+0x205/0x270
 [<c0353bc0>]usb_new_device+0x330/0x470
 [<c0356001>]usb_hub_port_connect_change+0x1c1/0x2e0
 [<c0356480>]usb_hub_events+0x360/0x410
 [<c012366f>]reparent_to_init+0x10f/0x1b0
 [<c0356565>]usb_hub_thread+0x35/0x100
 [<c0119a76>]preempt_schedule+0x36/0x50
 [<c0119a90>]default_wake_function+0x0/0x40
 [<c0356530>]usb_hub_thread+0x0/0x100
 [<c0105705>]kernel_thread_helper+0x5/0x10

Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0

and here:

eth0: Winbond 89C940 found at 0xef80, IRQ 11, 00:20:78:1A:A6:90.
Sleeping function called from illegal context at slab.c:1374
dbc1bf68 c01434d2 c043e782 0000055e dbc038bc 40015000 40016000 dbc1a000
       dbc145c0 00000000 00000001 c010d74f c150f6c0 000001d0 00000000 bfffb69c
       00000000 c0545800 dbc1a000 4001488c bffff884 bffff78c c0107e3b 00000000
Call Trace:
 [<c01434d2>]__kmem_cache_alloc+0x1e2/0x1f0
 [<c010d74f>]sys_ioperm+0x9f/0x170
 [<c0107e3b>]syscall_call+0x7/0xb

MTRR: setting reg 2

it seems that when it is loading drives or hardware it is doing it. I am assuming it is ACPI because it mentions sleeping. But I may be way off. :)

Thank you,
Robin E. Hall
