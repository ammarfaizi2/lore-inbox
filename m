Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbUKLQNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbUKLQNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUKLQNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:13:08 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:5100 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262561AbUKLQNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:13:02 -0500
Subject: Re: [PATCH] Add pci_save_state() to ALSA
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Takashi Iwai <tiwai@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, "Zhu, Yi" <yi.zhu@intel.com>,
       perex@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <s5hvfcbdv93.wl@alsa2.suse.de>
References: <3ACA40606221794F80A5670F0AF15F8403BD5836@pdsmsx403>
	 <s5hzn1ndwqx.wl@alsa2.suse.de> <1100267140.4096.7.camel@laptop.fenrus.org>
	 <s5hvfcbdv93.wl@alsa2.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Xn04YeKsqrbbnr3UCOUw"
Message-Id: <1100275977.1574.8.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 12 Nov 2004 17:12:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xn04YeKsqrbbnr3UCOUw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-11-12 at 14:58, Takashi Iwai wrote:
> At Fri, 12 Nov 2004 14:45:40 +0100,
> Arjan van de Ven wrote:
> >=20
> > On Fri, 2004-11-12 at 14:26 +0100, Takashi Iwai wrote:
> > > But pci_save_state() is called again after the driver's suspend
> > > callback is called.  So, the final saved state must be anyway same.
> >=20
> > no that changed recently in the upstream kernel.
> > pci_save_state() is now only called if there is no suspend callback in =
the driver!
>=20
> Ah, thanks, that explains why (I referred 2.6.10-rc1).

I realized that I forgot to include som vital information, sorry about
that.

Kernel 2.6.10-rc1-bk21 which has the pci_save_state() change in
pci-driver.c

My driver(s) are intel8x0.c and intel8x0m.c

First I just thought the missing pci_save_state() was a small mistake
and wondered why nobody else had reported the problem, later I found out
that a "generic" pci_save_state() for all pci-devices was removed
recently but I didn't have time to send a mail.

> If so, the patch is almost correct, but pci_save_state() should be put
> after the call of callback.

Great, thanks for fixing the fix.

I havn't had any problems with my broken patch, I'll see if I have the
time to test this one as well this weekend.

--=20
/Martin

--=-Xn04YeKsqrbbnr3UCOUw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBlOEJWm2vlfa207ERAvbbAKCmOe2YLHr7VdxuBtG9jrqSy3wPuQCeNEJ8
AozPfx7BcT38Y1pkZsjKtIk=
=inlD
-----END PGP SIGNATURE-----

--=-Xn04YeKsqrbbnr3UCOUw--
