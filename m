Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUC1Pvi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 10:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUC1Pvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 10:51:38 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:46230 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261921AbUC1Pvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 10:51:36 -0500
Date: Sun, 28 Mar 2004 17:51:34 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with my parport (and printer)
Message-ID: <20040328155134.GG27362@lug-owl.de>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040325115131.GA12195@DervishD>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
In-Reply-To: <20040325115131.GA12195@DervishD>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-03-25 12:51:31 +0100, DervishD <raul@pleyades.net>
wrote in message <20040325115131.GA12195@DervishD>:
>     Hi all :)
>=20
>     I have a printer connected thru my parallel port, supported in
> the kernel by parport+parport_pc+lp:
>=20
> kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
> kernel: parport0: Printer, Lexmark International Lexmark Optra E312
> kernel: lp0: using parport0 (interrupt-driven).
> kernel: lp0: console ready
>=20
>     It works ok, BTW... The problem is that, when the printer is
> switched of and I try to print something, the print command just
> blocks, no error, no messages, nothing. I use a shell function to

First of all, if you want to do normal printing, you shouldn't switch on
LP console. From there on, all kernel debug output (as seen in
/var/log/kern.log and outputted with "dmesg") would be sent to the
printer, what isn't exactly what you want to have.

>     Why this operation doesn't fail? IMHO, it should fail with
> ENODEV, because parport can work (the parallel port is there...), but
> lp shouldn't (the printer is switched off...).

Another gotcha may be that your printer doesn't easily accept commands.
Many printers don't do that nowadays. Some are dumb GDI-Printerts
(Windows-only, that is...), some nees specific wake-up sequences.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAZvSGHb1edYOZ4bsRAj0LAJ4pS/8zFxHGSxtrD2B496/nm2rzBgCePVu8
JAoufe3nko4Osa9PwAPYI5Y=
=sQD0
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--
