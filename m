Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTI2JXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbTI2JXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:23:48 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:2201 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262927AbTI2JXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:23:47 -0400
Date: Mon, 29 Sep 2003 11:23:08 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test6 oops futex"
Message-ID: <20030929092308.GA4189@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Seen: false
X-ID: bKveCyZVreQX-mQy63N+jw+4qmxI5prROaDZg-c-y7vCSOqPRokfZy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System SMP, Dual-Xeon, glibc-cvs with nptl-0.59, gcc-3.3.1
MozillaFirebird-0.61

With linux-2.6.0-test6 I got several times this oops.
I had no problems with linux-2.6.0-test5 before. (absolute stable for me)

Sep 29 11:06:36 xeon2 kernel: Unable to handle kernel paging request at virtual address 00100104
Sep 29 11:06:36 xeon2 kernel:  printing eip:
Sep 29 11:06:36 xeon2 kernel: c013522d
Sep 29 11:06:36 xeon2 kernel: *pde = 00000000
Sep 29 11:06:36 xeon2 kernel: Oops: 0002 [#1]
Sep 29 11:06:36 xeon2 kernel: CPU:    3
Sep 29 11:06:36 xeon2 kernel: EIP:    0060:[<c013522d>]    Not tainted
Sep 29 11:06:36 xeon2 kernel: EFLAGS: 00010246
Sep 29 11:06:36 xeon2 kernel: EIP is at futex_wake+0xe4/0x140
Sep 29 11:06:36 xeon2 kernel: eax: 00200200   ebx: f6e4deec   ecx: 00000000   edx: 00100100
Sep 29 11:06:36 xeon2 kernel: esi: c054cbc0   edi: 00000000   ebp: c054cbc0   esp: f626df3c
Sep 29 11:06:36 xeon2 kernel: ds: 007b   es: 007b   ss: 0068
Sep 29 11:06:36 xeon2 kernel: Process MozillaFirebird (pid: 967, threadinfo=f626c000 task=f6cdc080)
Sep 29 11:06:36 xeon2 kernel: Stack: f626df4c f626df4c 00000fe8 c054cbbc 0819c000 f7472c80 00000fe8 e75d6008
Sep 29 11:06:36 xeon2 kernel:        0819cfe8 00000001 0819cfe8 00000001 c0135c77 0819cfe8 00000001 00000000
Sep 29 11:06:36 xeon2 kernel:        00000001 c0135d85 0819cfe8 00000001 00000001 7fffffff 0819cfe8 00000000
Sep 29 11:06:36 xeon2 kernel: Call Trace:
Sep 29 11:06:36 xeon2 kernel:  [<c0135c77>] do_futex+0x7e/0x80
Sep 29 11:06:36 xeon2 kernel:  [<c0135d85>] sys_futex+0x10c/0x124
Sep 29 11:06:36 xeon2 kernel:  [<c0124d8b>] sys_gettimeofday+0x53/0xa8
Sep 29 11:06:36 xeon2 kernel:  [<c010aba9>] sysenter_past_esp+0x52/0x71
Sep 29 11:06:36 xeon2 kernel:
Sep 29 11:06:36 xeon2 kernel: Code: 89 42 04 89 10 89 5b 04 8d 43 08 89 1b ba 03 00 00 00 e8 3b
Sep 29 11:06:36 xeon2 kernel:  <6>note: MozillaFirebird[967] exited with preempt_count 1

-- 
Klaus 
