Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUFRRdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUFRRdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUFRRdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:33:05 -0400
Received: from wblv-235-33.telkomadsl.co.za ([165.165.235.33]:7860 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266292AbUFRRbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:31:37 -0400
Subject: Re: Stop the Linux kernel madness
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <1087573691.19400.116.camel@winden.suse.de>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
	 <40D23701.1030302@opensound.com>
	 <1087573691.19400.116.camel@winden.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iJF76a483jVs4ClJvCqq"
Message-Id: <1087579854.14905.54.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 19:30:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iJF76a483jVs4ClJvCqq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 at 17:48, Andreas Gruenbacher wrote:

Hi,

> This means that a single /lib/modules/$(uname
> -r)/build symlink is not sufficient anymore. Therefore we have the build
> symlink pointing to the output files, and a new source symlink pointing
> to the real source tree. This change hasn't found its way into mainline
> yet, which is unfortunate. For the discussion, see
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D108628265102121&w=3D2 =
and
> follow-ups. I keep pinging Sam Ravnborg (the kbuild maintainer), but
> apparently he is busy with other projects at the moment.
>=20

Once again, please do not do this.  As some others already have pointed
out already, many (of not most) projects out there that builds against
the running kernel use '/lib/modules/$(uname-r)/build' to locate the
SOURCE, and will be broken.  Rather use an 'output' or some such symlink
to store the object files, but keep the meaning of 'build' intact.

If, then please treat it like any other stable interface, and depreciate
it in 2.7, and change (but better, remove it, so that there will be no
misunderstanding) in 2.8.
=20

Thanks,

--=20
Martin Schlemmer

--=-iJF76a483jVs4ClJvCqq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA0ybOqburzKaJYLYRAsWqAJ9Gxmdv+i2O9mItIgtdj5qy0ghcVwCgivaU
kX1/nvvN02+bAOiM6CJTPyI=
=sr2q
-----END PGP SIGNATURE-----

--=-iJF76a483jVs4ClJvCqq--

