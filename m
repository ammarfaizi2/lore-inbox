Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUECMlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUECMlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbUECMlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:41:21 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:21734 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263663AbUECMlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:41:06 -0400
Date: Mon, 3 May 2004 14:41:05 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Reading from file in module fails
Message-ID: <20040503124105.GS29503@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040503105041.GA12023@Loki> <20040503113500.GB31513@harddisk-recovery.com> <20040503114316.GA22732@Loki>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5XwDZYQieeN6n9K"
Content-Disposition: inline
In-Reply-To: <20040503114316.GA22732@Loki>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f5XwDZYQieeN6n9K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-03 13:43:16 +0200, Libor Vanek <libor@conet.cz>
wrote in message <20040503114316.GA22732@Loki>:
> It's not bad design - what I'm doing is writing snapshots for VFS as my d=
iploma thesis. And I need to create copy of file before it's changed (copy-=
on-write). There is no other way how to do it in kernel-space (and user-spa=
ce solutions like using LUFS are really slow)

That can all be done in userspace.

$ export LD_PRELOAD=3Dlibcopyfilesbeforemodify.so

You just need to program a library that provides all functions that
modify files (eg. write, open with O_CREAT, ...) and you're done - 100%
in userspace.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--f5XwDZYQieeN6n9K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAlj3hHb1edYOZ4bsRAlhlAJ9bODmUvI/i7UNtsLQaJvPHGKPYSgCfbLIX
sfWjt3a+/m1FQYvyOCzvG38=
=3PTN
-----END PGP SIGNATURE-----

--f5XwDZYQieeN6n9K--
