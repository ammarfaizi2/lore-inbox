Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWAOUMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWAOUMM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWAOUMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:12:12 -0500
Received: from sipsolutions.net ([66.160.135.76]:25860 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932133AbWAOUMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:12:10 -0500
Subject: Re: wireless: recap of current issues (configuration)
From: Johannes Berg <johannes@sipsolutions.net>
To: Sam Leffler <sam@errno.com>
Cc: Stefan Rompf <stefan@loplof.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <43CAABD4.3070004@errno.com>
References: <20060113195723.GB16166@tuxdriver.com>
	 <200601151340.10730.stefan@loplof.de>
	 <56187.84.135.205.30.1137340292.squirrel@secure.sipsolutions.net>
	 <200601151853.31710.stefan@loplof.de>  <43CAABD4.3070004@errno.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VZiN2H76gR4JCmUHPpO6"
Date: Sun, 15 Jan 2006 21:11:51 +0100
Message-Id: <1137355912.2520.97.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VZiN2H76gR4JCmUHPpO6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-01-15 at 12:08 -0800, Sam Leffler wrote:

> To do what you describe I would create a monitor mode device, switch=20
> channel, then destroy it.  All the time you leave the station device=20
> unchanged, though you probably need to disable it.  This may not be=20
> possible with all devices--i.e. for those that require different=20
> firmware to do monitoring you will be restricted to a single virtual=20
> device and/or operating mode.

Yeah, I agree with this, it is much cleaner to handle in the kernel.
Think about the issues if you have a struct net_device that has 250
bytes of "payload" for the struct virtual_sta_device in it and you want
to switch that to a struct virtual_monitor_device. Icky.

johannes

--=-VZiN2H76gR4JCmUHPpO6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ8qshqVg1VMiehFYAQK/8Q//c00EMENoPgSXHOtwErL4SEFrqy3l1002
0R320+flr0SUNUhlUq7iaZJU6j99JzW/O9zNS5FXGz2vHb29XDyILHUO6elxVckx
BwQqyh+mFwpuLxFs3ZD8Frjdi14adTpqHyYqTTtuVgLOGq1T4fTVBuAw8AS3eZwv
gd43FOd26KQzELNOwBHuYDdErhUNQId2ZWZhpNCHpcv5Yp7LTdooQDM1D0WvO4v6
AnvHqOX02mWf+HLWEI0c0AAxFR95eCcO6CHIRiUym+1O4zrlr1G1iVo9BtxiA18E
QRc7D1XtzqYTEJBNTxq77D/MLIXA+BmHQq65sBK+CIWj0XoHFkrFV2kE6HHDvILr
5mIv1P6n+Cw7FmlFoyjBrSMedh3klbSzxJhSYNtx3BH+ILwDAyeKy4MU6JcWiHPX
ZxdKWXUTuDwPo3/0GZlUJVqYOXXlHrrl+N+vFlVXwjAANP6BunYnbl/pQ0PGQJ5g
eIObrMpPd6dXBdA6Iw/p5PwuZ2NaYtHY1onKnSBAyddZNQzVXOxRrwbEm2tmmgxv
he8EdWfGoYJzeGEsn5iMfdzclwd0e7d5P7XN0jRupsqAxxu8ws9nIXlxg3g7PGsi
s+pHES6yYOyWa6dtg8AyUkPSmeuez8YEn8Y7wNstvP3BjRCE/XEPSkw9YWzAIlC0
Zz3NIJsopDY=
=Hwcj
-----END PGP SIGNATURE-----

--=-VZiN2H76gR4JCmUHPpO6--

