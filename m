Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVCOMcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVCOMcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCOMcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:32:53 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:4236 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261196AbVCOMcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:32:47 -0500
Date: Tue, 15 Mar 2005 13:32:42 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.11-mm3: BUG: atomic counter underflow at: rpcauth_destroy
Message-ID: <20050315133242.4e25373f@phoebee>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Tue__15_Mar_2005_13_32_42_+0100_c2qYBTvEKPovPOM9;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Tue__15_Mar_2005_13_32_42_+0100_c2qYBTvEKPovPOM9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi there!

I got some atomic counter underflows in the nfs code:

Mar 14 17:19:15 phoebee rpc.statd[6890]: Received erroneous SM_UNMON request
                                         from phoebee for 192.168.0.1
Mar 14 17:19:15 phoebee BUG: atomic counter underflow at:
Mar 14 17:19:15 phoebee [<c03b51d1>] rpcauth_destroy+0x41/0x50
Mar 14 17:19:15 phoebee [<c03afcac>] rpc_destroy_client+0x9c/0xf0
Mar 14 17:19:15 phoebee [<c03b4698>] rpc_free+0x18/0x40
Mar 14 17:19:15 phoebee [<c03b49ad>] rpc_release_task+0xad/0x120
Mar 14 17:19:15 phoebee [<c03b4563>] __rpc_execute+0x2e3/0x360
Mar 14 17:19:15 phoebee [<c03b1580>] xprt_init_autodisconnect+0x0/0xd0
Mar 14 17:19:15 phoebee [<c012c9e0>] autoremove_wake_function+0x0/0x50
Mar 14 17:19:15 phoebee [<c03af9e7>] rpc_create_client+0x167/0x240
Mar 14 17:19:15 phoebee [<c012c9e0>] autoremove_wake_function+0x0/0x50
Mar 14 17:19:15 phoebee [<c03afefa>] rpc_call_sync+0x5a/0xa0
Mar 14 17:19:15 phoebee [<c0203874>] nsm_mon_unmon+0xb4/0xe0
Mar 14 17:19:15 phoebee [<c0203936>] nsm_unmonitor+0x26/0x70
Mar 14 17:19:15 phoebee [<c02007e8>] nlm_gc_hosts+0x168/0x190
Mar 14 17:19:15 phoebee [<c0200056>] nlm_lookup_host+0x46/0x270
Mar 14 17:19:15 phoebee [<c01fffd1>] nlmclnt_lookup_host+0x11/0x20
Mar 14 17:19:15 phoebee [<c01ff1da>] nlmclnt_proc+0x4a/0x310
Mar 14 17:19:15 phoebee [<c012c9e0>] autoremove_wake_function+0x0/0x50
Mar 14 17:19:15 phoebee [<c034955e>] kernel_sendmsg+0x2e/0x40
Mar 14 17:19:15 phoebee [<c03bb029>] xdr_sendpages+0xc9/0x270
Mar 14 17:19:15 phoebee [<c013a11c>] mempool_free+0x4c/0xa0
Mar 14 17:19:15 phoebee [<c03afd4b>] rpc_release_client+0x4b/0x90
Mar 14 17:19:15 phoebee [<c03b49a6>] rpc_release_task+0xa6/0x120
Mar 14 17:19:15 phoebee [<c03b4563>] __rpc_execute+0x2e3/0x360
Mar 14 17:19:15 phoebee [<c012c9e0>] autoremove_wake_function+0x0/0x50
Mar 14 17:19:15 phoebee [<c012c9e0>] autoremove_wake_function+0x0/0x50
Mar 14 17:19:15 phoebee [<c03aff05>] rpc_call_sync+0x65/0xa0
Mar 14 17:19:15 phoebee [<c01cbe93>] nfs3_rpc_wrapper+0x63/0x70
Mar 14 17:19:15 phoebee [<c01cc113>] nfs3_proc_setattr+0x93/0xd0
Mar 14 17:19:15 phoebee [<c01ca38c>] nfs_scan_commit+0x2c/0x70
Mar 14 17:19:15 phoebee [<c01c3500>] nfs_setattr+0xd0/0x1c0
Mar 14 17:19:15 phoebee [<c013642c>] __filemap_fdatawrite_range+0xbc/0xc0
Mar 14 17:19:15 phoebee [<c01ca38c>] nfs_scan_commit+0x2c/0x70
Mar 14 17:19:15 phoebee [<c01cbc6f>] nfs_commit_inode+0x3f/0xc0
Mar 14 17:19:15 phoebee [<c01cbd44>] nfs_sync_inode+0x54/0x70
Mar 14 17:19:15 phoebee [<c01c1e37>] do_setlk+0x77/0x170
Mar 14 17:19:15 phoebee [<c01c1f30>] nfs_lock+0x0/0x130
Mar 14 17:19:15 phoebee [<c016947b>] fcntl_setlk64+0x25b/0x2b0
Mar 14 17:19:15 phoebee [<c0169e4e>] dput+0x1e/0x250
Mar 14 17:19:15 phoebee [<c0160790>] path_release+0x10/0x60
Mar 14 17:19:15 phoebee [<c01528a9>] sys_chown+0x49/0x50
Mar 14 17:19:15 phoebee [<c0164e74>] sys_fcntl64+0x44/0x90
Mar 14 17:19:15 phoebee [<c0103071>] syscall_call+0x7/0xb
Mar 14 17:19:15 phoebee BUG: atomic counter underflow at:
Mar 14 17:19:15 phoebee [<c03b51d1>] rpcauth_destroy+0x41/0x50
Mar 14 17:19:15 phoebee [<c03afcac>] rpc_destroy_client+0x9c/0xf0
Mar 14 17:19:15 phoebee [<c03b4698>] rpc_free+0x18/0x40
Mar 14 17:19:15 phoebee [<c03b49ad>] rpc_release_task+0xad/0x120
Mar 14 17:19:15 phoebee [<c03b4563>] __rpc_execute+0x2e3/0x360
Mar 14 17:19:15 phoebee [<c03b1580>] xprt_init_autodisconnect+0x0/0xd0
Mar 14 17:19:15 phoebee [<c012c9e0>] autoremove_wake_function+0x0/0x50
Mar 14 17:19:15 phoebee [<c03af9e7>] rpc_create_client+0x167/0x240
Mar 14 17:19:15 phoebee [<c012c9e0>] autoremove_wake_function+0x0/0x50
Mar 14 17:19:15 phoebee [<c03afefa>] rpc_call_sync+0x5a/0xa0
Mar 14 17:19:15 phoebee [<c0203874>] nsm_mon_unmon+0xb4/0xe0
Mar 14 17:19:15 phoebee [<c028118f>] extract_entropy+0x4f/0xa0
Mar 14 17:19:15 phoebee [<c02038c6>] nsm_monitor+0x26/0x70
Mar 14 17:19:15 phoebee [<c01ffa9b>] nlmclnt_lock+0x2b/0xd0
Mar 14 17:19:15 phoebee [<c01ff397>] nlmclnt_proc+0x207/0x310
Mar 14 17:19:15 phoebee [<c012c9e0>] autoremove_wake_function+0x0/0x50
Mar 14 17:19:15 phoebee [<c01c1e37>] do_setlk+0x77/0x170
Mar 14 17:19:15 phoebee [<c01c1f30>] nfs_lock+0x0/0x130
Mar 14 17:19:15 phoebee [<c016947b>] fcntl_setlk64+0x25b/0x2b0
Mar 14 17:19:15 phoebee [<c0169e4e>] dput+0x1e/0x250
Mar 14 17:19:15 phoebee [<c0160790>] path_release+0x10/0x60
Mar 14 17:19:15 phoebee [<c01528a9>] sys_chown+0x49/0x50
Mar 14 17:19:15 phoebee [<c0164e74>] sys_fcntl64+0x44/0x90
Mar 14 17:19:15 phoebee [<c0103071>] syscall_call+0x7/0xb


Regardless of the "erroneous SM_UNMON request", the atomic counter
should not underflow ;)


Regards,
Martin

--=20
MyExcuse:
The kernel license has expired

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Tue__15_Mar_2005_13_32_42_+0100_c2qYBTvEKPovPOM9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNtXsmjLYGS7fcG0RAj58AJ9aWQaDQsbUXzQk9mVkmYret+Tq3wCgkt0C
98WsjZOWTSMLpdAjDuLo80c=
=sUQE
-----END PGP SIGNATURE-----

--Signature_Tue__15_Mar_2005_13_32_42_+0100_c2qYBTvEKPovPOM9--
