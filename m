Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUAIBc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265404AbUAIBc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:32:56 -0500
Received: from [61.51.122.197] ([61.51.122.197]:36079 "EHLO
	kapok.exavio.com.cn") by vger.kernel.org with ESMTP id S265356AbUAIBcw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:32:52 -0500
Date: Fri, 9 Jan 2004 09:35:53 +0800
From: Isaac Claymore <clay@exavio.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.1-rc2-mm1][BUG] kernel BUG at mm/rmap.c:305!
Message-ID: <20040109013553.GA3755@exavio.com.cn>
Mail-Followup-To: Isaac Claymore <clay@exavio.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1073605394.1070.3.camel@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <1073605394.1070.3.camel@debian>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I got a similar problem after running rc2-mm1 for about 12 hours,
and my window manager got killed as a result.

Attached is a snipped version of dmesg.

HTH.

-- 

Regards, Isaac
()  ascii ribbon campaign - against html e-mail
/\                        - against microsoft attachments

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

------------[ cut here ]------------
kernel BUG at mm/rmap.c:305!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c0149737>]    Not tainted VLI
EFLAGS: 00010246
EIP is at try_to_unmap_one+0x1c4/0x1d1
eax: 00000000   ebx: 00000000   ecx: c412c000   edx: c412c000
esi: c1117268   edi: c1117268   ebp: c412c000   esp: c133dd48
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 7, threadinfo=c133c000 task=c1341340)
Stack: c013c9fd 00000060 00000202 c1117268 00000000 00000000 c1117268 ffffffff 
       c133c000 c0149878 c02ea200 00000001 00000000 00000001 00000000 c1117268 
       00000001 c133c000 c01411df c1117268 000000d0 cf739c10 0000003c 0000001d 
Call Trace:
 [<c013c9fd>] __set_page_dirty_nobuffers+0x36/0x12e
 [<c0149878>] try_to_unmap+0x134/0x152
 [<c01411df>] shrink_list+0x232/0x586
 [<c0149913>] __pte_chain_free+0x6d/0x6f
 [<c01416db>] shrink_cache+0x1a8/0x363
 [<c0141e75>] shrink_zone+0x83/0xab
 [<c014223d>] balance_pgdat+0x178/0x1f0
 [<c01423c7>] kswapd+0x112/0x122
 [<c011dfbb>] autoremove_wake_function+0x0/0x4f
 [<c02a709e>] ret_from_fork+0x6/0x14
 [<c011dfbb>] autoremove_wake_function+0x0/0x4f
 [<c01422b5>] kswapd+0x0/0x122
 [<c0109255>] kernel_thread_helper+0x5/0xb

Code: e8 1b c1 e3 08 01 c0 09 d8 89 45 00 31 c0 85 c0 0f 84 3a ff ff ff 0f 0b 57 01 05 96 2b c0 e9 2d ff ff ff 0f 01 3b e9 c3 fe ff ff <0f> 0b 31 01 05 96 2b c0 e9 69 fe ff ff 55 57 bf ff ff ff ff 56 
Badness in unblank_screen at drivers/char/vt.c:2793
Call Trace:
 [<c010b8d9>] do_invalid_op+0x0/0xcb
 [<c01eacff>] unblank_screen+0x126/0x12b
 [<c011a5b8>] bust_spinlocks+0x2c/0x54
 [<c010b5a6>] die+0x98/0xfd
 [<c010b9a2>] do_invalid_op+0xc9/0xcb
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c010ca42>] do_IRQ+0x103/0x136
 [<c02a7bc7>] error_code+0x2f/0x38
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c013c9fd>] __set_page_dirty_nobuffers+0x36/0x12e
 [<c0149878>] try_to_unmap+0x134/0x152
 [<c01411df>] shrink_list+0x232/0x586
 [<c0149913>] __pte_chain_free+0x6d/0x6f
 [<c01416db>] shrink_cache+0x1a8/0x363
 [<c0141e75>] shrink_zone+0x83/0xab
 [<c014223d>] balance_pgdat+0x178/0x1f0
 [<c01423c7>] kswapd+0x112/0x122
 [<c011dfbb>] autoremove_wake_function+0x0/0x4f
 [<c02a709e>] ret_from_fork+0x6/0x14
 [<c011dfbb>] autoremove_wake_function+0x0/0x4f
 [<c01422b5>] kswapd+0x0/0x122
 [<c0109255>] kernel_thread_helper+0x5/0xb

 <6>note: kswapd0[7] exited with preempt_count 1
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Unable to handle kernel paging request at virtual address 02ccc029
 printing eip:
c016418b
*pde = 00000000
Oops: 0000 [#2]
PREEMPT 
CPU:    0
EIP:    0060:[<c016418b>]    Not tainted VLI
EFLAGS: 00210202
EIP is at poll_freewait+0xe/0x40
eax: 00000000   ebx: c08eb008   ecx: c10164b8   edx: c1014e40
esi: c08eb008   edi: 02ccc025   ebp: c8e39fa0   esp: c8e39f68
ds: 007b   es: 007b   ss: 0068
Process xfce4-panel (pid: 3534, threadinfo=c8e38000 task=c95106c0)
Stack: 00000000 cec18d48 00000000 c0164ec4 c8e39fa0 cec18d40 c8e39fa0 000001c3 
       c8e38000 08104a40 cec18d48 00000000 cec18d40 00000000 c01641bd c08eb000 
       00000000 3ffe0211 08104a38 0806ff40 4079af30 c8e38000 c02a71bb 08104a40 
Call Trace:
 [<c0164ec4>] sys_poll+0x242/0x28e
 [<c01641bd>] __pollwait+0x0/0xc6
 [<c02a71bb>] syscall_call+0x7/0xb
 [<c02a007b>] tcp_v6_rcv+0x552/0x733

Code: ff ff 90 90 8b 44 24 04 c7 00 bd 41 16 c0 c7 40 08 00 00 00 00 c7 40 04 00 00 00 00 c3 57 56 53 8b 44 24 10 8b 78 04 85 ff 74 2e <8b> 5f 04 8d 77 08 83 eb 1c 8d 53 04 8b 43 18 e8 19 9c fb ff 8b 
Badness in unblank_screen at drivers/char/vt.c:2793
Call Trace:
 [<c01eacff>] unblank_screen+0x126/0x12b
 [<c011a5b8>] bust_spinlocks+0x2c/0x54
 [<c010b5a6>] die+0x98/0xfd
 [<c011aa10>] do_page_fault+0x1d8/0x50c
 [<c013b39c>] __alloc_pages+0x9c/0x325
 [<c011c671>] schedule+0x354/0x5b2
 [<c0127d59>] schedule_timeout+0x6d/0xb7
 [<c02338fc>] sock_poll+0x29/0x31
 [<c011a838>] do_page_fault+0x0/0x50c
 [<c02a7bc7>] error_code+0x2f/0x38
 [<c016418b>] poll_freewait+0xe/0x40
 [<c0164ec4>] sys_poll+0x242/0x28e
 [<c01641bd>] __pollwait+0x0/0xc6
 [<c02a71bb>] syscall_call+0x7/0xb
 [<c02a007b>] tcp_v6_rcv+0x552/0x733

 <4>atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

--IS0zKkzwUGydFO0o--
