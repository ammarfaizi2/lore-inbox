Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267976AbTB1PVz>; Fri, 28 Feb 2003 10:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbTB1PVz>; Fri, 28 Feb 2003 10:21:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:24452 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267976AbTB1PVV>;
	Fri, 28 Feb 2003 10:21:21 -0500
Subject: Re: Proposal: Eliminate GFP_DMA
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030228145614.GA27798@wotan.suse.de>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	 <p73heao7ph2.fsf@amdsimf.suse.de>
	 <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk>
	 <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>
	 <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk>
	 <1046447737.16599.83.camel@irongate.swansea.linux.org.uk>
	 <20030228145614.GA27798@wotan.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7QtuPjVmjkszZlEjLAn8"
Organization: Red Hat, Inc.
Message-Id: <1046446286.2957.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Feb 2003 16:31:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7QtuPjVmjkszZlEjLAn8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-02-28 at 15:56, Andi Kleen wrote:
> On Fri, Feb 28, 2003 at 03:55:37PM +0000, Alan Cox wrote:
> > On Fri, 2003-02-28 at 14:34, Matthew Wilcox wrote:
> > > umm.  are you volunteering to convert drivers/net/macmace.c to the pc=
i_*
> > > API then?  also, GFP_DMA is used on, eg, s390 to get memory below 2GB=
 and
> > > on ia64 to get memory below 4GB.
> >=20
> > The ia64 is a fine example of how broken it is. People have to hack aro=
und=20
> > with GFP_DMA meaning different things on ia64 to everything else. It ne=
eds
> > to die.=20
>=20
> At least on x86-64 it is still needed when you need have some hardware
> with address limits < 4GB (e.g. an 24bit soundcard)
>=20
> pci_* on K8 only allows address mask 0xffffffff or unlimited.

for 2.7 the underlying low level budy allocator could (should?) just
take a DMA bitmask

--=-7QtuPjVmjkszZlEjLAn8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+X4DOxULwo51rQBIRAiPUAJ0ScQnm7i0rt8N4GN2x9S3TR0SBfgCfeFJ4
sY9xGSnqnb2yG1eKzHWnHb0=
=SF5W
-----END PGP SIGNATURE-----

--=-7QtuPjVmjkszZlEjLAn8--
