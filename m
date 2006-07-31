Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWGaFmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWGaFmQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWGaFmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:42:16 -0400
Received: from ns1.openconsultancy.com ([207.166.203.131]:58571 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id S1751496AbWGaFmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:42:15 -0400
X-Spam-Report: SA TESTS
 -2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
  0.8 SARE_BAYES_6x8         BODY: Bayes poison 6x8
  0.8 SARE_BAYES_5x8         BODY: Bayes poison 5x8
  1.0 SARE_BAYES_7x8         BODY: Bayes poison 7x8
Message-ID: <44CD8A1C.9040802@davidcoulson.net>
Date: Mon, 31 Jul 2006 00:42:04 -0400
From: David Coulson <david@davidcoulson.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at net/core/dev.c:1171/skb_checksum_help() 2.6.18-rc3
References: <44CD8415.2020403@davidcoulson.net> <20060730213437.e2ce619d.akpm@osdl.org>
In-Reply-To: <20060730213437.e2ce619d.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Now, I started the heartbeat process on the same machine, and it blew up
trying to do something with IPaddr. I can't even sysrq the box back into
life at this point :-/

BUG: unable to handle kernel paging request at virtual address 9e045900
 printing eip:
c01119d7
*pde = 00000000
Oops: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c01119d7>]    Not tainted VLI
EFLAGS: 00010097   (2.6.18-rc3 #2)
EIP is at resched_task+0x11/0x61
eax: c05134e0   ebx: f5024570   ecx: f5046000   edx: f76db540
esi: c200d340   edi: 00000001   ebp: f1cc3e00   esp: f1cc3dfc
ds: 007b   es: 007b   ss: 0068
Process IPaddr (pid: 8939, ti=f1cc2000 task=f5264ab0 task.ti=f1cc2000)
Stack: c2117030 f1cc3e5c c0112034 c0112804 00000075 00000180 c2011cdc
c2011cdc
       c200ca24 00000001 0000007d 01af9500 00000001 c200d340 c2011460
00000001
       00000000 00000000 00000000 0000000f 00000092 c2011460 c200d340
c200c9e0
Call Trace:
 [<c0112034>] try_to_wake_up+0x262/0x285
 [<c0112804>] move_tasks+0xfd/0x207
 [<c0112f2b>] load_balance+0x14a/0x1d7
 [<c011325e>] rebalance_tick+0xc5/0xe5
 [<c012025f>] update_process_times+0x52/0x5c
 [<c010a2b6>] smp_apic_timer_interrupt+0x5b/0x61
 [<c0103147>] apic_timer_interrupt+0x1f/0x24
 [<c038dbe6>] __mutex_lock_slowpath+0x17f/0x18e
 [<c015f020>] touch_atime+0x65/0xa6
 [<c0153c2b>] pipe_readv+0x67/0x272
 [<c0153e52>] pipe_read+0x1c/0x20
 [<c014a2e7>] vfs_read+0x84/0x123
 [<c014a5df>] sys_read+0x3c/0x62
 [<c010272f>] syscall_call+0x7/0xb
Code: 2b 43 18 89 42 08 89 d8 8b 53 30 e8 08 fd ff ff c7 43 30 00 00 00
00 5b 5
EIP: [<c01119d7>] resched_task+0x11/0x61 SS:ESP 0068:f1cc3dfc
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
 [<c0108ca4>] smp_call_function+0x59/0x119
 [<c01034b7>] show_stack_log_lvl+0x91/0x99
 [<c01185de>] printk+0xe/0x11
 [<c0108daa>] smp_send_stop+0x13/0x1c
 [<c0117dec>] panic+0x41/0xdb
 [<c01038ad>] die+0x1c3/0x1da
 [<c01185de>] printk+0xe/0x11
 [<c010dd0e>] do_page_fault+0x3e3/0x4bc
 [<c010d92b>] do_page_fault+0x0/0x4bc
 [<c01031d5>] error_code+0x39/0x40
 [<c01119d7>] resched_task+0x11/0x61
 [<c0112034>] try_to_wake_up+0x262/0x285
 [<c0112804>] move_tasks+0xfd/0x207
 [<c0112f2b>] load_balance+0x14a/0x1d7
 [<c011325e>] rebalance_tick+0xc5/0xe5
 [<c012025f>] update_process_times+0x52/0x5c
 [<c010a2b6>] smp_apic_timer_interrupt+0x5b/0x61
 [<c0103147>] apic_timer_interrupt+0x1f/0x24
 [<c038dbe6>] __mutex_lock_slowpath+0x17f/0x18e
 [<c015f020>] touch_atime+0x65/0xa6
 [<c0153c2b>] pipe_readv+0x67/0x272
 [<c0153e52>] pipe_read+0x1c/0x20
 [<c014a2e7>] vfs_read+0x84/0x123
 [<c014a5df>] sys_read+0x3c/0x62
 [<c010272f>] syscall_call+0x7/0xb



David

- --
David J. Coulson
email: david@davidcoulson.net
web: http://www.davidcoulson.net/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzYocTIgPQWnLowkRAvuKAKCCRVXMq60qIBwMq6BQ/eWFV/nTPQCgmjIl
Ki3kjhWJ3dG2itFTHn8D/sw=
=/Gf/
-----END PGP SIGNATURE-----
