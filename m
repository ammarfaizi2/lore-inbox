Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTLJNzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTLJNzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:55:24 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:54287 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S263545AbTLJNzS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:55:18 -0500
Date: Wed, 10 Dec 2003 07:55:16 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?
Message-ID: <20031210135516.GA2687@dbz.icequake.net>
References: <3ACA40606221794F80A5670F0AF15F8401720C15@PDSMSX403.ccr.corp.intel.com> <20031210125543.GA1444@dbz.icequake.net> <16343.8777.389445.2007@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <16343.8777.389445.2007@alkaid.it.uu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Dec 10, 2003 at 02:40:25PM +0100, Mikael Pettersson wrote:
> Ryan Underwood writes:
>  >=20
>  > Attached dmesg and interrupts with acpi=3Doff.  Also attached kernel
>  > config.
>  >=20
>  > As you see, it acknowledges a local APIC but mentions nothing about
>  > IO-APIC.  So I guess this isn't ACPI issue after all.  But, I wonder w=
hy
>  > the IO-APIC isn't being used on this board anymore.  There was a
>  > blacklist entry for it, but it was removed after it was discovered to =
be
>  > in error.
>=20
> Your dmesg log doesn't mention any MP-table. With neither ACPI MADT
> nor an MP-table the kernel has no way of knowing about any I/O-APIC.
>=20
> You do have UP_IOAPIC enabled, so the kernel should look for it.
> Please check your BIOS settings, and try with no ACPI at all in the kernel
> (just to verify that acpi=3Doff doesn't prevent MP-table parsing).

I went back and found the messages corresponding to our previous
discussions:

http://www.cs.helsinki.fi/linux/linux-kernel/2003-23/1675.html

Looks like again I've confused the local APIC with the IO-APIC regarding
that blacklist entry.  However, I thought 440BX had a IO-APIC built-in
to the southbridge.  Again, that was proved to be wrong by examining the
integrator's guide:
ftp://download.intel.com/design/chipsets/designex/29063401.pdf

page 99 of the PDF says:
"An I/O APIC is required for a DP system and optional for a UP system."

So it looks like I've never had an I/O-APIC on this board at all, only a
local APIC, and this thread is thus a waste of time. :)

In any case, thanks for leading me to the right answer!

--=20
Ryan Underwood, <nemesis@icequake.net>

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1yXEIonHnh+67jkRAhxeAJ9npBG8RKnD+YJir1Vovoq3kvgXhgCbBQ0b
v9ySVu+Sd24TtYq93/dYqzw=
=Orod
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
