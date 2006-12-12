Return-Path: <linux-kernel-owner+w=401wt.eu-S1751376AbWLLOcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWLLOcn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 09:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWLLOcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 09:32:42 -0500
Received: from lucidpixels.com ([66.45.37.187]:47749 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbWLLOcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 09:32:42 -0500
Date: Tue, 12 Dec 2006 09:32:38 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: =?iso-8859-2?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: xfslogd-spinlock bug?
In-Reply-To: <003701c71d78$33ed28d0$0400a8c0@dcccs>
Message-ID: <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan>
References: <003701c71d78$33ed28d0$0400a8c0@dcccs>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-1853555891-1165933958=:19050"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1853555891-1165933958=:19050
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

I'm not sure what is causing this problem but I was curious is this on a=20
32bit or 64bit platform?

Justin.

On Tue, 12 Dec 2006, Haar J=C3=A1nos wrote:

> Hello, list,
>=20
> I am the "big red button men" with the one big 14TB xfs, if somebody can
> remember me. :-)
>=20
> Now i found something in the 2.6.16.18, and try the 2.6.18.4, and the
> 2.6.19, but the bug still exists:
>=20
> Dec 11 22:47:21 dy-base BUG: spinlock bad magic on CPU#3, xfslogd/3/317
> Dec 11 22:47:21 dy-base general protection fault: 0000 [1]
> Dec 11 22:47:21 dy-base SMP
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base CPU 3
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base Modules linked in:
> Dec 11 22:47:21 dy-base  nbd
> Dec 11 22:47:21 dy-base  rd
> Dec 11 22:47:21 dy-base  netconsole
> Dec 11 22:47:21 dy-base  e1000
> Dec 11 22:47:21 dy-base  video
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base Pid: 317, comm: xfslogd/3 Not tainted 2.6.19 #1
> Dec 11 22:47:21 dy-base RIP: 0010:[<ffffffff803f3aba>]
> Dec 11 22:47:21 dy-base  [<ffffffff803f3aba>] spin_bug+0x69/0xdf
> Dec 11 22:47:21 dy-base RSP: 0018:ffff81011fb89bc0  EFLAGS: 00010002
> Dec 11 22:47:21 dy-base RAX: 0000000000000033 RBX: 6b6b6b6b6b6b6b6b RCX:
> 0000000000000000
> Dec 11 22:47:21 dy-base RDX: ffffffff808137a0 RSI: 0000000000000082 RDI:
> 0000000100000000
> Dec 11 22:47:21 dy-base RBP: ffff81011fb89be0 R08: 0000000000026a70 R09:
> 000000006b6b6b6b
> Dec 11 22:47:21 dy-base R10: 0000000000000082 R11: ffff81000584d380 R12:
> ffff8100db92ad80
> Dec 11 22:47:21 dy-base R13: ffffffff80642dc6 R14: 0000000000000000 R15:
> 0000000000000003
> Dec 11 22:47:21 dy-base FS:  0000000000000000(0000)
> GS:ffff81011fc76b90(0000) knlGS:0000000000000000
> Dec 11 22:47:21 dy-base CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> Dec 11 22:47:21 dy-base CR2: 00002ba007700000 CR3: 0000000108c05000 CR4:
> 00000000000006e0
> Dec 11 22:47:21 dy-base Process xfslogd/3 (pid: 317, threadinfo
> ffff81011fb88000, task ffff81011fa7f830)
> Dec 11 22:47:21 dy-base Stack:
> Dec 11 22:47:21 dy-base  ffff81011fb89be0
> Dec 11 22:47:21 dy-base  ffff8100db92ad80
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base  ffff81011fb89c10
> Dec 11 22:47:21 dy-base  ffffffff803f3bdc
> Dec 11 22:47:21 dy-base  0000000000000282
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base  0000000000000000
> Dec 11 22:47:21 dy-base  ffff81011fb89c30
> Dec 11 22:47:21 dy-base  ffffffff805e7f2b
> Dec 11 22:47:21 dy-base
> Dec 11 22:47:21 dy-base Call Trace:
> Dec 11 22:47:21 dy-base  [<ffffffff803f3bdc>] _raw_spin_lock+0x23/0xf1
> Dec 11 22:47:21 dy-base  [<ffffffff805e7f2b>] _spin_lock_irqsave+0x11/0x1=
8
> Dec 11 22:47:21 dy-base  [<ffffffff80222aab>] __wake_up+0x22/0x50
> Dec 11 22:47:21 dy-base  [<ffffffff803c97f9>] xfs_buf_unpin+0x21/0x23
> Dec 11 22:47:21 dy-base  [<ffffffff803970a4>] xfs_buf_item_unpin+0x2e/0xa=
6
> Dec 11 22:47:21 dy-base  [<ffffffff803bc460>]
> xfs_trans_chunk_committed+0xc3/0xf7
> Dec 11 22:47:21 dy-base  [<ffffffff803bc4dd>] xfs_trans_committed+0x49/0x=
de
> Dec 11 22:47:21 dy-base  [<ffffffff803b1bde>]
> xlog_state_do_callback+0x185/0x33f
> Dec 11 22:47:21 dy-base  [<ffffffff803b1e9c>] xlog_iodone+0x104/0x131
> Dec 11 22:47:22 dy-base  [<ffffffff803c9dae>] xfs_buf_iodone_work+0x1a/0x=
3e
> Dec 11 22:47:22 dy-base  [<ffffffff802399d8>] worker_thread+0x0/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff8023937e>] run_workqueue+0xa8/0xf8
> Dec 11 22:47:22 dy-base  [<ffffffff803c9d94>] xfs_buf_iodone_work+0x0/0x3=
e
> Dec 11 22:47:22 dy-base  [<ffffffff802399d8>] worker_thread+0x0/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff80239ad3>] worker_thread+0xfb/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff80223f6c>] default_wake_function+0x0/0=
xf
> Dec 11 22:47:22 dy-base  [<ffffffff802399d8>] worker_thread+0x0/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff8023c6e5>] kthread+0xd8/0x10b
> Dec 11 22:47:22 dy-base  [<ffffffff802256ac>] schedule_tail+0x45/0xa6
> Dec 11 22:47:22 dy-base  [<ffffffff8020a6a8>] child_rip+0xa/0x12
> Dec 11 22:47:22 dy-base  [<ffffffff802399d8>] worker_thread+0x0/0x134
> Dec 11 22:47:22 dy-base  [<ffffffff8023c60d>] kthread+0x0/0x10b
> Dec 11 22:47:22 dy-base  [<ffffffff8020a69e>] child_rip+0x0/0x12
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base Code:
> Dec 11 22:47:22 dy-base 8b
> Dec 11 22:47:22 dy-base 83
> Dec 11 22:47:22 dy-base 0c
> Dec 11 22:47:22 dy-base 01
> Dec 11 22:47:22 dy-base 00
> Dec 11 22:47:22 dy-base 00
> Dec 11 22:47:22 dy-base 48
> Dec 11 22:47:22 dy-base 8d
> Dec 11 22:47:22 dy-base 8b
> Dec 11 22:47:22 dy-base 98
> Dec 11 22:47:22 dy-base 02
> Dec 11 22:47:22 dy-base 00
> Dec 11 22:47:22 dy-base 00
> Dec 11 22:47:22 dy-base 41
> Dec 11 22:47:22 dy-base 8b
> Dec 11 22:47:22 dy-base 54
> Dec 11 22:47:22 dy-base 24
> Dec 11 22:47:22 dy-base 04
> Dec 11 22:47:22 dy-base 41
> Dec 11 22:47:22 dy-base 89
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base RIP
> Dec 11 22:47:22 dy-base  [<ffffffff803f3aba>] spin_bug+0x69/0xdf
> Dec 11 22:47:22 dy-base  RSP <ffff81011fb89bc0>
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base Kernel panic - not syncing: Fatal exception
> Dec 11 22:47:22 dy-base
> Dec 11 22:47:22 dy-base Rebooting in 5 seconds..
>=20
> After this, sometimes the server reboots normally, but sometimes hangs, n=
o
> console, no sysreq, no nothing.
>=20
> This is a "simple" crash, no "too much" data lost, or else.
>=20
> Can somebody help me to tracking down the problem?
>=20
> Thanks,
> Janos Haar
>=20
>=20
>=20
>=20
---1463747160-1853555891-1165933958=:19050--
