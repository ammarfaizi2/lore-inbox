Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTFUPim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 11:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbTFUPim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 11:38:42 -0400
Received: from 161.226-200-80.adsl.skynet.be ([80.200.226.161]:53508 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S264891AbTFUPif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 11:38:35 -0400
Message-ID: <3EF47EDA.4000101@trollprod.org>
Date: Sat, 21 Jun 2003 17:50:50 +0200
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7x: processes in D state
References: <3EF0CBCB.4010202@trollprod.org> <20030619060217.GA23774@namesys.com>
In-Reply-To: <20030619060217.GA23774@namesys.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg,

As I can't repoduce the problem, I had to wait for a new freeze.
After 3 days of uptime, 2.5.72 hasn'nt freezed so I decided to reboot 
into 2.5.71.

But the freeze occured during the 2.5.72 shutdown scirpts execution !


Olivier


Shutting down SSH daemon                                              done
Umount SMB File SystemSysRq : Show State

                          free                        sibling
   task             PC    stack   pid father child younger older
init          S 00000001 4294956284     1      0     2               (NOTLB)
Call Trace:
  [<c012a636>] schedule_timeout+0x66/0xc0
  [<c01413ed>] __get_free_pages+0x1d/0x50
  [<c012a5c0>] process_timeout+0x0/0x10
  [<c01735da>] do_select+0x29a/0x320
  [<c017367e>] select_bits_alloc+0x1e/0x20
  [<c01731a0>] __pollwait+0x0/0xc0
  [<c01738ee>] sys_select+0x25e/0x480
  [<c0169612>] sys_stat64+0x32/0x40
  [<c01097f3>] syscall_call+0x7/0xb

migration/0   S 00000000 3780881424     2      1             3       (L-TLB)
Call Trace:
  [<c011e381>] migration_thread+0xd1/0x180
  [<c011e2b0>] migration_thread+0x0/0x180
  [<c01073b5>] kernel_thread_helper+0x5/0x10

ksoftirqd/0   S 00000001 3780874348     3      1             4     2 (L-TLB)
Call Trace:
  [<c0125fef>] ksoftirqd+0xff/0x110
  [<c0125ef0>] ksoftirqd+0x0/0x110
  [<c01073b5>] kernel_thread_helper+0x5/0x10

migration/1   S 00000000 3780868152     4      1             5     3 (L-TLB)

Call Trace:
  [<c011e381>] migration_thread+0xd1/0x180
  [<c011e2b0>] migration_thread+0x0/0x180
  [<c01073b5>] kernel_thread_helper+0x5/0x10

ksoftirqd/1   S 00000000 4294958708     5      1             6     4 (L-TLB)
Call Trace:
  [<c0125fef>] ksoftirqd+0xff/0x110
  [<c0125ef0>] ksoftirqd+0x0/0x110
  [<c01073b5>] kernel_thread_helper+0x5/0x10

events/0      S 00000001 4294950984     6      1             7     5 (L-TLB)
Call Trace:
  [<c0132687>] worker_thread+0x2c7/0x380
  [<c021fa90>] batch_entropy_process+0x0/0xd0
  [<c011c380>] default_wake_function+0x0/0x30
  [<c0109706>] ret_from_fork+0x6/0x14
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01323c0>] worker_thread+0x0/0x380
  [<c01073b5>] kernel_thread_helper+0x5/0x10

events/1      S DFFCBED0 4294945244     7      1             8     6 (L-TLB)
Call Trace:
  [<c0132687>] worker_thread+0x2c7/0x380
  [<c023f1c0>] blk_unplug_work+0x0/0x20
  [<c011c380>] default_wake_function+0x0/0x30
  [<c0109706>] ret_from_fork+0x6/0x14
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01323c0>] worker_thread+0x0/0x380
  [<c01073b5>] kernel_thread_helper+0x5/0x10

kirqd         S 00000001 512372740     8      1             9     7 (L-TLB)
Call Trace:
  [<c012a636>] schedule_timeout+0x66/0xc0
  [<c012a5c0>] process_timeout+0x0/0x10
  [<c01185ec>] balanced_irq+0x4c/0x80
  [<c01185a0>] balanced_irq+0x0/0x80
  [<c01073b5>] kernel_thread_helper+0x5/0x10

pdflush       S DFDD9F6C 512366720     9      1            10     8 (L-TLB)
Call Trace:
  [<c01229b6>] reparent_to_init+0x106/0x1a0
  [<c0122cc2>] daemonize+0xd2/0xe0
  [<c0142eb7>] __pdflush+0xc7/0x350
  [<c0143140>] pdflush+0x0/0x20
  [<c0143151>] pdflush+0x11/0x20
  [<c01073b5>] kernel_thread_helper+0x5/0x10

pdflush       D 00000001 4294956740    10      1            11     9 (L-TLB)
Call Trace:
  [<c011cb5e>] sleep_on+0x6e/0x130
  [<c01e3616>] flush_commit_list+0x26/0x440
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01e38ad>] flush_commit_list+0x2bd/0x440
  [<c011c3ea>] __wake_up_common+0x3a/0x60
  [<c01e71e0>] flush_old_commits+0x90/0x1c0
  [<c01b388a>] log_start_commit+0x7a/0x110
  [<c01d4d98>] reiserfs_write_super+0xa8/0xf0
  [<c01652a4>] sync_supers+0x164/0x180
  [<c0142738>] wb_kupdate+0x48/0x160
  [<c011beb4>] schedule+0x114/0x5e0
  [<c0142f52>] __pdflush+0x162/0x350
  [<c0143140>] pdflush+0x0/0x20
  [<c0143151>] pdflush+0x11/0x20
  [<c01426f0>] wb_kupdate+0x0/0x160
  [<c01073b5>] kernel_thread_helper+0x5/0x10

kswapd0       S 00000001 4294950528    11      1            12    10 (L-TLB)
Call Trace:
  [<c014a899>] kswapd+0xd9/0x120
  [<c011ece0>] autoremove_wake_function+0x0/0x50
  [<c011ece0>] autoremove_wake_function+0x0/0x50
  [<c014a7c0>] kswapd+0x0/0x120
  [<c01073b5>] kernel_thread_helper+0x5/0x10

aio/0         S DFE01A74 4294937344    12      1            13    11 (L-TLB)
Call Trace:
  [<c012ef6b>] do_sigaction+0x23b/0x3f0
  [<c0132687>] worker_thread+0x2c7/0x380
  [<c011c380>] default_wake_function+0x0/0x30
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01323c0>] worker_thread+0x0/0x380 [<c01323c0>] worker_thread+0x0/0x380
  [<c01073b5>] kernel_thread_helper+0x5/0x10

aio/1         S 00000001 4294865196    13      1            14    12 (L-TLB)
Call Trace:
  [<c012ef6b>] do_sigaction+0x23b/0x3f0
  [<c0132687>] worker_thread+0x2c7/0x380
  [<c011c380>] default_wake_function+0x0/0x30
  [<c0109706>] ret_from_fork+0x6/0x14
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01323c0>] worker_thread+0x0/0x380
  [<c01073b5>] kernel_thread_helper+0x5/0x10

kseriod       S 00000001 4294383316    14      1            15    13 (L-TLB)
Call Trace:
  [<c027b035>] serio_thread+0xf5/0x190
  [<c011c380>] default_wake_function+0x0/0x30
  [<c027af40>] serio_thread+0x0/0x190
  [<c01073b5>] kernel_thread_helper+0x5/0x10

reiserfs/0    S DFDA0418 4294958448    15      1            16    14 (L-TLB)
Call Trace:
  [<c0132687>] worker_thread+0x2c7/0x380
  [<c01e5810>] reiserfs_journal_commit_task_func+0x0/0x120
  [<c011c380>] default_wake_function+0x0/0x30
  [<c0109706>] ret_from_fork+0x6/0x14
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01323c0>] worker_thread+0x0/0x380
  [<c01073b5>] kernel_thread_helper+0x5/0x10

reiserfs/1    S 00000001 4294951840    16      1           150    15 (L-TLB)
Call Trace:
  [<c0132687>] worker_thread+0x2c7/0x380
  [<c01e5810>] reiserfs_journal_commit_task_func+0x0/0x120
  [<c011c380>] default_wake_function+0x0/0x30
  [<c0109706>] ret_from_fork+0x6/0x14
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01323c0>] worker_thread+0x0/0x380
  [<c01073b5>] kernel_thread_helper+0x5/0x10

kjournald     S 00000001 4292344192   150      1           509    16 (L-TLB)
Call Trace:
  [<c011c3aa>] default_wake_function+0x2a/0x30
  [<c011c8ee>] interruptible_sleep_on+0x6e/0x130
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01b33f1>] kjournald+0x221/0x290
  [<c0150d64>] sys_munmap+0x54/0x70
  [<c01b31b0>] commit_timeout+0x0/0x10
  [<c01b31d0>] kjournald+0x0/0x290
  [<c01073b5>] kernel_thread_helper+0x5/0x10

dhcpcd        S 08053460 4294129064   509      1           528   150 (NOTLB)
Call Trace:
  [<c0135518>] adjust_abs_time+0x118/0x140
  [<c014e613>] handle_mm_fault+0x193/0x220
  [<c01361aa>] do_clock_nanosleep+0x14a/0x350
  [<c011c380>] default_wake_function+0x0/0x30
  [<c011c380>] default_wake_function+0x0/0x30
  [<c0135e30>] nanosleep_wake_up+0x0/0x10
  [<c0135ee0>] sys_nanosleep+0x80/0xf0
  [<c01097f3>] syscall_call+0x7/0xb

syslogd       S 00000001 2015492   528      1           531   509 (NOTLB)
Call Trace:
  [<c012a682>] schedule_timeout+0xb2/0xc0
  [<c0284916>] datagram_poll+0xe6/0xeb
  [<c027e8b7>] sock_poll+0x27/0x30
  [<c01735da>] do_select+0x29a/0x320
  [<c017367e>] select_bits_alloc+0x1e/0x20
  [<c01731a0>] __pollwait+0x0/0xc0
  [<c01738ee>] sys_select+0x25e/0x480
  [<c01097f3>] syscall_call+0x7/0xb

klogd         R 00000001 4294216928   531      1           602   528 (NOTLB)
Call Trace:
  [<c01217af>] do_syslog+0x4ff/0x510
  [<c011c380>] default_wake_function+0x0/0x30
  [<c015de4a>] vfs_read+0xda/0x120
  [<c010bfab>] do_IRQ+0x11b/0x240
  [<c015e0bf>] sys_read+0x3f/0x60
  [<c01097f3>] syscall_call+0x7/0xb

resmgrd       S 00000000 4275623656   602      1           616   531 (NOTLB)
Call Trace:
  [<c01413ed>] __get_free_pages+0x1d/0x50
  [<c012a682>] schedule_timeout+0xb2/0xc0
  [<c027e8b7>] sock_poll+0x27/0x30
  [<c0173b6c>] do_pollfd+0x5c/0xa0
  [<c0173c52>] do_poll+0xa2/0xd0
  [<c0173e53>] sys_poll+0x1d3/0x26d
  [<c015d4b6>] sys_close+0x86/0x100
  [<c01731a0>] __pollwait+0x0/0xc0
  [<c01097f3>] syscall_call+0x7/0xb

portmap       S 00000001 4283935664   616      1          1444   602 (NOTLB)
Call Trace:
  [<c029fe10>] tcp_poll+0x110/0x1a0
  [<c012a682>] schedule_timeout+0xb2/0xc0
  [<c027e8b7>] sock_poll+0x27/0x30
  [<c0173b6c>] do_pollfd+0x5c/0xa0
  [<c0173c52>] do_poll+0xa2/0xd0
  [<c0173e53>] sys_poll+0x1d3/0x26d
  [<c017297a>] sys_ioctl+0x11a/0x339
  [<c015d4b6>] sys_close+0x86/0x100
  [<c01731a0>] __pollwait+0x0/0xc0
  [<c01097f3>] syscall_call+0x7/0xb

kdeinit       S 00000001 4281905676  1441      1  2842    9456  1447 (NOTLB)
Call Trace:
  [<c012a682>] schedule_timeout+0xb2/0xc0
  [<c02da6d4>] unix_poll+0x94/0xd0
  [<c027e8b7>] sock_poll+0x27/0x30
  [<c01735da>] do_select+0x29a/0x320
  [<c017367e>] select_bits_alloc+0x1e/0x20
  [<c01731a0>] __pollwait+0x0/0xc0
  [<c01738ee>] sys_select+0x25e/0x480
  [<c01097f3>] syscall_call+0x7/0xb

kdeinit       S 00000001 4294884696  1444      1          1447   616 (NOTLB)
Call Trace:
  [<c012a636>] schedule_timeout+0x66/0xc0
  [<c012a5c0>] process_timeout+0x0/0x10
  [<c027e8b7>] sock_poll+0x27/0x30
   [<c017367e>] select_bits_alloc+0x1e/0x20
  [<c01731a0>] __pollwait+0x0/0xc0
  [<c01738ee>] sys_select+0x25e/0x480
  [<c01097f3>] syscall_call+0x7/0xb

kdeinit       S 00000001 4294293824  1447      1          1441  1444 (NOTLB)
Call Trace:
  [<c012a636>] schedule_timeout+0x66/0xc0
  [<c012a5c0>] process_timeout+0x0/0x10
  [<c027e8b7>] sock_poll+0x27/0x30
  [<c01735da>] do_select+0x29a/0x320
  [<c017367e>] select_bits_alloc+0x1e/0x20
  [<c01731a0>] __pollwait+0x0/0xc0
  [<c01738ee>] sys_select+0x25e/0x480
  [<c01097f3>] syscall_call+0x7/0xb

kdeinit       S 00000001 70588800  2842   1441                     (NOTLB)
Call Trace:
  [<c010bfab>] do_IRQ+0x11b/0x240
  [<c012a636>] schedule_timeout+0x66/0xc0
  [<c012a5c0>] process_timeout+0x0/0x10
  [<c027e8b7>] sock_poll+0x27/0x30
  [<c01735da>] do_select+0x29a/0x320
  [<c017367e>] select_bits_alloc+0x1e/0x20
  [<c01731a0>] __pollwait+0x0/0xc0
  [<c01738ee>] sys_select+0x25e/0x480
  [<c01097f3>] syscall_call+0x7/0xb

rc            D 00000001 4268079552  9456      1          9469  1441 (NOTLB)
Call Trace:
  [<c01cad36>] reiserfs_read_locked_inode+0xc6/0x110
  [<c011cb5e>] sleep_on+0x6e/0x130
  [<c011c380>] default_wake_function+0x0/0x30
  [<c01e6768>] do_journal_begin_r+0x88/0x2a0
  [<c01e69d7>] journal_begin+0x27/0x30
  [<c01d5a07>] reiserfs_dirty_inode+0x77/0x140
  [<c0183a16>] __mark_inode_dirty+0x126/0x160
  [<c017c6c2>] update_atime+0xb2/0xd0
  [<c01d0edc>] reiserfs_readdir+0x59c/0x610
  [<c014e63d>] handle_mm_fault+0x1bd/0x220
  [<c0172c2e>] vfs_readdir+0x7e/0xa0 [<c0172f40>] filldir64+0x0/0x120
  [<c01730d4>] sys_getdents64+0x74/0xb5
  [<c0172f40>] filldir64+0x0/0x120
  [<c01097f3>] syscall_call+0x7/0xb

blogd         D 00000001 321552576  9469      1                9456 (NOTLB)
Call Trace:
  [<c0240691>] generic_make_request+0xf1/0x1d0
  [<c011d8e4>] io_schedule+0x24/0x30
  [<c015f629>] __wait_on_buffer+0x99/0xd0
  [<c011ece0>] autoremove_wake_function+0x0/0x50
  [<c011ece0>] autoremove_wake_function+0x0/0x50
  [<c01e393d>] flush_commit_list+0x34d/0x440
  [<c01e80ec>] do_journal_end+0x71c/0xbe0
  [<c01e708d>] journal_end_sync+0x3d/0xa0
  [<c01e7906>] reiserfs_commit_for_inode+0x86/0xb0
  [<c01cd8d7>] reiserfs_sync_file+0x77/0x100
  [<c015fb51>] sys_fdatasync+0xa1/0xd0
  [<c01097f3>] syscall_call+0x7/0xb

SysRq : Emergency Sync
 
unused
Shutting down RPC portmap daemonEmergency Sync complete





Oleg Drokin wrote:
> Hello!
> 
> On Wed, Jun 18, 2003 at 10:30:03PM +0200, Olivier NICOLAS wrote:
> 
> 
>>AltSysRq T ....
>>.....
>>konqueror     D 00000001 4244652160  1965   1943                     (NOTLB)
>>Call Trace:
>> [<c011c3aa>] default_wake_function+0x2a/0x30
>> [<c011cb5e>] sleep_on+0x6e/0x130
>> [<c011c380>] default_wake_function+0x0/0x30
>> [<c01e6768>] do_journal_begin_r+0x88/0x2a0
> 
> 
> So they want to open the journal, but it is held by somebody else already.
> Can you please look include stacktraces for all other processes that have
> reiserfs bits in the trace and show those traces too? Or just mail me full sysrq-T outputs
> at the time of such a happinings.
> 
> Thank you.
> 
> Bye,
>     Oleg
> 
> 


