Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTBOLRP>; Sat, 15 Feb 2003 06:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTBOLRP>; Sat, 15 Feb 2003 06:17:15 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:4073 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262469AbTBOLRL>;
	Sat, 15 Feb 2003 06:17:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61-mm1
Date: Sat, 15 Feb 2003 22:27:03 +1100
User-Agent: KMail/1.5
References: <20030214231356.59e2ef51.akpm@digeo.com>
In-Reply-To: <20030214231356.59e2ef51.akpm@digeo.com>
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302152227.03979.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the same problem as 2.5.60-mm2 during boot:

bad: scheduling while atomic!
Call Trace:
 [<c0112ab1>] do_schedule+0x3d/0x2f4
 [<c0112fb5>] wait_for_completion+0x8d/0xd0
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c0122219>] create_workqueue+0x125/0x178
 [<c010508e>] init+0x2a/0x17c
 [<c0105064>] init+0x0/0x17c
 [<c0106e5d>] kernel_thread_helper+0x5/0xc

aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
bad: scheduling while atomic!
Call Trace:
 [<c0112ab1>] do_schedule+0x3d/0x2f4
 [<c0112fb5>] wait_for_completion+0x8d/0xd0
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c010508e>] init+0x2a/0x17c
 [<c0105064>] init+0x0/0x17c
 [<c0106e5d>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0112ab1>] do_schedule+0x3d/0x2f4
 [<c0112fb5>] wait_for_completion+0x8d/0xd0
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c010508e>] init+0x2a/0x17c
 [<c0105064>] init+0x0/0x17c
 [<c0106e5d>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0112ab1>] do_schedule+0x3d/0x2f4
 [<c0112fb5>] wait_for_completion+0x8d/0xd0
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c010508e>] init+0x2a/0x17c
 [<c0105064>] init+0x0/0x17c
 [<c0106e5d>] kernel_thread_helper+0x5/0xc

SGI XFS for Linux 2.5.61-mm1 with no debug enabled
bad: scheduling while atomic!
Call Trace:
 [<c0112ab1>] do_schedule+0x3d/0x2f4
 [<c0112fb5>] wait_for_completion+0x8d/0xd0
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c0112dac>] default_wake_function+0x0/0x1c
 [<c0122219>] create_workqueue+0x125/0x178
 [<c021711f>] pagebuf_daemon_start+0xb/0x4c
 [<c0161a4a>] create_proc_entry+0x9a/0xb4
 [<c0151d2b>] register_filesystem+0x3b/0x70
 [<c010508e>] init+0x2a/0x17c
 [<c0105064>] init+0x0/0x17c
 [<c0106e5d>] kernel_thread_helper+0x5/0xc

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
using deadline elevator
Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Copyright (c) 2002 Intel Corporation

PCI: Found IRQ 11 for device 00:04.0
bad: scheduling while atomic!
Call Trace:
 [<c0112ab1>] do_schedule+0x3d/0x2f4
 [<c011b977>] add_timer+0x11b/0x120
 [<c011c4e8>] schedule_timeout+0x84/0xac
 [<c011c458>] process_timeout+0x0/0xc
 [<c024e944>] e100_selftest+0x58/0xb0
 [<c02297d9>] pci_device_probe+0x41/0x5c
 [<c02302b3>] bus_match+0x37/0x60
 [<c0230374>] driver_attach+0x3c/0x5c
 [<c0230602>] bus_add_driver+0xa6/0xd8
 [<c023093c>] driver_register+0x34/0x38
 [<c02298d2>] pci_register_driver+0x42/0x54
 [<c010508e>] init+0x2a/0x17c
 [<c0105064>] init+0x0/0x17c
 [<c0106e5d>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0112ab1>] do_schedule+0x3d/0x2f4
 [<c011b977>] add_timer+0x11b/0x120
 [<c011c4e8>] schedule_timeout+0x84/0xac
 [<c011c458>] process_timeout+0x0/0xc
 [<c02297d9>] pci_device_probe+0x41/0x5c
 [<c02302b3>] bus_match+0x37/0x60
 [<c0230374>] driver_attach+0x3c/0x5c
 [<c0230602>] bus_add_driver+0xa6/0xd8
 [<c023093c>] driver_register+0x34/0x38
 [<c02298d2>] pci_register_driver+0x42/0x54
 [<c010508e>] init+0x2a/0x17c
 [<c0105064>] init+0x0/0x17c
 [<c0106e5d>] kernel_thread_helper+0x5/0xc

Freeing alive device c13a6000, eth%d
alloc_skb called nonatomically from interrupt c027a74c
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:178!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0271823>]    Not tainted
EFLAGS: 00010246
EIP is at alloc_skb+0x43/0x1a4
eax: 0000003a   ebx: c038adc0   ecx: c02f5308   edx: 00000296
esi: c13a6000   edi: 000000d0   ebp: c13a6000   esp: c129feac
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c129e000 task=c129c040)
Stack: c02ea8c0 c027a74c c038adc0 c13a6000 00000005 c027a74c 00000f60 000000d0
       c038adc0 c027abfe 00000010 c13a6000 ffffffff c011f9fa c038adc0 00000005
       c13a6000 c129e000 c03888e1 c0388908 c0276470 c04111c4 00000005 c13a6000
Call Trace:
 [<c027a74c>] rtmsg_ifinfo+0x10/0x78
 [<c027a74c>] rtmsg_ifinfo+0x10/0x78
 [<c027abfe>] rtnetlink_event+0x36/0x3c
 [<c011f9fa>] notifier_call_chain+0x1e/0x38
 [<c0276470>] register_netdevice+0x168/0x174
 [<c0255c0e>] register_netdev+0x5e/0x70
 [<c02297d9>] pci_device_probe+0x41/0x5c
 [<c02302b3>] bus_match+0x37/0x60
 [<c0230374>] driver_attach+0x3c/0x5c
 [<c0230602>] bus_add_driver+0xa6/0xd8
 [<c023093c>] driver_register+0x34/0x38
 [<c02298d2>] pci_register_driver+0x42/0x54
 [<c010508e>] init+0x2a/0x17c
 [<c0105064>] init+0x0/0x17c
 [<c0106e5d>] kernel_thread_helper+0x5/0xc

Code: 0f 0b b2 00 63 a8 2e c0 83 c4 08 83 e7 ef 31 c0 9c 59 fa be
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Con
