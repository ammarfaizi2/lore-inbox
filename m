Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVCFIHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVCFIHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVCFIHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 03:07:44 -0500
Received: from admingilde.org ([213.95.21.5]:52177 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S261332AbVCFIHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 03:07:31 -0500
Date: Sun, 6 Mar 2005 00:17:53 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/16] [DocBook] factor out escaping of XML special characters
Message-ID: <20050305231753.GB4653@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org> <200503031043.j23AhHan020786@faui31y.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <200503031043.j23AhHan020786@faui31y.informatik.uni-erlangen.de>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
X-Hashcash: 0:050306:akpm@osdl.org:77a7b2a45e3b1024
X-Hashcash: 0:050306:linux-kernel@vger.kernel.org:b37c3762d6d81b58
X-Spam-Score: -12.5 (------------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

well, this patch is broken :(

On Thu, Mar 03, 2005 at 11:43:17AM +0100, Martin Waitz wrote:
> --- a/scripts/kernel-doc	Thu Mar  3 11:43:21 2005
> +++ b/scripts/kernel-doc	Thu Mar  3 11:43:21 2005
> @@ -1624,6 +1624,15 @@
>      }
>  }
> =20
> +# replace <, >, and &
> +sub xml_escape($) {
> +	shift;

this must be: $_ =3D shift;

> +	s/\&/\\\\\\amp;/g;
> +	s/\</\\\\\\lt;/g;
> +	s/\>/\\\\\\gt;/g;
> +	return $_;
> +}
> +
>  sub process_file($) {
>      my ($file) =3D "$ENV{'SRCTREE'}@_";
>      my $identifier;


this is also fixed in my BK repository.
(I'll send mail with other updates to lkml later)

--=20
Martin Waitz

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCKj4hj/Eaxd/oD7IRAtjSAJ9XlXju8PmNkUGLm/ENN5+NoRXxCwCfSf39
u95viQF/zLi39Qm0WAZ81x4=
=586R
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--

