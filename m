Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbVHEVus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbVHEVus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbVHEVuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:50:32 -0400
Received: from neveragain.de ([217.69.76.1]:22734 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S263137AbVHEVt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:49:57 -0400
Date: Fri, 5 Aug 2005 23:49:54 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Message-ID: <20050805214954.GA25533@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan> <Pine.LNX.4.61.0508051538390.6245@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508051538390.6245@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender succeded SMTP AUTH authentication, not delayed by milter-greylist-1.4 (hobbit.neveragain.de [217.69.76.1]); Fri, 05 Aug 2005 23:49:55 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2005 at 03:40:26PM -0400, linux-os (Dick Johnson) wrote:
>=20
> On Fri, 5 Aug 2005, Martin Loschwitz wrote:
>=20
> > Hi folks,
> >
> > I just ran into the following problem: Having updated my box to 2.6.12.=
3,
> > I tried to start YaST2 and noticed a kernel panic (see below). Some qui=
ck
> > debugging brought the result that the kernel crashes while some user (n=
ot
> > even root ...) tries to access /proc/ioports. Is this a known problem a=
nd
> > if so, is a fix available?
> >
> > Ooops and ksymoops-output is attached.
> >
>=20
> This can happen if a module is unloaded that doesn't free its
> resources! Been there, done that.
>=20

"This can happen" is not an acceptable explanation, I think. Modules should
not be able to kill the kernel -- apart from that, I can trigger the bug in
the very early "ash-system" that KNOPPIX provides. At that time, the modules
listed below were the only ones loaded -- no others, and I am also sure that
until that point, no modules were unloaded.

sbp2 ohci1394 usb_storage ub ehci_hcd usbcore

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC898CHPo+jNcUXjARAonCAKCQAkCWvdEJOa1S0Q3D3sQxgND9oQCbBusI
dVbjXRvFKUtPkNBQiemLwDo=
=LTYm
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
