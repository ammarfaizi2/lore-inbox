Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265952AbUANJ15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUANJZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:25:48 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:49643 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S265294AbUANJZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:25:26 -0500
Date: Wed, 14 Jan 2004 10:25:01 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       mark.langsdorf@amd.com
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114092501.GA11381@dominikbrodowski.de>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Dave Jones <davej@redhat.com>, paul.devriendt@amd.com,
	cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
	mark.langsdorf@amd.com
References: <99F2150714F93F448942F9A9F112634C080EF39F@txexmtae.amd.com> <20040114034237.GT14674@redhat.com> <20040114090138.GB260@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20040114090138.GB260@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2004 at 10:01:39AM +0100, Pavel Machek wrote:
> Hi!
>=20
> >  > >> Dave had a good idea of a minimal ACPI parser for trying to retri=
eve the
> >  > >> table of p-states from an ACPI BIOS without needing the full AML =
interpreter.
> >  > >> I will see if I can get that to work in powernow-k8-acpi=20
> >  > > =20
> >  > > If done properly, that parsing code could be shared by the K7=20
> >  > > driver too.
> >  >=20
> >  > Agreed. Function in a header file? Don't want the drivers attempting=
 to
> >  > call each other at runtime.
> >=20
> > Works for me, or shove it out into its own .c file, and have both drive=
rs link against it.
>=20
> Would acpi parsing be usefull for non-amd systems, too?

The acpi "performance library", whether it uses the CONFIG_ACPI parser or
some small independent parser, is (at least) also useful for

- ACPI 2.0 P-States using I/O-port access [current
  arch/i386/kernel/cpu/cpufreq/acpi.c driver -- it can be cleaned up by
  that. In fact, I'm currently working on it.]

- speedstep-centrino driver [can use ACPI info instead of built-in tables]
  [sample patch based on earlier acpi-perflib patch is in the cpufreq and
   acpi-devel archives]

	Dominik

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABQrtZ8MDCHJbN8YRAjbnAJ0a+nBryCp+Kxopt++/el0K/IebvACggM4m
8xtkleb3YO6sF54QKzXUeGQ=
=oWEi
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
