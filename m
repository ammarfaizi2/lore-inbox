Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbTLHA4g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 19:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbTLHA4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 19:56:34 -0500
Received: from vmailb.mclink.it ([195.110.128.107]:15634 "EHLO
	vmailb.mclink.it") by vger.kernel.org with ESMTP id S264578AbTLHA4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 19:56:13 -0500
Message-ID: <3FD3CC24.6030908@arpacoop.it>
Date: Mon, 08 Dec 2003 01:56:04 +0100
From: Carlo Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 OHCI-1394 kernel debug messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens at boot when the 1394 modules are loaded.
Hw Asus A7V333, I don't have 1394 devices to connect at the moment,
don't know if the port actually works


Dec  8 01:08:27 localhost kernel: ohci1394: $Rev: 1045 $ Ben Collins 
<bcollins@debian.org>
Dec  8 01:08:27 localhost kernel: ohci1394_0: Get PHY Reg timeout 
[0x00000000/0x00000000/100]
Dec  8 01:08:27 localhost kernel: ohci1394_0: OHCI-1394 1.1 (PCI): 
IRQ=[17]  MMIO=[e5000000-e50007ff]  Max Packet=[2048]
Dec  8 01:08:27 localhost kernel: Debug: sleeping function called from 
invalid context at mm/slab.c:1856
Dec  8 01:08:27 localhost kernel: in_atomic():1, irqs_disabled():0
Dec  8 01:08:27 localhost kernel: Call Trace:
Dec  8 01:08:27 localhost kernel:  [copy_files+301/848] 
__might_sleep+0xad/0xe0
Dec  8 01:08:27 localhost kernel:  [<c011ab3d>] __might_sleep+0xad/0xe0
Dec  8 01:08:27 localhost kernel:  [release_pages+247/416] 
kmem_cache_alloc+0x57/0x70
Dec  8 01:08:27 localhost kernel:  [<c013c987>] kmem_cache_alloc+0x57/0x70
Dec  8 01:08:27 localhost kernel:  [copy_process+521/2816] 
dup_task_struct+0x29/0xe0
Dec  8 01:08:27 localhost kernel:  [<c011af89>] dup_task_struct+0x29/0xe0
Dec  8 01:08:27 localhost kernel:  [register_exec_domain+88/112] 
copy_process+0x98/0xb60
Dec  8 01:08:27 localhost kernel:  [<c011bcb8>] copy_process+0x98/0xb60
Dec  8 01:08:27 localhost kernel:  [printk+45/384] do_fork+0x4d/0x180
Dec  8 01:08:27 localhost kernel:  [<c011c7cd>] do_fork+0x4d/0x180
Dec  8 01:08:27 localhost kernel:  [flush_thread+1/80] 
kernel_thread+0x81/0x90
Dec  8 01:08:27 localhost kernel:  [<c01073d1>] kernel_thread+0x81/0x90
Dec  8 01:08:27 localhost kernel:  [_end+543618696/1068209928] 
nodemgr_host_thread+0x0/0x1a0 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [<e0bb3f80>] 
nodemgr_host_thread+0x0/0x1a0 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [kernel_thread+68/144] 
kernel_thread_helper+0x0/0xc
Dec  8 01:08:27 localhost kernel:  [<c0107344>] kernel_thread_helper+0x0/0xc
Dec  8 01:08:27 localhost kernel:  [_end+543619830/1068209928] 
nodemgr_add_host+0xde/0x140 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [<e0bb43ee>] 
nodemgr_add_host+0xde/0x140 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [_end+543618696/1068209928] 
nodemgr_host_thread+0x0/0x1a0 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [<e0bb3f80>] 
nodemgr_host_thread+0x0/0x1a0 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [_end+543543128/1068209928] 
ohci_initialize+0x210/0x220 [ohci1394]
Dec  8 01:08:27 localhost kernel:  [<e0ba1850>] 
ohci_initialize+0x210/0x220 [ohci1394]
Dec  8 01:08:27 localhost kernel:  [_end+543601848/1068209928] 
highlevel_add_host+0x50/0x80 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [<e0bafdb0>] 
highlevel_add_host+0x50/0x80 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [_end+543599169/1068209928] 
hpsb_add_host+0x69/0x90 [ieee1394]
Dec  8 01:08:27 localhost kernel:  [<e0baf339>] hpsb_add_host+0x69/0x90 
[ieee1394]
Dec  8 01:08:27 localhost kernel:  [_end+543578892/1068209928] 
ohci1394_pci_probe+0x404/0x590 [ohci1394]
Dec  8 01:08:27 localhost kernel:  [<e0baa404>] 
ohci1394_pci_probe+0x404/0x590 [ohci1394]
Dec  8 01:08:27 localhost kernel:  [_end+543551704/1068209928] 
ohci_irq_handler+0x0/0x7b0 [ohci1394]
Dec  8 01:08:27 localhost kernel:  [<e0ba39d0>] 
ohci_irq_handler+0x0/0x7b0 [ohci1394]
Dec  8 01:08:27 localhost kernel:  [acpi_os_get_physical_address+24/53] 
pci_device_probe_static+0x4b/0x70
Dec  8 01:08:27 localhost kernel:  [<c022734b>] 
pci_device_probe_static+0x4b/0x70
Dec  8 01:08:27 localhost kernel:  [acpi_os_predefined_override+52/115] 
__pci_device_probe+0x2c/0x30
Dec  8 01:08:27 localhost kernel:  [<c022739c>] __pci_device_probe+0x2c/0x30
Dec  8 01:08:27 localhost kernel:  [acpi_os_predefined_override+100/115] 
pci_device_probe+0x2c/0x60
Dec  8 01:08:27 localhost kernel:  [<c02273cc>] pci_device_probe+0x2c/0x60
Dec  8 01:08:27 localhost kernel:  [blk_queue_make_request+77/304] 
bus_match+0x3d/0x80
Dec  8 01:08:27 localhost kernel:  [<c028795d>] bus_match+0x3d/0x80
Dec  8 01:08:27 localhost kernel:  [blk_queue_bounce_limit+84/336] 
driver_attach+0x44/0xa0
Dec  8 01:08:27 localhost kernel:  [<c0287a94>] driver_attach+0x44/0xa0
Dec  8 01:08:27 localhost kernel:  [blk_queue_dma_alignment+6/32] 
bus_add_driver+0x86/0xc0
Dec  8 01:08:27 localhost kernel:  [<c0287d96>] bus_add_driver+0x86/0xc0
Dec  8 01:08:27 localhost kernel:  [blk_queue_start_tag+129/256] 
driver_register+0x31/0x40
Dec  8 01:08:27 localhost kernel:  [<c0288211>] driver_register+0x31/0x40
Dec  8 01:08:27 localhost kernel:  [acpi_os_read_memory+2/95] 
pci_register_driver+0x36/0x50
Dec  8 01:08:27 localhost kernel:  [<c0227596>] 
pci_register_driver+0x36/0x50
Dec  8 01:08:27 localhost kernel:  [_end+543579307/1068209928] 
ohci1394_init+0x13/0x3f [ohci1394]
Dec  8 01:08:27 localhost kernel:  [<e0baa5a3>] ohci1394_init+0x13/0x3f 
[ohci1394]
Dec  8 01:08:27 localhost kernel:  [page_waitqueue+15/48] 
sys_init_module+0x11f/0x2b0
Dec  8 01:08:27 localhost kernel:  [<c0133c0f>] sys_init_module+0x11f/0x2b0
Dec  8 01:08:27 localhost kernel:  [irq_entries_start+27/2176] 
syscall_call+0x7/0xb
Dec  8 01:08:27 localhost kernel:  [<c010946b>] syscall_call+0x7/0xb
Dec  8 01:08:27 localhost kernel:
Dec  8 01:08:27 localhost kernel: ieee1394: Host added: 
ID:BUS[0-00:1023]  GUID[00e0180000037e6a]
Dec  8 01:08:27 localhost kernel: raw1394: /dev/raw1394 device initialized


