Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSKKWyK>; Mon, 11 Nov 2002 17:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbSKKWyK>; Mon, 11 Nov 2002 17:54:10 -0500
Received: from iucha.net ([209.98.146.184]:61228 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id <S261568AbSKKWyI>;
	Mon, 11 Nov 2002 17:54:08 -0500
Date: Mon, 11 Nov 2002 17:00:55 -0600
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] cs46xx compile error 2.5.47
Message-ID: <20021111230055.GA691@iucha.net>
Mail-Followup-To: Ed Tomlinson <tomlins@cam.org>,
	linux-kernel@vger.kernel.org
References: <200211111740.18312.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <200211111740.18312.tomlins@cam.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2002 at 05:40:18PM -0500, Ed Tomlinson wrote:
> Hi,
>=20
> I get this compiling 2.5.47
>=20
>   gcc -Wp,-MD,sound/pci/cs46xx/.cs46xx_lib.o.d -D__KERNEL__ -Iinclude -Wa=
ll=20
> -Wstrict-prototypes -Wrigraphs -O2 -fno-strict-aliasing -fno-common -pipe=
=20
> -mpreferred-stack-boundary=3D2 -march=3Dk6 -Iarch//mach-generic -fomit-fr=
ame-pointer=20
> -nostdinc -iwithprefix include -DMODULE -include include/linux/ersions.h =
 =20
> -DKBUILD_BASENAME=3Dcs46xx_lib   -c -o sound/pci/cs46xx/cs46xx_lib.o soun=
d/pci/cs46xx/cs_lib.c
> sound/pci/cs46xx/cs46xx_lib.c: In function `_cs46xx_adjust_sample_rate':
> sound/pci/cs46xx/cs46xx_lib.c:1054: structure has no member named `spos_m=
utex'
> sound/pci/cs46xx/cs46xx_lib.c: In function `snd_cs46xx_playback_hw_params=
':
> sound/pci/cs46xx/cs46xx_lib.c:1071: warning: unused variable `chip'
> sound/pci/cs46xx/cs46xx_lib.c:1072: warning: unused variable `sample_rate'
> sound/pci/cs46xx/cs46xx_lib.c:1073: warning: unused variable `period_size'
> sound/pci/cs46xx/cs46xx_lib.c: In function `snd_cs46xx_capture_hw_params':
> sound/pci/cs46xx/cs46xx_lib.c:1251: warning: unused variable `period_size'
> sound/pci/cs46xx/cs46xx_lib.h: At top level:
> sound/pci/cs46xx/cs46xx_lib.c:1028: warning: `_cs46xx_adjust_sample_rate'=
 defined but not used
> sound/pci/cs46xx/cs46xx_lib.c:1445: warning: `hw_constraints_period_sizes=
' defined but not used
> make[3]: *** [sound/pci/cs46xx/cs46xx_lib.o] Error 1
> make[2]: *** [sound/pci/cs46xx] Error 2
> make[1]: *** [sound/pci] Error 2
> make: *** [sound] Error 2
>=20
> Anyone have any ideas?

Enable CONFIG_SND_CS46XX_NEW_DSP. That will get it to compile.

Cheers,
florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE90DanNLPgdTuQ3+QRAnp4AJ0SyjtCjh/VVZTeSdI//av0fuDA+ACfYY3t
pZnI/6yT06jrSunL8PihpVc=
=JmiY
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
