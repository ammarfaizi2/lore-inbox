Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279321AbRKFN7e>; Tue, 6 Nov 2001 08:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279326AbRKFN7Z>; Tue, 6 Nov 2001 08:59:25 -0500
Received: from [194.51.220.145] ([194.51.220.145]:62171 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S279321AbRKFN7M>;
	Tue, 6 Nov 2001 08:59:12 -0500
Date: Tue, 6 Nov 2001 14:58:22 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: Georg Nikodym <georgn@somanetworks.com>
Cc: LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011106145822.A8159@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <20011105100346.A1511@emeraude.kwisatz.net> <20011105130954.A24310@joshua.mesa.nl> <20011105180124.B17203@emeraude.kwisatz.net> <1004986822.1553.3.camel@keller>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <1004986822.1553.3.camel@keller>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14-pre8
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2001 at 02:00:22PM -0500, Georg Nikodym wrote:
> On Mon, 2001-11-05 at 12:01, Stephane Jourdois wrote:
> > Hope this helps, and if anybody knows how to implement keysyms, I'm
> > interested... as long as I don't have to patch XFree86 !
>=20
> No need.  Here's what I do with xmodmap:
>=20
> !
> ! Dell 8000
> ! I have sawfish map these to
> ! xmms -u, -s, -r and -f respectively
> !
> keycode 129 =3D XF86AudioPlay
> keycode 130 =3D XF86AudioStop
> keycode 131 =3D XF86AudioPrev
> keycode 132 =3D XF86AudioNext

And that works indeed !

Try :
	[ `ps -C xmms | wc -l` =3D 7 ] && xmms --pause || xmms --play
instead of xmms -u. Then you really have Play/Pause...



For those who use enlightenment... here are the keybindings for it
(in your .enlightenment/keybindings.cfg, that you copyied from
/usr/share/enlightenment/config/) :

  __NEXT_ACTION
    __MODIFIER_KEY __NONE
    __KEY XF86AudioPlay
    __EVENT __KEY_PRESS
    __ACTION __A_EXEC /home/kwisatz/bin/xmms_play
  __NEXT_ACTION
    __MODIFIER_KEY __NONE
    __KEY XF86AudioStop
    __EVENT __KEY_PRESS
    __ACTION __A_EXEC xmms --stop
  __NEXT_ACTION
    __MODIFIER_KEY __NONE
    __KEY XF86AudioPrev
    __EVENT __KEY_PRESS
    __ACTION __A_EXEC xmms --rew
  __NEXT_ACTION
    __MODIFIER_KEY __NONE
    __KEY XF86AudioNext
    __EVENT __KEY_PRESS
    __ACTION __A_EXEC xmms --fwd

/home/kwisatz/bin/xmms_play is a onle-liner (Cf. above)


PS : I know this is OT, but as the only mean of those i8k buttons
is multimedia, I think it's great to learn how to bind them :-)

Stephane

--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing=E9nieur d=E9veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvn7H4ACgkQk2dpMN4A2NPwfgCfePUqDG0nLnDiIvYjQGDNTWKm
vegAn2UgMg3duk8DJTl2cuSRd/d+lMAz
=0vhs
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
