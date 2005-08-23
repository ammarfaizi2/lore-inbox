Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVHWHPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVHWHPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVHWHPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:15:14 -0400
Received: from www.pro-linux.de ([213.239.211.178]:56023 "EHLO pro-linux.de")
	by vger.kernel.org with ESMTP id S1750820AbVHWHPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:15:12 -0400
Date: Tue, 23 Aug 2005 09:14:57 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process in D state with st driver
Message-ID: <20050823071456.GC3360@kiwi.hjbaader.home>
References: <20050823054333.GA3360@kiwi.hjbaader.home> <20050822233051.4f8fa377.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20050822233051.4f8fa377.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> >
> > I do nightly backups on tape. Every 3 to 4 weeks a process is stuck in
> >  D state while accessing the drive:
> >=20
> >  12398 ?        D      0:00 /usr/sbin/amcheck -ms daily
> >=20
> >  There are no messages in the log. Only a reboot can remove this proces=
s.
>=20
> Next time it happens, do
>=20
> 	dmesg -c
> 	echo t > /proc/sysrq-trigger
> 	dmesg -s 1000000 > foo

thanks for looking into this. Since I haven't rebooted yet, I have the
output for you. Hope it helps.

Regards,
hjb


function+0x0/0x20
 [<c0123d24>] sigprocmask+0x64/0x100
 [<d0902345>] nfsd+0xe5/0x320 [nfsd]
 [<d0902260>] nfsd+0x0/0x320 [nfsd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
nfsd          S 00000286     0  1086      1          1087  1085 (L-TLB)
cd9f1f0c 00000046 00000286 00000286 cf89da40 0774a6c0 0007d169 cc1d2ac0=20
       0000be0e 0774a6c0 0007d169 cdee9560 cdee9684 831defc2 cd9f1f14 cf514=
698=20
       cdeb9e00 c026f718 ce7fdf14 cc129f58 831defc2 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c012b996>] add_wait_queue+0x16/0x40
 [<d08b9662>] svc_recv+0x3b2/0x4c0 [sunrpc]
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0123d24>] sigprocmask+0x64/0x100
 [<d0902345>] nfsd+0xe5/0x320 [nfsd]
 [<d0902260>] nfsd+0x0/0x320 [nfsd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
nfsd          S 00000028     0  1087      1          1088  1086 (L-TLB)
cc1c9f0c 00000046 00000000 00000028 ce3cf060 c1205dc0 c01208f0 cc1d25a0=20
       000331a4 68393cc0 0007d168 cde33aa0 cde33bc4 831de558 cc1c9f14 cf514=
698=20
       cdeb9c00 c026f718 cee07f14 cd9c1f14 831de558 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c012b996>] add_wait_queue+0x16/0x40
 [<d08b9662>] svc_recv+0x3b2/0x4c0 [sunrpc]
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0123d24>] sigprocmask+0x64/0x100
 [<d0902345>] nfsd+0xe5/0x320 [nfsd]
 [<d0902260>] nfsd+0x0/0x320 [nfsd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
nfsd          S 00000028     0  1088      1          1089  1087 (L-TLB)
ce7f9f0c 00000046 00000000 00000028 ce3cf060 67c9ae34 0007d168 c12ba5a0=20
       0000cff7 68a24bb6 0007d168 cde33580 cde336a4 831de55e ce7f9f14 cf514=
698=20
       cdeb9a00 c026f718 cf4dff14 ce7fbf14 831de55e 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c012b996>] add_wait_queue+0x16/0x40
 [<d08b9662>] svc_recv+0x3b2/0x4c0 [sunrpc]
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0123d24>] sigprocmask+0x64/0x100
 [<d0902345>] nfsd+0xe5/0x320 [nfsd]
 [<d0902260>] nfsd+0x0/0x320 [nfsd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
nfsd          S 00000028     0  1089      1          1090  1088 (L-TLB)
ce7fbf0c 00000046 00000000 00000028 ce3cf060 c1205dc0 c01208f0 cde33580=20
       000227e1 687e7b0f 0007d168 cde33060 cde33184 831de55c ce7fbf14 cf514=
698=20
       cdeb9800 c026f718 ce7f9f14 cee07f14 831de55c 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c012b996>] add_wait_queue+0x16/0x40
 [<d08b9662>] svc_recv+0x3b2/0x4c0 [sunrpc]
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0123d24>] sigprocmask+0x64/0x100
 [<d0902345>] nfsd+0xe5/0x320 [nfsd]
 [<d0902260>] nfsd+0x0/0x320 [nfsd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
nfsd          S 00000028     0  1090      1          1091  1089 (L-TLB)
ce7fdf0c 00000046 000000d0 00000028 cf89da40 c120ddc0 c01208f0 ce937020=20
       00000d89 07752e1d 0007d169 cc1d2ac0 cc1d2be4 831defc2 ce7fdf14 cf514=
698=20
       cdeb9600 c026f718 c120eb58 cd9f1f14 831defc2 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c012b996>] add_wait_queue+0x16/0x40
 [<d08b9662>] svc_recv+0x3b2/0x4c0 [sunrpc]
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0123d24>] sigprocmask+0x64/0x100
 [<d0902345>] nfsd+0xe5/0x320 [nfsd]
 [<d0902260>] nfsd+0x0/0x320 [nfsd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
nfsd          S 00000028     0  1091      1          1092  1090 (L-TLB)
cee07f0c 00000046 00000000 00000028 ce3cf060 c1205dc0 c01208f0 cde33060=20
       0003758d 685c0936 0007d168 cc1d25a0 cc1d26c4 831de55a cee07f14 cf514=
698=20
       cdeb9400 c026f718 ce7fbf14 cc1c9f14 831de55a 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c012b996>] add_wait_queue+0x16/0x40
 [<d08b9662>] svc_recv+0x3b2/0x4c0 [sunrpc]
 [<c0114530>] default_wake_function+0x0/0x20
 [<c010540f>] do_IRQ+0x1f/0x30
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0123d24>] sigprocmask+0x64/0x100
 [<d0902345>] nfsd+0xe5/0x320 [nfsd]
 [<d0902260>] nfsd+0x0/0x320 [nfsd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
nfsd          S 0000007B     0  1092      1          1094  1091 (L-TLB)
cd9c1f0c 00000046 ceac0d90 0000007b ce3cf060 c1205dc0 c01208f0 cde33aa0=20
       0001232d 68194c57 0007d168 cc1d2080 cc1d21a4 831de556 cd9c1f14 cf514=
698=20
       cdeb9200 c026f718 cc1c9f14 c1206b58 831de556 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c012b996>] add_wait_queue+0x16/0x40
 [<d08b9662>] svc_recv+0x3b2/0x4c0 [sunrpc]
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0123d24>] sigprocmask+0x64/0x100
 [<d0902345>] nfsd+0xe5/0x320 [nfsd]
 [<d0902260>] nfsd+0x0/0x320 [nfsd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
lockd         S CF284540     0  1094      1          1104  1092 (L-TLB)
cfdedf28 00000046 c0112486 cf284540 cfdbbae0 71168801 0000000e cf284540=20
       00004d0f 71176b6a 0000000e cfd9aac0 cfd9abe4 cfdedf94 7fffffff cf514=
6f8=20
       cdeb9000 c026f75f c134a760 00000000 cdeb9000 00000000 00000202 cf514=
6f8=20
Call Trace:
 [<c0112486>] recalc_task_prio+0x96/0x170
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c012b996>] add_wait_queue+0x16/0x40
 [<d08b9662>] svc_recv+0x3b2/0x4c0 [sunrpc]
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0127c67>] __create_workqueue+0x147/0x180
 [<c0114530>] default_wake_function+0x0/0x20
 [<d08a4065>] lockd+0x145/0x270 [lockd]
 [<d08a3f20>] lockd+0x0/0x270 [lockd]
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
rpciod/0      S 00010000     0  1095      9          1096    46 (L-TLB)
cc1d7f50 00000046 00010000 00010000 ce3cf060 cdee9040 c01247ab cf284a60=20
       00001823 7111f614 0000000e cdee9040 cdee9164 cd9937f8 cd9937e0 cc1d7=
f94=20
       c01275e0 c01277ec 00000001 c12bac80 cdee9040 cc1d6000 cd9937f0 fffff=
fff=20
Call Trace:
 [<c01247ab>] do_sigaction+0x17b/0x210
 [<c01275e0>] worker_thread+0x0/0x230
 [<c01277ec>] worker_thread+0x20c/0x230
 [<c0114530>] default_wake_function+0x0/0x20
 [<c026eaf5>] schedule+0x3a5/0x730
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01275e0>] worker_thread+0x0/0x230
 [<c012b737>] kthread+0xa7/0xb0
 [<c012b690>] kthread+0x0/0xb0
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
rpciod/1      S 00010000     0  1096      9                1095 (L-TLB)
cf779f50 00000046 00010000 00010000 cfdbbae0 cf284540 c01247ab cfb8f580=20
       00000d5a 7117e396 0000000e cf284540 cf284664 cd993858 cd993840 cf779=
f94=20
       c01275e0 c01277ec 00000001 c12bac80 cf284540 cf778000 cd993850 fffff=
fff=20
Call Trace:
 [<c01247ab>] do_sigaction+0x17b/0x210
 [<c01275e0>] worker_thread+0x0/0x230
 [<c01277ec>] worker_thread+0x20c/0x230
 [<c0114530>] default_wake_function+0x0/0x20
 [<c026eaf5>] schedule+0x3a5/0x730
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01275e0>] worker_thread+0x0/0x230
 [<c012b737>] kthread+0xa7/0xb0
 [<c012b690>] kthread+0x0/0xb0
 [<c0100e7d>] kernel_thread_helper+0x5/0x18
rpc.mountd    S CE3E6060     0  1104      1          1174  1094 (NOTLB)
ce2c5eb0 00000086 000000d0 ce3e6060 ce3cf560 d16a4c5b 0007d153 cf967a60=20
       0001710a d16899c4 0007d153 cdee9a80 cdee9ba4 ce398284 7fffffff 00000=
005=20
       ce398184 c026f75f 00000202 c023c522 ce36c920 ce365db8 ce2c5f3c ce36c=
920=20
Call Trace:
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c023c522>] tcp_poll+0x22/0x150
 [<c0219f59>] sock_poll+0x19/0x20
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c0102ba9>] syscall_call+0x7/0xb
mysqld        S CFB8F060     0  1108   1049          1111       (NOTLB)
ce3afeb0 00000082 00000000 cfb8f060 cfb86540 c02b0d80 00000000 b6be5000=20
       0002f2fa 97548762 0000000e cfb8f060 cfb8f184 ce3d5198 7fffffff 00000=
006=20
       ce3d5190 c026f75f cf586ac0 00000020 00000202 c026d7f0 ce283920 cf657=
3d8=20
Call Trace:
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c026d7f0>] unix_poll+0x20/0x90
 [<c0219f59>] sock_poll+0x19/0x20
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c0161b87>] sys_fcntl64+0x47/0x80
 [<c0102ba9>] syscall_call+0x7/0xb
mysqld        S 00000004     0  1111   1049                1108 (NOTLB)
ce2fdec4 00000082 c0112ac5 00000004 cfb86540 ce3ae000 c120d400 00000001=20
       000050fa 94b302e1 0000000e cf284a60 cf284b84 ce2fc000 7fffffff 00000=
000=20
       7fffffff c026f75f ce2fdf20 ce2fdf28 cf284a60 c01221e7 cfbd04dc ce2fd=
f20=20
Call Trace:
 [<c0112ac5>] try_to_wake_up+0x275/0x2c0
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c01221e7>] dequeue_signal+0xa7/0xc0
 [<c01242ad>] sys_rt_sigtimedwait+0x1cd/0x2b0
 [<c026eeb5>] preempt_schedule+0x35/0x50
 [<c012e89a>] futex_wake+0x6a/0xc0
 [<c012f0b2>] do_futex+0x42/0x70
 [<c012f1b3>] sys_futex+0xd3/0xf0
 [<c0102ba9>] syscall_call+0x7/0xb
smartd        S CE0AB100     0  1174      1          1185  1104 (NOTLB)
ca093f50 00000082 c129ba14 ce0ab100 cfb86a40 c1205dc0 c01208f0 cf284020=20
       0000e6a9 e9860ced 0007d120 cf8dc540 cf8dc664 82fdbe05 ca093f58 000f4=
1a7=20
       00000707 c026f718 c1206b48 c1206b48 82fdbe05 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c01213d8>] sys_nanosleep+0x18/0x150
 [<c012148e>] sys_nanosleep+0xce/0x150
 [<c0102ba9>] syscall_call+0x7/0xb
uml_switch    S CA095F98     0  1185      1          1206  1174 (NOTLB)
ca095f14 00000082 ce189d80 ca095f98 cfb86040 00000202 ca954028 cf284020=20
       0000406e e3ee0678 0007d16d cf6efac0 cf6efbe4 00000000 7fffffff ca095=
f60=20
       7fffffff c026f75f cfabe740 ce365a60 ca095f98 c0163200 cfabe740 c0163=
1cc=20
Call Trace:
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0163200>] do_pollfd+0x80/0x90
 [<c01631cc>] do_pollfd+0x4c/0x90
 [<c016326f>] do_poll+0x5f/0xc0
 [<c01632b1>] do_poll+0xa1/0xc0
 [<c016340a>] sys_poll+0x13a/0x200
 [<c01020d7>] sys_sigreturn+0xb7/0xd0
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0102ba9>] syscall_call+0x7/0xb
rpc.statd     S CE189380     0  1206      1          1208  1185 (NOTLB)
cacf1eb0 00000082 000000d0 ce189380 ce3cf7e0 cf513ab8 00000202 ca700028=20
       0000709a aae0d5a9 0000000f cf434ac0 cf434be4 cf899a84 7fffffff 00000=
007=20
       cf899984 c026f75f 00000202 c023c522 ce283880 cf513918 cacf1f3c ce283=
880=20
Call Trace:
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c023c522>] tcp_poll+0x22/0x150
 [<c0219f59>] sock_poll+0x19/0x20
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c0102ba9>] syscall_call+0x7/0xb
eclipse_clien S 00000000     0  1208      1          1213  1206 (NOTLB)
ca271eb0 00000086 cdc2eaa0 00000000 cfdbbd60 c120ddc0 c01208f0 ce937020=20
       000abc19 8ddddfb8 0007d143 cf6ef5a0 cf6ef6c4 82e92196 ca271eb8 00000=
000=20
       00000000 c026f718 c120e8f0 c120e8f0 82e92196 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0152c5d>] invalidate_inode_buffers+0xd/0x60
 [<c0162890>] __pollwait+0x0/0xa0
 [<c01668dd>] dput+0x1d/0x1c0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c0102ba9>] syscall_call+0x7/0xb
friend0       R running     0  1213      1          1217  1208 (NOTLB)
friend1       R running     0  1217      1          1235  1213 (NOTLB)
proftpd       S CD915AA0     0  1235      1          1238  1217 (NOTLB)
cd963eb0 00000082 00000000 cd915aa0 cc178080 c1205dc0 c01208f0 cf284020=20
       0001eb0e 60d7e87e 0007d167 cd915aa0 cd915bc4 82e75acd cd963eb8 00000=
001=20
       ca985b10 c026f718 cfbd0928 cacd3d08 82e75acd 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c012113b>] run_timer_softirq+0x11b/0x1a0
 [<c0102ba9>] syscall_call+0x7/0xb
atd           S 00000000     0  1238      1          1241  1235 (NOTLB)
cc129f50 00000086 00001000 00000000 cfb862c0 c120ddc0 c01208f0 ce937020=20
       000040bd e0f4b3fd 0007d15c ca0aa040 ca0aa164 831d266f cc129f58 000f4=
1a7=20
       00000e10 c026f718 cd9f1f14 c120eb58 831d266f 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c01213d8>] sys_nanosleep+0x18/0x150
 [<c012148e>] sys_nanosleep+0xce/0x150
 [<c0102ba9>] syscall_call+0x7/0xb
cron          S 00000000     0  1241      1 12396    1249  1238 (NOTLB)
cc109f50 00000082 000001c8 00000000 ce3cf2e0 c1205dc0 c01208f0 cf284020=20
       00009f11 cbe526b1 0007d163 ca0aa560 ca0aa684 82e7940d cc109f58 000f4=
1a7=20
       0000003c c026f718 c13b6648 c02fb3c0 82e7940d 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c01213d8>] sys_nanosleep+0x18/0x150
 [<c012148e>] sys_nanosleep+0xce/0x150
 [<c0102ba9>] syscall_call+0x7/0xb
apache-ssl    S CE685EB8     0  1249      1  7250    1253  1241 (NOTLB)
ce685eb0 00000086 c120ddc0 ce685eb8 cf4900a0 c120ddc0 c01208f0 ce937020=20
       000023a4 e3beb7d3 0007d16d cd915060 cd915184 82e7568f ce685eb8 00000=
000=20
       00000000 c026f718 c120e680 c120e680 82e7568f 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c011bf56>] sys_waitpid+0x16/0x1a
 [<c0102ba9>] syscall_call+0x7/0xb
getty         S 00000202     0  1253      1          1254  1249 (NOTLB)
cebd7e80 00000082 c0135831 00000202 cfdbb5e0 c121a000 0000000e cedf9560=20
       000305e9 91bc059e 00000010 cf967540 cf967664 cf897600 7fffffff cf897=
600=20
       bff8751b c026f75f cfda5000 00000202 c0118e15 cfda5000 00000008 cebd6=
000=20
Call Trace:
 [<c0135831>] find_get_page+0x31/0x40
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0118e15>] release_console_sem+0x75/0xb0
 [<c012b996>] add_wait_queue+0x16/0x40
 [<c01e0bab>] read_chan+0x5fb/0x6f0
 [<c01e0dfc>] write_chan+0x15c/0x210
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01daeec>] tty_ldisc_deref+0x4c/0x70
 [<c01dbb72>] tty_read+0xb2/0xc0
 [<c0150dc7>] vfs_read+0x87/0xf0
 [<c015103d>] sys_read+0x3d/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
getty         S 00000133     0  1254      1          1255  1253 (NOTLB)
ce151e80 00000082 c0135831 00000133 cf490d20 c013685e 00000001 cedf9040=20
       00018e28 91ebf875 00000010 cd915580 cd9156a4 cf897560 7fffffff cf897=
560=20
       bff8664b c026f75f cd996000 00000202 c0118e15 cd996000 00000008 ce150=
000=20
Call Trace:
 [<c0135831>] find_get_page+0x31/0x40
 [<c013685e>] filemap_nopage+0xae/0x370
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0118e15>] release_console_sem+0x75/0xb0
 [<c012b996>] add_wait_queue+0x16/0x40
 [<c01e0bab>] read_chan+0x5fb/0x6f0
 [<c01e0dfc>] write_chan+0x15c/0x210
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01daeec>] tty_ldisc_deref+0x4c/0x70
 [<c01dbb72>] tty_read+0xb2/0xc0
 [<c0150dc7>] vfs_read+0x87/0xf0
 [<c015103d>] sys_read+0x3d/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
getty         S 00000133     0  1255      1          1256  1254 (NOTLB)
cc107e80 00000086 c0135831 00000133 cf63f0c0 c013685e 00000001 cf284020=20
       00016965 99522e6f 00000010 ca0aaa80 ca0aaba4 cf8974c0 7fffffff cf897=
4c0=20
       bf9ed15b c026f75f cda39000 00000202 c0118e15 cda39000 00000008 cc106=
000=20
Call Trace:
 [<c0135831>] find_get_page+0x31/0x40
 [<c013685e>] filemap_nopage+0xae/0x370
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0118e15>] release_console_sem+0x75/0xb0
 [<c012b996>] add_wait_queue+0x16/0x40
 [<c01e0bab>] read_chan+0x5fb/0x6f0
 [<c01e0dfc>] write_chan+0x15c/0x210
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01daeec>] tty_ldisc_deref+0x4c/0x70
 [<c01dbb72>] tty_read+0xb2/0xc0
 [<c0150dc7>] vfs_read+0x87/0xf0
 [<c015103d>] sys_read+0x3d/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
getty         S 00000133     0  1256      1          1257  1255 (NOTLB)
ce687e80 00000086 c0135831 00000133 cf63fac0 c013685e 00000001 cedf9560=20
       0001b169 94cb329a 00000010 cac955a0 cac956c4 cf897420 7fffffff cf897=
420=20
       bf9931cb c026f75f cea41000 00000202 c0118e15 cea41000 fffcd5e1 00000=
014=20
Call Trace:
 [<c0135831>] find_get_page+0x31/0x40
 [<c013685e>] filemap_nopage+0xae/0x370
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0118e15>] release_console_sem+0x75/0xb0
 [<c012b996>] add_wait_queue+0x16/0x40
 [<c01e0bab>] read_chan+0x5fb/0x6f0
 [<c0114530>] default_wake_function+0x0/0x20
 [<c011d575>] irq_exit+0x45/0x50
 [<c0103bcc>] apic_timer_interrupt+0x1c/0x30
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01dbb72>] tty_read+0xb2/0xc0
 [<c0150dc7>] vfs_read+0x87/0xf0
 [<c015103d>] sys_read+0x3d/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
getty         S 00000133     0  1257      1          1260  1256 (NOTLB)
ce6b7e80 00000082 c0135831 00000133 cf63f840 c013685e 00000001 cedf9560=20
       0001eb21 93aadfeb 00000010 cac95080 cac951a4 ce3e6380 7fffffff ce3e6=
380=20
       bffeda7b c026f75f cf259000 00000202 c0118e15 cf259000 00000008 ce6b6=
000=20
Call Trace:
 [<c0135831>] find_get_page+0x31/0x40
 [<c013685e>] filemap_nopage+0xae/0x370
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0118e15>] release_console_sem+0x75/0xb0
 [<c012b996>] add_wait_queue+0x16/0x40
 [<c01e0bab>] read_chan+0x5fb/0x6f0
 [<c01e0dfc>] write_chan+0x15c/0x210
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01daeec>] tty_ldisc_deref+0x4c/0x70
 [<c01dbb72>] tty_read+0xb2/0xc0
 [<c0150dc7>] vfs_read+0x87/0xf0
 [<c015103d>] sys_read+0x3d/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
getty         S 00000133     0  1260      1          1261  1257 (NOTLB)
cfa39e80 00000082 c0135831 00000133 cf63f340 c013685e 00000001 cedf9040=20
       0001b712 93f54a5b 00000010 cf8dca60 cf8dcb84 cf897380 7fffffff cf897=
380=20
       bfb39feb c026f75f ceb47000 00000202 c0118e15 ceb47000 00000008 cfa38=
000=20
Call Trace:
 [<c0135831>] find_get_page+0x31/0x40
 [<c013685e>] filemap_nopage+0xae/0x370
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0118e15>] release_console_sem+0x75/0xb0
 [<c012b996>] add_wait_queue+0x16/0x40
 [<c01e0bab>] read_chan+0x5fb/0x6f0
 [<c01e0dfc>] write_chan+0x15c/0x210
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01daeec>] tty_ldisc_deref+0x4c/0x70
 [<c01dbb72>] tty_read+0xb2/0xc0
 [<c0150dc7>] vfs_read+0x87/0xf0
 [<c015103d>] sys_read+0x3d/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
getty         S D089BCC4     0  1261      1         30398  1260 (NOTLB)
ce6a1e80 00000086 ce6a1e78 d089bcc4 cf63f5c0 d089bcc4 cda3f954 ce937020=20
       0000b937 9bdd2264 00000010 cf8d8a60 cf8d8b84 cacc1380 7fffffff cacc1=
380=20
       bfab09ab c026f75f d08600af cda3f000 cf24a408 00000008 00000202 d0860=
5e5=20
Call Trace:
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<d08600af>] uart_start+0x1f/0x30 [serial_core]
 [<d08605e5>] uart_write+0xc5/0xd0 [serial_core]
 [<c012b996>] add_wait_queue+0x16/0x40
 [<c01e0bab>] read_chan+0x5fb/0x6f0
 [<c01e0dfc>] write_chan+0x15c/0x210
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0114530>] default_wake_function+0x0/0x20
 [<c01daeec>] tty_ldisc_deref+0x4c/0x70
 [<c01dbb72>] tty_read+0xb2/0xc0
 [<c0150dc7>] vfs_read+0x87/0xf0
 [<c015103d>] sys_read+0x3d/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
sshd          S CAC95AC0     0 30398      1 14725   25165  1261 (NOTLB)
c810feb0 00000082 00000000 cac95ac0 cc178a80 c02b0d80 00000000 c0a37560=20
       0000db28 4f1f6f98 0007d125 cac95ac0 cac95be4 ca0897d8 7fffffff 00000=
005=20
       ca0897d0 c026f75f 00000202 c023c522 c0871420 cedf7118 c810ff3c c0871=
420=20
Call Trace:
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c023c522>] tcp_poll+0x22/0x150
 [<c0219f59>] sock_poll+0x19/0x20
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c0102ba9>] syscall_call+0x7/0xb
xinetd        S C02B0D80     0 25165      1          7284 30398 (NOTLB)
c7cabeb0 00000086 c0139e98 c02b0d80 cfb6e5a0 00000001 00000202 cf4345a0=20
       0000cda5 1dbfe96c 0007b9f5 cf740560 cf740684 ca089c78 7fffffff 00000=
009=20
       ca089c70 c026f75f c0257588 ccfcf6a0 c3f022c0 c7cabf3c ccfcf6a0 00000=
100=20
Call Trace:
 [<c0139e98>] __alloc_pages+0x298/0x3c0
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0257588>] udp_poll+0x18/0x130
 [<c0219f59>] sock_poll+0x19/0x20
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c011bf56>] sys_waitpid+0x16/0x1a
 [<c0102ba9>] syscall_call+0x7/0xb
gcache        S C6B7240C     0  7250   1249          7259       (NOTLB)
c0d83dfc 00000086 c0d83e34 c6b7240c cc178300 c6b7240c cf8ed09c c9122a60=20
       00025996 21015cd0 0007654d c0448060 c0448184 00000000 7fffffff c0d83=
e60=20
       c0d83ea0 c026f75f 00000246 ce1ea778 c13aace0 c6b7240c c019c267 c13aa=
ce0=20
Call Trace:
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c019c267>] journal_stop+0x167/0x220
 [<c012bab6>] prepare_to_wait_exclusive+0x16/0x50
 [<c021f7d4>] wait_for_packet+0xb4/0x120
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c013685e>] filemap_nopage+0xae/0x370
 [<c01369a7>] filemap_nopage+0x1f7/0x370
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c021f8c7>] skb_recv_datagram+0x87/0xb0
 [<c026c28d>] unix_accept+0x5d/0xf0
 [<c021a703>] sys_accept+0xb3/0x160
 [<c01141ea>] scheduler_tick+0xaa/0x3f0
 [<c012113b>] run_timer_softirq+0x11b/0x1a0
 [<c011d446>] __do_softirq+0xc6/0xe0
 [<c01b5642>] copy_from_user+0x32/0x60
 [<c021b0fa>] sys_socketcall+0xaa/0x1b0
 [<c0102ba9>] syscall_call+0x7/0xb
apache-ssl    S 00000400     0  7259   1249          7260  7250 (NOTLB)
ce689e14 00000082 c0103bcc 00000400 cfb6e820 c106fcc0 00000000 cf284020=20
       000571b9 3bc8f28d 0007654d cf8d8020 cf8d8144 cf8d8020 7fffffff ce688=
000=20
       7fffffff c026f75f 00000000 00000000 000080d2 c0139f9c c0139e98 c02b0=
da0=20
Call Trace:
 [<c0103bcc>] apic_timer_interrupt+0x1c/0x30
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0139f9c>] __alloc_pages+0x39c/0x3c0
 [<c0139e98>] __alloc_pages+0x298/0x3c0
 [<c021cbaf>] release_sock+0xf/0x60
 [<c023ff4a>] wait_for_connect+0xea/0xf0
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c023ff99>] tcp_accept+0x49/0xd0
 [<c025d178>] inet_accept+0x28/0xb0
 [<c021a703>] sys_accept+0xb3/0x160
 [<c01b55f1>] copy_to_user+0x31/0x50
 [<c0124b38>] sys_rt_sigaction+0x88/0xa0
 [<c01b5642>] copy_from_user+0x32/0x60
 [<c021b0fa>] sys_socketcall+0xaa/0x1b0
 [<c0102ba9>] syscall_call+0x7/0xb
apache-ssl    S C021CBAF     0  7260   1249          7261  7259 (NOTLB)
ce6a3e14 00000082 00000202 c021cbaf cfb6e320 00000000 00000206 cf284020=20
       0005963a 3d546ded 0007654d cf8d8540 cf8d8664 cf8d8540 7fffffff ce6a2=
000=20
       7fffffff c026f75f 00ec0f60 c012113b ce6a2000 ce6a3e28 ce6a3e28 00000=
001=20
Call Trace:
 [<c021cbaf>] release_sock+0xf/0x60
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c012113b>] run_timer_softirq+0x11b/0x1a0
 [<c021cbaf>] release_sock+0xf/0x60
 [<c023ff4a>] wait_for_connect+0xea/0xf0
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c0103bcc>] apic_timer_interrupt+0x1c/0x30
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c023ff99>] tcp_accept+0x49/0xd0
 [<c025d178>] inet_accept+0x28/0xb0
 [<c021a703>] sys_accept+0xb3/0x160
 [<c01b55f1>] copy_to_user+0x31/0x50
 [<c0124b38>] sys_rt_sigaction+0x88/0xa0
 [<c01b5642>] copy_from_user+0x32/0x60
 [<c021b0fa>] sys_socketcall+0xaa/0x1b0
 [<c0102ba9>] syscall_call+0x7/0xb
apache-ssl    S C021CBAF     0  7261   1249          7262  7260 (NOTLB)
ce68be14 00000086 00000202 c021cbaf cc178800 00000000 00000206 cf284020=20
       00084c04 43d38768 0007654d cedf9a80 cedf9ba4 cedf9a80 7fffffff ce68a=
000=20
       7fffffff c026f75f 00000000 00000000 000080d2 c0139f9c c0139e98 c02b0=
da0=20
Call Trace:
 [<c021cbaf>] release_sock+0xf/0x60
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0139f9c>] __alloc_pages+0x39c/0x3c0
 [<c0139e98>] __alloc_pages+0x298/0x3c0
 [<c021cbaf>] release_sock+0xf/0x60
 [<c023ff4a>] wait_for_connect+0xea/0xf0
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c023ff99>] tcp_accept+0x49/0xd0
 [<c025d178>] inet_accept+0x28/0xb0
 [<c021a703>] sys_accept+0xb3/0x160
 [<c01b55f1>] copy_to_user+0x31/0x50
 [<c0124b38>] sys_rt_sigaction+0x88/0xa0
 [<c01b5642>] copy_from_user+0x32/0x60
 [<c021b0fa>] sys_socketcall+0xaa/0x1b0
 [<c0102ba9>] syscall_call+0x7/0xb
apache-ssl    S C021CBAF     0  7262   1249          7263  7261 (NOTLB)
cd831e14 00000086 00000202 c021cbaf c068dcc0 00000000 00000206 ce937020=20
       000755a0 5005dc67 0007654d cedf9560 cedf9684 cedf9560 7fffffff cd830=
000=20
       7fffffff c026f75f 00000000 00000000 000080d2 c0139f9c c0139e98 c02b0=
da0=20
Call Trace:
 [<c021cbaf>] release_sock+0xf/0x60
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c0139f9c>] __alloc_pages+0x39c/0x3c0
 [<c0139e98>] __alloc_pages+0x298/0x3c0
 [<c021cbaf>] release_sock+0xf/0x60
 [<c023ff4a>] wait_for_connect+0xea/0xf0
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c023ff99>] tcp_accept+0x49/0xd0
 [<c025d178>] inet_accept+0x28/0xb0
 [<c021a703>] sys_accept+0xb3/0x160
 [<c01b55f1>] copy_to_user+0x31/0x50
 [<c0124b38>] sys_rt_sigaction+0x88/0xa0
 [<c01b5642>] copy_from_user+0x32/0x60
 [<c021b0fa>] sys_socketcall+0xaa/0x1b0
 [<c0102ba9>] syscall_call+0x7/0xb
apache-ssl    S C012113B     0  7263   1249                7262 (NOTLB)
ce087e14 00000086 00ec0f60 c012113b ce3cfa60 ce087de8 ce087de8 cf284020=20
       00069e6e 50ab2bb0 0007654d cedf9040 cedf9164 cedf9040 7fffffff ce086=
000=20
       7fffffff c026f75f ce3cfaa0 00000046 02893067 c011d575 c0103bcc 02893=
067=20
Call Trace:
 [<c012113b>] run_timer_softirq+0x11b/0x1a0
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c011d575>] irq_exit+0x45/0x50
 [<c0103bcc>] apic_timer_interrupt+0x1c/0x30
 [<c021cbaf>] release_sock+0xf/0x60
 [<c023ff4a>] wait_for_connect+0xea/0xf0
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c023ff99>] tcp_accept+0x49/0xd0
 [<c025d178>] inet_accept+0x28/0xb0
 [<c021a703>] sys_accept+0xb3/0x160
 [<c01b55f1>] copy_to_user+0x31/0x50
 [<c0124b38>] sys_rt_sigaction+0x88/0xa0
 [<c01b5642>] copy_from_user+0x32/0x60
 [<c021b0fa>] sys_socketcall+0xaa/0x1b0
 [<c0102ba9>] syscall_call+0x7/0xb
twistd        S C0A37A80     0  7284      1               25165 (NOTLB)
cf161eb0 00000086 00000000 c0a37a80 cfdbb860 c120ddc0 c01208f0 ce937020=20
       004ca7b2 016cf705 0007ce70 c0a37a80 c0a37ba4 8621807e cf161eb8 00000=
006=20
       c4203ad0 c026f718 c120eae0 c120eae0 8621807e 00000001 00000000 4b87a=
d6e=20
Call Trace:
 [<c01208f0>] __mod_timer+0xc0/0x120
 [<c026f718>] schedule_timeout+0x68/0xc0
 [<c01213a0>] process_timeout+0x0/0x10
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c012113b>] run_timer_softirq+0x11b/0x1a0
 [<c0102ba9>] syscall_call+0x7/0xb
cron          S C02AFB00     0 12396   1241 12397               (NOTLB)
c5db5eb8 00000086 c01286f8 c02afb00 cf490aa0 c1206e20 c5db4000 ce937020=20
       00007c71 53ff1883 0007acb4 ce937a60 ce937b84 ce6c6b90 c5db5ee0 c5db5=
ed4=20
       b7ccd000 c015c227 00000000 ce937a60 c012bb40 c5db5eec c5db5eec c5db5=
f64=20
Call Trace:
 [<c01286f8>] __rcu_process_callbacks+0x78/0xc0
 [<c015c227>] pipe_wait+0x77/0xa0
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c0159edb>] cp_new_stat64+0xeb/0x100
 [<c012bb40>] autoremove_wake_function+0x0/0x40
 [<c015c4a8>] pipe_readv+0x1f8/0x320
 [<c0144e12>] vma_link+0x52/0xe0
 [<c015c5f7>] pipe_read+0x27/0x30
 [<c0150dc7>] vfs_read+0x87/0xf0
 [<c015103d>] sys_read+0x3d/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
amcheck       S C027EF1B     0 12397  12396 12398               (NOTLB)
c54cdf40 00000082 c54cdfbc c027ef1b cf89d040 0000000e 0000000b cf284020=20
       00005bb9 5c97dec7 0007acb4 ce937540 ce937664 ce9375e8 00000001 fffff=
e00=20
       ce9375e8 c011bcaf 00000000 00000001 00000000 ce937540 c0114530 00000=
000=20
Call Trace:
 [<c011bcaf>] do_wait+0x18f/0x370
 [<c0114530>] default_wake_function+0x0/0x20
 [<c0117d7a>] do_fork+0x12a/0x182
 [<c0114530>] default_wake_function+0x0/0x20
 [<c011bf3b>] sys_wait4+0x2b/0x30
 [<c0102ba9>] syscall_call+0x7/0xb
amcheck       D D08727D5     0 12398  12397                     (NOTLB)
c0879dd8 00000082 00001055 d08727d5 cf89d540 00001055 cf68e000 cf284020=20
       000107d5 62329cd4 0007acb4 c0448580 c04486a4 c0878000 c1341824 c0879=
df8=20
       c0879e30 c026efb5 c1341820 00000000 c0448580 c0114530 00000000 00000=
000=20
Call Trace:
 [<d08727d5>] scsi_dispatch_cmd+0x1c5/0x280 [scsi_mod]
 [<c026efb5>] wait_for_completion+0x85/0xd0
 [<c0114530>] default_wake_function+0x0/0x20
 [<d0877258>] scsi_insert_special_req+0x28/0x30 [scsi_mod]
 [<c0114530>] default_wake_function+0x0/0x20
 [<d08664b9>] st_do_scsi+0xd9/0x180 [st]
 [<d08664db>] st_do_scsi+0xfb/0x180 [st]
 [<d0866c06>] test_ready+0x76/0x170 [st]
 [<d0866d93>] check_tape+0x93/0x490 [st]
 [<d086a850>] enlarge_buffer+0xf0/0x1b0 [st]
 [<d08672bf>] st_open+0x12f/0x1b0 [st]
 [<c0159401>] chrdev_open+0xe1/0x190
 [<c015030c>] dentry_open+0x14c/0x240
 [<c01501b0>] filp_open+0x50/0x60
 [<c0150456>] get_unused_fd+0x56/0xb0
 [<c0150575>] sys_open+0x35/0x70
 [<c0102ba9>] syscall_call+0x7/0xb
sshd          S C02F26E4     0 14725  30398 14727               (NOTLB)
c49c3eb0 00000082 c7ba1000 c02f26e4 c068d540 ee7ff9fe 0007d16d ca4cca60=20
       00010545 ee85235a 0007d16d cf4345a0 cf4346c4 c4203f98 7fffffff 00000=
00b=20
       c4203f90 c026f75f c7ba100c 00000002 c01daeec 00000000 c7ba1000 00000=
202=20
Call Trace:
 [<c026f75f>] schedule_timeout+0xaf/0xc0
 [<c01daeec>] tty_ldisc_deref+0x4c/0x70
 [<c01dd258>] tty_poll+0x48/0x60
 [<c0162be0>] do_select+0x1c0/0x310
 [<c0162890>] __pollwait+0x0/0xa0
 [<c0162fdb>] sys_select+0x27b/0x420
 [<c0102ba9>] syscall_call+0x7/0xb
bash          R running     0 14727  14725                     (NOTLB)


--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDCszwLbySPj3b3eoRAsMVAJ9zHr8Y9po6iiw2LsoEJ5li1ddjmQCeMz6a
y0cl8/ZzOH8y5XY9q4GMgn8=
=AlV6
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
