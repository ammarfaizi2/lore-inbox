Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUIWKlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUIWKlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 06:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUIWKlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 06:41:18 -0400
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:9701 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S268367AbUIWKlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 06:41:11 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm2 oops on bootup on Acer Aspire 1501LMi (Athlon64) in 32 bit mode
Date: Thu, 23 Sep 2004 12:38:28 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231238.28369.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inserting floppy driver for 2.6.9-0.rc2.1ark
Unable to handle kernel paging request at virtual address e082ed20
 printing eip:
c0218c13
*pde = 1fe17067
*pte = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: floppy parport_pc parport eth1394 sr_mod ide_scsi scsi_mod 
ide_cd cdrom ohci1394 ieee1394 pl2303 ehci_hcd usbserial uhci_hcd usbcore 
thermalprocessor fan button battery asus_acpi ac rtc
CPU:    0
EIP:    0060:[<c0218c13>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-0.rc2.1ark)
EIP is at acpi_bus_register_driver+0x34/0x54
eax: ded1b000   ebx: e0d13ba0   ecx: c0334b44   edx: e082ed20
esi: e0d13e00   edi: ffffffed   ebp: c03361e0   esp: ded1bf5c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1183, threadinfo=ded1b000 task=df22e1f0)
Stack: c03361f8 e0d0d278 e0d13ba0 c03361e0 e0c8f871 0000000a 00000400 e0d0f670
       ded1bfa0 c03361f8 e0d13e00 ded1b000 c01216d7 c03361f8 e0d13e00 ded1b000
       c03361e0 c013ad12 c03f7f88 00000001 e0d13e00 b7fec000 0804f8e8 00000001
Call Trace:
 [<e0d0d278>] acpi_floppy_init+0x18/0x50 [floppy]
 [<e0c8f871>] floppy_init+0x11/0x650 [floppy]
 [<c01216d7>] printk+0x17/0x20
 [<c013ad12>] sys_init_module+0x172/0x250
 [<c010624b>] syscall_call+0x7/0xb
Code: ed ff ff ff 8b 5c 24 08 75 3f 85 db b0 ea 74 39 66 b8 00 f0 21 e0 ff 40 
14 8b 15 2c 56 37 c0 c7 03 28 56 37 c0 89 1d 2c 56 37 c0 <89> 1a 89 53 04 ff 
48 14 8b 40 08 a8 08 74 05 e8 79 6b 0d 00 89
 <6>note: modprobe[1183] exited with preempt_count 1
scheduling while atomic: modprobe/0x04000001/1183
 [<c02ef66d>] schedule+0x57d/0x6b0
 [<c014ef3f>] zap_pmd_range+0x5f/0x80
 [<c014efab>] unmap_page_range+0x4b/0x80
 [<c011dfcf>] cond_resched_lock+0x2f/0x60
 [<c014f136>] unmap_vmas+0x156/0x1f0
 [<c0153de3>] exit_mmap+0x83/0x160
 [<c011ef84>] mmput+0x34/0xc0
 [<c01238a2>] do_exit+0x162/0x440
 [<c0118990>] do_page_fault+0x0/0x5de
 [<c010755d>] die+0x18d/0x190
 [<c0118990>] do_page_fault+0x0/0x5de
 [<c01216d7>] printk+0x17/0x20
 [<c0118d92>] do_page_fault+0x402/0x5de
 [<c01567bb>] unmap_area_pmd+0x4b/0x60
 [<e0d06000>] floppy_hardint+0x0/0x130 [floppy]
 [<c0156e22>] __vunmap+0xc2/0x100
 [<c0156e87>] vfree+0x27/0x40
 [<c013aa96>] load_module+0xa46/0xb50
 [<c0118990>] do_page_fault+0x0/0x5de
 [<c0106ce5>] error_code+0x2d/0x38
 [<c0218c13>] acpi_bus_register_driver+0x34/0x54
 [<e0d0d278>] acpi_floppy_init+0x18/0x50 [floppy]
 [<e0c8f871>] floppy_init+0x11/0x650 [floppy]
 [<c01216d7>] printk+0x17/0x20
 [<c013ad12>] sys_init_module+0x172/0x250
 [<c010624b>] syscall_call+0x7/0xb
