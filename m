Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUHICgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUHICgv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 22:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUHICgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 22:36:51 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:26830 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265825AbUHICgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 22:36:49 -0400
Message-ID: <bec878da04080819361445af2c@mail.gmail.com>
Date: Sun, 8 Aug 2004 19:36:41 -0700
From: "Kevin O'Shea" <mastergoon@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [BUG?] nvidia oops 2.6.8-rc3-mm2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope its ok to post about this here, but I thought it might be a
kernel bug not nvidia.

This is the oops with the new 6111 driver (it worked fine on mm1).

Thanks,
Kevin


Unable to handle kernel NULL pointer dereference at virtual address 000000a9
 printing eip:
c050ed00
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: nvidia
CPU:    0
EIP:    0060:[<c050ed00>]    Tainted: P   VLI
EFLAGS: 00010212   (2.6.8-rc3-mm2) 
EIP is at add_pin_to_irq+0x0/0x70
eax: 000000a9   ebx: 00000010   ecx: 00000080   edx: 00000020
esi: 00000010   edi: 00000000   ebp: 00000001   esp: c4667d98
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 26835, threadinfo=c4667000 task=de4d7930)
Stack: c0114375 00000010 00000000 00000010 00000093 c4667000 00000292 dfe3f540 
       00000001 0001a900 01000000 00000010 00000010 00000000 00010000 c011246b 
       00000000 00000010 00000010 00000001 00000001 00000001 00000001 00000010 
Call Trace:
 [<c0114375>] io_apic_set_pci_routing+0x1e5/0x210
 [<c011246b>] mp_register_gsi+0xeb/0x180
 [<c01101a1>] acpi_register_gsi+0x61/0xc0
 [<c025bc41>] acpi_pci_irq_enable+0x100/0x15f
 [<c03774f8>] pcibios_enable_device+0x28/0x30
 [<c023bdab>] pci_enable_device_bars+0x2b/0x40
 [<c023bdde>] pci_enable_device+0x1e/0x30
 [<e17863a8>] nv_kern_probe+0x227/0x33f [nvidia]
 [<c018e003>] create_dir+0x153/0x1c0
 [<c023d7d2>] pci_device_probe_static+0x52/0x70
 [<c023d82b>] __pci_device_probe+0x3b/0x50
 [<c023d86c>] pci_device_probe+0x2c/0x50
 [<c028d72f>] bus_match+0x3f/0x70
 [<c028d859>] driver_attach+0x59/0x90
 [<c028dd55>] bus_add_driver+0xa5/0xd0
 [<c028e31f>] driver_register+0x2f/0x40
 [<c023daec>] pci_register_driver+0x5c/0x90
 [<e1a4305f>] nvidia_init_module+0x5f/0x3a0 [nvidia]
 [<c013157e>] sys_init_module+0x12e/0x280
 [<c0104135>] sysenter_past_esp+0x52/0x71
Code: 00 00 00 00 00 00 00 00 00 00 00 87 db 02 00 06 de 02 00 00 00
00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00>
00 00 00 04 ed 50 c0 04 ed 50 c0 00 00 00 00 89 0e 00 00 e0
