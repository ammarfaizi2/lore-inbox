Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTDYOR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbTDYOR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:17:29 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:8177 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263229AbTDYOR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:17:28 -0400
Subject: [Fwd: RE: cciss patches for 2.4.21-rc1, 4 of 4]
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cameron@laptop.fenrus.com, Steve <Steve.Cameron@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jcN+22wL4fBiHvRlOXHE"
Organization: Red Hat, Inc.
Message-Id: <1051280955.1391.21.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 25 Apr 2003 16:29:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jcN+22wL4fBiHvRlOXHE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

-----Forwarded Message-----

> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
> Cc: "Cameron, Steve" <Steve.Cameron@hp.com>, Linux Kernel Mailing List <l=
inux-kernel@vger.kernel.org>
> Subject: RE: cciss patches for 2.4.21-rc1, 4 of 4
> Date: 25 Apr 2003 14:09:53 +0100
>=20
> On Gwe, 2003-04-25 at 14:48, Miller, Mike (OS Dev) wrote:
> > I haven't seen any issues (yet) on ia64. I'm running with 5GB RAM.
>=20
> That doesn't make it correct. This same problem occurs in other drivers
> and the usual trick is to set the pci mask to 32bit, allocate those
> command buffers ready, then flip back to 64bit. Just be sure one thread
> doesn't change it to 64bit while another is allocating commands. The
> reverse is fine since an accidental odd bounce is no big deal
Alan,

except that pci_alloc_consistent is guaranteed to return a 32 bit address

what you're thinking about is the mapping interface instead.


--=-jcN+22wL4fBiHvRlOXHE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+qUY7xULwo51rQBIRAjPDAJ0fUZDsIcgJucWuOHOIgdLkJuq0eQCfYvt5
aa8KtTZGqHmbpLzUZvZXoqQ=
=TFZk
-----END PGP SIGNATURE-----

--=-jcN+22wL4fBiHvRlOXHE--
