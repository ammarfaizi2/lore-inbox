Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264229AbUF1K4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUF1K4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 06:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUF1K4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 06:56:42 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:45440 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264229AbUF1K4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 06:56:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rik van Riel <riel@redhat.com>
Subject: Re: Inclusion of UML in 2.6.8
Date: Mon, 28 Jun 2004 12:55:30 +0200
User-Agent: KMail/1.6.2
Cc: Jeff Dike <jdike@addtoit.com>, Christoph Hellwig <hch@infradead.org>,
       BlaisorBlade <blaisorblade_spam@yahoo.it>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0406270956240.3889-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0406270956240.3889-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ik/3AfDCg/TrVwg";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406281255.30361.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_ik/3AfDCg/TrVwg
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sonntag, 27. Juni 2004 15:57, Rik van Riel wrote:
> On Sat, 26 Jun 2004, Jeff Dike wrote:
> > On Sat, Jun 26, 2004 at 07:10:48PM +0100, Christoph Hellwig wrote:
>=20
> > > Also your above arch_free_page needs some more discussion.
> >=20
> > I think that can disappear. =A0In some cases, it might be handy for the
> > arch to see pages being freed, but right now, I believe that UML has no
> > need for it.
>=20
> Should be useful for Linux/Xen, Linux/s390 and Linux/iSeries,
> too...

At least for Linux/s390, the underlying architecture interface (DIAG 0x10)
that would let us exploit this is too expensive, so we chose not to do it.
=46uture machine might give us more flexibility, but using those requires
more than just hooking into free_page.

	Arnd <><

--Boundary-02=_ik/3AfDCg/TrVwg
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3/ki5t5GS2LDRf4RAnQCAJ9xj5NqOU6jkuKFOcAAU+OAV9dS4QCcCpfP
kEhONHwsl4pkFkKqZu8MpyI=
=w8N+
-----END PGP SIGNATURE-----

--Boundary-02=_ik/3AfDCg/TrVwg--
