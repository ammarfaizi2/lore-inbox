Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbTIFHiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 03:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTIFHiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 03:38:23 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:43966 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265108AbTIFHiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 03:38:19 -0400
Date: Sat, 6 Sep 2003 09:38:16 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Message-ID: <20030906073814.GE14376@lug-owl.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
References: <200309020139.08248.mhf@linuxmail.org> <200309030613.19800.mhf@linuxmail.org> <20030902235224.GA20901@kroah.com> <200309031432.17209.mhf@linuxmail.org> <20030905230852.GA18196@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9j/QU+CmmrcVJkVI"
Content-Disposition: inline
In-Reply-To: <20030905230852.GA18196@kroah.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9j/QU+CmmrcVJkVI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-09-05 16:08:52 -0700, Greg KH <greg@kroah.com>
wrote in message <20030905230852.GA18196@kroah.com>:
> On Wed, Sep 03, 2003 at 02:32:16PM +0800, Michael Frank wrote:
> > On Wednesday 03 September 2003 07:52, Greg KH wrote:
> > Besides it just stopping without obvious reason:=20
> >=20
> > 1) It does not like when something is typed on cu and not received by t=
he serial port side=20
> >    connected to PL2303 (CTS low). It tends to hang and the trouble star=
ts....
> >=20
> > Sep  3 12:52:15 mhfl2 kernel: ttyUSB0: 1 input overrun(s)
> > Sep  3 12:54:30 mhfl2 last message repeated 2 times
>=20
> Hm, what is causing this?
> That is probably why cu is getting confused, right?

I've seen the input overrun message also (with the vanilla driver, not
patched). It's effect is that the first bytes (maybe up to 100..300
bytes) are scrambled. It's like accessing a serial link with a horribly
wrong baud rate.

After a split-second, however, everything is okay and I start receiving
valid NMEA data from my GPS receiver. For me, that's not much of a
problem because nmea is checksum'ed and the bad bytes are ignored...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--9j/QU+CmmrcVJkVI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/WY7lHb1edYOZ4bsRAoMXAJ9wZEpR58Mk//6xVLPwnj9V90lWsgCgg5WD
ciq5UCGc6gfDktEzABip/Mo=
=f96S
-----END PGP SIGNATURE-----

--9j/QU+CmmrcVJkVI--
