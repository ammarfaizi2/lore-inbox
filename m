Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbUCTNLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbUCTNLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:11:16 -0500
Received: from attila.bofh.it ([213.92.8.2]:200 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S263396AbUCTNLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:11:12 -0500
Date: Sat, 20 Mar 2004 11:06:54 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: fatal oops on CHRP powerpc with 2.6.3
Message-ID: <20040320100654.GB2591@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonight one of my B50 servers crashed. This oops was repeated for a few
processes, and when I tried to access it I could not run any new process
and had to reboot with SysRq.

This was Linus' tree.

Linux erode 2.6.3-b50 #1 Fri Feb 20 02:12:34 CET 2004 ppc GNU/Linux


Mar 20 03:22:03 erode kernel: Oops: kernel access of bad area, sig: 11 [#1]
Mar 20 03:22:03 erode kernel: NIP: C0046FF0 LR: C0040C94 SP: CF971DC0 REGS: cf971d10 TRAP: 0301    Not tainted
Mar 20 03:22:03 erode kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Mar 20 03:22:03 erode kernel: DAR: 00000010, DSISR: 40000000
Mar 20 03:22:03 erode kernel: TASK = c0b1e9a0[29400] 'actsyncd' Last syscall: 234 
Mar 20 03:22:03 erode kernel: GPR00: 00000020 CF971DC0 C0B1E9A0 D3D7C7E0 DD58DAD0 DADAD386 D3D7C7F4 DADAD385 
Mar 20 03:22:03 erode kernel: GPR08: 00000010 00000007 D3D7C7E0 00000010 00000005 
Mar 20 03:22:03 erode kernel: Call trace:
Mar 20 03:22:03 erode kernel:  [c0040c94] zap_pte_range+0x198/0x22c
Mar 20 03:22:03 erode kernel:  [c0040d6c] zap_pmd_range+0x44/0x68
Mar 20 03:22:03 erode kernel:  [c0040de0] unmap_page_range+0x50/0x8c
Mar 20 03:22:03 erode kernel:  [c0040f5c] unmap_vmas+0x140/0x248
Mar 20 03:22:04 erode kernel:  [c004536c] exit_mmap+0x60/0x188
Mar 20 03:22:04 erode kernel:  [c00190c8] mmput+0x8c/0xc0
Mar 20 03:22:04 erode kernel:  [c001d230] do_exit+0x1bc/0x448
Mar 20 03:22:04 erode kernel:  [c001d554] do_group_exit+0x38/0x98
Mar 20 03:22:04 erode kernel:  [c0005d1c] ret_from_syscall+0x0/0x44

processor       : 0
cpu             : 604r
clock           : 374MHz
revision        : 49.2 (pvr 0009 3102)
bogomips        : 372.73
machine         : CHRP IBM,7046-B50

-- 
ciao, |
Marco | [5206 peWM2MXMlHcu.]
