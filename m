Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTAQAFW>; Thu, 16 Jan 2003 19:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbTAQAFW>; Thu, 16 Jan 2003 19:05:22 -0500
Received: from [200.82.34.148] ([200.82.34.148]:24489 "EHLO
	prod1.trimaxcba.com") by vger.kernel.org with ESMTP
	id <S267337AbTAQAFN>; Thu, 16 Jan 2003 19:05:13 -0500
Date: Thu, 16 Jan 2003 21:14:04 -0300
From: Horacio de Oro <hgdeoro@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: oops 2.5.58-mm1while 'apt-get dselect-upgrade'
Message-Id: <20030116211404.208da8ed.hgdeoro@yahoo.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I was on a 'apt-get dselect-upgrade', and the
system locked up.


Jan 16 17:27:28 corralito kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000514
Jan 16 17:27:28 corralito kernel:  printing eip:
Jan 16 17:27:28 corralito kernel: c0121db1
Jan 16 17:27:28 corralito kernel: *pde = 00000000
Jan 16 17:27:28 corralito kernel: Oops: 0000
Jan 16 17:27:28 corralito kernel: CPU:    0
Jan 16 17:27:28 corralito kernel: EIP:    0060:[recalc_sigpending+65/128]    Not tainted
Jan 16 17:27:28 corralito kernel: EFLAGS: 00010046
Jan 16 17:27:28 corralito kernel: EIP is at recalc_sigpending+0x41/0x80
Jan 16 17:27:28 corralito kernel: eax: 00000000   ebx: 00000000   ecx: cefa3240   edx: 00000000
Jan 16 17:27:28 corralito kernel: esi: 00000000   edi: c6504000   ebp: c6504000   esp: c6505f98
Jan 16 17:27:28 corralito kernel: ds: 007b   es: 007b   ss: 0068
Jan 16 17:27:28 corralito kernel: Process pdflush (pid: 1816, threadinfo=c6504000 task=cefa3240)
Jan 16 17:27:28 corralito kernel: Stack: c6505fd0 c034350e cefa3522 c0131e0b c011b938 00000000 cefa3240 cefa3240 
Jan 16 17:27:28 corralito kernel:        c0131fe0 00000000 00000000 00000000 c0131fef c6505fd0 00000000 00000000 
Jan 16 17:27:28 corralito kernel:        00000000 00000000 0000007b 0000007b ffffffff c0107148 c010714d 00000000 
Jan 16 17:27:28 corralito kernel: Call Trace:
Jan 16 17:27:28 corralito kernel:  [__pdflush+75/544] __pdflush+0x4b/0x220
Jan 16 17:27:28 corralito kernel:  [sys_exit_group+152/160] sys_exit_group+0x98/0xa0
Jan 16 17:27:28 corralito kernel:  [pdflush+0/32] pdflush+0x0/0x20
Jan 16 17:27:28 corralito kernel:  [pdflush+15/32] pdflush+0xf/0x20
Jan 16 17:27:28 corralito kernel:  [kernel_thread_helper+0/24] kernel_thread_helper+0x0/0x18
Jan 16 17:27:28 corralito kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Jan 16 17:27:28 corralito kernel: 
Jan 16 17:27:28 corralito kernel: Code: 23 b0 14 05 00 00 23 98 10 05 00 00 09 de 74 18 b8 02 00 00 
Jan 16 17:27:28 corralito kernel:  <6>note: pdflush[1816] exited with preempt_count 1
Jan 16 17:27:28 corralito kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000518
Jan 16 17:27:28 corralito kernel:  printing eip:
Jan 16 17:27:28 corralito kernel: c011bcb2
Jan 16 17:27:28 corralito kernel: *pde = 00000000
Jan 16 17:27:28 corralito kernel: Oops: 0000
Jan 16 17:27:28 corralito kernel: CPU:    0
Jan 16 17:27:28 corralito kernel: EIP:    0060:[sys_wait4+690/1216]    Not tainted
Jan 16 17:27:28 corralito kernel: EFLAGS: 00010286
Jan 16 17:27:28 corralito kernel: EIP is at sys_wait4+0x2b2/0x4c0
Jan 16 17:27:28 corralito kernel: eax: 00000000   ebx: cefa4000   ecx: 00000000   edx: 00000008
Jan 16 17:27:28 corralito kernel: esi: 00000000   edi: cefa3240   ebp: bffff728   esp: cefa5f4c
Jan 16 17:27:28 corralito kernel: ds: 007b   es: 007b   ss: 0068
Jan 16 17:27:28 corralito kernel: Process init (pid: 1, threadinfo=cefa4000 task=cefa2040)
Jan 16 17:27:28 corralito kernel: Stack: ffffffff 00000001 cefa3240 cefa20dc cefa4000 cefa4000 cefa4000 cefa4000 
Jan 16 17:27:28 corralito kernel:        00000001 00000000 cefa2040 c0116450 00000000 00000000 00000001 cedf5f00 
Jan 16 17:27:28 corralito kernel:        00001310 00000000 cefa2040 c0116450 cefa2190 cefa2190 cefa5fc4 00000000 
Jan 16 17:27:28 corralito kernel: Call Trace:
Jan 16 17:27:28 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:28 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:28 corralito kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 16 17:27:28 corralito kernel: 
Jan 16 17:27:28 corralito kernel: Code: 8b 99 18 05 00 00 85 db 0f 84 a0 00 00 00 b8 00 e0 ff ff 8b 
Jan 16 17:27:28 corralito kernel:  <0>Kernel panic: Attempted to kill init!

At this point, the CPU was at 100% processor usage: 100% system, 0% user
(i use an applet that show me user/system processor usage).

I waited some seconds, and do a SysRq+S, and I supouse it
produce this (see the system time, now it is 17:27:54):

Jan 16 17:27:54 corralito kernel:  <1>Unable to handle kernel paging request at virtual address 00017c84
Jan 16 17:27:54 corralito kernel:  printing eip:
Jan 16 17:27:54 corralito kernel: c013207b
Jan 16 17:27:54 corralito kernel: *pde = 00000000
Jan 16 17:27:54 corralito kernel: Oops: 0002
Jan 16 17:27:54 corralito kernel: CPU:    0
Jan 16 17:27:54 corralito kernel: EIP:    0060:[pdflush_operation+123/208]    Not tainted
Jan 16 17:27:54 corralito kernel: EFLAGS: 00010006
Jan 16 17:27:54 corralito kernel: EIP is at pdflush_operation+0x7b/0xd0
Jan 16 17:27:54 corralito kernel: eax: c48b0fe4   ebx: c162c000   ecx: c6505fdc   edx: 00017c84
Jan 16 17:27:54 corralito kernel: esi: 00000286   edi: c6505fd0   ebp: c0131750   esp: c162de90
Jan 16 17:27:54 corralito kernel: ds: 007b   es: 007b   ss: 0068
Jan 16 17:27:54 corralito kernel: Process dpkg (pid: 1686, threadinfo=c162c000 task=c3808c80)
Jan 16 17:27:54 corralito kernel: Stack: 00000000 c042eb9c c0131870 c038c400 00000000 c0131887 c0131750 00000000 
Jan 16 17:27:54 corralito kernel:        c01219e7 00000000 c162df18 c010ea6d c162c000 c162c000 00000011 c042d908 
Jan 16 17:27:54 corralito kernel:        ffffffdd 00000046 c011d39c c038c400 c162c000 c162c000 00000000 c03d5900 
Jan 16 17:27:54 corralito kernel: Call Trace:
Jan 16 17:27:54 corralito kernel:  [wb_timer_fn+0/64] wb_timer_fn+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [wb_timer_fn+23/64] wb_timer_fn+0x17/0x40
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [__run_timers+119/336] __run_timers+0x77/0x150
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [do_softirq+156/160] do_softirq+0x9c/0xa0
Jan 16 17:27:54 corralito kernel:  [do_IRQ+252/288] do_IRQ+0xfc/0x120
Jan 16 17:27:54 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 16 17:27:54 corralito kernel:  [sys_wait4+241/1216] sys_wait4+0xf1/0x4c0
Jan 16 17:27:54 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [sys_rmdir+207/272] sys_rmdir+0xcf/0x110
Jan 16 17:27:54 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 16 17:27:54 corralito kernel: 
Jan 16 17:27:54 corralito kernel: Code: 89 02 89 50 04 89 09 81 3d f8 e1 38 c0 f8 e1 38 c0 89 49 04 
Jan 16 17:27:54 corralito kernel:  <0>Kernel panic: Aiee, killing interrupt handler!
Jan 16 17:27:54 corralito kernel: In interrupt handler - not syncing
Jan 16 17:27:54 corralito kernel:  <6>SysRq : Emergency Sync
Jan 16 17:27:54 corralito kernel: Unable to handle kernel paging request at virtual address 00017c84
Jan 16 17:27:54 corralito kernel:  printing eip:
Jan 16 17:27:54 corralito kernel: c013207b
Jan 16 17:27:54 corralito kernel: *pde = 00000000
Jan 16 17:27:54 corralito kernel: Oops: 0002
Jan 16 17:27:54 corralito kernel: CPU:    0
Jan 16 17:27:54 corralito kernel: EIP:    0060:[pdflush_operation+123/208]    Not tainted
Jan 16 17:27:54 corralito kernel: EFLAGS: 00010006
Jan 16 17:27:54 corralito kernel: EIP is at pdflush_operation+0x7b/0xd0
Jan 16 17:27:54 corralito kernel: eax: c48b0fe4   ebx: c162c000   ecx: c6505fdc   edx: 00017c84
Jan 16 17:27:54 corralito kernel: esi: 00000286   edi: c6505fd0   ebp: c0131600   esp: c162da54
Jan 16 17:27:54 corralito kernel: ds: 007b   es: 007b   ss: 0068
Jan 16 17:27:54 corralito kernel: Process dpkg (pid: 1686, threadinfo=c162c000 task=c3808c80)
Jan 16 17:27:54 corralito kernel: Stack: 00000000 c039d034 00000073 0000000f 00000001 c0131731 c0131600 00000425 
Jan 16 17:27:54 corralito kernel:        00000425 00000000 000083f1 000000c2 0000ca95 00007382 000009c5 00000000 
Jan 16 17:27:54 corralito kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Jan 16 17:27:54 corralito kernel: Call Trace:
Jan 16 17:27:54 corralito kernel:  [wakeup_bdflush+33/64] wakeup_bdflush+0x21/0x40
Jan 16 17:27:54 corralito kernel:  [background_writeout+0/272] background_writeout+0x0/0x110
Jan 16 17:27:54 corralito kernel:  [__handle_sysrq_nolock+115/240] __handle_sysrq_nolock+0x73/0xf0
Jan 16 17:27:54 corralito kernel:  [handle_sysrq+74/96] handle_sysrq+0x4a/0x60
Jan 16 17:27:54 corralito kernel:  [kbd_keycode+648/784] kbd_keycode+0x288/0x310
Jan 16 17:27:54 corralito kernel:  [kbd_event+34/80] kbd_event+0x22/0x50
Jan 16 17:27:54 corralito kernel:  [input_event+221/864] input_event+0xdd/0x360
Jan 16 17:27:54 corralito kernel:  [atkbd_interrupt+261/528] atkbd_interrupt+0x105/0x210
Jan 16 17:27:54 corralito kernel:  [serio_interrupt+78/80] serio_interrupt+0x4e/0x50
Jan 16 17:27:54 corralito kernel:  [i8042_interrupt+254/528] i8042_interrupt+0xfe/0x210
Jan 16 17:27:54 corralito kernel:  [release_console_sem+200/208] release_console_sem+0xc8/0xd0
Jan 16 17:27:54 corralito kernel:  [rcu_check_callbacks+61/112] rcu_check_callbacks+0x3d/0x70
Jan 16 17:27:54 corralito kernel:  [scheduler_tick+896/912] scheduler_tick+0x380/0x390
Jan 16 17:27:54 corralito kernel:  [update_process_times+70/96] update_process_times+0x46/0x60
Jan 16 17:27:54 corralito kernel:  [update_wall_time+11/64] update_wall_time+0xb/0x40
Jan 16 17:27:54 corralito kernel:  [do_timer+235/256] do_timer+0xeb/0x100
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0x38/0x60
Jan 16 17:27:54 corralito kernel:  [rcu_check_callbacks+61/112] rcu_check_callbacks+0x3d/0x70
Jan 16 17:27:54 corralito kernel:  [scheduler_tick+896/912] scheduler_tick+0x380/0x390
Jan 16 17:27:54 corralito kernel:  [do_IRQ+259/288] do_IRQ+0x103/0x120
Jan 16 17:27:54 corralito kernel:  [update_process_times+70/96] update_process_times+0x46/0x60
Jan 16 17:27:54 corralito kernel:  [update_wall_time+11/64] update_wall_time+0xb/0x40
Jan 16 17:27:54 corralito kernel:  [do_timer+235/256] do_timer+0xeb/0x100
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0x38/0x60
Jan 16 17:27:54 corralito kernel:  [do_IRQ+151/288] do_IRQ+0x97/0x120
Jan 16 17:27:54 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 16 17:27:54 corralito kernel:  [panic+215/272] panic+0xd7/0x110
Jan 16 17:27:54 corralito kernel:  [do_exit+675/704] do_exit+0x2a3/0x2c0
Jan 16 17:27:54 corralito kernel:  [die+133/144] die+0x85/0x90
Jan 16 17:27:54 corralito kernel:  [do_page_fault+330/1111] do_page_fault+0x14a/0x457
Jan 16 17:27:54 corralito kernel:  [try_to_wake_up+283/304] try_to_wake_up+0x11b/0x130
Jan 16 17:27:54 corralito kernel:  [wake_up_process+22/32] wake_up_process+0x16/0x20
Jan 16 17:27:54 corralito kernel:  [deliver_signal+121/144] deliver_signal+0x79/0x90
Jan 16 17:27:54 corralito kernel:  [specific_send_sig_info+231/464] specific_send_sig_info+0xe7/0x1d0
Jan 16 17:27:54 corralito kernel:  [do_page_fault+0/1111] do_page_fault+0x0/0x457
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [pdflush_operation+123/208] pdflush_operation+0x7b/0xd0
Jan 16 17:27:54 corralito kernel:  [wb_timer_fn+0/64] wb_timer_fn+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [wb_timer_fn+23/64] wb_timer_fn+0x17/0x40
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [__run_timers+119/336] __run_timers+0x77/0x150
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [do_softirq+156/160] do_softirq+0x9c/0xa0
Jan 16 17:27:54 corralito kernel:  [do_IRQ+252/288] do_IRQ+0xfc/0x120
Jan 16 17:27:54 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 16 17:27:54 corralito kernel:  [sys_wait4+241/1216] sys_wait4+0xf1/0x4c0
Jan 16 17:27:54 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [sys_rmdir+207/272] sys_rmdir+0xcf/0x110
Jan 16 17:27:54 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 16 17:27:54 corralito kernel: 
Jan 16 17:27:54 corralito kernel: Code: 89 02 89 50 04 89 09 81 3d f8 e1 38 c0 f8 e1 38 c0 89 49 04 
Jan 16 17:27:54 corralito kernel:  <0>Kernel panic: Aiee, killing interrupt handler!
Jan 16 17:27:54 corralito kernel: In interrupt handler - not syncing
Jan 16 17:27:54 corralito kernel:  <6>Syncing device ide0(3,6) ... <3>bad: scheduling while atomic!
Jan 16 17:27:54 corralito kernel: Call Trace:
Jan 16 17:27:54 corralito kernel:  [do_schedule+753/768] do_schedule+0x2f1/0x300
Jan 16 17:27:54 corralito kernel:  [__wait_on_buffer+186/192] __wait_on_buffer+0xba/0xc0
Jan 16 17:27:54 corralito kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Jan 16 17:27:54 corralito kernel:  [lookup_bh_lru+100/160] lookup_bh_lru+0x64/0xa0
Jan 16 17:27:54 corralito kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Jan 16 17:27:54 corralito kernel:  [flush_commit_list+913/1168] flush_commit_list+0x391/0x490
Jan 16 17:27:54 corralito kernel:  [do_journal_end+1517/3136] do_journal_end+0x5ed/0xc40
Jan 16 17:27:54 corralito kernel:  [flush_old_commits+310/464] flush_old_commits+0x136/0x1d0
Jan 16 17:27:54 corralito kernel:  [reiserfs_write_super+83/96] reiserfs_write_super+0x53/0x60
Jan 16 17:27:54 corralito kernel:  [fsync_super+166/176] fsync_super+0xa6/0xb0
Jan 16 17:27:54 corralito kernel:  [fsync_bdev+37/96] fsync_bdev+0x25/0x60
Jan 16 17:27:54 corralito kernel:  [go_sync+364/368] go_sync+0x16c/0x170
Jan 16 17:27:54 corralito kernel:  [do_emergency_sync+220/240] do_emergency_sync+0xdc/0xf0
Jan 16 17:27:54 corralito kernel:  [panic+224/272] panic+0xe0/0x110
Jan 16 17:27:54 corralito kernel:  [do_exit+675/704] do_exit+0x2a3/0x2c0
Jan 16 17:27:54 corralito kernel:  [die+133/144] die+0x85/0x90
Jan 16 17:27:54 corralito kernel:  [do_page_fault+330/1111] do_page_fault+0x14a/0x457
Jan 16 17:27:54 corralito kernel:  [deliver_signal+131/144] deliver_signal+0x83/0x90
Jan 16 17:27:54 corralito kernel:  [ignored_signal+57/80] ignored_signal+0x39/0x50
Jan 16 17:27:54 corralito kernel:  [specific_send_sig_info+178/464] specific_send_sig_info+0xb2/0x1d0
Jan 16 17:27:54 corralito kernel:  [__send_sig_info+333/368] __send_sig_info+0x14d/0x170
Jan 16 17:27:54 corralito kernel:  [send_sig_info+94/96] send_sig_info+0x5e/0x60
Jan 16 17:27:54 corralito kernel:  [send_sigio_to_task+242/304] send_sigio_to_task+0xf2/0x130
Jan 16 17:27:54 corralito kernel:  [do_page_fault+0/1111] do_page_fault+0x0/0x457
Jan 16 17:27:54 corralito kernel:  [background_writeout+0/272] background_writeout+0x0/0x110
Jan 16 17:27:54 corralito kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 16 17:27:54 corralito kernel:  [background_writeout+0/272] background_writeout+0x0/0x110
Jan 16 17:27:54 corralito kernel:  [pdflush_operation+123/208] pdflush_operation+0x7b/0xd0
Jan 16 17:27:54 corralito kernel:  [wakeup_bdflush+33/64] wakeup_bdflush+0x21/0x40
Jan 16 17:27:54 corralito kernel:  [background_writeout+0/272] background_writeout+0x0/0x110
Jan 16 17:27:54 corralito kernel:  [__handle_sysrq_nolock+115/240] __handle_sysrq_nolock+0x73/0xf0
Jan 16 17:27:54 corralito kernel:  [handle_sysrq+74/96] handle_sysrq+0x4a/0x60
Jan 16 17:27:54 corralito kernel:  [kbd_keycode+648/784] kbd_keycode+0x288/0x310
Jan 16 17:27:54 corralito kernel:  [kbd_event+34/80] kbd_event+0x22/0x50
Jan 16 17:27:54 corralito kernel:  [input_event+221/864] input_event+0xdd/0x360
Jan 16 17:27:54 corralito kernel:  [atkbd_interrupt+261/528] atkbd_interrupt+0x105/0x210
Jan 16 17:27:54 corralito kernel:  [serio_interrupt+78/80] serio_interrupt+0x4e/0x50
Jan 16 17:27:54 corralito kernel:  [i8042_interrupt+254/528] i8042_interrupt+0xfe/0x210
Jan 16 17:27:54 corralito kernel:  [release_console_sem+200/208] release_console_sem+0xc8/0xd0
Jan 16 17:27:54 corralito kernel:  [rcu_check_callbacks+61/112] rcu_check_callbacks+0x3d/0x70
Jan 16 17:27:54 corralito kernel:  [scheduler_tick+896/912] scheduler_tick+0x380/0x390
Jan 16 17:27:54 corralito kernel:  [update_process_times+70/96] update_process_times+0x46/0x60
Jan 16 17:27:54 corralito kernel:  [update_wall_time+11/64] update_wall_time+0xb/0x40
Jan 16 17:27:54 corralito kernel:  [do_timer+235/256] do_timer+0xeb/0x100
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0x38/0x60
Jan 16 17:27:54 corralito kernel:  [rcu_check_callbacks+61/112] rcu_check_callbacks+0x3d/0x70
Jan 16 17:27:54 corralito kernel:  [scheduler_tick+896/912] scheduler_tick+0x380/0x390
Jan 16 17:27:54 corralito kernel:  [do_IRQ+259/288] do_IRQ+0x103/0x120
Jan 16 17:27:54 corralito kernel:  [update_process_times+70/96] update_process_times+0x46/0x60
Jan 16 17:27:54 corralito kernel:  [update_wall_time+11/64] update_wall_time+0xb/0x40
Jan 16 17:27:54 corralito kernel:  [do_timer+235/256] do_timer+0xeb/0x100
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0x38/0x60
Jan 16 17:27:54 corralito kernel:  [do_IRQ+151/288] do_IRQ+0x97/0x120
Jan 16 17:27:54 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 16 17:27:54 corralito kernel:  [panic+215/272] panic+0xd7/0x110
Jan 16 17:27:54 corralito kernel:  [do_exit+675/704] do_exit+0x2a3/0x2c0
Jan 16 17:27:54 corralito kernel:  [die+133/144] die+0x85/0x90
Jan 16 17:27:54 corralito kernel:  [do_page_fault+330/1111] do_page_fault+0x14a/0x457
Jan 16 17:27:54 corralito kernel:  [try_to_wake_up+283/304] try_to_wake_up+0x11b/0x130
Jan 16 17:27:54 corralito kernel:  [wake_up_process+22/32] wake_up_process+0x16/0x20
Jan 16 17:27:54 corralito kernel:  [deliver_signal+121/144] deliver_signal+0x79/0x90
Jan 16 17:27:54 corralito kernel:  [specific_send_sig_info+231/464] specific_send_sig_info+0xe7/0x1d0
Jan 16 17:27:54 corralito kernel:  [do_page_fault+0/1111] do_page_fault+0x0/0x457
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [pdflush_operation+123/208] pdflush_operation+0x7b/0xd0
Jan 16 17:27:54 corralito kernel:  [wb_timer_fn+0/64] wb_timer_fn+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [wb_timer_fn+23/64] wb_timer_fn+0x17/0x40
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [__run_timers+119/336] __run_timers+0x77/0x150
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [do_softirq+156/160] do_softirq+0x9c/0xa0
Jan 16 17:27:54 corralito kernel:  [do_IRQ+252/288] do_IRQ+0xfc/0x120
Jan 16 17:27:54 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 16 17:27:54 corralito kernel:  [sys_wait4+241/1216] sys_wait4+0xf1/0x4c0
Jan 16 17:27:54 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [sys_rmdir+207/272] sys_rmdir+0xcf/0x110
Jan 16 17:27:54 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 16 17:27:54 corralito kernel: 
Jan 16 17:27:54 corralito kernel: bad: scheduling while atomic!
Jan 16 17:27:54 corralito kernel: Call Trace:
Jan 16 17:27:54 corralito kernel:  [do_schedule+753/768] do_schedule+0x2f1/0x300
Jan 16 17:27:54 corralito kernel:  [__wait_on_buffer+186/192] __wait_on_buffer+0xba/0xc0
Jan 16 17:27:54 corralito kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Jan 16 17:27:54 corralito kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Jan 16 17:27:54 corralito kernel:  [flush_commit_list+758/1168] flush_commit_list+0x2f6/0x490
Jan 16 17:27:54 corralito kernel:  [do_journal_end+1517/3136] do_journal_end+0x5ed/0xc40
Jan 16 17:27:54 corralito kernel:  [flush_old_commits+310/464] flush_old_commits+0x136/0x1d0
Jan 16 17:27:54 corralito kernel:  [reiserfs_write_super+83/96] reiserfs_write_super+0x53/0x60
Jan 16 17:27:54 corralito kernel:  [fsync_super+166/176] fsync_super+0xa6/0xb0
Jan 16 17:27:54 corralito kernel:  [fsync_bdev+37/96] fsync_bdev+0x25/0x60
Jan 16 17:27:54 corralito kernel:  [go_sync+364/368] go_sync+0x16c/0x170
Jan 16 17:27:54 corralito kernel:  [do_emergency_sync+220/240] do_emergency_sync+0xdc/0xf0
Jan 16 17:27:54 corralito kernel:  [panic+224/272] panic+0xe0/0x110
Jan 16 17:27:54 corralito kernel:  [do_exit+675/704] do_exit+0x2a3/0x2c0
Jan 16 17:27:54 corralito kernel:  [die+133/144] die+0x85/0x90
Jan 16 17:27:54 corralito kernel:  [do_page_fault+330/1111] do_page_fault+0x14a/0x457
Jan 16 17:27:54 corralito kernel:  [deliver_signal+131/144] deliver_signal+0x83/0x90
Jan 16 17:27:54 corralito kernel:  [ignored_signal+57/80] ignored_signal+0x39/0x50
Jan 16 17:27:54 corralito kernel:  [specific_send_sig_info+178/464] specific_send_sig_info+0xb2/0x1d0
Jan 16 17:27:54 corralito kernel:  [__send_sig_info+333/368] __send_sig_info+0x14d/0x170
Jan 16 17:27:54 corralito kernel:  [send_sig_info+94/96] send_sig_info+0x5e/0x60
Jan 16 17:27:54 corralito kernel:  [send_sigio_to_task+242/304] send_sigio_to_task+0xf2/0x130
Jan 16 17:27:54 corralito kernel:  [do_page_fault+0/1111] do_page_fault+0x0/0x457
Jan 16 17:27:54 corralito kernel:  [background_writeout+0/272] background_writeout+0x0/0x110
Jan 16 17:27:54 corralito kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 16 17:27:54 corralito kernel:  [background_writeout+0/272] background_writeout+0x0/0x110
Jan 16 17:27:54 corralito kernel:  [pdflush_operation+123/208] pdflush_operation+0x7b/0xd0
Jan 16 17:27:54 corralito kernel:  [wakeup_bdflush+33/64] wakeup_bdflush+0x21/0x40
Jan 16 17:27:54 corralito kernel:  [background_writeout+0/272] background_writeout+0x0/0x110
Jan 16 17:27:54 corralito kernel:  [__handle_sysrq_nolock+115/240] __handle_sysrq_nolock+0x73/0xf0
Jan 16 17:27:54 corralito kernel:  [handle_sysrq+74/96] handle_sysrq+0x4a/0x60
Jan 16 17:27:54 corralito kernel:  [kbd_keycode+648/784] kbd_keycode+0x288/0x310
Jan 16 17:27:54 corralito kernel:  [kbd_event+34/80] kbd_event+0x22/0x50
Jan 16 17:27:54 corralito kernel:  [input_event+221/864] input_event+0xdd/0x360
Jan 16 17:27:54 corralito kernel:  [atkbd_interrupt+261/528] atkbd_interrupt+0x105/0x210
Jan 16 17:27:54 corralito kernel:  [serio_interrupt+78/80] serio_interrupt+0x4e/0x50
Jan 16 17:27:54 corralito kernel:  [i8042_interrupt+254/528] i8042_interrupt+0xfe/0x210
Jan 16 17:27:54 corralito kernel:  [release_console_sem+200/208] release_console_sem+0xc8/0xd0
Jan 16 17:27:54 corralito kernel:  [rcu_check_callbacks+61/112] rcu_check_callbacks+0x3d/0x70
Jan 16 17:27:54 corralito kernel:  [scheduler_tick+896/912] scheduler_tick+0x380/0x390
Jan 16 17:27:54 corralito kernel:  [update_process_times+70/96] update_process_times+0x46/0x60
Jan 16 17:27:54 corralito kernel:  [update_wall_time+11/64] update_wall_time+0xb/0x40
Jan 16 17:27:54 corralito kernel:  [do_timer+235/256] do_timer+0xeb/0x100
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0x38/0x60
Jan 16 17:27:54 corralito kernel:  [rcu_check_callbacks+61/112] rcu_check_callbacks+0x3d/0x70
Jan 16 17:27:54 corralito kernel:  [scheduler_tick+896/912] scheduler_tick+0x380/0x390
Jan 16 17:27:54 corralito kernel:  [do_IRQ+259/288] do_IRQ+0x103/0x120
Jan 16 17:27:54 corralito kernel:  [update_process_times+70/96] update_process_times+0x46/0x60
Jan 16 17:27:54 corralito kernel:  [update_wall_time+11/64] update_wall_time+0xb/0x40
Jan 16 17:27:54 corralito kernel:  [do_timer+235/256] do_timer+0xeb/0x100
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0x38/0x60
Jan 16 17:27:54 corralito kernel:  [do_IRQ+151/288] do_IRQ+0x97/0x120
Jan 16 17:27:54 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 16 17:27:54 corralito kernel:  [panic+215/272] panic+0xd7/0x110
Jan 16 17:27:54 corralito kernel:  [do_exit+675/704] do_exit+0x2a3/0x2c0
Jan 16 17:27:54 corralito kernel:  [die+133/144] die+0x85/0x90
Jan 16 17:27:54 corralito kernel:  [do_page_fault+330/1111] do_page_fault+0x14a/0x457
Jan 16 17:27:54 corralito kernel:  [try_to_wake_up+283/304] try_to_wake_up+0x11b/0x130
Jan 16 17:27:54 corralito kernel:  [wake_up_process+22/32] wake_up_process+0x16/0x20
Jan 16 17:27:54 corralito kernel:  [deliver_signal+121/144] deliver_signal+0x79/0x90
Jan 16 17:27:54 corralito kernel:  [specific_send_sig_info+231/464] specific_send_sig_info+0xe7/0x1d0
Jan 16 17:27:54 corralito kernel:  [do_page_fault+0/1111] do_page_fault+0x0/0x457
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [pdflush_operation+123/208] pdflush_operation+0x7b/0xd0
Jan 16 17:27:54 corralito kernel:  [wb_timer_fn+0/64] wb_timer_fn+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [wb_timer_fn+23/64] wb_timer_fn+0x17/0x40
Jan 16 17:27:54 corralito kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Jan 16 17:27:54 corralito kernel:  [__run_timers+119/336] __run_timers+0x77/0x150
Jan 16 17:27:54 corralito kernel:  [timer_interrupt+45/304] timer_interrupt+0x2d/0x130
Jan 16 17:27:54 corralito kernel:  [do_softirq+156/160] do_softirq+0x9c/0xa0
Jan 16 17:27:54 corralito kernel:  [do_IRQ+252/288] do_IRQ+0xfc/0x120
Jan 16 17:27:54 corralito kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 16 17:27:54 corralito kernel:  [sys_wait4+241/1216] sys_wait4+0xf1/0x4c0
Jan 16 17:27:54 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [sys_rmdir+207/272] sys_rmdir+0xcf/0x110
Jan 16 17:27:54 corralito kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Jan 16 17:27:54 corralito kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
... and a lot more of this (arround 200kb!!!)

I could send you the full report taken from syslog (294kb),
and any information that you think could be usefull.
I've no tried any other kernel of the 2.5 serie before
this, so, I don't know if this problem exist with plain 2.5.58
or an older kernel.

By the way, the kernel was compiled with no module support. Compiling with
module support give me lot of 'Unresolved symbols' at 'make modules_install',
for example (I've included the errors of 2 modules, but I could send you
all the errors from all the modules):

depmod: *** Unresolved symbols in /lib/modules/2.5.58-mm1/kernel/drivers/cdrom/cdrom.ko
depmod: 	_mmx_memcpy
depmod: 	invalidate_bdev
depmod: 	__copy_to_user_ll
depmod: 	check_disk_change
depmod: 	kmalloc
depmod: 	proc_dostring
depmod: 	scsi_cmd_ioctl
depmod: 	proc_dointvec
depmod: 	unregister_sysctl_table
depmod: 	kfree
depmod: 	__copy_from_user_ll
depmod: 	sprintf
depmod: 	printk
depmod: 	register_sysctl_table
depmod: *** Unresolved symbols in /lib/modules/2.5.58-mm1/kernel/drivers/block/loop.ko
depmod: 	bio_endio
depmod: 	preempt_schedule
depmod: 	flush_signals
depmod: 	_mmx_memcpy
depmod: 	balance_dirty_pages_ratelimited
depmod: 	alloc_disk
...


Almost all the modules give me errors!


My system:

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      2.4.21
e2fsprogs              1.32
pcmcia-cs              3.2.2
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.4



processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : mobile AMD Duron(tm) Processor
stepping        : 0
cpu MHz         : 946.722
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr
                  pge mca cmov pat pse36 mmx fxsr sse syscall
                  mmxext 3dnowext 3dnow
bogomips        : 1887.43


.config:

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT_14=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_PREEMPT=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_CPU_FREQ=y
CONFIG_X86_POWERNOW_K6=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_PPP=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_RTC=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_ZISOFS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VIA82XX=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y


Thanks to all the developers for this excelent software!!!!
(and sorry for my poor english)

Horacio de Oro

