Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQLTLQy>; Wed, 20 Dec 2000 06:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129757AbQLTLQp>; Wed, 20 Dec 2000 06:16:45 -0500
Received: from Cantor.suse.de ([194.112.123.193]:27400 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129604AbQLTLQc>;
	Wed, 20 Dec 2000 06:16:32 -0500
Date: Wed, 20 Dec 2000 11:44:09 +0100
From: Kurt Garloff <garloff@suse.de>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001220114409.E29231@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu> <20001217125656.A309@elektroni.ee.tut.fi> <20001217163802.O2589@garloff.suse.de> <20001220123254.A208@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001220123254.A208@elektroni.ee.tut.fi>; from kaukasoi@elektroni.ee.tut.fi on Wed, Dec 20, 2000 at 12:32:54PM +0200
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2000 at 12:32:54PM +0200, Petri Kaukasoina wrote:
> OK, I booted 2.4.0-test12 which even prints that list:
>=20
> BIOS-provided physical RAM map:
>  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
>  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
>  BIOS-e820: 0000000003480000 @ 0000000000100000 (usable)
>  BIOS-e820: 0000000000100000 @ 00000000fec00000 (reserved)
>  BIOS-e820: 0000000000100000 @ 00000000fee00000 (reserved)
>  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
> Memory: 52232k/54784k available (831k kernel code, 2164k reserved, 62k da=
ta, 168k init, 0k highmem)
>=20
> The last three reserved lines correspond to the missing 2.5 Megs. What are
> they?

Data reserved by your system for whatever purpose.
Most probably ACPI data or similar.

> 2.2.18 sees all 56 Megs and works ok and after adding mem=3D56M on the
> kernel command line even 2.2.19pre2 works ok with all the 56 Megs. No
> crashes.

If you would have ACPI events, you would probably run into trouble.
Apart from this, chances are that the reserved data is not needed by Linux
and never accessed by the BIOS, so you may get away with using the reserved
memory.
The safe way is to respect the BIOS' RAM map.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6QI15xmLh6hyYd04RAmylAKDA2shrZuG631xSJw2/eScVdIS8CgCffBcd
Bmpho4GdvxHs4iD26fR6V5k=
=Ie6A
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
