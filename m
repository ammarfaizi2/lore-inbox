Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbTLRRcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 12:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbTLRRcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 12:32:20 -0500
Received: from datasink.webmonster.de ([194.162.162.209]:15620 "HELO
	mail.webmonster.de") by vger.kernel.org with SMTP id S265238AbTLRRcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 12:32:10 -0500
Date: Thu, 18 Dec 2003 18:32:09 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
Subject: Re: 2.6.0 keyboard not working
Message-ID: <20031218173231.GB41396@mail.webmonster.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <20031218060053.GA645@gnu.org> <Pine.LNX.4.58.0312180230150.1710@montezuma.fsmlabs.com> <20031218145434.GA20303@gnu.org> <20031218150431.GA20543@gnu.org> <Pine.LNX.4.58.0312181129260.1710@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312181129260.1710@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Organisation: Organisation for the bulletization of popular thought as a result of the increasing prevalence of Microsoft PowerPoint(TM)
X-MSMail-Priority: High
x-gpg-fingerprint: D02B D0E0 3790 1AA1 DA3A  B508 BF48 87BF D777 DBA7
x-gpg-key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0xD777DBA7
x-gpg-keyid: 0xD777DBA7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Zwane Mwaikambo(zwane@arm.linux.org.uk) on 2003.12.18 11:30:27 +0000:
> On Thu, 18 Dec 2003, Lennert Buytenhek wrote:
>=20
> > > > > Halfway between having uncompressed the kernel and starting init,=
 the console
> > > > > starts to scroll "atkbd.c: Unknown key pressed", mentioning key c=
ode 0 (IIRC),
> > > > > even though no keys are pressed at all.  After a while, the scrol=
ling stops,
> > > > > but the keyboard still doesn't work.  2.4 works fine on the same =
hardware.
> > > > >
> > > > > Hardware is an Intel SE7505VB2 board with dual 2.40GHz Xeon proce=
ssors,
> > > > > and a Logitech PS/2 "Internet keyboard."
> > > > >
> > > > > Ideas?
> > > >
> > > > May we have a look at your .config?
>=20
> Thanks Lennert, could you try without CONFIG_HIGHMEM64G, perhaps just
> CONFIG_HIGHMEM4G, how much memory in the system? dmesg also would be nice.

I had exactly the same symptoms (Unknown key pressed, scrolling) with a
Cherry PS/2 keyboard an a PS/2 mouse, starting with 2.6.0-test6 (i think).
The mouse also stopped working.

Unfortunatly it was a heisenbug - every time i tried to find out what caused
the problem (there where drivers/input/mouse* - changes at that time) the
problem disapeared. I then exchanged the mouse for a USB-type and the
problem disappeared completly.

/B.
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0xD777DBA7 2003-09-10 D02B D0E0 3790 1AA1 DA3A  B508 BF48 87BF D777 D=
BA7

Konzepte sind Kokolores. -- Erich Ribbeck

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (FreeBSD)

iD8DBQE/4eSvv0iHv9d326cRAn1hAJ9jdfHK1Bbtw7wZwJBPmPmIZY/0nwCdE9Ys
usrl6oNTJyOJMVVu0GCmlX8=
=amme
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
