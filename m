Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265606AbTFNDtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 23:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbTFNDtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 23:49:46 -0400
Received: from iucha.net ([209.98.146.184]:353 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S265606AbTFNDtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 23:49:32 -0400
Date: Fri, 13 Jun 2003 23:03:19 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: nfs/rpc badness with 2.5.70-bk18
Message-ID: <20030614040319.GS25303@iucha.net>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ixDgnS8AC6zwmyK0"
Content-Disposition: inline
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ixDgnS8AC6zwmyK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

With 2.5.70-bk18 I get freezes. After the freeze this was in the
serial console:

Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c0166951
*pde =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0166951>]    Not tainted
EFLAGS: 00010286
EIP is at dput+0x91/0x200
eax: 00100100   ebx: e7c52d40   ecx: e7c52d54   edx: 00200200
esi: e4266000   edi: e7c52d54   ebp: e7c52e1c   esp: e4267ea4
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 757, threadinfo=3De4266000 task=3De70ab280)
Stack: e7c52d40 c0454c50 e7c52d40 00000000 e7c52d54 c03450bc e7c52d40 e7c52=
d40=20
       e7c53528 e7c534c0 e7c52db0 e7c52e00 e7c52e00 e7c539a8 e7c53940 c0345=
6af=20
       e7c52e00 e7ea3180 e7ea3180 effe49c0 ea4c1a59 00000005 10ee271a 00000=
010=20
Call Trace:
 [<c03450bc>] rpc_depopulate+0xac/0x150
 [<c03456af>] rpc_rmdir+0x7f/0xc0
 [<c0335f9f>] rpc_destroy_client+0x5f/0x90
 [<c018925f>] nfs_put_super+0x1f/0x50
 [<c0156706>] generic_shutdown_super+0x176/0x190
 [<c0156fc7>] kill_anon_super+0x17/0x50
 [<c018b7d9>] nfs_kill_super+0x19/0x30
 [<c015644e>] deactivate_super+0x5e/0xc0
 [<c016bfcf>] sys_umount+0x3f/0x90
 [<c016c037>] sys_oldumount+0x17/0x20
 [<c010aa67>] syscall_call+0x7/0xb

Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 43 14 00 01 10 00 ff=20
 <6>note: umount[757] exited with preempt_count 3
bad: scheduling while atomic!
Call Trace:
 [<c011a11b>] schedule+0x39b/0x3a0
 [<c01418b3>] unmap_page_range+0x43/0x70
 [<c0141a95>] unmap_vmas+0x1b5/0x210
 [<c014571b>] exit_mmap+0x7b/0x190
 [<c011bab4>] mmput+0x64/0xc0
 [<c011f675>] do_exit+0x105/0x410
 [<c0118760>] do_page_fault+0x0/0x451
 [<c010bac0>] do_divide_error+0x0/0x100
 [<c011888c>] do_page_fault+0x12c/0x451
 [<c0124e46>] update_process_times+0x46/0x60
 [<c0124f8a>] run_timer_softirq+0x10a/0x1b0
 [<c012511f>] do_timer+0xdf/0xf0
 [<c012c803>] rcu_process_callbacks+0x83/0x100
 [<c0121176>] tasklet_action+0x46/0x70
 [<c010cf6c>] do_IRQ+0xfc/0x130
 [<c0118760>] do_page_fault+0x0/0x451
 [<c010b471>] error_code+0x2d/0x38
 [<c0166951>] dput+0x91/0x200
 [<c03450bc>] rpc_depopulate+0xac/0x150
 [<c03456af>] rpc_rmdir+0x7f/0xc0
 [<c0335f9f>] rpc_destroy_client+0x5f/0x90
 [<c018925f>] nfs_put_super+0x1f/0x50
 [<c0156706>] generic_shutdown_super+0x176/0x190
 [<c0156fc7>] kill_anon_super+0x17/0x50
 [<c018b7d9>] nfs_kill_super+0x19/0x30
 [<c015644e>] deactivate_super+0x5e/0xc0
 [<c016bfcf>] sys_umount+0x3f/0x90
 [<c016c037>] sys_oldumount+0x17/0x20
 [<c010aa67>] syscall_call+0x7/0xb

agpgart: Found an AGP 2.0 compliant device at 00:00.0.
agpgart: Putting AGP V2 device at 00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 01:00.0 into 2x mode
[drm] Loading R200 Microcode
agpgart: Found an AGP 2.0 compliant device at 00:00.0.
agpgart: Putting AGP V2 device at 00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 01:00.0 into 2x mode
[drm] Loading R200 Microcode

!!! Now the second freeze, I pressed Ctrl-Alt-Del. Still frozen, I
dumped the tasks with SysRq-T. Here is the serial console dump:

SysRq : Emergency Sync
SysRq : Emergency Remount R/O
SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S EF98F5C0 4294956888     1      0     2               (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

ksoftirqd/0   S 00000246 4294951996     2      1             3       (L-TLB)
Call Trace:
 [<c0121176>] tasklet_action+0x46/0x70
 [<c012138f>] ksoftirqd+0xaf/0xc0
 [<c01212e0>] ksoftirqd+0x0/0xc0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

events/0      S C03C9E60 4294945064     3      1             4     2 (L-TLB)
Call Trace:
 [<c012bc2e>] worker_thread+0x29e/0x2d0
 [<c026dd00>] console_callback+0x0/0xc0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c012b990>] worker_thread+0x0/0x2d0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

khubd         S EFD21F9E 4292416496     4      1             5     3 (L-TLB)
Call Trace:
 [<c02c5d5e>] hub_thread+0xce/0xf0
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c02c5c90>] hub_thread+0x0/0xf0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

pdflush       D 00000000 4292213248     5      1             6     4 (L-TLB)
Call Trace:
 [<c0225164>] vfs_mntupdate+0x34/0x40
 [<c022f39d>] rwsem_down_read_failed+0x8d/0x130
 [<c0157598>] .text.lock.super+0xef/0x197
 [<c013b312>] __pdflush+0xd2/0x1d0
 [<c013b410>] pdflush+0x0/0x20
 [<c013b41f>] pdflush+0xf/0x20
 [<c0156e20>] do_emergency_remount+0x0/0xd0
 [<c0108a68>] kernel_thread_helper+0x0/0x18
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

pdflush       D 00000000 4294951360     6      1             7     5 (L-TLB)
Call Trace:
 [<c022f39d>] rwsem_down_read_failed+0x8d/0x130
 [<c01703c5>] .text.lock.fs_writeback+0x7/0x42
 [<c0170155>] sync_inodes+0x15/0xa0
 [<c0151ac3>] do_sync+0x23/0x80
 [<c013b312>] __pdflush+0xd2/0x1d0
 [<c013b410>] pdflush+0x0/0x20
 [<c013b41f>] pdflush+0xf/0x20
 [<c0151aa0>] do_sync+0x0/0x80
 [<c0108a68>] kernel_thread_helper+0x0/0x18
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

kswapd0       S EFCE8000 4294944704     7      1             8     6 (L-TLB)
Call Trace:
 [<c011eaf2>] daemonize+0xd2/0xe0
 [<c01401eb>] kswapd+0xeb/0x130
 [<c011a14a>] preempt_schedule+0x2a/0x50
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c0140100>] kswapd+0x0/0x130
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

aio/0         S EFCE6000 4294938048     8      1             9     7 (L-TLB)
Call Trace:
 [<c0128ce5>] do_sigaction+0x185/0x260
 [<c012bc2e>] worker_thread+0x29e/0x2d0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c012b990>] worker_thread+0x0/0x2d0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfslogd/0     S EF9B48D8 4294931392     9      1            10     8 (L-TLB)
Call Trace:
 [<c012bc2e>] worker_thread+0x29e/0x2d0
 [<c021b000>] pagebuf_iodone_work+0x0/0x60
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c012b990>] worker_thread+0x0/0x2d0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfsdatad/0    S EFCE2000 4294924736    10      1            11     9 (L-TLB)
Call Trace:
 [<c0128ce5>] do_sigaction+0x185/0x260
 [<c012bc2e>] worker_thread+0x29e/0x2d0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c012b990>] worker_thread+0x0/0x2d0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

pagebufd      S 00000000 4294951280    11      1            12    10 (L-TLB)
Call Trace:
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a4ff>] interruptible_sleep_on+0x4f/0x90
 [<c011a170>] default_wake_function+0x0/0x30
 [<c021bc9e>] pagebuf_daemon+0x21e/0x240
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c021ba50>] pagebuf_daemon_wakeup+0x0/0x30
 [<c021ba80>] pagebuf_daemon+0x0/0x240
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

scsi_eh_0     S 00000046 4294543216    12      1            13    11 (L-TLB)
Call Trace:
 [<c0109947>] __down_interruptible+0xa7/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0109a47>] __down_failed_interruptible+0x7/0xc
 [<c02ac90a>] .text.lock.scsi_error+0x41/0x77
 [<c02ac510>] scsi_error_handler+0x0/0x1c0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

kseriod       S EFC38000 4294408832    13      1            14    12 (L-TLB)
Call Trace:
 [<c011eaf2>] daemonize+0xd2/0xe0
 [<c02d7a87>] serio_thread+0x137/0x140
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c02d7950>] serio_thread+0x0/0x140
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     S EFC51E80 4291605364    14      1            75    13 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

knodemgrd_0   S EEFD94CC 4287445296    75      1           125    14 (L-TLB)
Call Trace:
 [<c0185139>] sysfs_symlink+0x69/0x80
 [<c0109947>] __down_interruptible+0xa7/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0109a47>] __down_failed_interruptible+0x7/0xc
 [<f091224e>] .text.lock.nodemgr+0x37/0xa9 [ieee1394]
 [<f0911c10>] nodemgr_host_thread+0x0/0x170 [ieee1394]
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

usb-storage   S EFC71A8C 4292626160   125      1           126    75 (L-TLB)
Call Trace:
 [<c011a282>] __wake_up_locked+0x22/0x30
 [<c0109947>] __down_interruptible+0xa7/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0109a47>] __down_failed_interruptible+0x7/0xc
 [<f08873fb>] .text.lock.usb+0x5/0x5a [usb_storage]
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<f08868c0>] usb_stor_control_thread+0x0/0x250 [usb_storage]
 [<f08868c0>] usb_stor_control_thread+0x0/0x250 [usb_storage]
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

scsi_eh_1     S 00000046 4292619504   126      1           167   125 (L-TLB)
Call Trace:
 [<c0109947>] __down_interruptible+0xa7/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0109a47>] __down_failed_interruptible+0x7/0xc
 [<c02ac90a>] .text.lock.scsi_error+0x41/0x77
 [<c02ac510>] scsi_error_handler+0x0/0x1c0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     S EF64ACC0 4283936048   167      1           168   126 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     S EF64A2C0 4291649776   168      1           169   167 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     S 00000001 4291580656   169      1           170   168 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     S 00000001 4291381440   170      1           171   169 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     S EF9B4B80 4294951088   171      1           172   170 (L-TLB)
Call Trace:
 [<c0208c3e>] xfs_getsb+0x2e/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     S EF64A0C0 4294948480   172      1           218   171 (L-TLB)
Call Trace:
 [<c0208c3e>] xfs_getsb+0x2e/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

dhclient      S C03982E4 9646768   218      1           222   172 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

portmap       S 00000246 4293299376   222      1           298   218 (NOTLB)
Call Trace:
 [<c02ff464>] tcp_poll+0x34/0x160
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c014fb21>] sys_close+0x61/0xa0
 [<c010aa67>] syscall_call+0x7/0xb

syslog-ng     R E7C644D8 4292894832   298      1           302   222 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

rpc.statd     S C03982E4 4290803888   302      1           309   298 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02ff464>] tcp_poll+0x34/0x160
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c014fb21>] sys_close+0x61/0xa0
 [<c010aa67>] syscall_call+0x7/0xb

acpid         S 00000000 4291995248   309      1           389   302 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

automount     S BFFFFB94 4276127536   389      1   755     393   309 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c015ca34>] pipe_poll+0x34/0x80
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

gpm           S 00000000 4276515872   393      1           398   389 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c0150498>] vfs_write+0xb8/0x130
 [<c010aa67>] syscall_call+0x7/0xb

inetd         S 40049000 4289604720   398      1           404   393 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02ff464>] tcp_poll+0x34/0x160
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

lpd           S C03982E4 4294681072   404      1           492   398 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02ff464>] tcp_poll+0x34/0x160
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c02e2407>] sys_socketcall+0xd7/0x2a0
 [<c0145414>] sys_munmap+0x44/0x70
 [<c010aa67>] syscall_call+0x7/0xb

master        S EE4A1ECC 4293029492   492      1   496     498   404 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

nqmgr         S C03982E4 4293150704   496    492           764       (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c014fb21>] sys_close+0x61/0xa0
 [<c010aa67>] syscall_call+0x7/0xb

nmbd          S C03982E4 4289410032   498      1           504   492 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

sshd          S C03980CC 4290527680   504      1           520   498 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02ff464>] tcp_poll+0x34/0x160
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c0145414>] sys_munmap+0x44/0x70
 [<c010aa67>] syscall_call+0x7/0xb

ntpd          S C03982E4 4289865648   520      1           524   504 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e677b>] datagram_poll+0x2b/0xf0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c01504b1>] vfs_write+0xd1/0x130
 [<c010aa67>] syscall_call+0x7/0xb

usbmgr        S EDEF5EC0 4287314548   524      1           528   520 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c02cfcb0>] usb_device_lseek+0x0/0x9d
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

atd           S EDF13F20 4289555888   528      1           532   524 (NOTLB)
Call Trace:
 [<c012ee39>] do_clock_nanosleep+0x199/0x2f0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0129130>] sys_rt_sigaction+0xe0/0xf0
 [<c012ea90>] nanosleep_wake_up+0x0/0x10
 [<c012eb52>] sys_nanosleep+0x92/0xe0
 [<c010aa67>] syscall_call+0x7/0xb

cron          S EDE97F20 4289049536   532      1           537   528 (NOTLB)
Call Trace:
 [<c012ee39>] do_clock_nanosleep+0x199/0x2f0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0129130>] sys_rt_sigaction+0xe0/0xf0
 [<c012ea90>] nanosleep_wake_up+0x0/0x10
 [<c012eb52>] sys_nanosleep+0x92/0xe0
 [<c010aa67>] syscall_call+0x7/0xb

gdm           S EEB1C398 4294951280   537      1   538     541   532 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

gdm           S EE119840 4294616944   538    537   797               (NOTLB)
Call Trace:
 [<c015c43b>] pipe_wait+0x7b/0xa0
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c015c59f>] pipe_read+0x13f/0x240
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4267565376   541      1           542   537 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4289463868   542      1           543   541 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 6311284   543      1           544   542 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 74560   544      1           545   543 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4294834544   545      1           546   544 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 1491248   546      1           624   545 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

rpciod        S E938E000 24102904   624      1           625   546 (L-TLB)
Call Trace:
 [<c033a813>] __rpc_schedule+0xe3/0x120
 [<c033b26b>] rpciod+0x1fb/0x250
 [<c011a170>] default_wake_function+0x0/0x30
 [<c033b070>] rpciod+0x0/0x250
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

lockd         S FFEF6449 4291735024   625      1           804   624 (L-TLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c033db59>] svc_sock_release+0xc9/0x1e0
 [<c033f6e9>] svc_recv+0x3d9/0x520
 [<c014fa82>] filp_close+0x92/0xd0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011e874>] reparent_to_init+0xe4/0x170
 [<c011a170>] default_wake_function+0x0/0x30
 [<c01a8fd9>] lockd+0x109/0x250
 [<c01a8ed0>] lockd+0x0/0x250
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

automount     S 00000000 4222436976   755    389           756       (NOTLB)
Call Trace:
 [<c011a4ff>] interruptible_sleep_on+0x4f/0x90
 [<c011a170>] default_wake_function+0x0/0x30
 [<f08759ca>] autofs4_wait+0x1ea/0x2b0 [autofs4]
 [<f0875f56>] autofs4_expire_multi+0x76/0xa0 [autofs4]
 [<c0161ff3>] sys_ioctl+0xf3/0x280
 [<c014fb21>] sys_close+0x61/0xa0
 [<c010aa67>] syscall_call+0x7/0xb

automount     S C0145684 4232641008   756    389   765           755 (NOTLB)
Call Trace:
 [<c0145684>] build_mmap_rb+0x34/0x50
 [<c015c43b>] pipe_wait+0x7b/0xa0
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c015c59f>] pipe_read+0x13f/0x240
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

pickup        S C03982E4 4287748208   764    492                 496 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

mount         D E4266000 4246448048   765    756                     (NOTLB)
Call Trace:
 [<c0135f6c>] find_get_page+0x2c/0x60
 [<c022f4cd>] rwsem_down_write_failed+0x8d/0x130
 [<c01574c7>] .text.lock.super+0x1e/0x197
 [<c015683b>] sget+0x11b/0x140
 [<c018b6eb>] nfs_get_sb+0x15b/0x230
 [<c018b530>] nfs_compare_super+0x0/0x60
 [<c018b510>] nfs_set_super+0x0/0x20
 [<c01573ff>] do_kern_mount+0x5f/0xe0
 [<c016c808>] do_add_mount+0x78/0x150
 [<c016cae4>] do_mount+0x124/0x170
 [<c016c9b6>] copy_mount_options+0xd6/0xe0
 [<c016cf8f>] sys_mount+0xbf/0x140
 [<c010aa67>] syscall_call+0x7/0xb

XFree86       S BFFFF450 51280   797    538           803       (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

gdmgreeter    S ED92FB58 48907952   803    538                 797 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

shutdown      D 00000000 4219117808   804      1                 625 (NOTLB)
Call Trace:
 [<c022f39d>] rwsem_down_read_failed+0x8d/0x130
 [<c01703c5>] .text.lock.fs_writeback+0x7/0x42
 [<c0170155>] sync_inodes+0x15/0xa0
 [<c0151ac3>] do_sync+0x23/0x80
 [<c0118760>] do_page_fault+0x0/0x451
 [<c0151b2f>] sys_sync+0xf/0x20
 [<c010aa67>] syscall_call+0x7/0xb

atkbd.c: Unknown key

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--ixDgnS8AC6zwmyK0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+6p6HNLPgdTuQ3+QRAl4aAJ9kwHRJ+1F1eD1Ubkox6yfdMZLdywCffktm
aZdEj/g1wkASLqlqJ1+voi4=
=iTRB
-----END PGP SIGNATURE-----

--ixDgnS8AC6zwmyK0--
