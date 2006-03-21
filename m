Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWCUR2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWCUR2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWCUR2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:28:36 -0500
Received: from lug-owl.de ([195.71.106.12]:54763 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932314AbWCUR2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:28:22 -0500
Date: Tue, 21 Mar 2006 18:28:20 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Paul Smith <psmith@gnu.org>
Subject: Re: [PATCH 35/46] kbuild: change kbuild to not rely on incorrect GNU make behavior
Message-ID: <20060321172820.GQ20746@lug-owl.de>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	lkml <linux-kernel@vger.kernel.org>, Paul Smith <psmith@gnu.org>
References: <1142958057218-git-send-email-sam@ravnborg.org> <11429580571656-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L/iKGr82HRlWSTal"
Content-Disposition: inline
In-Reply-To: <11429580571656-git-send-email-sam@ravnborg.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--L/iKGr82HRlWSTal
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-21 17:20:57 +0100, Sam Ravnborg <sam@ravnborg.org> wrote:
> diff --git a/scripts/package/Makefile b/scripts/package/Makefile
> index c201ef0..d3038b7 100644
> --- a/scripts/package/Makefile
> +++ b/scripts/package/Makefile
> @@ -82,7 +82,7 @@ clean-dirs +=3D $(objtree)/debian/
> =20
>  # tarball targets
>  # ----------------------------------------------------------------------=
-----
> -.PHONY: tar%pkg
> +PHONY +=3D tar%pkg
>  tar%pkg:
>  	$(MAKE) KBUILD_SRC=3D
>  	$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@

This part is wrong. $(PHONY) isn't subject to pattern matching, so all
targets that match 'tar%pkg' must be listed here. Fortunately, that's
only three:

PHONY +=3D tar-pkg targz-pkg tarbz2-pkg

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--L/iKGr82HRlWSTal
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEIDe0Hb1edYOZ4bsRAhzBAJ49pVhIVycsL1ezJnegi6TClDUYSACfWbkx
evXzNe060pajN+kSxl9j7So=
=Z0og
-----END PGP SIGNATURE-----

--L/iKGr82HRlWSTal--
