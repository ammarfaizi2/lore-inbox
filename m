Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUFOUOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUFOUOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUFOUOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:14:07 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:3814 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265928AbUFOUNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:13:34 -0400
Date: Tue, 15 Jun 2004 22:13:29 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: AT Keyboard (was: Helge Hafting vs. make menuconfig help)
Message-ID: <20040615201329.GR20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de> <20040615142040.B6241@beton.cybernet.src> <20040615144127.GG20632@lug-owl.de> <20040615172129.F6843@beton.cybernet.src> <20040615173210.GM20632@lug-owl.de> <20040615174651.A6965@beton.cybernet.src> <20040615183700.GA13866@hh.idb.hist.no> <20040615195903.A7813@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m3jd3pM6f9NTUwsB"
Content-Disposition: inline
In-Reply-To: <20040615195903.A7813@beton.cybernet.src>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m3jd3pM6f9NTUwsB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 19:59:03 +0000, Karel Kulhav=FD <clock@twibright.com>
wrote in message <20040615195903.A7813@beton.cybernet.src>:
> > 4. From there, the key is propagated through tty and
> >    console and ends up in your application.  This application
> >    might be X, which passes the key onto some program using X.
>=20
> I am insterested in the 4. itself.

This is from memory, some details may be wrong:

	- The keyboard driver first determines what key the scancodes
	  belong to. If you press one single key, it may be sent as
	  multiple scancodes. The keyboard driver first has to assemble
	  these scancodes and make a decision from it (like "Key 'a'
	  pressed"). This information ('a' pressed down). is put into
	  Input API.
	- Input API then prepares hands this key press to the TTY
	  driver.
	- An application on the currently visible VT gets the 'a' (if it
	  didn't request raw scancodes. In this case, the TTY layer
	  *emulates* scancodes from the "'a' pressed down" event), and
	  the 'a' is also displayed on the VT (if echo'ing is switched
	  on).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--m3jd3pM6f9NTUwsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAz1hoHb1edYOZ4bsRAvo1AJ9J1Qt61oNPXdnW9vbLAYSXBZ2PLACfcYeH
uX5AapOHUvylFDRL8O5OzRs=
=V0N5
-----END PGP SIGNATURE-----

--m3jd3pM6f9NTUwsB--
