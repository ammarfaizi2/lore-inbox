Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUGFS7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUGFS7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 14:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUGFS7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 14:59:09 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:31941 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264296AbUGFS65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 14:58:57 -0400
Date: Tue, 6 Jul 2004 20:58:56 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040706185856.GN18841@lug-owl.de>
Mail-Followup-To: linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org> <20040629222751.392f0a82.davem@redhat.com> <20040630152750.2d01ca51@dell_ss3.pdx.osdl.net> <20040630153049.3ca25b76.davem@redhat.com> <20040701133738.301b9e46@dell_ss3.pdx.osdl.net> <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7Vi1RbbjZdZQ982c"
Content-Disposition: inline
In-Reply-To: <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7Vi1RbbjZdZQ982c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-06 11:47:41 -0700, Stephen Hemminger <shemminger@osdl.org>
wrote in message <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>:

> I propose that the following that will avoid sending window scaling that
> is big enough to break in these cases unless the tcp_rmem has been increa=
sed.
> It will keep default configuration from blowing in a corrupt world.

I'm not sure if this is the right way to react. I'd think it's okay to
give the user the possibility to scale the window so that it works with
his b0rk3d firewall, but default behavior should be to do whatever the
protocol dictates/allows.

We did the same with ECN, and I think that's the way to go.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--7Vi1RbbjZdZQ982c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6vZwHb1edYOZ4bsRAtI3AJ9Dw33O3rJbuKRngQ0hClZZRxLrIwCfce/4
d5IA9I3a+IOD5cTVSqukYpQ=
=jGRT
-----END PGP SIGNATURE-----

--7Vi1RbbjZdZQ982c--
