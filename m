Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUF0Qmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUF0Qmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 12:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUF0Qmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 12:42:46 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:29903 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S264085AbUF0Qmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 12:42:43 -0400
Date: Sun, 27 Jun 2004 18:42:39 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 - oops while dereferencing null pointer in nfs_create_request
Message-ID: <20040627164239.GA8349@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks

Linux 2.6.7 on s390 regulary oopses with the following error:

| Unable to handle kernel pointer dereference at virtual kernel address 000=
0000000000000
| Oops: 0004 [#1]
| CPU:    2    Not tainted
| Process pdflush (pid: 90, task: 000000000fbb5400, ksp: 000000000fad7ba0)
| Krnl PSW : 0700200180000000 000000000010a08c (nfs3_request_init+0x34/0x50)
| Krnl GPRS: 0000000000000000 0000000000000001 0000000000000000 00000000000=
00028
|            0000000000000001 0000000000000000 0000000000001000 00000000092=
84948
|            000000000040c300 000000000feecc00 0000000000000000 00000000008=
15638
|            0000000001ef3f00 000000000029df00 000000000010a07c 000000000fa=
d72c8
| Krnl Code: ba 54 30 00 a7 44 ff fc e3 20 c0 30 00 24 e3 40 f1 10 00 04
| Call Trace:
|  [nfs_create_request+220/316] nfs_create_request+0xdc/0x13c
|  [nfs_update_request+718/1168] nfs_update_request+0x2ce/0x490
|  [nfs_writepage_async+44/252] nfs_writepage_async+0x2c/0xfc
|  [nfs_writepage+492/536] nfs_writepage+0x1ec/0x218
|  [mpage_writepages+586/892] mpage_writepages+0x24a/0x37c
|  [nfs_writepages+50/368] nfs_writepages+0x32/0x170
|  [do_writepages+64/100] do_writepages+0x40/0x64
|  [__sync_single_inode+130/632] __sync_single_inode+0x82/0x278
|  [__writeback_single_inode+254/272] __writeback_single_inode+0xfe/0x110
|  [sync_sb_inodes+426/896] sync_sb_inodes+0x1aa/0x380
|  [writeback_inodes+360/388] writeback_inodes+0x168/0x184
|  [wb_kupdate+182/324] wb_kupdate+0xb6/0x144
|  [__pdflush+430/700] __pdflush+0x1ae/0x2bc
|  [pdflush+46/60] pdflush+0x2e/0x3c
|  [kthread+228/236] kthread+0xe4/0xec
|  [kernel_thread_starter+20/28] kernel_thread_starter+0x14/0x1c

Bastian

--=20
	"Life and death are seldom logical."
	"But attaining a desired goal always is."
		-- McCoy and Spock, "The Galileo Seven", stardate 2821.7

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkDe+P8ACgkQnw66O/MvCNHnBQCeKGuKhgNDD75FaxkTPaISJwBK
54QAoKt7qPMotXQhMi0WGvyScTkoqOao
=YH7B
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
