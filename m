Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUJBW5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUJBW5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 18:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUJBW5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 18:57:47 -0400
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:47514 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S267588AbUJBW5m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 18:57:42 -0400
Date: Sun, 3 Oct 2004 00:57:34 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Subject: [ACPI?] what we can learn from running kernel with debugging enabled
Message-ID: <Pine.LNX.4.60.0410030048240.23034@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was going to debug some problem with reiser4 and I compiled kernel with 
all debuging enabled.

This is what I got:
Oct  3 00:26:03 kangur Capability LSM initialized
Oct  3 00:26:03 kangur CSLIP: code copyright 1989 Regents of the 
University of California
Oct  3 00:26:03 kangur PPP generic driver version 2.4.2
Oct  3 00:26:03 kangur PPP Deflate Compression module registered
Oct  3 00:26:03 kangur NET: Registered protocol family 8
Oct  3 00:26:03 kangur NET: Registered protocol family 20
Oct  3 00:26:03 kangur input: PS/2 Generic Mouse on isa0060/serio1
Oct  3 00:26:03 kangur Unable to handle kernel paging request at virtual 
address b06685a0
Oct  3 00:26:03 kangur printing eip:
Oct  3 00:26:03 kangur b03ffc7b
Oct  3 00:26:03 kangur *pde = 006bf027
Oct  3 00:26:03 kangur *pte = 00668000
Oct  3 00:26:03 kangur Oops: 0002 [#1]
Oct  3 00:26:03 kangur PREEMPT DEBUG_PAGEALLOC
Oct  3 00:26:03 kangur Modules linked in: ac psmouse pppoatm atm 
ppp_deflate zlib_deflate zlib_inflate ppp_generic slhc capability 
commoncap unix
Oct  3 00:26:03 kangur CPU:    0
Oct  3 00:26:03 kangur EIP:    0060:[<b03ffc7b>]    Not tainted
Oct  3 00:26:03 kangur EFLAGS: 00010246   (2.6.8.1-cko8)
Oct  3 00:26:03 kangur EIP is at acpi_bus_register_driver+0xd5/0x16e
Oct  3 00:26:03 kangur eax: b06685a0   ebx: f0902140   ecx: 000001f2 
edx: ffffffed
Oct  3 00:26:03 kangur esi: ed2ad000   edi: f0902280   ebp: ed2adf84 
esp: ed2adf80
Oct  3 00:26:03 kangur ds: 007b   es: 007b   ss: 0068
Oct  3 00:26:03 kangur Process modprobe (pid: 888, threadinfo=ed2ad000 
task=ed2ac9e0)
Oct  3 00:26:03 kangur Stack: b059b500 ed2adf8c f08c2032 ed2adfbc b01445e0 
ed142f54 ed6ded30 ee371d90
Oct  3 00:26:03 kangur ed2dcd50 ed2dcd70 00000000 ed2adfbc 3aacc008 
0805b178 41562cbb ed2ad000
Oct  3 00:26:03 kangur b01058bd 3aacc008 0002f371 0805b178 0805b178 
41562cbb 0805b178 00000080
Oct  3 00:26:03 kangur Call Trace:
Oct  3 00:26:03 kangur [<b010670a>] show_stack+0x7a/0x90
Oct  3 00:26:03 kangur [<b010688d>] show_registers+0x14d/0x1a0
Oct  3 00:26:03 kangur [<b0106a79>] die+0xf9/0x250
Oct  3 00:26:03 kangur [<b011b7e3>] do_page_fault+0x1d3/0x55b
Oct  3 00:26:03 kangur [<b0106399>] error_code+0x2d/0x38
Oct  3 00:26:03 kangur [<f08c2032>] init_module+0x32/0x51 [ac]
Oct  3 00:26:03 kangur [<b01445e0>] sys_init_module+0x1c0/0x390
Oct  3 00:26:03 kangur [<b01058bd>] sysenter_past_esp+0x52/0x71
Oct  3 00:26:03 kangur Code: 89 18 81 3d c8 e4 5a b0 3c 4b 24 1d 74 1c 68 
c8 e4 5a b0 68
Oct  3 00:26:03 kangur <6>note: modprobe[888] exited with preempt_count 1
Oct  3 00:26:03 kangur Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
Oct  3 00:26:03 kangur in_atomic():1, irqs_disabled():0
Oct  3 00:26:03 kangur [<b0106737>] dump_stack+0x17/0x20
Oct  3 00:26:03 kangur [<b011fa84>] __might_sleep+0xb4/0xe0
Oct  3 00:26:03 kangur [<b01273ef>] do_exit+0xaf/0x9a0
Oct  3 00:26:03 kangur [<b0106bc7>] die+0x247/0x250
Oct  3 00:26:03 kangur [<b011b7e3>] do_page_fault+0x1d3/0x55b
Oct  3 00:26:03 kangur [<b0106399>] error_code+0x2d/0x38
Oct  3 00:26:03 kangur [<f08c2032>] init_module+0x32/0x51 [ac]
Oct  3 00:26:03 kangur [<b01445e0>] sys_init_module+0x1c0/0x390
Oct  3 00:26:03 kangur [<b01058bd>] sysenter_past_esp+0x52/0x71
Oct  3 00:26:03 kangur bad: scheduling while atomic!
Oct  3 00:26:03 kangur [<b0106737>] dump_stack+0x17/0x20
Oct  3 00:26:03 kangur [<b04f31f4>] schedule+0x634/0x640
Oct  3 00:26:03 kangur [<b015b218>] unmap_vmas+0x2a8/0x320
Oct  3 00:26:03 kangur [<b0160c88>] exit_mmap+0xc8/0x270
Oct  3 00:26:03 kangur [<b012093d>] mmput+0xad/0x110
Oct  3 00:26:03 kangur [<b0127514>] do_exit+0x1d4/0x9a0
Oct  3 00:26:03 kangur [<b0106bc7>] die+0x247/0x250
Oct  3 00:26:03 kangur [<b011b7e3>] do_page_fault+0x1d3/0x55b
Oct  3 00:26:03 kangur [<b0106399>] error_code+0x2d/0x38
Oct  3 00:26:03 kangur [<f08c2032>] init_module+0x32/0x51 [ac]
Oct  3 00:26:03 kangur [<b01445e0>] sys_init_module+0x1c0/0x390
Oct  3 00:26:03 kangur [<b01058bd>] sysenter_past_esp+0x52/0x71
Oct  3 00:26:03 kangur drivers/acpi/scan.c:445: 
spin_lock(drivers/acpi/scan.c:b05ae4c8) already locked by 
drivers/acpi/scan.c/445
Oct  3 00:26:03 kangur ACPI: Power Button (FF) [PWRF]
Oct  3 00:26:03 kangur ACPI: Sleep Button (CM) [SLPB]
Oct  3 00:26:03 kangur ACPI: Processor [CPU0] (supports C1, 2 throttling 
states)
Oct  3 00:26:03 kangur input: PC Speaker
Oct  3 00:26:03 kangur inserting floppy driver for 2.6.8.1-cko8
Oct  3 00:26:03 kangur Floppy drive(s): fd0 is 1.44M
Oct  3 00:26:03 kangur FDC 0 is a post-1991 82077
Oct  3 00:26:03 kangur loop: loaded (max 8 devices)


I am currently using 2.6.8.1-cko8 and can reproduce this problem every 
time. This message is not displayed when debuging is disabled.

Could somebody look at it?


Thanks,

Grzegorz Kulewski

