Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbQLQQLR>; Sun, 17 Dec 2000 11:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129905AbQLQQLH>; Sun, 17 Dec 2000 11:11:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:28167 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129675AbQLQQKz>;
	Sun, 17 Dec 2000 11:10:55 -0500
Date: Sun, 17 Dec 2000 16:38:02 +0100
From: Kurt Garloff <garloff@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001217163802.O2589@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu> <20001217125656.A309@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="K8zN2sh9fO5jmbe4"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217125656.A309@elektroni.ee.tut.fi>; from kaukasoi@elektroni.ee.tut.fi on Sun, Dec 17, 2000 at 12:56:56PM +0200
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8zN2sh9fO5jmbe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 17, 2000 at 12:56:56PM +0200, Petri Kaukasoina wrote:
> I guess the new memory detect does not work correctly with my old work
> horse. It is a 100 MHz pentium with 56 Megs RAM. AMIBIOS dated 10/10/94 w=
ith
> a version number of 51-000-0001169_00111111-101094-SIS550X-H.
>=20
> 2.2.18 reports:
> Memory: 55536k/57344k available (624k kernel code, 412k reserved, 732k da=
ta, 40k init)
>=20
> 2.2.19pre2 reports:
> Memory: 53000k/54784k available (628k kernel code, 408k reserved, 708k da=
ta, 40k init)
>=20
> 57344k is 56 Megs which is correct.
> 54784k is only 53.5 Megs.

It's this patch that changes things for you:
o       E820 memory detect backport from 2.4            (Michael Chen)

The E820 memory detection parses a list from the BIOS, which specifies
the amount of memory, holes, reserved regions, ...
Apparently, your BIOS does not do it completely correctly; otherwise you
should have had crashes before ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--K8zN2sh9fO5jmbe4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6PN3ZxmLh6hyYd04RAtueAJ9CBs1j3Ox/DdyCNaQzAKjhYEPLzACgvfsH
Y2FSpRxjhCVLDQOHF1yQEjA=
=YZRe
-----END PGP SIGNATURE-----

--K8zN2sh9fO5jmbe4--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
