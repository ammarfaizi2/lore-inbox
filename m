Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWIYGF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWIYGF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWIYGF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:05:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751298AbWIYGF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:05:28 -0400
Date: Sun, 24 Sep 2006 23:05:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: i386 pda patches
Message-Id: <20060924230506.572eee8e.akpm@osdl.org>
In-Reply-To: <45176B53.7040608@goop.org>
References: <20060924013521.13d574b1.akpm@osdl.org>
	<4517256E.10606@goop.org>
	<20060924223427.6f42e77c.akpm@osdl.org>
	<45176B53.7040608@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 22:38:27 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > It may be related to the .config, rather than the CPU type.
> >   
> 
> Hm, wonder if it's !4K stacks...
> 

It oopses in the same manner with 4k stacks enabled.

CPU 1 irqstacks, hard=c0503000 soft=c04fb000
Initializing CPU#1
general protection fault: 0080 [#1]
SMP 
last sysfs file: 
Modules linked in:
CPU:    1
EIP:    0060:[<c010af23>]    Not tainted VLI
EFLAGS: 00010086   (2.6.18 #2) 
EIP is at cpu_init+0x153/0x2b0
eax: 00000080   ebx: 0115f220   ecx: e2c02073   edx: c1008964
esi: 00000001   edi: c1c94550   ebp: c1c98f84   esp: c1c98f6c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, ti=c1c98000 task=c1c94550 task.ti=c1c98000)
Stack: c03c4604 00000001 0115f220 00000002 00000000 00000000 c1c98fb8 c010ffbe 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000002 00000000 00000000 c1c98fb4 00000000 00000000 00000000 00000000 
Call Trace:
 [<c0103e56>] show_trace_log_lvl+0x26/0x40
 [<c0103f19>] show_stack_log_lvl+0xa9/0xd0
 [<c0104321>] show_registers+0x1c1/0x250
 [<c01044ec>] die+0x13c/0x300
 [<c0105614>] do_general_protection+0x114/0x1c0
 [<c03aa8d9>] error_code+0x39/0x40
 [<c010ffbe>] start_secondary+0xe/0x4d0
 [<00000000>] 0x0
 [<c1c98fb4>] 0xc1c98fb4
 =======================
Code: c1 ea 10 09 da 8b 1c b5 00 87 4a c0 c1 e1 10 81 c9 73 20 00 00 01 d8 8b 40 02 89 88 80 00 00 00 89 90 84 00 00 00 b8 80 00 00 00 <0f> 00 d8 89 e0 8b 1d a0 0a 41 c0 25 00 f0 ff ff 8b 78 10 a1 7c 
EIP: [<c010af23>] cpu_init+0x153/0x2b0 SS:ESP 0068:c1c98f6c
 <0>Kernel panic - not syncing: Attempted to kill the idle task!

