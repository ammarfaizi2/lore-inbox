Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030804AbWJDKkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030804AbWJDKkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030805AbWJDKkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:40:35 -0400
Received: from systemlinux.org ([83.151.29.59]:60829 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1030804AbWJDKke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:40:34 -0400
Date: Wed, 4 Oct 2006 12:40:18 +0200
From: Andre Noll <maan@systemlinux.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, andrea@suse.de,
       nickpiggin@yahoo.com.au, riel@redhat.com
Subject: 2.6.18: Kernel BUG at mm/rmap.c:522
Message-ID: <20061004104018.GB22487@skl-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

MATLAB triggers the following bug on both of our new 16-way opteron
machines (64G Ram): The same kernel is running with no problems on a
bunch of smaller (8-way, 4-way, max 32G Ram) cluster nodes.

Any hints?
Andre


----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...aid0/home/maan/scm/stable/linux-2.6.18.y/mm/rmap.c:522
invalid opcode: 0000 [1] SMP=20
CPU 14=20
Pid: 12948, comm: MATLAB Not tainted 2.6.18-tt64-6 #1
RIP: 0010:[<ffffffff8015ee54>]  [<ffffffff8015ee54>] page_remove_rmap+0x13/=
0x2d
RSP: 0018:ffff810207a19d70  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff81101aa1dd90 RCX: 000000000000001c
RDX: 00002aaad63b2000 RSI: 00002aaad63b2000 RDI: ffff81102d129ce8
RBP: 0000000f59e3b067 R08: 0000000000000023 R09: ffff810e30000680
R10: ffff8106079df408 R11: ffff8105970284a8 R12: ffff81102d129ce8
R13: ffff810e3005e160 R14: 00002aaad63b2000 R15: 0000000000000000
FS:  00002b3f6aa704a0(0000) GS:ffff810e301b9440(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aaad8592000 CR3: 00000005bdd17000 CR4: 00000000000006a0
Process MATLAB (pid: 12948, threadinfo ffff810207a18000, task ffff8101ea581=
080)
Stack:  ffffffff80157a37 ffff810e30000680 00002aaad63b3000 ffff81101aa1dd98
 ffff81102fb53668 ffffffffffffffb8 ffff8106079df400 ffff810207a19e98
 00002aaad6400000 ffff810feecdc088 00002aaad6400000 ffff810b24d11588
Call Trace:
 [<ffffffff80157a37>] zap_pte_range+0x1c4/0x2c0
 [<ffffffff80157d0e>] unmap_page_range+0x1db/0x23a
 [<ffffffff80157e5b>] unmap_vmas+0xee/0x1e3
 [<ffffffff8015c6fe>] unmap_region+0xb4/0x127
 [<ffffffff8015caa7>] do_munmap+0x183/0x19a
 [<ffffffff8015caf7>] sys_munmap+0x39/0x52
 [<ffffffff80109726>] system_call+0x7e/0x83


Code: 0f 0b 68 c0 4e 46 80 c2 0a 02 31 f6 f6 47 18 01 40 0f 94 c6=20
RIP  [<ffffffff8015ee54>] page_remove_rmap+0x13/0x2d
 RSP <ffff810207a19d70>
 <0>Bad page state in process 'MATLAB'
page:ffff81102d129ce8 flags:0x1e00000000000014 mapping:0000000000000000 map=
count:-1 count:0
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace:
 [<ffffffff8014f325>] bad_page+0x51/0x7b
 [<ffffffff8014f788>] prep_new_page+0x57/0x15f
 [<ffffffff8014feb1>] buffered_rmqueue+0x128/0x14a
 [<ffffffff8015002c>] get_page_from_freelist+0xbd/0xe2
 [<ffffffff801500a3>] __alloc_pages+0x52/0x29f
 [<ffffffff80159a26>] do_anonymous_page+0x46/0x1b8
 [<ffffffff8015a023>] __handle_mm_fault+0x18f/0x29d
 [<ffffffff8011b359>] do_page_fault+0x1bd/0x4e7
 [<ffffffff8015bf42>] do_mmap_pgoff+0x5fd/0x6de
 [<ffffffff8022094b>] __up_write+0x14/0x108
 [<ffffffff8010a3f9>] error_exit+0x0/0x84

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...aid0/home/maan/scm/stable/linux-2.6.18.y/mm/rmap.c:522
invalid opcode: 0000 [2] SMP=20
CPU 14=20
Pid: 12079, comm: MATLAB Tainted: G    B 2.6.18-tt64-6 #1
RIP: 0010:[<ffffffff8015ee54>]  [<ffffffff8015ee54>] page_remove_rmap+0x13/=
0x2d
RSP: 0018:ffff810a0916fd70  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff810e7c68d300 RCX: 000000000000001c
RDX: ffff810e30000000 RSI: 00002aab5ea60000 RDI: ffff81102bb25c10
RBP: 0000000ef53ee067 R08: 0000000000000023 R09: ffff810e30000680
R10: ffff810c01b69c88 R11: ffff810bce5484a8 R12: ffff81102bb25c10
R13: ffff810e3005e160 R14: 00002aab5ea60000 R15: 0000000000000000
FS:  00002b1f8100d4a0(0000) GS:ffff810e301b9440(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aab31345000 CR3: 0000000c1bebd000 CR4: 00000000000006a0
Process MATLAB (pid: 12079, threadinfo ffff810a0916e000, task ffff810a092d2=
180)
Stack:  ffffffff80157a37 ffff810e30000680 00002aab5ea61000 ffff810e7c68d308
 ffff81102a0b6ee8 00000000ffffff9f ffff810c01b69c80 ffff810a0916fe98
 00002aab5ec00000 ffff810fd4924298 00002aab5ec00000 ffff8100812777a8
Call Trace:
 [<ffffffff80157a37>] zap_pte_range+0x1c4/0x2c0
 [<ffffffff80157d0e>] unmap_page_range+0x1db/0x23a
 [<ffffffff80157e5b>] unmap_vmas+0xee/0x1e3
 [<ffffffff8015c6fe>] unmap_region+0xb4/0x127
 [<ffffffff8015caa7>] do_munmap+0x183/0x19a
 [<ffffffff8015caf7>] sys_munmap+0x39/0x52
 [<ffffffff80109726>] system_call+0x7e/0x83


Code: 0f 0b 68 c0 4e 46 80 c2 0a 02 31 f6 f6 47 18 01 40 0f 94 c6=20
RIP  [<ffffffff8015ee54>] page_remove_rmap+0x13/0x2d
 RSP <ffff810a0916fd70>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...aid0/home/maan/scm/stable/linux-2.6.18.y/mm/rmap.c:522
invalid opcode: 0000 [3] SMP=20
CPU 15=20
Pid: 20344, comm: MATLAB Tainted: G    B 2.6.18-tt64-6 #1
RIP: 0010:[<ffffffff8015ee54>]  [<ffffffff8015ee54>] page_remove_rmap+0x13/=
0x2d
RSP: 0018:ffff8101113b7d70  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff810e87e8d660 RCX: 000000000000001c
RDX: ffff810e30000000 RSI: 00002aaaf6acc000 RDI: ffff81102ef01410
RBP: 0000000fe24ee067 R08: 0000000000000023 R09: ffff810e30000680
R10: ffff81010a2d5248 R11: ffff810162b6a608 R12: ffff81102ef01410
R13: ffff810e300639e0 R14: 00002aaaf6acc000 R15: 0000000000000000
FS:  00002b88026364a0(0000) GS:ffff810e301f4440(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aab0284c0d0 CR3: 00000001038e3000 CR4: 00000000000006a0
Process MATLAB (pid: 20344, threadinfo ffff8101113b6000, task ffff81018fbd1=
8a0)
Stack:  ffffffff80157a37 ffff810e30000680 00002aaaf6acd000 ffff810e87e8d668
 ffff81102a33aee8 00000000ffffff3f ffff81010a2d5240 ffff8101113b7e98
 00002aaaf6c00000 ffff810ff0aa7818 00002aaaf6c00000 ffff810eaffd3da8
Call Trace:
 [<ffffffff80157a37>] zap_pte_range+0x1c4/0x2c0
 [<ffffffff80157d0e>] unmap_page_range+0x1db/0x23a
 [<ffffffff80157e5b>] unmap_vmas+0xee/0x1e3
 [<ffffffff8015c6fe>] unmap_region+0xb4/0x127
 [<ffffffff8015caa7>] do_munmap+0x183/0x19a
 [<ffffffff8015caf7>] sys_munmap+0x39/0x52
 [<ffffffff80109726>] system_call+0x7e/0x83


Code: 0f 0b 68 c0 4e 46 80 c2 0a 02 31 f6 f6 47 18 01 40 0f 94 c6=20
RIP  [<ffffffff8015ee54>] page_remove_rmap+0x13/0x2d
 RSP <ffff8101113b7d70>
 <3>swap_free: Unused swap offset entry 00000060
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...aid0/home/maan/scm/stable/linux-2.6.18.y/mm/rmap.c:522
invalid opcode: 0000 [4] SMP=20
CPU 14=20
Pid: 5985, comm: MATLAB Tainted: G    B 2.6.18-tt64-6 #1
RIP: 0010:[<ffffffff8015ee54>]  [<ffffffff8015ee54>] page_remove_rmap+0x13/=
0x2d
RSP: 0018:ffff810204875d70  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff810e87e852b0 RCX: ffff8101ef34d970
RDX: 00002aaae1856000 RSI: ffff8102280524d0 RDI: ffff81102d127358
RBP: 0000000f59d7d067 R08: 000000000000001e R09: 0000000000000000
R10: 0000000000000206 R11: 00000000fffffffa R12: ffff81102d127358
R13: ffff810e3005e160 R14: 00002aaae1856000 R15: 0000000000000000
FS:  00002ada130564a0(0000) GS:ffff810e301b9440(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aaae418a000 CR3: 0000000c0bdad000 CR4: 00000000000006a0
Process MATLAB (pid: 5985, threadinfo ffff810204874000, task ffff8101110f31=
40)
Stack:  ffffffff80157a37 ffff810e30000680 00002aaae1857000 ffff810e87e852b8
 ffff81102a33ad28 ffffffffffffffaa ffff810a30128a40 ffff810204875e98
 00002aaae1a00000 ffff810fffed14a8 00002aaae1a00000 ffff810be0f79860
Call Trace:
 [<ffffffff80157a37>] zap_pte_range+0x1c4/0x2c0
 [<ffffffff80157d0e>] unmap_page_range+0x1db/0x23a
 [<ffffffff80157e5b>] unmap_vmas+0xee/0x1e3
 [<ffffffff8015c6fe>] unmap_region+0xb4/0x127
 [<ffffffff8015caa7>] do_munmap+0x183/0x19a
 [<ffffffff8015caf7>] sys_munmap+0x39/0x52
 [<ffffffff80109726>] system_call+0x7e/0x83


Code: 0f 0b 68 c0 4e 46 80 c2 0a 02 31 f6 f6 47 18 01 40 0f 94 c6=20
RIP  [<ffffffff8015ee54>] page_remove_rmap+0x13/0x2d
 RSP <ffff810204875d70>
 <3>swap_free: Unused swap offset entry 00000060
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...aid0/home/maan/scm/stable/linux-2.6.18.y/mm/rmap.c:522
invalid opcode: 0000 [5] SMP=20
CPU 14=20
Pid: 19074, comm: MATLAB Tainted: G    B 2.6.18-tt64-6 #1
RIP: 0010:[<ffffffff8015ee54>]  [<ffffffff8015ee54>] page_remove_rmap+0x13/=
0x2d
RSP: 0018:ffff810021587d70  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff810e8ca8f6a0 RCX: 000000000000001c
RDX: ffff810e30000000 RSI: 00002aaaf7cd4000 RDI: ffff81102a447b08
RBP: 0000000e8cb57067 R08: 00000000fffffffe R09: ffff810e30000680
R10: ffff810230080708 R11: ffff810389b47b88 R12: ffff81102a447b08
R13: ffff810e3005e160 R14: 00002aaaf7cd4000 R15: 0000000000000000
FS:  00002b1e7eb3b4a0(0000) GS:ffff810e301b9440(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aab08206870 CR3: 00000002b40e4000 CR4: 00000000000006a0
Process MATLAB (pid: 19074, threadinfo ffff810021586000, task ffff81013b640=
040)
Stack:  ffffffff80157a37 ffff810e30000680 00002aaaf7cd5000 ffff810e8ca8f6a8
 ffff81102a444f58 00000000ffffff38 ffff810230080700 ffff810021587e98
 00002aaaf7e00000 ffff810fecefdb88 00002aaaf7e00000 ffff810092d8fdf0
Call Trace:
 [<ffffffff80157a37>] zap_pte_range+0x1c4/0x2c0
 [<ffffffff80157d0e>] unmap_page_range+0x1db/0x23a
 [<ffffffff80157e5b>] unmap_vmas+0xee/0x1e3
 [<ffffffff8015c6fe>] unmap_region+0xb4/0x127
 [<ffffffff8015caa7>] do_munmap+0x183/0x19a
 [<ffffffff8015caf7>] sys_munmap+0x39/0x52
 [<ffffffff80109726>] system_call+0x7e/0x83


Code: 0f 0b 68 c0 4e 46 80 c2 0a 02 31 f6 f6 47 18 01 40 0f 94 c6=20
RIP  [<ffffffff8015ee54>] page_remove_rmap+0x13/0x2d
 RSP <ffff810021587d70>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...aid0/home/maan/scm/stable/linux-2.6.18.y/mm/rmap.c:522
invalid opcode: 0000 [6] SMP=20
CPU 14=20
Pid: 20028, comm: MATLAB Tainted: G    B 2.6.18-tt64-6 #1
RIP: 0010:[<ffffffff8015ee54>]  [<ffffffff8015ee54>] page_remove_rmap+0x13/=
0x2d
RSP: 0018:ffff810dad0e7d70  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff810e7ea8d0e0 RCX: 000000000000001c
RDX: ffff810e30000000 RSI: 00002aaaad21c000 RDI: ffff81102cf5e918
RBP: 0000000f51b05067 R08: 00002aaaad400000 R09: ffff810e30000680
R10: ffff810428d0f888 R11: ffff810fcb122ad8 R12: ffff81102cf5e918
R13: ffff810e3005e160 R14: 00002aaaad21c000 R15: 0000000000000000
FS:  00002adbe435e4a0(0000) GS:ffff810e301b9440(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aaab12b8000 CR3: 0000000394dab000 CR4: 00000000000006a0
Process MATLAB (pid: 20028, threadinfo ffff810dad0e6000, task ffff810dbc128=
140)
Stack:  ffffffff80157a37 ffff810e301b9340 00002aaaad21d000 ffff810e7ea8d0e8
 ffff81102a134ee8 00000000fffffff2 ffff810428d0f880 ffff810dad0e7e98
 00002aaaad400000 ffff810fe56a0d98 00002aaaad400000 ffff810175c0eb48
Call Trace:
 [<ffffffff80157a37>] zap_pte_range+0x1c4/0x2c0
 [<ffffffff80157d0e>] unmap_page_range+0x1db/0x23a
 [<ffffffff80157e5b>] unmap_vmas+0xee/0x1e3
 [<ffffffff8015c6fe>] unmap_region+0xb4/0x127
 [<ffffffff8015caa7>] do_munmap+0x183/0x19a
 [<ffffffff8015caf7>] sys_munmap+0x39/0x52
 [<ffffffff80109726>] system_call+0x7e/0x83


Code: 0f 0b 68 c0 4e 46 80 c2 0a 02 31 f6 f6 47 18 01 40 0f 94 c6=20
RIP  [<ffffffff8015ee54>] page_remove_rmap+0x13/0x2d
 RSP <ffff810dad0e7d70>
=20


--=20
The only person who always got his work done by Friday was Robinson Crusoe

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFI4+SWto1QDEAkw8RAoPTAJ4zizBFV1fCplbHhrtyA4KHR74cBACfUhYb
2Nb8/joheJXVfawyC3SH4HM=
=8rRj
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
