Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTDDHT3 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 02:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTDDHT3 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 02:19:29 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:62974
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261522AbTDDHTV (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 02:19:21 -0500
Date: Fri, 4 Apr 2003 02:26:18 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: William Lee Irwin III <wli@holomorphy.com>
Subject: 2.5-vanilla scribbles on memory on 8quad during boot
Message-ID: <Pine.LNX.4.50.0304040221510.30262-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is all averted by my 'purge panic in as assign_irq_vector' 
patch, as well as my not so invasive pernode idt/vector patch.

Total of 32 processors activated (31453.18 BogoMIPS).
ENABLING IO-APIC IRQs
 printing eip:
c010c954
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c010c954>]    Not tainted
EFLAGS: 00010202
EIP is at set_intr_gate+0x14/0x30
eax: 00606f20   ebx: 07070707   ecx: 07070707   edx: c0138e00
esi: c0136f20   edi: 0000000c   ebp: 00000127   esp: c3c9ff40
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c3c9e000 task=c3c9c040)
Stack: c037cd34 07070707 c0136f20 c3c9ff60 07070707 00000000 00000007 0000000c 
       0001a107 0f000000 000072ed 00000286 c03ee396 00000246 00000000 00eff800 
       00000010 00000000 c037d662 c02c6181 000072b4 00000296 c03ee3b9 00000246 
Call Trace:
 [<c0136f20>] sys_setregid16+0x0/0x30
 [<c0122f28>] printk+0x1d8/0x230
 [<c01050ec>] init+0x6c/0x220
 [<c0105080>] init+0x0/0x220
 [<c0108bb5>] kernel_thread_helper+0x5/0x10

Code: 89 04 cd 00 10 35 c0 89 14 cd 04 10 35 c0 c3 8d b6 00 00 00 
 <0>Kernel panic: Attempted to kill init!

-- 
function.linuxpower.ca
