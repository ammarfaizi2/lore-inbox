Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279629AbRKGKPH>; Wed, 7 Nov 2001 05:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279688AbRKGKO5>; Wed, 7 Nov 2001 05:14:57 -0500
Received: from [194.51.220.145] ([194.51.220.145]:51427 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S279629AbRKGKOr>;
	Wed, 7 Nov 2001 05:14:47 -0500
Date: Wed, 7 Nov 2001 11:13:39 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Cc: Massimo Dal Zotto <dz@cs.unitn.it>, LKLM <linux-kernel@vger.kernel.org>,
        Juri Haberland <juri@koschikode.com>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011107111339.A4155@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <20011105231759.02B541195E@a.mx.spoiled.org> <200111061645.RAA02115@fandango.cs.unitn.it> <20011107104405.A3168@emeraude.kwisatz.net> <20011107110141.C29983@joshua.mesa.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20011107110141.C29983@joshua.mesa.nl>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2001 at 11:01:41AM +0100, Marcel J.E. Mol wrote:
> Maybe this is better:
>=20
> diff -u i8kutils-1.2.orig/i8kbuttons.c i8kutils-1.2/i8kbuttons.c
> --- i8kutils-1.2.orig/i8kbuttons.c      Tue Nov  6 20:07:27 2001
> +++ i8kutils-1.2/i8kbuttons.c   Tue Nov  6 20:11:19 2001
> @@ -53,15 +53,17 @@
>=20
>      DPRINTF("exec_cmd: %s\n", cmd);
>=20
>      if ((rc=3Dfork()) < 0) {
>         perror("fork failed");
>         return;
>      }
> =20
>      if (rc =3D=3D 0) {
>         execl("/bin/sh", "sh", "-c", cmd, NULL);
>         exit(0);
>      }
> +    else
> +       wait(&rc);
>  }
> =20
> It get rid of the zombies and allows only one setmixer/auimix command
> to be active at a time...

Yup I did that on i8kutils-1.1, then reverted to system(), because I
removed the anti-repeat system, and used a slow mixer application. Then
the repeat was bad (sometimes slow, sometimes quick).
In fact, I don't really mind, as now I use aumix (and it is fast
enought).

Massimo, choose one please :-)

	Stephane


--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing=E9nieur d=E9veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvpCVMACgkQk2dpMN4A2NPVMgCggZCjnQJ3C/OgJrj382d1FO2L
AAIAnRYtafWJFhz2Of+3OOtmbdB1xBZd
=tokU
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
