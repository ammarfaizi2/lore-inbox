Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTFYSvU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTFYSvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:51:19 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:8463 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264924AbTFYSvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:51:06 -0400
Date: Wed, 25 Jun 2003 21:05:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SOLVED - Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030625190515.GJ29233@lug-owl.de>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <20030625182210.GI29233@lug-owl.de> <Pine.SOL.4.30.0306252040570.11992-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2uG6jHjFLimDtBY"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306252040570.11992-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2uG6jHjFLimDtBY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-06-25 20:44:19 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiew=
icz@elka.pw.edu.pl>
wrote in message <Pine.SOL.4.30.0306252040570.11992-100000@mion.elka.pw.edu=
.pl>:
> On Wed, 25 Jun 2003, Jan-Benedict Glaw wrote:
> > On Wed, 2003-06-25 01:08:13 +0200, Bartlomiej Zolnierkiewicz <B.Zolnier=
kiewicz@elka.pw.edu.pl>
> > wrote in message <Pine.SOL.4.30.0306250107180.17106-100000@mion.elka.pw=
.edu.pl>:
> > > On Wed, 25 Jun 2003, Jan-Benedict Glaw wrote:
> > > > On Tue, 2003-06-24 15:44:36 +0200, Bartlomiej Zolnierkiewicz <B.Zol=
nierkiewicz@elka.pw.edu.pl>
> > > > wrote in message <Pine.SOL.4.30.0306241543050.23584-100000@mion.elk=
a.pw.edu.pl>:

> > However, allow me to ask why this occured never bevore (for other
> > people)? Do they all have only one drive? Does nobody use TCQ? Nobody
> > with old hardware (though, your patch hasn't touched the core PIIX
> > parts...)?
>=20
> nobody is stupid^H^Hbrave enough to use TCQ ;-)

Well... I knew that it was, erm, brave to use it at some time (this box
isn't really important - if I kill its filesystems, I'll simply
re-install and recover my mirror scripts:) ,  but new, where 2.5.x
starts to be really useable, I'd suggest to face users with upcoming
problems:

CONFIG_IDE_TASKFILE_IO
	It is safe to say Y to this question, in most cases.

	(By the way, exactly which cases are ment?)


CONFIG_BLK_DEV_IDE_TCQ
	If you have such a drive, say Y here.


CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
	Generally say Y here.


CONFIG_BLK_DEV_IDE_TCQ_DEPTH
	You probably just want the default of 32 here.

	(Default queue depth is 8, not 32...)


Right now, I'm building 2.5.73-bk3 + your 2nd patch. Let's face it:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--J2uG6jHjFLimDtBY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++fJrHb1edYOZ4bsRAmYqAJ9iNxr664CtVYbkHGSzRwKEEtNR4ACfQvkC
yQT4OrbMN9H4iGdSN82Ltws=
=C6en
-----END PGP SIGNATURE-----

--J2uG6jHjFLimDtBY--
