Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271842AbTG2OhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271844AbTG2OhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:37:21 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:7123 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271842AbTG2OhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:37:20 -0400
Date: Tue, 29 Jul 2003 07:37:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Panic on 2.6.0-test1-mm1
Message-ID: <5110000.1059489420@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The big box had this on the console ... looks like it was doing a
compile at the time ... sorry, only just noticed it after returning
from OLS, so don't have more context (2.6.0-test1-mm1).

kernel BUG at include/linux/list.h:149!
invalid operand: 0000 [#1]
SMP 
CPU:    3
EIP:    0060:[<c0117f98>]    Not tainted VLI
EFLAGS: 00010083
EIP is at pgd_dtor+0x64/0x8c
eax: c1685078   ebx: c1685060   ecx: c0288348   edx: c1685078
esi: 00000082   edi: c030b6a0   ebp: e9b9c000   esp: e9ea3ed0
ds: 007b   es: 007b   ss: 0068
Process cc1 (pid: 4439, threadinfo=e9ea2000 task=eac36690)
Stack: 00000000 f01fdecc c0139588 e9b9c1e0 f01fdecc 00000000 00000039 f01fdecc 
       0000000a f01fdf54 e9871000 c013a540 f01fdecc e9b9c000 f01e9000 00000024 
       f01e9010 f01fdecc c013ace8 f01fdecc f01e9010 00000024 f01fdecc f01fdfb8 
Call Trace:
 [<c0139588>] slab_destroy+0x40/0x124
 [<c013a540>] free_block+0xfc/0x13c
 [<c013ace8>] drain_array_locked+0x80/0xac
 [<c013adef>] reap_timer_fnc+0xdb/0x1e0
 [<c013ad14>] reap_timer_fnc+0x0/0x1e0
 [<c0125aa5>] run_timer_softirq+0x13d/0x170
 [<c0121f7c>] do_softirq+0x6c/0xcc
 [<c01159df>] smp_apic_timer_interrupt+0x14b/0x158
 [<c023a752>] apic_timer_interrupt+0x1a/0x20

Code: 80 50 26 00 00 8d 14 92 8d 1c d0 8d 53 18 8b 4a 04 39 11 74 0e 0f 0b 94 00 99 3e 24 c0 8d b6 00 00 00 00 8b 43 18 39 50 04 74 08 <0f> 0b 95 00 99 3e 24 c0 89 48 04 89 01 c7 43 18 00 01 10 00 c7 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

