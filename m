Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUANJVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbUANJVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:21:03 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:41683 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S265263AbUANJUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:20:30 -0500
Date: Wed, 14 Jan 2004 10:11:28 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com, pavel@ucw.cz,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       mark.langsdorf@amd.com
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114091128.GA11159@dominikbrodowski.de>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	paul.devriendt@amd.com, pavel@ucw.cz, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org, mark.langsdorf@amd.com
References: <99F2150714F93F448942F9A9F112634C080EF39F@txexmtae.amd.com> <20040114034237.GT14674@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20040114034237.GT14674@redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2004 at 03:42:37AM +0000, Dave Jones wrote:
> On Tue, Jan 13, 2004 at 09:39:53PM -0600, paul.devriendt@amd.com wrote:
>  > >> Dave had a good idea of a minimal ACPI parser for trying to retriev=
e the
>  > >> table of p-states from an ACPI BIOS without needing the full AML in=
terpreter.
>  > >> I will see if I can get that to work in powernow-k8-acpi=20
>  > > =20
>  > > If done properly, that parsing code could be shared by the K7=20
>  > > driver too.
>  >=20
>  > Agreed. Function in a header file? Don't want the drivers attempting to
>  > call each other at runtime.
>=20
> Works for me, or shove it out into its own .c file, and have both drivers=
 link against it.

Guys, do you remember my acpi-perflib?[1] Currently, I'm rewriting it so th=
at
it isn't so invasive and can be merged more easily during 2.x.[2] It's exac=
tly
what you want as base for powernow-k7-acpi and powernow-k8-acpi driver.

However, as it relies on CONFIG_ACPI, an acpi-perflib-no-acpi module which
exports the same functions, but includes a minimal parser could be added.
But let's do the easy part (CONFIG_ACPI) first.

[1] http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D106547064228222&w=3D2
[patches are taken down from the website, though...]

[2] http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D107398568612489&w=3D2 =
is a
first step, another one will be sent out later today.

	Dominik

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABQfAZ8MDCHJbN8YRAgjBAJ0RVZwuo+hjsICIAIhxSYigpiLjbgCfcypp
LmgK8LUme7UY88V/3e8D+yU=
=d9Tz
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
