Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264095AbUKZUyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUKZUyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbUKZUrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:47:14 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:50401 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264016AbUKZUYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:24:34 -0500
Date: Fri, 26 Nov 2004 13:24:31 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Any reason why we don't initialize all members of struct Xgt_desc_struct in doublefault.c ?
Message-ID: <20041126202431.GL23661@schnapps.adilger.int>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <Pine.LNX.4.61.0411250011160.3447@dragon.hygekrogen.localhost> <41A7483F.9010302@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+svXpSx+RSEd8UhP"
Content-Disposition: inline
In-Reply-To: <41A7483F.9010302@pobox.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+svXpSx+RSEd8UhP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 26, 2004  10:14 -0500, Jeff Garzik wrote:
> Jesper Juhl wrote:
> >Yes, this is nitpicking, but I just can't leave small corners like this=
=20
> >unpolished ;)
> >
> >in arch/i386/kernel/doublefault.c you will find this (line 20) :
> >
> >struct Xgt_desc_struct gdt_desc =3D {0, 0};
> >
> >but, struct Xgt_desc_struct has 3 members,=20
> >
> >struct Xgt_desc_struct {
> >        unsigned short size;
> >        unsigned long address __attribute__((packed));
> >        unsigned short pad;
> >} __attribute__ ((packed));
> >
> >so why only initialize two of them explicitly?
>=20
> 'pad' is a dummy variable... nobody cares about its value.

Also, for struct initializations if you don't specify a field explicitly
it will be initialized to zero anyways, so even "gdt_desc =3D { }" is enough
in this case to initialize all of the fields to zero.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--+svXpSx+RSEd8UhP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBp5D/pIg59Q01vtYRAlrwAJ9IyF/biou63BZLDPRDkiMa9HiSAgCgw6Fq
7vASAWRdQ+C+4xZKIBxgthk=
=FTZ8
-----END PGP SIGNATURE-----

--+svXpSx+RSEd8UhP--
