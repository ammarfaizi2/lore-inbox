Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274808AbTGaPeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274814AbTGaPd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:33:26 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:45458 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272516AbTGaPcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:32:05 -0400
Date: Thu, 31 Jul 2003 17:32:03 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Emulating i486 on i386 (was: TSCs are a no-no on i386)
Message-ID: <20030731153203.GA1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de> <20030731071719.GA26249@alpha.home.local> <20030731113838.GU1873@lug-owl.de> <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk> <20030731151226.GG6410@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nwrnLigiJ19QsFfd"
Content-Disposition: inline
In-Reply-To: <20030731151226.GG6410@mail.jlokier.co.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nwrnLigiJ19QsFfd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 16:12:26 +0100, Jamie Lokier <jamie@shareable.org>
wrote in message <20030731151226.GG6410@mail.jlokier.co.uk>:
> Alan Cox wrote:
> > On Iau, 2003-07-31 at 12:38, Jan-Benedict Glaw wrote:
> > > See? It's loaded at the "ls" call, but it seems to be not loaded for
> > > apt-get.
> >=20
> > Remember you need to overload signal setting functions like sigaction.
> > My guess is apt decided to disable your signal and you didnt stop it
>=20
> An application might install its own SIGILL handler to emulate or trap
> _other_ instructions.  To do it properly, you have to chain the handlers.
>=20
> Not sure how to do this, when you get to the stage of two LD_PRELOAD
> libraries each wanting to overload sigaction.

That's not (yet) my problem and I think it's not impossible to hook
them. _But_ before, I need to get called at all _before_ libstdc++5's
_init(). For now, I haven't managed to do that...

My hack^H^H^H^Hsources are at
http://www.lug-owl.de/~jbglaw/software/catch_sigill/ .

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--nwrnLigiJ19QsFfd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KTZzHb1edYOZ4bsRAnxCAKCKwj61kDLVEhZjxNepmghHuysfYwCfbDk2
CwNb72FKr+YuzIpQBiQD6nQ=
=LQ7v
-----END PGP SIGNATURE-----

--nwrnLigiJ19QsFfd--
