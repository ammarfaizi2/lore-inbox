Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUFTAut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUFTAut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUFTAuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:50:44 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:51688 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264821AbUFTAuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:50:37 -0400
Date: Sat, 19 Jun 2004 20:52:40 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartmann <greg@kroah.com>
Subject: Oops inserting USB storage device
Message-ID: <Pine.LNX.4.58.0406192049430.2228@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following upon insertion of said USB device. Did the kobject get
freed?

Unable to handle kernel paging request at virtual address ded28d08
 printing eip:
c032de76
*pde = 0007d067
Oops: 0002 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c032de76>]    Not tainted
EFLAGS: 00010296   (2.6.7)
EIP is at kobject_put+0x6/0x20
eax: dee57c00   ebx: dee1def8   ecx: ded28cf0   edx: ded28cf0
esi: dee57bf8   edi: 00000101   ebp: dfa3bf44   esp: dfa3bf44
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 12, threadinfo=dfa3a000 task=dfa68a60)
Stack: dfa3bf70 c045323d ded28cf0 00001388 00000002 c045279f dee1df08 00000002
       00000002 00000001 dee14ef8 dfa3bfb4 c0453551 dee14ef8 00000001 00000101
       00000001 dee14f24 dee57bf8 dee1df08 00000286 00000296 00010101 c0453640
Call Trace:
 [<c0107725>] show_stack+0x75/0x90
 [<c0107885>] show_registers+0x125/0x180
 [<c0107a1b>] die+0xab/0x170
 [<c011af78>] do_page_fault+0x1e8/0x535
 [<c010737d>] error_code+0x2d/0x40
 [<c045323d>] hub_port_connect_change+0x2bd/0x2f0
 [<c0453551>] hub_events+0x2e1/0x3d0
 [<c045366d>] hub_thread+0x2d/0xe0
 [<c01042a5>] kernel_thread_helper+0x5/0x10

Code: f0 ff 4a 18 0f 94 c0 84 c0 75 02 5d c3 89 55 08 5d e9 64 ff
