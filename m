Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVJWVzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVJWVzj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVJWVzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:55:39 -0400
Received: from smtp06.auna.com ([62.81.186.16]:59809 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1750704AbVJWVzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:55:38 -0400
Date: Sun, 23 Oct 2005 23:58:06 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: /proc/kcore size incorrect ?
Message-ID: <20051023235806.1a4df9ab@werewolf.able.es>
X-Mailer: Sylpheed-Claws 1.9.15cvs93 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_DhxMiUHeLy/MUlXwd4_FK28";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.216.103] Login:jamagallon@able.es Fecha:Sun, 23 Oct 2005 23:55:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_DhxMiUHeLy/MUlXwd4_FK28
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all...

Probably this is a stupid question, but anyways...

I'm trying to make a script to generate an /etc/motd, and I wanted to
include memory size of the box.

I tried:

	echo $(($(stat -c %s /proc/kcore) / 1024 / 1024)) "Mb"

but it gives 1022 for a 1Gb box.

In fact:

	werewolf:~# ll /proc/kcore
	-r--------  1 root root 1072566272 2005.10.23 23:53 /proc/kcore
	werewolf:~# stat -c %s /proc/kcore
	1072566272

	werewolf:~# echo $((1024*1024*1024))
	1073741824

Why that difference ?

TIA

BTW, any simple method to get the real mem of the box ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.13-jam9 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))

--Sig_DhxMiUHeLy/MUlXwd4_FK28
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDXAduRlIHNEGnKMMRAlqSAJ9vCoR2lvZV9ThPZw/BSJmV1tFecQCeJwkW
+j3itm5xY8zzIACox/RP9fE=
=AKco
-----END PGP SIGNATURE-----

--Sig_DhxMiUHeLy/MUlXwd4_FK28--
