Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUFFHc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUFFHc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 03:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUFFHc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 03:32:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46473 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263003AbUFFHc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 03:32:26 -0400
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Mike McCormack <mike@codeweavers.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <40C2D5F4.4020803@codeweavers.com>
References: <40C2B51C.9030203@codeweavers.com>
	 <20040606052615.GA14988@elte.hu>  <40C2D5F4.4020803@codeweavers.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZVFnDopQoloWpG2lCG7b"
Organization: Red Hat UK
Message-Id: <1086507140.2810.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 09:32:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZVFnDopQoloWpG2lCG7b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-06 at 10:29, Mike McCormack wrote:
> Hi Ingo,
>=20
> Ingo Molnar wrote:
>=20
> > there are multiple methods in FC1 to turn this off:
> >=20
> > - FC1 has PT_GNU_STACK support and all binaries that have no
> >   PT_GNU_STACK program header will have the stock Linux VM layout.=20
> >   (including executable stack/heap) So by stripping the PT_GNU_STACK=20
> >   header from the wine binary you get this effect.
>=20
> As far as we can tell, this alone does not stop the kernel from loading=20
> stuff at the addresses we need.  Even without PT_GNU_STACK ld-linux.so.2=20
> and libc are loaded below 0x01000000, which is the region that Wine=20
> assumes is free.  I think this may be due to prelinking...

that is prelink yes, not the kernel execshield.


--=-ZVFnDopQoloWpG2lCG7b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAwsiExULwo51rQBIRApchAJ424lle4GJOQdQCZXOABDfVKxDkDwCeNt9Q
brsR+b+2tgnuxcku3BktYfk=
=Dh8F
-----END PGP SIGNATURE-----

--=-ZVFnDopQoloWpG2lCG7b--

