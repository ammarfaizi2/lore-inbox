Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUBIM4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUBIM4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:56:23 -0500
Received: from ns1.nordita.dk ([130.225.213.200]:59034 "EHLO ns1.nordita.dk")
	by vger.kernel.org with ESMTP id S265137AbUBIM4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:56:18 -0500
Date: Mon, 9 Feb 2004 13:56:16 +0100 (CET)
From: Tobias Heinemann <theine@ns1.nordita.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.2-mm1]Badness in kobject_get
Message-ID: <Pine.LNX.4.44.0402091350260.22362-100000@ns1.nordita.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the same error as Adam Koszela with 2.6.3-mm1 using a Samsung
P10 laptop:

Badness in kobject_get at lib/kobject.c:431
Call Trace:
 [<c01eba59>] kobject_get+0x4c/0x4e
 [<c023db7f>] get_device+0x1a/0x23
 [<c023e77a>] bus_for_each_dev+0x82/0xd4
 [<c028325b>] nodemgr_node_probe+0x4a/0x119
 [<c0283128>] nodemgr_probe_ne_cb+0x0/0x8a
 [<c028339d>] nodemgr_do_irm_duties+0x73/0x11c
 [<c028366e>] nodemgr_host_thread+0x15e/0x18f
 [<c0283510>] nodemgr_host_thread+0x0/0x18f
 [<c010b275>] kernel_thread_helper+0x5/0xb
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller

Unable to handle kernel paging request at virtual address ffedb855
 printing eip:
ffedb855
*pde = 00002067
*pte = 00000000
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<ffedb855>]    Not tainted VLI
EFLAGS: 00010286
EIP is at 0xffedb855
eax: ffedb855   ebx: c03d8b84   ecx: c173bf9c   edx: 00000000
esi: c0282b78   edi: 00000000   ebp: c173bf50   esp: c173bf38
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 10, threadinfo=c173a000 task=dfd58100)
Stack: c01ebae8 c03d8b84 c02818e9 c03d8b60 c03d8b68 c03d8ac0 c173bf78 
c023e794 
       c03d8b84 c173bf9c c03d8b0c 00000000 c16f3e44 c16f3e3c c173bf9c 
c173c898 
       c173bfc0 c028325b c03d8ac0 c16f3e3c c173bf9c c0283128 c173bfc0 
c028339d 
Call Trace:
 [<c01ebae8>] kobject_cleanup+0x8d/0x8f
 [<c02818e9>] nodemgr_bus_match+0x0/0x82
 [<c023e794>] bus_for_each_dev+0x9c/0xd4
 [<c028325b>] nodemgr_node_probe+0x4a/0x119
 [<c0283128>] nodemgr_probe_ne_cb+0x0/0x8a
 [<c028339d>] nodemgr_do_irm_duties+0x73/0x11c
 [<c028366e>] nodemgr_host_thread+0x15e/0x18f
 [<c0283510>] nodemgr_host_thread+0x0/0x18f
 [<c010b275>] kernel_thread_helper+0x5/0xb

Code:  Bad EIP value.


I wish to be personally CC'ed the answers/comments posted to the list in 
response to my posting.


Cheers,

 Tobi

