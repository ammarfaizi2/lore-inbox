Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVK1J2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVK1J2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 04:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVK1J2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 04:28:51 -0500
Received: from 83-216-141-215.markhi700.adsl.metronet.co.uk ([83.216.141.215]:18949
	"EHLO mx.hindley.org.uk") by vger.kernel.org with ESMTP
	id S1751104AbVK1J2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 04:28:51 -0500
Date: Mon, 28 Nov 2005 09:28:38 +0000
To: linux-kernel@vger.kernel.org
Subject: 2.6.14: Unable to handle kernel paging request
Message-ID: <20051128092837.GA3971@hindley.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Mark Hindley <mark@hindley.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got this as I logged into an AMD K200 system I use as gateway/firewall.

I have been having a few unexplained crashes. Nothing in logs until
this. Requiring cold reboot. Usually occur with nightime cron jobs.

Let me know if you need more info.

Thanks

Mark


Nov 28 07:24:22 titan kernel: Unable to handle kernel paging request at virtual address c03553f8
Nov 28 07:24:22 titan kernel:  printing eip:
Nov 28 07:24:22 titan kernel: c0116764
Nov 28 07:24:22 titan kernel: *pde = 000000e3
Nov 28 07:24:22 titan kernel: *pte = 00000000
Nov 28 07:24:22 titan kernel: Oops: 0000 [#1]
Nov 28 07:24:22 titan kernel: PREEMPT 
Nov 28 07:24:22 titan kernel: Modules linked in: nfsd exportfs apm ipv6 nfs lockd sunrpc via_rhine crc32 af_packet 3c59x mii dummy floppy uhci_hcd ohci_hcd ehci_hcd usbcore ipt_owner ipt_REDIRECT ipt_MASQUERADE ipt_REJECT ipt_LOG ipt_state iptable_filter iptable_nat ip_nat ip_tables ip_conntrack_ftp ip_conntrack nls_iso8859_1 nls_cp437 vfat fat hangcheck_timer
Nov 28 07:24:22 titan kernel: CPU:    0
Nov 28 07:24:22 titan kernel: EIP:    0060:[scheduler_tick+36/768]    Not tainted VLI
Nov 28 07:24:22 titan kernel: EFLAGS: 00010086   (2.6.14) 
Nov 28 07:24:22 titan kernel: EIP is at scheduler_tick+0x24/0x300
Nov 28 07:24:22 titan kernel: eax: c3c4aad0   ebx: c05d6090   ecx: 00000b66   edx: 0000006c
Nov 28 07:24:22 titan kernel: esi: 5ce09cd0   edi: 0000006c   ebp: c2503f08   esp: c2503ef8
Nov 28 07:24:22 titan kernel: ds: 007b   es: 007b   ss: 0068
Nov 28 07:24:22 titan kernel: Process zsh (pid: 2353, threadinfo=c2502000 task=c3c4aad0)
Nov 28 07:24:22 titan kernel: Stack: c3c4aad0 c05d6090 c2502000 b7dc6708 c2503f18 c01161c8 bfea369c 00000000 
Nov 28 07:24:22 titan kernel:        c05d6090 c0118e21 c3a19640 c05d6144 c2503f60 c221155c c01b7b69 c221155c 
Nov 28 07:24:22 titan kernel:        01200011 01200011 0000094b 00000000 c01197a5 01200011 bfea369c c2503fbc 
Nov 28 07:24:22 titan kernel: Call Trace:
Nov 28 07:24:22 titan kernel:  [sched_fork+152/160] sched_fork+0x98/0xa0
Nov 28 07:24:22 titan kernel:  [copy_process+1345/3584] copy_process+0x541/0xe00
Nov 28 07:24:22 titan kernel:  [sprintf+25/32] sprintf+0x19/0x20
Nov 28 07:24:22 titan kernel:  [do_fork+85/372] do_fork+0x55/0x174
Nov 28 07:24:22 titan kernel:  [copy_to_user+49/80] copy_to_user+0x31/0x50
Nov 28 07:24:22 titan kernel:  [sys_clone+41/48] sys_clone+0x29/0x30
Nov 28 07:24:22 titan kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 28 07:24:22 titan kernel: Code: 50 35 c0 eb d2 89 f6 55 89 e5 57 56 53 51 e8 34 2a 0a 00 b8 00 e0 ff ff 21 e0 8b 00 89 45 f0 e8 a3 83 ff ff 89 c6 89 d7 8b 45 f0 <8b> 15 f8 53 35 c0 8b 58 38 8b 48 34 39 da a1 f4 53 35 c0 77 0a 
Nov 28 07:24:22 titan kernel:  <6>note: zsh[2353] exited with preempt_count 1
