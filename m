Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276439AbRJPQSl>; Tue, 16 Oct 2001 12:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276448AbRJPQSd>; Tue, 16 Oct 2001 12:18:33 -0400
Received: from snowball.fnal.gov ([131.225.81.94]:29444 "EHLO
	snowball.fnal.gov") by vger.kernel.org with ESMTP
	id <S276439AbRJPQSS>; Tue, 16 Oct 2001 12:18:18 -0400
Date: Tue, 16 Oct 2001 11:18:49 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel bug 2.4.9-IDE related?
Message-ID: <Pine.LNX.4.31.0110161106190.8923-100000@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.9-0.18smp from Redhat's Rawhide:

I get the following bug report after a machine crash:--
this has happened about 6 times on 63 machines in the course of a week:


------------[ cut here ]------------
kernel BUG at slab.c:1419!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013c90e>]    Tainted: P
EFLAGS: 00010092
eax: 0000001b   ebx: 008d0228   ecx: c028fd08   edx: 00002d7e
esi: df55d000   edi: df55d140   ebp: df55d3b0   esp: c1d1df8c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1d1d000)
Stack: c025650e 0000058b 000000c0 00000001 c1d0940c c1d09400 00000006 00000003
       00000003 c1cfe420 c1cfe0c0 00000c96 000000c0 000000c0 0008e000 c013f506
       000000c0 c1d1c000 00000006 c013f565 000000c0 00000000 00010f00 c190ffb8
Call Trace: [<c025650e>] fb_con_Rsmp_190e00e0 [] 0x3d0e
[<c013f506>] deactivate_page_Rsmp_9f75d205 [] 0x2216
[<c013f565>] deactivate_page_Rsmp_9f75d205 [] 0x2275
[<c0105000>] gdt_Rsmp_455fbf86 [] 0x4d94
[<c0105946>] kernel_thread_Rsmp_7e9ebb05 [] 0x26
[<c013f510>] deactivate_page_Rsmp_9f75d205 [] 0x2220


Code: 0f 0b 5f 58 8b 44 24 20 89 ea 8b 58 18 b8 71 f0 2c 5a 01 da


------------------------------------------------------------------

This could be related to the IDE/DMA faults
I have seen before because the system disk is often 100% full when
this happens.  however, it is not always connected with this
and there is nothing in /var/log/messages.

------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

