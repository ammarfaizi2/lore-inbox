Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbTGLK6D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 06:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbTGLK6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 06:58:03 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:13184 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S265675AbTGLK55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 06:57:57 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.75 slab corruption
Date: Sat, 12 Jul 2003 13:13:28 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307121313.29192.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry disturbing,

But I have also slab corruption in 2.5.75...

Regards.

Nicolas.


In /var/log/kernel/warning

Jul 12 11:27:41 hal9003 kernel:  printing eip:
Jul 12 11:27:41 hal9003 kernel: 80116ef1
Jul 12 11:27:41 hal9003 kernel: Oops: 0000 [#1]
Jul 12 11:27:41 hal9003 kernel: CPU:    0
Jul 12 11:27:41 hal9003 kernel: EIP:    0060:[<80116ef1>]    Not tainted
Jul 12 11:27:41 hal9003 kernel: EFLAGS: 00010047
Jul 12 11:27:41 hal9003 kernel: EIP is at 0x80116ef1
Jul 12 11:27:41 hal9003 kernel: eax: 00000088   ebx: f05a273c   ecx: c02e00c0   
edx: 00000027
Jul 12 11:27:41 hal9003 kernel: esi: f7d39380   edi: c02de788   ebp: f3049fbc   
esp: f3049f9c
Jul 12 11:27:41 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul 12 11:27:41 hal9003 kernel: Process kopete (pid: 4545, threadinfo=f3048000 
task=f59d4180)
Jul 12 11:27:41 hal9003 kernel: Stack: c0147fe4 f1296190 bfff9750 00000002 
f59d4180 00000004 415682e0 00000004
Jul 12 11:27:41 hal9003 kernel:        f3048000 c010900a 00000004 bfff9750 
00000002 415682e0 00000004 bfff96d8
Jul 12 11:27:41 hal9003 kernel:        00000848 c010007b 0000007b 00000092 
4150e9a7 00000073 00000246 bfff96bc
Jul 12 11:27:41 hal9003 kernel: Call Trace:
Jul 12 11:27:41 hal9003 kernel:  [sys_writev+63/93] sys_writev+0x3f/0x5d
Jul 12 11:27:41 hal9003 kernel:  [<c0147fe4>] sys_writev+0x3f/0x5d
Jul 12 11:27:41 hal9003 kernel:  [work_resched+5/22] work_resched+0x5/0x16
Jul 12 11:27:41 hal9003 kernel:  [<c010900a>] work_resched+0x5/0x16
Jul 12 11:27:41 hal9003 kernel:
Jul 12 11:27:41 hal9003 kernel: Code:  Bad EIP value.






Jul 12 12:42:50 hal9003 kernel:  printing eip:
Jul 12 12:42:50 hal9003 kernel: 78116ef1
Jul 12 12:42:50 hal9003 kernel: Oops: 0000 [#2]
Jul 12 12:42:50 hal9003 kernel: CPU:    0
Jul 12 12:42:50 hal9003 kernel: EIP:    0060:[<78116ef1>]    Not tainted
Jul 12 12:42:50 hal9003 kernel: EFLAGS: 00013007
Jul 12 12:42:50 hal9003 kernel: EIP is at 0x78116ef1
Jul 12 12:42:50 hal9003 kernel: eax: 00000088   ebx: f7d75894   ecx: f2ef5000   
edx: 00000fff
Jul 12 12:42:50 hal9003 kernel: esi: e3c95880   edi: c02de788   ebp: f6ea3e58   
esp: f6ea3e38
Jul 12 12:42:50 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul 12 12:42:50 hal9003 kernel: Process X (pid: 1113, threadinfo=f6ea2000 
task=f7d39380)
Jul 12 12:42:50 hal9003 kernel: Stack: 00003246 f6ea3e6c f6ea3e58 00003246 
f7d39380 007f39eb f6ea3e6c 00000018
Jul 12 12:42:50 hal9003 kernel:        f6ea3e94 c0120d27 f6ea3e6c f6ea3e7c 
c028e6d9 c02e3768 c02e3768 007f39eb
Jul 12 12:42:50 hal9003 kernel:        4b87ad6e c0120cc1 f7d39380 c02e2b80 
ee8d2644 00000000 00000000 f6ea3f10
Jul 12 12:42:50 hal9003 kernel: Call Trace:
Jul 12 12:42:50 hal9003 kernel:  [schedule_timeout+90/171] 
schedule_timeout+0x5a/0xab
Jul 12 12:42:50 hal9003 kernel:  [<c0120d27>] schedule_timeout+0x5a/0xab
Jul 12 12:42:50 hal9003 kernel:  [unix_poll+43/153] unix_poll+0x2b/0x99
Jul 12 12:42:50 hal9003 kernel:  [<c028e6d9>] unix_poll+0x2b/0x99
Jul 12 12:42:50 hal9003 kernel:  [process_timeout+0/12] 
process_timeout+0x0/0xc
Jul 12 12:42:50 hal9003 kernel:  [<c0120cc1>] process_timeout+0x0/0xc
Jul 12 12:42:50 hal9003 kernel:  [do_select+324/610] do_select+0x144/0x262
Jul 12 12:42:50 hal9003 kernel:  [<c0157a11>] do_select+0x144/0x262
Jul 12 12:42:50 hal9003 kernel:  [__pollwait+0/169] __pollwait+0x0/0xa9
Jul 12 12:42:50 hal9003 kernel:  [<c0157743>] __pollwait+0x0/0xa9
Jul 12 12:42:50 hal9003 kernel:  [sys_select+744/1310] sys_select+0x2e8/0x51e
Jul 12 12:42:50 hal9003 kernel:  [<c0157e42>] sys_select+0x2e8/0x51e
Jul 12 12:42:50 hal9003 kernel:  [update_wall_time+15/58] 
update_wall_time+0xf/0x3a
Jul 12 12:42:50 hal9003 kernel:  [<c01207f3>] update_wall_time+0xf/0x3a
Jul 12 12:42:50 hal9003 kernel:  [do_timer+223/228] do_timer+0xdf/0xe4
Jul 12 12:42:50 hal9003 kernel:  [<c0120beb>] do_timer+0xdf/0xe4
Jul 12 12:42:50 hal9003 kernel:  [do_gettimeofday+25/144] 
do_gettimeofday+0x19/0x90
Jul 12 12:42:50 hal9003 kernel:  [<c010e6d5>] do_gettimeofday+0x19/0x90
Jul 12 12:42:50 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 12:42:50 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Jul 12 12:42:50 hal9003 kernel:
Jul 12 12:42:50 hal9003 kernel: Code:  Bad EIP value.
Jul 12 12:42:50 hal9003 kernel:  <3>Slab corruption: start=f7d39380, 
expend=f7d3997f, problemat=f7d39380
Jul 12 12:42:50 hal9003 kernel: Call Trace:
Jul 12 12:42:50 hal9003 kernel:  [check_poison_obj+364/428] 
check_poison_obj+0x16c/0x1ac
Jul 12 12:42:50 hal9003 kernel:  [<c0134165>] check_poison_obj+0x16c/0x1ac
Jul 12 12:42:50 hal9003 kernel:  [kmem_cache_alloc+288/344] 
kmem_cache_alloc+0x120/0x158
Jul 12 12:42:50 hal9003 kernel:  [<c01356be>] kmem_cache_alloc+0x120/0x158
Jul 12 12:42:50 hal9003 kernel:  [dup_task_struct+179/241] 
dup_task_struct+0xb3/0xf1
Jul 12 12:42:50 hal9003 kernel:  [<c01183ac>] dup_task_struct+0xb3/0xf1
Jul 12 12:42:50 hal9003 kernel:  [dup_task_struct+179/241] 
dup_task_struct+0xb3/0xf1
Jul 12 12:42:50 hal9003 kernel:  [<c01183ac>] dup_task_struct+0xb3/0xf1
Jul 12 12:42:50 hal9003 kernel:  [copy_process+111/2619] 
copy_process+0x6f/0xa3b
Jul 12 12:42:50 hal9003 kernel:  [<c0118d76>] copy_process+0x6f/0xa3b
Jul 12 12:42:50 hal9003 kernel:  [default_wake_function+0/46] 
default_wake_function+0x0/0x2e
Jul 12 12:42:50 hal9003 kernel:  [<c01170c1>] default_wake_function+0x0/0x2e
Jul 12 12:42:50 hal9003 kernel:  [default_wake_function+0/46] 
default_wake_function+0x0/0x2e
Jul 12 12:42:50 hal9003 kernel:  [<c01170c1>] default_wake_function+0x0/0x2e
Jul 12 12:42:50 hal9003 kernel:  [do_fork+77/348] do_fork+0x4d/0x15c
Jul 12 12:42:50 hal9003 kernel:  [<c011978f>] do_fork+0x4d/0x15c
Jul 12 12:42:50 hal9003 kernel:  [sys_fork+56/60] sys_fork+0x38/0x3c
Jul 12 12:42:50 hal9003 kernel:  [<c01079e4>] sys_fork+0x38/0x3c
Jul 12 12:42:50 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 12:42:50 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Jul 12 12:42:50 hal9003 kernel:
Jul 12 12:42:50 hal9003 kernel: Call Trace:
Jul 12 12:42:50 hal9003 kernel:  [check_poison_obj+364/428] 
check_poison_obj+0x16c/0x1ac
Jul 12 12:42:50 hal9003 kernel:  [<c0134165>] check_poison_obj+0x16c/0x1ac
Jul 12 12:42:50 hal9003 kernel:  [kmem_cache_alloc+288/344] 
kmem_cache_alloc+0x120/0x158
Jul 12 12:42:50 hal9003 kernel:  [<c01356be>] kmem_cache_alloc+0x120/0x158
Jul 12 12:42:50 hal9003 kernel:  [dup_task_struct+179/241] 
dup_task_struct+0xb3/0xf1
Jul 12 12:42:50 hal9003 kernel:  [<c01183ac>] dup_task_struct+0xb3/0xf1
Jul 12 12:42:50 hal9003 kernel:  [dup_task_struct+179/241] 
dup_task_struct+0xb3/0xf1
Jul 12 12:42:50 hal9003 kernel:  [<c01183ac>] dup_task_struct+0xb3/0xf1
Jul 12 12:42:50 hal9003 kernel:  [copy_process+111/2619] 
copy_process+0x6f/0xa3b
Jul 12 12:42:50 hal9003 kernel:  [<c0118d76>] copy_process+0x6f/0xa3b
Jul 12 12:42:50 hal9003 kernel:  [do_fork+77/348] do_fork+0x4d/0x15c
Jul 12 12:42:50 hal9003 kernel:  [<c011978f>] do_fork+0x4d/0x15c
Jul 12 12:42:50 hal9003 kernel:  [sigprocmask+77/174] sigprocmask+0x4d/0xae
Jul 12 12:42:50 hal9003 kernel:  [<c012370b>] sigprocmask+0x4d/0xae
Jul 12 12:42:50 hal9003 kernel:  [sys_fork+56/60] sys_fork+0x38/0x3c
Jul 12 12:42:50 hal9003 kernel:  [<c01079e4>] sys_fork+0x38/0x3c
Jul 12 12:42:50 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 12:42:50 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb


And in /var/log/kernel/error

Jul 12 11:27:41 hal9003 kernel: Unable to handle kernel paging request at 
virtual address 80116ef1
Jul 12 11:27:41 hal9003 kernel: *pde = 00000000
Jul 12 12:42:50 hal9003 kernel: Unable to handle kernel paging request at 
virtual address 78116ef1
Jul 12 12:42:50 hal9003 kernel: *pde = 00000000
Jul 12 12:42:50 hal9003 kernel: Data: 00 00 00 00 
*****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
Jul 12 12:42:50 hal9003 kernel: Next: 01 00 00 00 00 40 B2 F5 09 00 00 00 00 
01 00 00 00 00 00 00 FF FF FF FF 79 00 00 00 78 00 00 00
Jul 12 12:42:50 hal9003 kernel: slab error in check_poison_obj(): cache 
`task_struct': object was modified after freeing
Jul 12 12:42:50 hal9003 kernel: Slab corruption: start=f7d39380, 
expend=f7d3997f, problemat=f7d39380
Jul 12 12:42:50 hal9003 kernel: Data: 00 00 00 00 
*****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
Jul 12 12:42:50 hal9003 kernel: Next: 01 00 00 00 00 40 B2 F5 09 00 00 00 00 
01 00 00 00 00 00 00 FF FF FF FF 79 00 00 00 78 00 00 00
Jul 12 12:42:50 hal9003 kernel: slab error in check_poison_obj(): cache 
`task_struct': object was modified after freeing
Jul 12 12:45:47 hal9003 kernel: e100: eth0 NIC Link is Up 10 Mbps Half duplex


