Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273272AbTHKS5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273288AbTHKS4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:56:18 -0400
Received: from pwmail.procempa.com.br ([200.248.222.108]:60627 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S272975AbTHKSzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:55:51 -0400
Date: Mon, 11 Aug 2003 15:58:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org
Subject: test3 oops on Compaq 8500R
Message-ID: <Pine.LNX.4.44.0308111552350.1734-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried booting test3 on the Compaq 8500R:

DAC960#0:                   Read Cache Disabled, Write Cache Enabled
DAC960#0:     /dev/rd/c0d6: RAID-0, Online, 142123008 blocks
DAC960#0:                   Logical Device Initialized, BIOS Geometry: 
255/63
DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
DAC960#0:                   Read Cache Disabled, Write Cache Enabled
Unable to handle kernel NULL pointer dereference at virtual address 
00000148
 printing eip:
c0249945
*pde = 00104001
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0249945>]    Not tainted
EFLAGS: 00010286
EIP is at DAC960_open+0x15/0x80
eax: 00000000   ebx: 00000000   ecx: f668d004   edx: f6a2c004
esi: 00000000   edi: f668e6a0   ebp: f6a2c004   esp: cc1fbd1c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=cc1fa000 task=f7f97000)
Stack: 00000000 f668d004 c016884c f668d004 cc1fbe08 00000000 00000000 
c195a03c
       00000246 c195a03c 00000000 f668d004 00000000 cc1fbe08 f668e6a0 
c0168bf9
       f668e6a0 f668d004 cc1fbe08 00000000 00000000 00000000 00000000 
f668d004
Call Trace:
 [<c016884c>] do_open+0x12c/0x470
 [<c0168bf9>] blkdev_get+0x69/0x80
 [<c0198081>] register_disk+0xa1/0x130
 [<c023b2bf>] blk_register_region+0x2f/0x40
 [<c023b35a>] add_disk+0x3a/0x50
 [<c023b2f0>] exact_match+0x0/0x10
 [<c023b300>] exact_lock+0x0/0x20
 [<c024e004>] DAC960_Probe+0x84/0xa0
 [<c01f14bc>] pci_device_probe_static+0x2c/0x50
 [<c01f1671>] __pci_device_probe+0x21/0x40
 [<c01f16af>] pci_device_probe+0x1f/0x40
 [<c02347f4>] bus_match+0x34/0x60
 [<c02348d4>] driver_attach+0x44/0x60
 [<c0234b41>] bus_add_driver+0x71/0x90
 [<c01f1968>] pci_register_driver+0x88/0xb0
 [<c025407e>] DAC960_init_module+0xe/0x30
 [<c041889b>] do_initcalls+0x3b/0x90
 [<c01050fb>] init+0x7b/0x210
 [<c0105080>] init+0x0/0x210
 [<c0108ba5>] kernel_thread_helper+0x5/0x10
                                            
Code: 8b 98 48 01 00 00 80 7b 1c 00 75 12 85 f6 75 0e 8b 44 24 10
 <0>Kernel panic: Attempted to kill init!


