Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSKBUgd>; Sat, 2 Nov 2002 15:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSKBUgd>; Sat, 2 Nov 2002 15:36:33 -0500
Received: from [212.104.37.2] ([212.104.37.2]:18450 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S261423AbSKBUgX>; Sat, 2 Nov 2002 15:36:23 -0500
Date: Sat, 2 Nov 2002 21:42:46 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: lord@sgi.com
Subject: Re: [2.5.45] Unable to umount XFS filesystems
Message-ID: <20021102204246.GA294@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
References: <20021102151320.GA308@dreamland.darkstar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102151320.GA308@dreamland.darkstar.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Nov 02, 2002 at 04:13:20PM +0100, Kronos ha scritto: 
> with kernel  2.5.45 I'm  unable to unmount  XFS filesystems. 'umount' is
> blocked in D state:

As Denis Vlasenko suggested, this is Alt-SysRq-T:

ksymoops 2.4.5 on i686 2.5.45.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.45/ (default)
     -m /boot/System.map-2.5.45 (specified)

Warning (compare_maps): ksyms_base symbol page_states__per_cpu_R__ver_page_states__per_cpu not found in System.map.  Ignoring ksyms_base entry
init          S C129E040     0     1      0     2               (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
 [<c0120d97>] schedule_timeout+0x57/0xb0
 [<c0155851>] __pollwait+0x41/0xd0
 [<c0120d30>] process_timeout+0x0/0x10
 [<c0155ad4>] do_select+0x114/0x240
 [<c0155f22>] sys_select+0x2f2/0x510
 [<c010763f>] syscall_call+0x7/0xb
ksoftirqd/0   S C129E640     0     2      1             3       (L-TLB)
 [<c011d6a6>] ksoftirqd+0x96/0xe0
 [<c011d610>] ksoftirqd+0x0/0xe0
 [<c010563d>] kernel_thread_helper+0x5/0x18
events/0      S C129EC40     0     3      1             4     2 (L-TLB)
 [<c02805a0>] batch_entropy_process+0x0/0xe0
 [<c0127063>] worker_thread+0x213/0x250
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0126e50>] worker_thread+0x0/0x250
 [<c010563d>] kernel_thread_helper+0x5/0x18
kswapd0       S C129F840     0     4      1             5     3 (L-TLB)
 [<c01360d6>] kswapd+0x106/0x139
 [<c0115b20>] autoremove_wake_function+0x0/0x50
 [<c0115b20>] autoremove_wake_function+0x0/0x50
 [<c0135fd0>] kswapd+0x0/0x139
 [<c010563d>] kernel_thread_helper+0x5/0x18
pdflush       S C129F240     0     5      1             6     4 (L-TLB)
 [<c011b0ae>] reparent_to_init+0xde/0x180
 [<c013f969>] __pdflush+0xe9/0x220
 [<c013faa0>] pdflush+0x0/0x20
 [<c013faaf>] pdflush+0xf/0x20
 [<c0105638>] kernel_thread_helper+0x0/0x18
 [<c010563d>] kernel_thread_helper+0x5/0x18
pdflush       S C138B880     0     6      1             7     5 (L-TLB)
 [<c013f969>] __pdflush+0xe9/0x220
 [<c013faa0>] pdflush+0x0/0x20
 [<c013faaf>] pdflush+0xf/0x20
 [<c0105638>] kernel_thread_helper+0x0/0x18
 [<c010563d>] kernel_thread_helper+0x5/0x18
aio/0         S C138B280     0     7      1             8     6 (L-TLB)
 [<c0127063>] worker_thread+0x213/0x250
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0114476>] preempt_schedule+0x36/0x60
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0126e50>] worker_thread+0x0/0x250
 [<c010563d>] kernel_thread_helper+0x5/0x18
pagebufd      S C138AC80     0     8      1             9     7 (L-TLB)
 [<c0114760>] interruptible_sleep_on+0x50/0x90
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c020de53>] pagebuf_daemon+0x263/0x280
 [<c020dbc0>] pagebuf_daemon_wakeup+0x0/0x30
 [<c020dbf0>] pagebuf_daemon+0x0/0x280
 [<c010563d>] kernel_thread_helper+0x5/0x18
pagebuf/0     S C138A680     0     9      1            29     8 (L-TLB)
 [<c020d110>] pagebuf_iodone_work+0x0/0x60
 [<c0127063>] worker_thread+0x213/0x250
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0114476>] preempt_schedule+0x36/0x60
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0126e50>] worker_thread+0x0/0x250
 [<c010563d>] kernel_thread_helper+0x5/0x18
reiserfs/0    S CFD22CC0     0    29      1            93     9 (L-TLB)
 [<c0127063>] worker_thread+0x213/0x250
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0126e50>] worker_thread+0x0/0x250
 [<c010563d>] kernel_thread_helper+0x5/0x18
bash          S CFD220C0     0    93      1   165      95    29 (NOTLB)
 [<c011bdd1>] sys_wait4+0x201/0x4c0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c010763f>] syscall_call+0x7/0xb
bash          S CFD226C0     0    95      1            96    93 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0122cf4>] sys_rt_sigprocmask+0x104/0x190
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S CF9F9900     0    96      1            97    95 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S C138A080     0    97      1            98    96 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S CF9F8700     0    98      1            99    97 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S CF9F8100     0    99      1           100    98 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S CF951940     0   100      1           137    99 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
bash          S CF9F8D00     0   137      1           151   100 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0122cf4>] sys_rt_sigprocmask+0x104/0x190
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
gpm           S CF951340     0   151      1                 137 (NOTLB)
 [<c0120d97>] schedule_timeout+0x57/0xb0
 [<c0120d30>] process_timeout+0x0/0x10
 [<c02e12a5>] sock_poll+0x25/0x30
 [<c0155ad4>] do_select+0x114/0x240
 [<c0155f22>] sys_select+0x2f2/0x510
 [<c010763f>] syscall_call+0x7/0xb
umount        D CF9F9300     0   165     93                     (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c0209bfa>] xfs_finish_reclaim+0xea/0x120
 [<c02099fb>] xfs_reclaim+0xcb/0x1e0
 [<c0217a73>] vn_remove+0xe3/0x110
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0217831>] vn_purge+0xd1/0x100
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0133fef>] cache_free_debugcheck+0x12f/0x1b0
 [<c02177ed>] vn_purge+0x8d/0x100
 [<c02179dc>] vn_remove+0x4c/0x110
 [<c020338f>] xfs_unmount+0xef/0x120
 [<c0203689>] xfs_sync+0x29/0x30
 [<c020ff66>] fs_dounmount+0x66/0x70
 [<c0216fb5>] linvfs_put_super+0x35/0x80
 [<c0149ef5>] generic_shutdown_super+0x125/0x140
 [<c014a86d>] kill_block_super+0x1d/0x50
 [<c0149cc5>] deactivate_super+0x75/0xb0
 [<c015e46f>] sys_umount+0x3f/0x90
 [<c015e4d7>] sys_oldumount+0x17/0x20
 [<c010763f>] syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init

>>EIP; c129e040 <_end+db2500/10bdf4c0>   <=====
Proc;  ksoftirqd/0

>>EIP; c129e640 <_end+db2b00/10bdf4c0>   <=====
Proc;  events/0

>>EIP; c129ec40 <_end+db3100/10bdf4c0>   <=====
Proc;  kswapd0

>>EIP; c129f840 <_end+db3d00/10bdf4c0>   <=====
Proc;  pdflush

>>EIP; c129f240 <_end+db3700/10bdf4c0>   <=====
Proc;  pdflush

>>EIP; c138b880 <_end+e9fd40/10bdf4c0>   <=====
Proc;  aio/0

>>EIP; c138b280 <_end+e9f740/10bdf4c0>   <=====
Proc;  pagebufd

>>EIP; c138ac80 <_end+e9f140/10bdf4c0>   <=====
Proc;  pagebuf/0

>>EIP; c138a680 <_end+e9eb40/10bdf4c0>   <=====
Proc;  reiserfs/0

>>EIP; cfd22cc0 <_end+f837180/10bdf4c0>   <=====
Proc;  bash

>>EIP; cfd220c0 <_end+f836580/10bdf4c0>   <=====
Proc;  bash

>>EIP; cfd226c0 <_end+f836b80/10bdf4c0>   <=====
Proc;  agetty

>>EIP; cf9f9900 <_end+f50ddc0/10bdf4c0>   <=====
Proc;  agetty

>>EIP; c138a080 <_end+e9e540/10bdf4c0>   <=====
Proc;  agetty

>>EIP; cf9f8700 <_end+f50cbc0/10bdf4c0>   <=====
Proc;  agetty

>>EIP; cf9f8100 <_end+f50c5c0/10bdf4c0>   <=====
Proc;  agetty

>>EIP; cf951940 <_end+f465e00/10bdf4c0>   <=====
Proc;  bash

>>EIP; cf9f8d00 <_end+f50d1c0/10bdf4c0>   <=====
Proc;  gpm

>>EIP; cf951340 <_end+f465800/10bdf4c0>   <=====
Proc;  umount

>>EIP; cf9f9300 <_end+f50d7c0/10bdf4c0>   <=====


2 warnings issued.  Results may not be reliable.


After that I tried 'sync' but it blocked too:

ksymoops 2.4.5 on i686 2.5.45.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.45/ (default)
     -m /boot/System.map-2.5.45 (specified)

Warning (compare_maps): ksyms_base symbol page_states__per_cpu_R__ver_page_states__per_cpu not found in System.map.  Ignoring ksyms_base entry
init          S C129E040     0     1      0     2               (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
 [<c0120d97>] schedule_timeout+0x57/0xb0
 [<c0155851>] __pollwait+0x41/0xd0
 [<c0120d30>] process_timeout+0x0/0x10
 [<c0155ad4>] do_select+0x114/0x240
 [<c0155f22>] sys_select+0x2f2/0x510
 [<c010763f>] syscall_call+0x7/0xb
ksoftirqd/0   S C129E640     0     2      1             3       (L-TLB)
 [<c011d6a6>] ksoftirqd+0x96/0xe0
 [<c011d610>] ksoftirqd+0x0/0xe0
 [<c010563d>] kernel_thread_helper+0x5/0x18
events/0      S C129EC40     0     3      1             4     2 (L-TLB)
 [<c02805a0>] batch_entropy_process+0x0/0xe0
 [<c0127063>] worker_thread+0x213/0x250
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0126e50>] worker_thread+0x0/0x250
 [<c010563d>] kernel_thread_helper+0x5/0x18
kswapd0       S C129F840     0     4      1             5     3 (L-TLB)
 [<c01360d6>] kswapd+0x106/0x139
 [<c0115b20>] autoremove_wake_function+0x0/0x50
 [<c0115b20>] autoremove_wake_function+0x0/0x50
 [<c0135fd0>] kswapd+0x0/0x139
 [<c010563d>] kernel_thread_helper+0x5/0x18
pdflush       S C129F240     0     5      1             6     4 (L-TLB)
 [<c011b0ae>] reparent_to_init+0xde/0x180
 [<c013f969>] __pdflush+0xe9/0x220
 [<c013faa0>] pdflush+0x0/0x20
 [<c013faaf>] pdflush+0xf/0x20
 [<c0105638>] kernel_thread_helper+0x0/0x18
 [<c010563d>] kernel_thread_helper+0x5/0x18
pdflush       S C138B880     0     6      1             7     5 (L-TLB)
 [<c013f969>] __pdflush+0xe9/0x220
 [<c013faa0>] pdflush+0x0/0x20
 [<c013faaf>] pdflush+0xf/0x20
 [<c0105638>] kernel_thread_helper+0x0/0x18
 [<c010563d>] kernel_thread_helper+0x5/0x18
aio/0         S C138B280     0     7      1             8     6 (L-TLB)
 [<c0127063>] worker_thread+0x213/0x250
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0114476>] preempt_schedule+0x36/0x60
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0126e50>] worker_thread+0x0/0x250
 [<c010563d>] kernel_thread_helper+0x5/0x18
pagebufd      S C138AC80     0     8      1             9     7 (L-TLB)
 [<c0114760>] interruptible_sleep_on+0x50/0x90
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c020de53>] pagebuf_daemon+0x263/0x280
 [<c020dbc0>] pagebuf_daemon_wakeup+0x0/0x30
 [<c020dbf0>] pagebuf_daemon+0x0/0x280
 [<c010563d>] kernel_thread_helper+0x5/0x18
pagebuf/0     S C138A680     0     9      1            29     8 (L-TLB)
 [<c020d110>] pagebuf_iodone_work+0x0/0x60
 [<c0127063>] worker_thread+0x213/0x250
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0114476>] preempt_schedule+0x36/0x60
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0126e50>] worker_thread+0x0/0x250
 [<c010563d>] kernel_thread_helper+0x5/0x18
reiserfs/0    S CFD22CC0     0    29      1            93     9 (L-TLB)
 [<c0127063>] worker_thread+0x213/0x250
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0126e50>] worker_thread+0x0/0x250
 [<c010563d>] kernel_thread_helper+0x5/0x18
bash          S CFD220C0     0    93      1   165      95    29 (NOTLB)
 [<c011bdd1>] sys_wait4+0x201/0x4c0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c010763f>] syscall_call+0x7/0xb
bash          S CFD226C0     0    95      1            96    93 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0122cf4>] sys_rt_sigprocmask+0x104/0x190
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
bash          S CF9F9900     0    96      1            97    95 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c01077a6>] apic_timer_interrupt+0x1a/0x20
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0122cf4>] sys_rt_sigprocmask+0x104/0x190
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S C138A080     0    97      1            98    96 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S CF9F8700     0    98      1            99    97 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S CF9F8100     0    99      1           100    98 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
agetty        S CF951940     0   100      1           137    99 (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c028d6a9>] con_write+0x39/0x50
 [<c027dd81>] write_chan+0x181/0x230
 [<c027d7cf>] read_chan+0x29f/0x6d0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0279792>] tty_read+0xf2/0x120
 [<c014383c>] vfs_read+0xdc/0x150
 [<c0222227>] copy_to_user+0x57/0x60
 [<c0143e2e>] sys_read+0x3e/0x60
 [<c010763f>] syscall_call+0x7/0xb
bash          S CF9F8D00     0   137      1   324           100 (NOTLB)
 [<c011bdd1>] sys_wait4+0x201/0x4c0
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c010763f>] syscall_call+0x7/0xb
umount        D CF9F9300     0   165     93                     (NOTLB)
 [<c0120dee>] schedule_timeout+0xae/0xb0
 [<c0209bfa>] xfs_finish_reclaim+0xea/0x120
 [<c02099fb>] xfs_reclaim+0xcb/0x1e0
 [<c0217a73>] vn_remove+0xe3/0x110
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0217831>] vn_purge+0xd1/0x100
 [<c01144a0>] default_wake_function+0x0/0x40
 [<c0133fef>] cache_free_debugcheck+0x12f/0x1b0
 [<c02177ed>] vn_purge+0x8d/0x100
 [<c02179dc>] vn_remove+0x4c/0x110
 [<c020338f>] xfs_unmount+0xef/0x120
 [<c0203689>] xfs_sync+0x29/0x30
 [<c020ff66>] fs_dounmount+0x66/0x70
 [<c0216fb5>] linvfs_put_super+0x35/0x80
 [<c0149ef5>] generic_shutdown_super+0x125/0x140
 [<c014a86d>] kill_block_super+0x1d/0x50
 [<c0149cc5>] deactivate_super+0x75/0xb0
 [<c015e46f>] sys_umount+0x3f/0x90
 [<c015e4d7>] sys_oldumount+0x17/0x20
 [<c010763f>] syscall_call+0x7/0xb
sync          D CF951340     0   324    137                     (NOTLB)
 [<c0221c4c>] rwsem_down_failed_common+0x5c/0x90
 [<c0221a29>] rwsem_down_read_failed+0x29/0x40
 [<c01627d6>] .text.lock.fs_writeback+0x7/0x31
 [<c0162555>] sync_inodes+0x15/0xa0
 [<c01458cb>] sys_sync+0x1b/0x40
 [<c010763f>] syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init

>>EIP; c129e040 <_end+db2500/10bdf4c0>   <=====
Proc;  ksoftirqd/0

>>EIP; c129e640 <_end+db2b00/10bdf4c0>   <=====
Proc;  events/0

>>EIP; c129ec40 <_end+db3100/10bdf4c0>   <=====
Proc;  kswapd0

>>EIP; c129f840 <_end+db3d00/10bdf4c0>   <=====
Proc;  pdflush

>>EIP; c129f240 <_end+db3700/10bdf4c0>   <=====
Proc;  pdflush

>>EIP; c138b880 <_end+e9fd40/10bdf4c0>   <=====
Proc;  aio/0

>>EIP; c138b280 <_end+e9f740/10bdf4c0>   <=====
Proc;  pagebufd

>>EIP; c138ac80 <_end+e9f140/10bdf4c0>   <=====
Proc;  pagebuf/0

>>EIP; c138a680 <_end+e9eb40/10bdf4c0>   <=====
Proc;  reiserfs/0

>>EIP; cfd22cc0 <_end+f837180/10bdf4c0>   <=====
Proc;  bash

>>EIP; cfd220c0 <_end+f836580/10bdf4c0>   <=====
Proc;  bash

>>EIP; cfd226c0 <_end+f836b80/10bdf4c0>   <=====
Proc;  bash

>>EIP; cf9f9900 <_end+f50ddc0/10bdf4c0>   <=====
Proc;  agetty

>>EIP; c138a080 <_end+e9e540/10bdf4c0>   <=====
Proc;  agetty

>>EIP; cf9f8700 <_end+f50cbc0/10bdf4c0>   <=====
Proc;  agetty

>>EIP; cf9f8100 <_end+f50c5c0/10bdf4c0>   <=====
Proc;  agetty

>>EIP; cf951940 <_end+f465e00/10bdf4c0>   <=====
Proc;  bash

>>EIP; cf9f8d00 <_end+f50d1c0/10bdf4c0>   <=====
Proc;  umount

>>EIP; cf9f9300 <_end+f50d7c0/10bdf4c0>   <=====
Proc;  sync

>>EIP; cf951340 <_end+f465800/10bdf4c0>   <=====


2 warnings issued.  Results may not be reliable.

Not sure  about the meaning  of the first  warning, I'm using  the right
System.map

Uh, kernel is UP with CONFIG_PREEMPT=y

HTH,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Ci sono due cose che l'uomo non puo` nascondere:
essere ubriaco ed essere innamorato.
