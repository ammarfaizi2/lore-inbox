Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759878AbWLFDqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759878AbWLFDqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 22:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759900AbWLFDqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 22:46:45 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:42008 "EHLO
	quickstop.soohrt.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759878AbWLFDqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 22:46:44 -0500
Date: Wed, 6 Dec 2006 04:46:42 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, jpdenheijer@gmail.com,
       Daniel Drake <dsd@gentoo.org>, sam@ravnborg.org, miraze@web.de,
       zzam@gentoo.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061206034642.GH3092@quickstop.soohrt.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@suse.de>, jpdenheijer@gmail.com,
	Daniel Drake <dsd@gentoo.org>, sam@ravnborg.org, miraze@web.de,
	zzam@gentoo.org
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612051516070.1868@scrub.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612051516070.1868@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 05 Dec 2006, Roman Zippel wrote:
> On Mon, 4 Dec 2006, Andrew Morton wrote:
> > kbuild-dont-put-temp-files-in-the-source-tree.patch
> > actually-delete-the-as-instr-ld-option-tmp-file.patch
>=20
> Andi had objections about the mktemp usage and I agree with him.
> The proposed patch in bugzilla didn't have this and no further=20
> justification was given for why it's needed.
> Below is a replacement patch with some improvements:
> - kbuild doesn't use $(AS), so use $(CC)
> - tmp dir needs only to be calculated once
> - reformat a bit to keep it under 80 columns and to be more readable
>=20
> bye, Roman
>=20
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

This patch looks good to me, and I'd prefer it over the (twice
corrected) one currently in -mm.

-  It's close to what Daniel Drake proposed recently [1] (main
   difference: corrects the very same problem for ld-option, which might
   otherwise bite us later) and what's already in Gentoo's patchkernel,

-  it abstains from using mktemp, hopefully making Andi happy ;),

-  resolves the current Gentoo sandbox issues without touching more
   kbuild code than necessary.

Kind regards,
 Horst

[1]Message-Id: <20061202194544.D9F057B40A0@zog.reactivated.net>

--=20
PGP-Key 0xD40E0E7A

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdj0iB6mkGNQODnoRAk18AJ9TAi34+ZgCSvZELiroKpHbbTo9DQCfTPTD
vXSHu1LYOdiSbaV1xX3/OFA=
=dFzE
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
