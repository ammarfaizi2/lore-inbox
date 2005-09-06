Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVIFS0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVIFS0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVIFS0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:26:09 -0400
Received: from ms-smtp-01-lbl.southeast.rr.com ([24.25.9.100]:36060 "EHLO
	ms-smtp-01-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S1750778AbVIFS0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:26:08 -0400
Subject: Re: [ck] 2.6.13-ck2
From: Adam Petaccia <adam@tpetaccia.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
In-Reply-To: <200509052344.11665.kernel@kolivas.org>
References: <200509052344.11665.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gXFI7U7oQmQQtfDsu7LM"
Date: Tue, 06 Sep 2005 14:25:57 -0400
Message-Id: <1126031157.8117.5.camel@pimpmobile>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gXFI7U7oQmQQtfDsu7LM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-09-05 at 23:44 +1000, Con Kolivas wrote:
> These are patches designed to improve system responsiveness and interacti=
vity.=20
> It is configurable to any workload but the default ck* patch is aimed at =
the=20
> desktop and ck*-server is available with more emphasis on serverspace.
>=20
>=20
> Apply to 2.6.13
> http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck2/patch-2.6.13-ck2.bz2
>=20
> or server version (no new version this release):
> http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1-serv=
er.bz2
>=20
>=20
> web:
> http://kernel.kolivas.org
> all patches:
> http://ck.kolivas.org/patches/
> Split patches available.
>=20
>=20
> Changes:
>=20
> Added:
>  +vm-swap_prefetch-2.patch
> As mentioned many times already, this code prefetches ram that has been=20
> swapped out during idle periods. This is the latest version of the patch =
and=20
> is a config option.
I think this patch is missing an IFDEF or something (I'm not really a
programmer, I just like to pretend).  Anyway, I've tried building -ck2
without swap enabled, and it failed.  Just to make sure, I make'd
distclean, and I get the following:

  LD      .tmp_vmlinux1
mm/built-in.o: In function `zone_watermark_ok':
mm/page_alloc.c:763: undefined reference to `delay_prefetch'
mm/built-in.o: In function `swap_setup':
mm/swap.c:485: undefined reference to `prepare_prefetch'
make: *** [.tmp_vmlinux1] Error 1

--=20
Adam Petaccia <adam@tpetaccia.com>

--=-gXFI7U7oQmQQtfDsu7LM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDHd81BIvjQglsR2ARAjQOAJ49jQ2VosD+puvx8Z7EIFmvIu7j+ACgtQXB
Cb07kNnk7QgkVMu6u8LYbik=
=vdSy
-----END PGP SIGNATURE-----

--=-gXFI7U7oQmQQtfDsu7LM--

