Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVIVUZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVIVUZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVIVUZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:25:04 -0400
Received: from zlynx.org ([199.45.143.209]:2823 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S1750804AbVIVUZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:25:02 -0400
Subject: Re: security patch
From: Zan Lynx <zlynx@acm.org>
To: Valdis.Kletnieks@vt.edu
Cc: breno@kalangolinux.org, linux-kernel@vger.kernel.org
In-Reply-To: <200509222003.j8MK3i8E010365@turing-police.cc.vt.edu>
References: <20050922194433.13200.qmail@webmail2.locasite.com.br>
	 <200509222003.j8MK3i8E010365@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f6nWB5F2rI6CFyTavWa8"
Date: Thu, 22 Sep 2005 14:24:48 -0600
Message-Id: <1127420688.10462.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f6nWB5F2rI6CFyTavWa8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-09-22 at 16:03 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 22 Sep 2005 19:44:33 -0000, breno@kalangolinux.org said:
>=20
> > I'm doing a new feature for linux kernel 2.6 to protect against all kin=
ds of buffer
> > overflow. It works with new sys_control() system call controling if a p=
rocess can or can't
> > call a system call ie. sys_execve();
>=20
> This has been done before. ;)
>=20
> Also, note *VERY* carefully that this does *NOT* protect against buffer o=
verflow
> the way ExecShield and PAX and similar do - this merely tries to mitigate=
 the
> damage.
>=20
> Note that you probably don't *DARE* remove open()/read()/write()/close() =
from
> the "permitted syscall" list - and an attacker can have plenty of fun jus=
t with
> those 4 syscalls.
>=20
> (That's also why SELinux was designed to give better granularity to sysca=
lls - it
> can restrict a program to "write only to files it *should* be able to wri=
te").

An interesting thing that I don't think has been done before is to
create a map linking stack call chains to syscalls.  If the call stack
doesn't match then it isn't a valid call.

Although that might already be part of execution fingerprinting, now
that I think about it...
--=20
Zan Lynx <zlynx@acm.org>

--=-f6nWB5F2rI6CFyTavWa8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDMxMOG8fHaOLTWwgRAsPTAJ40WqbxvX8McweOAEU7D3R5nHJDRQCdGxBO
ZBx1Ll3F+kBymDY1fIgelQk=
=z4UG
-----END PGP SIGNATURE-----

--=-f6nWB5F2rI6CFyTavWa8--

