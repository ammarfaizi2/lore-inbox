Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUJEIew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUJEIew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 04:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUJEIew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 04:34:52 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:7348 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S268877AbUJEIet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 04:34:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Roland Dreier <roland@topspin.com>
Subject: Re: proper way to annotate kernel use of sys_xxx?
Date: Tue, 5 Oct 2004 10:32:33 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <52u0t9u414.fsf@topspin.com>
In-Reply-To: <52u0t9u414.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_mwlYBGiT95yuLGx";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410051032.39531.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_mwlYBGiT95yuLGx
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dienstag, 5. Oktober 2004 07:28, Roland Dreier wrote:
> This is an abuse of sys_open(), but we know it's OK. =A0Is the right way
> to shut up sparse to just change it to:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0fd =3D sys_open((const char __user *) path, 0, 0);
>=20
No, that's wrong, see=20
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D108697882525067 ;-)

In this case, you can easily convert the calls to use
filp_open/vfs_read/filp_close, though I'm not sure if that's
the correct solution either.

	Arnd <><

--Boundary-02=_mwlYBGiT95yuLGx
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBYlwm5t5GS2LDRf4RAjZiAKCEjDtfk7lKL3thAqKncL+JEaKxxwCeJatB
ofestGZ4Nshlm3NZi+voMsc=
=ZgOA
-----END PGP SIGNATURE-----

--Boundary-02=_mwlYBGiT95yuLGx--
