Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSJDFHh>; Fri, 4 Oct 2002 01:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261496AbSJDFHh>; Fri, 4 Oct 2002 01:07:37 -0400
Received: from ip45.usw1.rb1.pdx.nwlink.com ([207.202.132.45]:54245 "EHLO
	consumption.net") by vger.kernel.org with ESMTP id <S261495AbSJDFHe>;
	Fri, 4 Oct 2002 01:07:34 -0400
Date: Thu, 3 Oct 2002 22:31:32 -0700 (PDT)
From: <crozierm@consumption.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 - four "sleeping function called..." messages
Message-ID: <Pine.LNX.4.21.0210032222070.8899-100000@consumption.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These are from a 2.5.40 kernel, all during boot/init.  Please CC if I can
provide any useful information, as I'm not subscribed to the list.  The
machine is a dual pentium3, supermicro p6dbe.  The scsi is ide-scsi, not
hw.


kernel: Debug: sleeping function called from illegal context at
slab.c:1374
kernel: d7f3fe90 c011a814 c03a81c0 c03ad399 0000055e 000001d0 c013bc5e
c03ad399
kernel:        0000055e c05a2814 c05a27dc d7d6b214 00000000 00000046
c04f69d0 c04f69c0
kernel:        c04f69d0 c0264a40 d7d6f980 000001d0 c05a27dc c05a27cc
d7d6b214 00000000
kernel: Call Trace:
kernel:  [__might_sleep+84/88]__might_sleep+0x54/0x58
kernel:  [kmem_cache_alloc+38/780]kmem_cache_alloc+0x26/0x30c
kernel:  [blk_init_free_list+76/224]blk_init_free_list+0x4c/0xe0
kernel:  [blk_init_queue+13/240]blk_init_queue+0xd/0xf0
kernel:  [ide_init_queue+40/104]ide_init_queue+0x28/0x68
kernel:  [do_ide_request+0/24]do_ide_request+0x0/0x18
kernel:  [init_irq+813/1048]init_irq+0x32d/0x418
kernel:  [hwif_init+262/588]hwif_init+0x106/0x24c
kernel:  [probe_hwif_init+28/108]probe_hwif_init+0x1c/0x6c
kernel:  [ide_setup_pci_device+61/104]ide_setup_pci_device+0x3d/0x68
kernel:  [piix_init_one+55/64]piix_init_one+0x37/0x40
kernel:  [init+117/532]init+0x75/0x214
kernel:  [init+0/532]init+0x0/0x214
kernel:  [kernel_thread_helper+5/12]kernel_thread_helper+0x5/0xc



kernel: Debug: sleeping function called from illegal context at
slab.c:1374
kernel: d7f3ff08 c011a814 c03a81c0 c03ad399 0000055e 000001d0 c013bf9e
c03ad399
kernel:        0000055e d8800000 00000246 00001000 00001000 d7d6c420
d7d6c420 c0233a26
kernel:        d7d6c420 c13cf060 c013a145 0000001c 000001d0 d7f3e000
00000246 00001000
kernel: Call Trace:
kernel:  [__might_sleep+84/88]__might_sleep+0x54/0x58
kernel:  [kmalloc+90/836]kmalloc+0x5a/0x344
kernel:  [attach+178/184]attach+0xb2/0xb8
kernel:  [get_vm_area+41/312]get_vm_area+0x29/0x138
kernel:  [__vmalloc+50/268]__vmalloc+0x32/0x10c
kernel:  [vmalloc+21/28]vmalloc+0x15/0x1c
kernel:  [sg_init+178/328]sg_init+0xb2/0x148
kernel:  [scsi_register_device+117/280]scsi_register_device+0x75/0x118
kernel:  [init+117/532]init+0x75/0x214
kernel:  [init+0/532]init+0x0/0x214
kernel:  [kernel_thread_helper+5/12]kernel_thread_helper+0x5/0xc



kernel: Debug: sleeping function called from illegal context at
/usr/src/kcompile/linux-2.5.40/include/asm/semaphore.h:119
kernel: d7f19f80 c011a814 c03a81c0 c0429860 00000077 d7cdc16c c02d0b27
c0429860
kernel:        00000077 d7f18000 d7f18000 00000001 d7f19fdc d7cdc194
d7f19fc0 d7cdc194
kernel:        00000000 00010301 c02d0e0d c02d0ddc 00000000 00000000
00000000 00000000
kernel: Call Trace:
kernel:  [__might_sleep+84/88]__might_sleep+0x54/0x58
kernel:  [usb_hub_events+139/832]usb_hub_events+0x8b/0x340
kernel:  [usb_hub_thread+49/212]usb_hub_thread+0x31/0xd4
kernel:  [usb_hub_thread+0/212]usb_hub_thread+0x0/0xd4
kernel:  [default_wake_function+0/52]default_wake_function+0x0/0x34
kernel:  [kernel_thread_helper+5/12]kernel_thread_helper+0x5/0xc



kernel: Debug: sleeping function called from illegal context at
slab.c:1374
kernel: d56a3f54 c011a814 c03a81c0 c03ad399 0000055e 000001d0 c013bf9e
c03ad399
kernel:        0000055e 00000100 00000400 bffffd84 d5b034e0 d594fa18
d6f582f4 c01f053f
kernel:        d5b030c0 c13cf6c0 c010e442 00000080 000001d0 d56a2000
00000100 bffffd84
kernel: Call Trace:
kernel:  [__might_sleep+84/88]__might_sleep+0x54/0x58
kernel:  [kmalloc+90/836]kmalloc+0x5a/0x344
kernel:  [capable+27/52]capable+0x1b/0x34
kernel:  [sys_ioperm+146/300]sys_ioperm+0x92/0x12c
kernel:  [syscall_call+7/11]syscall_call+0x7/0xb

-- 

p.s. 2.5.40 feels snappy!

