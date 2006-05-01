Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWEAVGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWEAVGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWEAVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:06:20 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21461 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751249AbWEAVGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:06:20 -0400
Message-Id: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc3 - fs/namespace.c issue
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146517576_2606P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 01 May 2006 17:06:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146517576_2606P
Content-Type: text/plain; charset=us-ascii

There seems to have been a bug introduced in this changeset:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08

Am running 2.6.17-rc3-mm1.  When this changeset is applied, 'mount --bind'
misbehaves:

> # mkdir /foo
> # mount -t tmpfs -o rw,nosuid,nodev,noexec,noatime,nodiratime none /foo
> # mkdir /foo/bar
> # mount --bind /foo/bar /foo
> # tail -2 /proc/mounts
> none /foo tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
> none /foo tmpfs rw 0 0

Reverting this changeset causes both mounts to have the same options.

(Thanks to Stephen Smalley for tracking down the changeset...)

--==_Exmh_1146517576_2606P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEVnhIcC3lWbTT17ARAvb8AKCql3XtNRR03ai0fZhMwwig9Bs9uACeKtl/
Xz61i56PAMhZplxgUU9YlWA=
=l/bm
-----END PGP SIGNATURE-----

--==_Exmh_1146517576_2606P--
