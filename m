Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVBIOLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVBIOLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 09:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVBIOLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 09:11:24 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:36589 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261824AbVBIOLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 09:11:19 -0500
Subject: Re: [PATCH] New sys_chmod() hook for the LSM framework
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Chris Wright <chrisw@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
In-Reply-To: <20050208161530.F469@build.pdx.osdl.net>
References: <1107879275.3754.279.camel@localhost.localdomain>
	 <20050208161530.F469@build.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zPbJSgdMhldBDyAdZooW"
Date: Wed, 09 Feb 2005 15:10:54 +0100
Message-Id: <1107958254.3754.292.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zPbJSgdMhldBDyAdZooW
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El mar, 08-02-2005 a las 16:15 -0800, Chris Wright escribi=F3:
> * Lorenzo Hern=E1ndez Garc=EDa-Hierro (lorenzo@gnu.org) wrote:
> > As commented yesterday, I was going to release a few more hooks for som=
e
> > *critical* syscalls, this one adds a hook to sys_chmod(), and makes us
> > able to apply checks and logics before releasing the operation to
> > sys_chmod().
>=20
> This is exactly the kind of hook we've tried to avoid.  This is really
> asking for permission to alter inode attribute data.  This type of
> hook is incomplete because there are other ways to alter this data,
> and this access is already controlled by the inode_setattr hook (as
> Tony mentioned).  So this is a no go.

Right, the patch is no longer available as notify_change grabs the
inode_setattr hook returned data.

Did you checked the other one on sys_chroot()? (I've updated it a day or
so ago).

Cheers, thanks for commenting on it.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-zPbJSgdMhldBDyAdZooW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCChnuDcEopW8rLewRAikPAJ48KENE4CfeuSwHvlsbvF8JC7NV0ACfUkTj
8J16RLqS+FLMdWBwJh0r2n8=
=Lx2w
-----END PGP SIGNATURE-----

--=-zPbJSgdMhldBDyAdZooW--

