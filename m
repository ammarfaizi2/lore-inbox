Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264302AbUEXPRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264302AbUEXPRU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 11:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbUEXPRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 11:17:20 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:58558 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264302AbUEXPRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 11:17:16 -0400
Date: Mon, 24 May 2004 17:17:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Alan Cox <alan@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@alpha.home.local>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: i486 emu in mainline?
Message-ID: <20040524151715.GS1912@lug-owl.de>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	Willy Tarreau <willy@w.ods.org>,
	Christoph Hellwig <hch@alpha.home.local>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.ua
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <20040523110836.GE25746@devserv.devel.redhat.com> <20040523115735.GA16726@alpha.home.local> <20040523131512.GA25185@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="notDl2c8diusUOgP"
Content-Disposition: inline
In-Reply-To: <20040523131512.GA25185@devserv.devel.redhat.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--notDl2c8diusUOgP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-05-23 09:15:12 -0400, Alan Cox <alan@redhat.com>
wrote in message <20040523131512.GA25185@devserv.devel.redhat.com>:
> > > Is there a reason btw it can't be done with LD_PRELOAD ?
> >=20
> > Well, this is an interesting question. I don't know how to do it this w=
ay
> > (how can a program know exactly where the trap occured, etc... I don't =
know
> > how to program this). Other than that, LD_PRELOAD will not work against=
 setuid
> > binaries. But if it does for the rest, I think it can become an elegant
> > approach.
>=20
> setuid binaries can still use /etc/ld.preload or whatever the file is cal=
led
> just not environment.

Being an old hardware user and tester (I still have a i386 and i486SLC
where I do testing on!), I strongly support the inclusion of the
emulator. I think that it should even be extended/fixed to catch the
remaining opcode(s).

> Someone actually did a libmmx long ago that used preload, hooked SIGILL
> and the signal handlers and used that to provide mmx on an mmx free cpu

There are some application that register signal handling functions IIRC
for SIGILL, SIGSEGV and the like to do internal error trapping on their
own (not only OOo comes to mind). These would probably be f*cked up if they
didn't call the LD_PRELOADed signal handler...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--notDl2c8diusUOgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAshH7Hb1edYOZ4bsRAgrgAJ49Ot8MizGS8U3YbD8WHo8ScyQceQCbBQoU
gEyGtMuK34HPUFKMVPGQRzE=
=0zk2
-----END PGP SIGNATURE-----

--notDl2c8diusUOgP--
