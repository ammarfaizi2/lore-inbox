Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264691AbUFHFSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264691AbUFHFSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 01:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUFHFSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 01:18:15 -0400
Received: from mail.donpac.ru ([80.254.111.2]:732 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264691AbUFHFSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 01:18:12 -0400
Date: Tue, 8 Jun 2004 09:18:08 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-ID: <20040608051808.GA19170@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org> <20040607124125.GT3776@pazke> <20040607220157.1e67ec39.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20040607220157.1e67ec39.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 159, 06 07, 2004 at 10:01:57 -0700, Andrew Morton wrote:
> Andrey Panin <pazke@donpac.ru> wrote:
> >
> > Could you apply attached patch (only exports DMI check functions) inste=
ad of them ?
>=20
> I'll need a better description of what it does, please.

This patch creates and exports 2 functions which can be used
by the rest of kernel code to perform DMI data checks:

 - dmi_check_system() function checks system DMI data against
given blacklist table and on each match runs corresponding
callback function;

 - dmi_get_system_info() function returns DMI data value.
Useful for people wanting more complex DMI data check than
simple string match.


Also filling unused match entries with NO_MATCH made optional,
but existing NO_MATCH occurences are left intact, so people
are free to continue dmi_scan.c patching without massive
reject problems.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxUwQby9O0+A2ZecRAkQpAKCyQQ0MsVCV+6giXASBsvgULqmTaACeJGBb
kBaFvpmmbB5DqgveNsVnZ2I=
=91vX
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
