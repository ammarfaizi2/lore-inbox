Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWIHHbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWIHHbd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbWIHHbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:31:33 -0400
Received: from systemlinux.org ([83.151.29.59]:18133 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1750699AbWIHHbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:31:31 -0400
Date: Fri, 8 Sep 2006 09:31:25 +0200
From: Andre Noll <maan@systemlinux.org>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: 2.6.18-rc5 page_to_pfn: Unable to handle kernel NULL pointer dereference
Message-ID: <20060908073125.GA23642@skl-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following just happend to one of our 8-way Opteron cluster nodes
(nfs client version 3, solaris nfs server).

Just let me know if you need further info.
Andre

Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:=
=20
 [<ffffffff80150c09>] page_to_pfn+0x0/0x33
PGD 74ba36067 PUD 0=20
Oops: 0000 [1] SMP=20
CPU 0=20
Pid: 1782, comm: sge_execd Not tainted 2.6.18-rc5-tt64-6-gd9629953 #23
RIP: 0010:[<ffffffff80150c09>]  [<ffffffff80150c09>] page_to_pfn+0x0/0x33
RSP: 0018:ffff81074b99bbb0  EFLAGS: 00010287
RAX: 0000000000000b9a RBX: 0000000000000734 RCX: 0000000000000b9a
RDX: ffff81074b99bbf0 RSI: ffff810812320500 RDI: 0000000000000000
RBP: 0000000000000466 R08: ffff8104c53a89a0 R09: ffff8104c53a8810
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000008cc
R13: ffff81074b99bbf8 R14: 0000000000002000 R15: ffff8104c53a8ab8
FS:  00002b75f92987a0(0000) GS:ffffffff80703000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 000000080b603000 CR4: 00000000000006a0
Process sge_execd (pid: 1782, threadinfo ffff81074b99a000, task ffff81080bc=
50040)
Stack:  ffffffff80205a72 ffff8104c53a89a0 ffff810812320380 0000000000000b9a
 ffff8104c53a89a0 0000000000000466 ffffffff80205cf8 0000000000000000
 ffff810817df9678 0000000000000000 ffff8104c53a89a0 ffff810817df9678
Call Trace:
 [<ffffffff80205a72>] nfs_readpage_truncate_uninitialised_page+0x77/0xec
 [<ffffffff80205cf8>] nfs_readpage_sync+0x211/0x255
 [<ffffffff8020677e>] nfs_readpage+0x118/0x151
 [<ffffffff8014c65e>] do_generic_mapping_read+0x1ec/0x398
 [<ffffffff8014c80a>] file_read_actor+0x0/0xd1
 [<ffffffff8014ca52>] __generic_file_aio_read+0x177/0x1b0
 [<ffffffff8014cabf>] generic_file_aio_read+0x34/0x39
 [<ffffffff801fea68>] nfs_file_read+0xb1/0xc0
 [<ffffffff8016df5c>] do_sync_read+0xc9/0x106
 [<ffffffff8013e541>] autoremove_wake_function+0x0/0x2e
 [<ffffffff8015bd8e>] do_mmap_pgoff+0x5fd/0x6de
 [<ffffffff8016e046>] vfs_read+0xad/0x14c
 [<ffffffff8016e380>] sys_read+0x45/0x6e
 [<ffffffff80109726>] system_call+0x7e/0x83


Code: 48 8b 07 48 c1 e8 3a 48 8b 14 c5 00 c8 70 80 48 b8 b7 6d db=20
RIP  [<ffffffff80150c09>] page_to_pfn+0x0/0x33
 RSP <ffff81074b99bbb0>
CR2: 0000000000000000

--=20
The only person who always got his work done by Friday was Robinson Crusoe

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFARxNWto1QDEAkw8RArfiAJoCv7BnSaTe2UXyrN/OvLQOSV8vRACfbThj
dmunCRxeLNE1R0mHJWeKVE4=
=iJh8
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
