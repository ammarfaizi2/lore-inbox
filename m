Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbUAKSol (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 13:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUAKSol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 13:44:41 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:26249 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265954AbUAKSoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 13:44:37 -0500
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
	0x37ffffff" warning.
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401111037550.19685-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0401111037550.19685-100000@bigblue.dev.mdolabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uyq3d5/rbcMTMP6n1D+O"
Message-Id: <1073846854.9096.133.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 20:47:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uyq3d5/rbcMTMP6n1D+O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-11 at 20:42, Davide Libenzi wrote:
> On Sun, 11 Jan 2004, Martin Schlemmer wrote:
>=20
> > azarah@nosferatu tar $ as << EOF
> > > PG=3D0xC0000000
> > > VM=3D(128 << 20)
> > > .long (-PG -VM)
> > > .long (~PG + 1 - VM)
> > > EOF
> > {standard input}: Assembler messages:
> > {standard input}:3: Warning: value 0x38000000 truncated to 0x38000000
> > {standard input}:4: Warning: value 0x38000000 truncated to 0x38000000
> > azarah@nosferatu tar $ objdump -D a.out
> > =20
> > a.out:     file format elf32-i386
> > =20
> > Disassembly of section .text:
> > =20
> > 00000000 <.text>:
> >    0:   00 00                   add    %al,(%eax)
> >    2:   00 38                   add    %bh,(%eax)
> >    4:   00 00                   add    %al,(%eax)
> >    6:   00 38                   add    %bh,(%eax)
> > azarah@nosferatu tar $
>=20
> This is weird. I also verified the above with:
>=20
> GNU assembler 2.13.90.0.18 20030206
>=20
> and it works fine too.
>=20

What distro?  Might be an in-house patch ...


--=20
Martin Schlemmer

--=-uyq3d5/rbcMTMP6n1D+O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAZpGqburzKaJYLYRAqf1AJ4u37h8BR/53wg2CPrzZjq2CVyA/wCdHzHd
BO6bFXunMUtLIsOj6PcdqK4=
=qukv
-----END PGP SIGNATURE-----

--=-uyq3d5/rbcMTMP6n1D+O--

