Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTKHUp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTKHUp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:45:27 -0500
Received: from web40912.mail.yahoo.com ([66.218.78.209]:61630 "HELO
	web40912.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262118AbTKHUpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:45:25 -0500
Message-ID: <20031108204521.83413.qmail@web40912.mail.yahoo.com>
Date: Sat, 8 Nov 2003 12:45:21 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Badness in atomic_dec_and_test in 2.6.0-test9-mm2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After unplugging and replugging my Logitech MX700 mouse and then shutting
down my Linksys WPC11, I get the following badness message:

input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1.4
orinoco_lock() called with hw_unavailable (dev=df2e8184)
Badness in atomic_dec_and_test at include/asm/atomic.h:150
Call Trace:
 [<c02184f0>] kobject_put+0x7e/0x80
 [<e4cac191>] orinoco_cs_detach+0x0/0xa1 [orinoco_cs]
 [<c02bfd0b>] unbind_request+0xd1/0xdb
 [<c02c0433>] ds_ioctl+0x3dd/0x67a
 [<c01203ae>] scheduler_tick+0x64f/0x65b
 [<c0150c8d>] __alloc_pages+0xb9/0x357
 [<c0132bf5>] update_process_times+0x46/0x52
 [<c013f832>] rcu_check_quiescent_state+0x179/0x1cf
 [<c0132a6f>] update_wall_time+0xd/0x36
 [<c0133155>] do_timer+0xdf/0xe4
 [<c013fa26>] rcu_process_callbacks+0x19e/0x24d
 [<c0114385>] timer_interrupt+0x2cc/0x3bc
 [<c012d64a>] tasklet_action+0x40/0x61
 [<c010e11e>] do_IRQ+0x24c/0x39b
 [<c026102e>] do_con_write+0x31a/0x72f
 [<c015fe6a>] zap_pte_range+0x141/0x187
 [<c015fef8>] zap_pmd_range+0x48/0x64
 [<c015ff57>] unmap_page_range+0x43/0x69
 [<c016005c>] unmap_vmas+0xdf/0x358
 [<c012bc52>] wait_task_zombie+0x164/0x20e
 [<c016591f>] unmap_vma_list+0x1c/0x28
 [<c016591f>] unmap_vma_list+0x1c/0x28
 [<c0165f1f>] do_munmap+0x1d6/0x290
 [<c0192d72>] sys_ioctl+0x204/0x3ee
 [<c0166031>] sys_munmap+0x58/0x78
 [<c03b8cd6>] sysenter_past_esp+0x43/0x65

I am using the 0.14alpha2 orinoco drivers on top of 2.6.0-test9-mm2. Previous
unloads of this driver did not produce this badness message until after I
replugged my mouse.

TIA

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
