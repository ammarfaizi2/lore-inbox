Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUBDVGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbUBDVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:05:05 -0500
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:14976 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id S266609AbUBDVDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:03:21 -0500
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16417.24074.807107.128849@ronispc.chem.mcgill.ca>
Date: Wed, 4 Feb 2004 16:03:06 -0500
To: "Juergen E. Fischer" <fischer@linux-buechse.de>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Problem with module-init-tools-3.0-pre3
In-Reply-To: <20040204194756.GA29909@linux-buechse.de>
References: <16417.14736.420280.796948@ronispc.chem.mcgill.ca>
	<20040204193154.GA29661@linux-buechse.de>
	<16417.19084.870196.696467@ronispc.chem.mcgill.ca>
	<20040204194756.GA29909@linux-buechse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: david.ronis@mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I applied the patch and rebuilt/reinstalled kernel and modules.
Problem is still present.  

David

Here's the log:

Feb  4 16:00:49 ronispc kernel:  printing eip:
Feb  4 16:00:49 ronispc kernel: c0162a50
Feb  4 16:00:49 ronispc kernel: *pde = 00000000
Feb  4 16:00:49 ronispc kernel: Oops: 0000 [#1]
Feb  4 16:00:49 ronispc kernel: CPU:    1
Feb  4 16:00:49 ronispc kernel: EIP:    0060:[<c0162a50>]    Not tainted
Feb  4 16:00:49 ronispc kernel: EFLAGS: 00010202
Feb  4 16:00:49 ronispc kernel: EIP is at cdev_get+0x20/0xb0
Feb  4 16:00:49 ronispc kernel: eax: e8a92000   ebx: 00000708   ecx: 00000015   edx: e8a93f28
Feb  4 16:00:49 ronispc kernel: esi: e88e2ea0   edi: 00000001   ebp: e88e2ea0   esp: e8a93ed8
Feb  4 16:00:49 ronispc kernel: ds: 007b   es: 007b   ss: 0068
Feb  4 16:00:49 ronispc kernel: Process xsane (pid: 2175, threadinfo=e8a92000 task=e89ab370)
Feb  4 16:00:49 ronispc kernel: Stack: c0130185 e8bf2560 e8a92000 00000000 c016293f e88e2ea0 c01ecf89 01500000 
Feb  4 16:00:49 ronispc kernel:        e88e2ea0 00000006 c0162920 00000000 e8a92000 00000000 00000000 00000000 
Feb  4 16:00:49 ronispc kernel:        c0162767 f7fe2c00 01500000 e8a93f28 00000000 e8cc2540 ec313a14 00000001 
Feb  4 16:00:49 ronispc kernel: Call Trace:
Feb  4 16:00:49 ronispc kernel:  [<c0130185>] in_group_p+0x25/0x30
Feb  4 16:00:49 ronispc kernel:  [<c016293f>] exact_lock+0xf/0x20
Feb  4 16:00:49 ronispc kernel:  [<c01ecf89>] kobj_lookup+0x119/0x200
Feb  4 16:00:49 ronispc kernel:  [<c0162920>] exact_match+0x0/0x10
Feb  4 16:00:49 ronispc kernel:  [<c0162767>] chrdev_open+0x1e7/0x290
Feb  4 16:00:49 ronispc kernel:  [<c01576e0>] dentry_open+0x160/0x230
Feb  4 16:00:49 ronispc kernel:  [<c0157578>] filp_open+0x68/0x70
Feb  4 16:00:49 ronispc kernel:  [<c0157aeb>] sys_open+0x5b/0x90
Feb  4 16:00:49 ronispc kernel:  [<c01092ab>] syscall_call+0x7/0xb
Feb  4 16:00:49 ronispc kernel: 
Feb  4 16:00:49 ronispc kernel: Code: 83 3b 02 8b 40 10 74 7f c1 e0 05 8d 04 18 ff 80 a0 00 00 00 
Feb  4 16:00:49 ronispc kernel:  <6>note: xsane[2175] exited with preempt_count 1
Feb  4 16:00:49 ronispc kernel: bad: scheduling while atomic!
Feb  4 16:00:49 ronispc kernel: Call Trace:
Feb  4 16:00:49 ronispc kernel:  [<c011b8a1>] schedule+0x6e1/0x6f0
Feb  4 16:00:49 ronispc kernel:  [<c0153698>] free_pages_and_swap_cache+0x68/0xa0
Feb  4 16:00:49 ronispc kernel:  [<c0148db1>] unmap_vmas+0x241/0x2f0
Feb  4 16:00:49 ronispc kernel:  [<c014d1d9>] exit_mmap+0xe9/0x240
Feb  4 16:00:49 ronispc kernel:  [<c011e0b0>] mmput+0x70/0xd0
Feb  4 16:00:49 ronispc kernel:  [<c012290b>] do_exit+0x18b/0x500
Feb  4 16:00:49 ronispc kernel:  [<c01186f0>] do_page_fault+0x0/0x530
Feb  4 16:00:49 ronispc kernel:  [<c010a3c5>] die+0xf5/0x100
Feb  4 16:00:49 ronispc kernel:  [<c01188ce>] do_page_fault+0x1de/0x530
Feb  4 16:00:49 ronispc kernel:  [<c01a3e81>] journal_stop+0x201/0x310
Feb  4 16:00:49 ronispc kernel:  [<c0171441>] dput+0x31/0x270
Feb  4 16:00:49 ronispc kernel:  [<c0167f14>] link_path_walk+0x694/0x9f0
Feb  4 16:00:49 ronispc kernel:  [<c01186f0>] do_page_fault+0x0/0x530
Feb  4 16:00:49 ronispc kernel:  [<c0109d15>] error_code+0x2d/0x38
Feb  4 16:00:49 ronispc kernel:  [<c0162a50>] cdev_get+0x20/0xb0
Feb  4 16:00:49 ronispc kernel:  [<c0130185>] in_group_p+0x25/0x30
Feb  4 16:00:49 ronispc kernel:  [<c016293f>] exact_lock+0xf/0x20
Feb  4 16:00:49 ronispc kernel:  [<c01ecf89>] kobj_lookup+0x119/0x200
Feb  4 16:00:49 ronispc kernel:  [<c0162920>] exact_match+0x0/0x10
Feb  4 16:00:49 ronispc kernel:  [<c0162767>] chrdev_open+0x1e7/0x290
Feb  4 16:00:49 ronispc kernel:  [<c01576e0>] dentry_open+0x160/0x230
Feb  4 16:00:49 ronispc kernel:  [<c0157578>] filp_open+0x68/0x70
Feb  4 16:00:49 ronispc kernel:  [<c0157aeb>] sys_open+0x5b/0x90
Feb  4 16:00:49 ronispc kernel:  [<c01092ab>] syscall_call+0x7/0xb
Feb  4 16:00:49 ronispc kernel: 
Feb  4 16:00:49 ronispc kernel: bad: scheduling while atomic!
Feb  4 16:00:49 ronispc kernel: Call Trace:
Feb  4 16:00:49 ronispc kernel:  [<c011b8a1>] schedule+0x6e1/0x6f0
Feb  4 16:00:49 ronispc kernel:  [<c0148acb>] zap_pmd_range+0x4b/0x70
Feb  4 16:00:49 ronispc kernel:  [<c0153698>] free_pages_and_swap_cache+0x68/0xa0
Feb  4 16:00:49 ronispc kernel:  [<c0148db1>] unmap_vmas+0x241/0x2f0
Feb  4 16:00:49 ronispc kernel:  [<c014d1d9>] exit_mmap+0xe9/0x240
Feb  4 16:00:49 ronispc kernel:  [<c011e0b0>] mmput+0x70/0xd0
Feb  4 16:00:49 ronispc kernel:  [<c012290b>] do_exit+0x18b/0x500
Feb  4 16:00:49 ronispc kernel:  [<c01186f0>] do_page_fault+0x0/0x530
Feb  4 16:00:49 ronispc kernel:  [<c010a3c5>] die+0xf5/0x100
Feb  4 16:00:49 ronispc kernel:  [<c01188ce>] do_page_fault+0x1de/0x530
Feb  4 16:00:49 ronispc kernel:  [<c01a3e81>] journal_stop+0x201/0x310
Feb  4 16:00:49 ronispc kernel:  [<c0171441>] dput+0x31/0x270
Feb  4 16:00:49 ronispc kernel:  [<c0167f14>] link_path_walk+0x694/0x9f0
Feb  4 16:00:49 ronispc kernel:  [<c01186f0>] do_page_fault+0x0/0x530
Feb  4 16:00:49 ronispc kernel:  [<c0109d15>] error_code+0x2d/0x38
Feb  4 16:00:49 ronispc kernel:  [<c0162a50>] cdev_get+0x20/0xb0
Feb  4 16:00:49 ronispc kernel:  [<c0130185>] in_group_p+0x25/0x30
Feb  4 16:00:49 ronispc kernel:  [<c016293f>] exact_lock+0xf/0x20
Feb  4 16:00:49 ronispc kernel:  [<c01ecf89>] kobj_lookup+0x119/0x200
Feb  4 16:00:49 ronispc kernel:  [<c0162920>] exact_match+0x0/0x10
Feb  4 16:00:49 ronispc kernel:  [<c0162767>] chrdev_open+0x1e7/0x290
Feb  4 16:00:49 ronispc kernel:  [<c01576e0>] dentry_open+0x160/0x230
Feb  4 16:00:49 ronispc kernel:  [<c0157578>] filp_open+0x68/0x70
Feb  4 16:00:49 ronispc kernel:  [<c0157aeb>] sys_open+0x5b/0x90
Feb  4 16:00:49 ronispc kernel:  [<c01092ab>] syscall_call+0x7/0xb
Feb  4 16:00:49 ronispc kernel: 
