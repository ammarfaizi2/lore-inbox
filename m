Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWDYUKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWDYUKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDYUKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:10:04 -0400
Received: from smtp05.auna.com ([62.81.186.15]:62137 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1751054AbWDYUKC (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 25 Apr 2006 16:10:02 -0400
Date: Tue, 25 Apr 2006 22:10:00 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: C++ pushback
Message-ID: <20060425221000.1016c26a@werewolf.auna.net>
In-Reply-To: <17485.59227.679738.701155@gargle.gargle.HOWL>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	<mj+md-20060424.201044.18351.atrey@ucw.cz>
	<444D44F2.8090300@wolfmountaingroup.com>
	<1145915533.1635.60.camel@localhost.localdomain>
	<20060425001617.0a536488@werewolf.auna.net>
	<17485.59227.679738.701155@gargle.gargle.HOWL>
X-Mailer: Sylpheed-Claws 2.1.1cvs28 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_xw6ijRqy1HnfcEBgQSZZ09C;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Tue, 25 Apr 2006 22:10:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_xw6ijRqy1HnfcEBgQSZZ09C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Apr 2006 13:09:47 +0400, Nikita Danilov <nikita@clusterfs.com> w=
rote:

> J.A. Magallon writes:
>=20
> [...]
>=20
>  >=20
>  > Tell me what is the difference between:
>  >=20
>  >=20
>  >     sbi =3D kmalloc(sizeof(*sbi), GFP_KERNEL);
>  >     if (!sbi)
>  >         return -ENOMEM;
>  >     sb->s_fs_info =3D sbi;
>  >     memset(sbi, 0, sizeof(*sbi));
>  >     sbi->s_mount_opt =3D 0;
>  >     sbi->s_resuid =3D EXT3_DEF_RESUID;
>  >     sbi->s_resgid =3D EXT3_DEF_RESGID;
>  >=20
>  > and
>  >=20
>  >     SuperBlock() : s_mount_opt(0), s_resuid(EXT3_DEF_RESUID), s_resgid=
(EXT3_DEF_RESGID)
>  >     {}
>  >=20
>  >     ...
>  >     sbi =3D new SuperBlock;
>  >     if (!sbi)
>  >         return -ENOMEM;
>  >=20
>  > apart that you don't get members initalized twice and get a shorter co=
de :).
>=20
> The difference is that second fragment doesn't mention GFP_KERNEL, so
> it's most likely wrong. Moreover it's shorter only because it places
> multiple initializations on the same like, hence, contradicting
> CodingStyle.
>=20

Well, you could always have=20

   sbi =3D new(GPF_KERNEL) SuperBlock;

And CodingStyle was written for C.

Just to make a thing clear: I'm not advocating to include C++ support in
current kernel. I just say that the only valid argument is that
'KERNEL IS C', and interfacing C with C++ just would add bloat and errors.
There is no technical argument to reject to write an OS kernel in C++.
It would not be slower not more complicated, and it will be probably safer
because it leaves less things (from thost you always _must_ do) to
programmers memories.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam9 (gcc 4.1.1 20060330 (prerelease)) #1 SMP PREEMPT Tue

--Sig_xw6ijRqy1HnfcEBgQSZZ09C
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEToIYRlIHNEGnKMMRArA1AJ0XHp4U69kMNDk/z2Alfa0jOvKmPACgnbKl
qwXJ12zJn/ME+8XgDNGSzl8=
=8d/Q
-----END PGP SIGNATURE-----

--Sig_xw6ijRqy1HnfcEBgQSZZ09C--
