Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274975AbTHFUdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274986AbTHFUdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:33:15 -0400
Received: from proibm3.portoweb.com.br ([200.248.222.108]:13759 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S274975AbTHFUdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:33:07 -0400
Date: Wed, 6 Aug 2003 17:36:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@digeo.com>, <torvalds@osdl.org>
Subject: Boot oops of 2.6.0-test2-mm4
Message-ID: <Pine.LNX.4.44.0308061729280.3182-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 

While trying to boot 8way's OSDL boxen with 2.6.0-test2-mm4 I got: 

....

CPU7: Intel Pentium III (Cascades) stepping 04
Total of 8 processors activated (11153.40 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0918 MHz.
..... host bus clock speed is 99.0988 MHz.
checking TSC synchronization across 8 CPUs: 
BIOS BUG: CPU#6 improperly initialized, has 2 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
------------[ cut here ]------------
kernel BUG at kernel/softirq.c:334!
invalid operand: 0000 [#1]
SMP DEBUG_PAGEALLOC
CPU:    1
EIP:    0060:[<c012a5ec>]    Not tainted VLI
EFLAGS: 00010297
EIP is at ksoftirqd+0x4c/0xe0
eax: cc1d4000   ebx: 00000002   ecx: f7f59f84   edx: 00000004
esi: f7f58000   edi: 00000000   ebp: 00000000   esp: f7f59fe8
ds: 007b   es: 007b   ss: 0068
Process ksoftirqd/2 (pid: 7, threadinfo=f7f58000 task=cc1d4000)
Stack: c012a5a0 00000000 c010abd9 00000002 00000000 00000000 
Call Trace: 
 [<c012a5a0>] ksoftirqd+0x0/0xe0
 [<c010abd9>] kernel_thread_helper+0x5/0xc

Code: ff 8b 06 83 c4 10 88 d9 8b 50 0c 81 ca 00 80 00 00 89 50 0c b8 01 00 
00 00 d3 e0 50 8b 0e 51 e8 fb 8b ff ff 58 5a 39 5e 10 74 08 <0f> 0b 4e 01 
00 d7 34 c0 8b 06 c7 00 01 00 00 00 f0 83 44 24 00 


Any hints, doctors ? 









