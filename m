Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTFQKLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 06:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTFQKLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 06:11:53 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:57611 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261651AbTFQKLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 06:11:51 -0400
Date: Tue, 17 Jun 2003 12:25:45 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA/Orinoco
Message-ID: <20030617102545.GB6353@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030617105544.D25452@flint.arm.linux.org.uk> <Pine.LNX.4.44.0306171159470.1854-100000@blackstar.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306171159470.1854-100000@blackstar.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-06-17 12:01:40 +0200, bvermeul@blackstar.nl <bvermeul@blacksta=
r.nl>
wrote in message <Pine.LNX.4.44.0306171159470.1854-100000@blackstar.nl>:
> On Tue, 17 Jun 2003, Russell King wrote:
> > On Tue, Jun 17, 2003 at 11:29:00AM +0200, bvermeul@blackstar.nl wrote:
> > > I'm having some problems with 2.5.71 (latest bk yesterday I believe).
> > > All works well (pcmcia works as advertised, with one tiny blip on
> > > the horizon), except when I want to reboot, when I get the following
> > > message:
> > >=20
> > > unregister_netdevice: waiting for eth1 to become free. Usage count =
=3D 1
> > >=20
> > > The net device is an Orinoco mini-pci card (eg, cardbus minipci inter=
face=20
> > > with built-in orinoco card), and it is down.
> > >=20
> > > I'm not sure what causes this, and it's started somewhere in 2.5.70 b=
k.
> >=20
> > I believe this is a netdevice problem and isn't anything to do with
> > PCMCIA or Cardbus.  If the net people would like to confirm this, it'd
> > be most helpful.
>=20
> I'm also using a RTL8139 cardbus card, and that does not show this=20
> particular problem (works great actually).
> So I'm not so sure it is a netdevice problem. It may be a orinoco
> problem, but I'm not entirely sure what's causing it.
> Just wanted to see if anyone's noticed it as well, and if a fix was
> out there.

I'm not sure, but for what I *see* (using a PCMCIA NE2000 clone with my
Laptop) this problem occures by this:

- Insert your card (after "/etc/init.d/pcmcia-cs start" is done, that
  card will be recognized and configured).
- shutdown your laptop. This involves "/etc/init.d/pcmcia-cs stop".
- _Later on_ (after the card should already have gone away because
  you've just stopped the pcmcia subsystem), "/etc/init.d/networking
  stop" tried to "ifconfig ethX down" the card - Bang.

The cardbus/hotplug stuff might be different here. I think this is
solely a problem of the pure PCMCIA stuff...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7uyoHb1edYOZ4bsRAi4yAJ9kRW3RPmIWy+WhRtYE981Uz5L+zQCfZecj
nS7gBwP18QD07/3FRcU4j24=
=TI4e
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
