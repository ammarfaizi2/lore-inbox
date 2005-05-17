Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVEQQZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVEQQZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVEQQZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:25:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9485 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261648AbVEQQYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:24:35 -0400
Message-Id: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org, linux-audit@redhat.com
Subject: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116347064_5349P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 May 2005 12:24:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116347064_5349P
Content-Type: text/plain; charset=us-ascii

It threw 5 of them in short succession.  Different entry points into
avc_has_perm(). Here's the tracebacks:

[4295584.974000] Debug: sleeping function called from invalid context at mm/slab.c:2502
[4295584.974000] in_atomic():1, irqs_disabled():0
[4295584.974000]  [<c01035a8>] dump_stack+0x15/0x17
[4295584.974000]  [<c013ba6d>] kmem_cache_alloc+0x1e/0x6a
[4295584.974000]  [<c02de4fa>] skb_clone+0x14/0x183
[4295584.974000]  [<c02ef64a>] netlink_unicast+0x7d/0x171
[4295584.974000]  [<c0130947>] audit_log_end_fast+0xf5/0x188
[4295584.974000]  [<c01c3c56>] avc_audit+0x94d/0x958
[4295584.974000]  [<c01c3ffb>] avc_has_perm+0x3b/0x48
[4295584.974000]  [<c01c8022>] selinux_socket_unix_stream_connect+0x6f/0xa8
[4295584.974000]  [<c032b740>] unix_stream_connect+0x228/0x482
[4295584.974000]  [<c02dbab6>] sys_connect+0x6a/0x81
[4295584.974000]  [<c02dc23b>] sys_socketcall+0x6f/0x166
[4295584.974000]  [<c01026cf>] sysenter_past_esp+0x54/0x75

[4295592.398000] Debug: sleeping function called from invalid context at mm/slab.c:2502
[4295592.398000] in_atomic():1, irqs_disabled():0
[4295592.398000]  [<c01035a8>] dump_stack+0x15/0x17
[4295592.398000]  [<c013ba6d>] kmem_cache_alloc+0x1e/0x6a
[4295592.398000]  [<c02de4fa>] skb_clone+0x14/0x183
[4295592.398000]  [<c02ef64a>] netlink_unicast+0x7d/0x171
[4295592.398000]  [<c0130947>] audit_log_end_fast+0xf5/0x188
[4295592.398000]  [<c01c3c56>] avc_audit+0x94d/0x958
[4295592.398000]  [<c01c3ffb>] avc_has_perm+0x3b/0x48
[4295592.398000]  [<c01c8790>] ipc_has_perm+0x52/0x5a
[4295592.398000]  [<c01b808c>] ipcperms+0x89/0x93
[4295592.398000]  [<c01bba55>] do_shmat+0x28d/0x2a2
[4295592.398000]  [<c0107bfd>] sys_ipc+0xe8/0x143
[4295592.398000]  [<c01026cf>] sysenter_past_esp+0x54/0x75

[4295857.484000] Debug: sleeping function called from invalid context at mm/slab.c:2502
[4295857.484000] in_atomic():1, irqs_disabled():0
[4295857.484000]  [<c01035a8>] dump_stack+0x15/0x17
[4295857.484000]  [<c013ba6d>] kmem_cache_alloc+0x1e/0x6a
[4295857.484000]  [<c02de4fa>] skb_clone+0x14/0x183
[4295857.484000]  [<c02ef64a>] netlink_unicast+0x7d/0x171
[4295857.484000]  [<c0130947>] audit_log_end_fast+0xf5/0x188
[4295857.484000]  [<c01c3c56>] avc_audit+0x94d/0x958
[4295857.484000]  [<c01c3ffb>] avc_has_perm+0x3b/0x48
[4295857.484000]  [<c01c8790>] ipc_has_perm+0x52/0x5a
[4295857.484000]  [<c01b808c>] ipcperms+0x89/0x93
[4295857.484000]  [<c01bba55>] do_shmat+0x28d/0x2a2
[4295857.484000]  [<c0107bfd>] sys_ipc+0xe8/0x143
[4295857.484000]  [<c01026cf>] sysenter_past_esp+0x54/0x75

[4295859.266000] Debug: sleeping function called from invalid context at mm/slab.c:2502
[4295859.266000] in_atomic():1, irqs_disabled():0
[4295859.266000]  [<c01035a8>] dump_stack+0x15/0x17
[4295859.266000]  [<c013ba6d>] kmem_cache_alloc+0x1e/0x6a
[4295859.266000]  [<c02de4fa>] skb_clone+0x14/0x183
[4295859.266000]  [<c02ef64a>] netlink_unicast+0x7d/0x171
[4295859.266000]  [<c0130947>] audit_log_end_fast+0xf5/0x188
[4295859.266000]  [<c01c3c56>] avc_audit+0x94d/0x958
[4295859.266000]  [<c01c3ffb>] avc_has_perm+0x3b/0x48
[4295859.266000]  [<c01c8022>] selinux_socket_unix_stream_connect+0x6f/0xa8
[4295859.266000]  [<c032b740>] unix_stream_connect+0x228/0x482
[4295859.266000]  [<c02dbab6>] sys_connect+0x6a/0x81
[4295859.266000]  [<c02dc23b>] sys_socketcall+0x6f/0x166
[4295859.266000]  [<c0102729>] syscall_call+0x7/0xb

[4295873.575000] Debug: sleeping function called from invalid context at mm/slab.c:2502
[4295873.575000] in_atomic():1, irqs_disabled():0
[4295873.575000]  [<c01035a8>] dump_stack+0x15/0x17
[4295873.576000]  [<c013ba6d>] kmem_cache_alloc+0x1e/0x6a
[4295873.576000]  [<c02de4fa>] skb_clone+0x14/0x183
[4295873.576000]  [<c02ef64a>] netlink_unicast+0x7d/0x171
[4295873.576000]  [<c0130947>] audit_log_end_fast+0xf5/0x188
[4295873.576000]  [<c01c3c56>] avc_audit+0x94d/0x958
[4295873.576000]  [<c01c3ffb>] avc_has_perm+0x3b/0x48
[4295873.576000]  [<c01c8022>] selinux_socket_unix_stream_connect+0x6f/0xa8
[4295873.576000]  [<c032b740>] unix_stream_connect+0x228/0x482
[4295873.576000]  [<c02dbab6>] sys_connect+0x6a/0x81
[4295873.576000]  [<c02dc23b>] sys_socketcall+0x6f/0x166
[4295873.576000]  [<c0102729>] syscall_call+0x7/0xb


--==_Exmh_1116347064_5349P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCihq4cC3lWbTT17ARAiePAJ0RE1Pucsyo8dJbmwnfBUqdF8E8swCfUFca
eRonpAuTVaNgJ/I3BnRKheU=
=KUEi
-----END PGP SIGNATURE-----

--==_Exmh_1116347064_5349P--
