Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVAAJBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVAAJBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 04:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVAAJBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 04:01:16 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:30415 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262201AbVAAJBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 04:01:11 -0500
Date: Sat, 1 Jan 2005 11:01:10 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, pmarques@grupopie.com
Subject: Re: sh: inconsistent kallsyms data
Message-ID: <20050101090110.GA22697@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	sam@ravnborg.org, pmarques@grupopie.com
References: <20041231172549.GA18211@linux-sh.org> <7184.1104551959@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <7184.1104551959@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 01, 2005 at 02:59:19PM +1100, Keith Owens wrote:
> This corner case only occurs with CONFIG_KALLSYMS_ALL=3Dn.  That is the
> only time that we drop symbols outside the ranges _stext ... _etext and
> _sinittext ... _einittext.  For CONFIG_KALLSYMS_ALL=3Dn, we want the
> _etext and _einittext labels, but not any other symbols that have the
> same numeric value as _etext or _einittext.
>=20
> Paul, please test this patch.  Build with CONFIG_KALLSYMS_ALL=3Dn and
> CONFIG_KALLSYMS_EXTRA_PASS=3Dn.
>=20
Works fine for me, thanks.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB1mbW1K+teJFxZ9wRAj2sAJ9w8j5lInlXyL5izKbH/36OKpn24QCeNFia
cmy5dQnS51BbgwNqRNJZA0k=
=h57v
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
