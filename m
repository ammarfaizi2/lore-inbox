Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318965AbSHMIBM>; Tue, 13 Aug 2002 04:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSHMIBM>; Tue, 13 Aug 2002 04:01:12 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:51681 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318965AbSHMIBL>; Tue, 13 Aug 2002 04:01:11 -0400
Date: Tue, 13 Aug 2002 10:59:44 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Andrew Morton <akpm@zip.com.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] __func__ -> __FUNCTION__
Message-ID: <20020813075944.GA2192@alhambra.actcom.co.il>
References: <3D58A45F.A7F5BDD@zip.com.au> <ajaa5h$61f$1@cesium.transmeta.com> <3D58BF90.56C75C66@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jsn5+Lu/ZvzbAGtZ"
Content-Disposition: inline
In-Reply-To: <3D58BF90.56C75C66@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Jsn5+Lu/ZvzbAGtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2002 at 01:13:04AM -0700, Andrew Morton wrote:
> "H. Peter Anvin" wrote:
> >=20
> > Followup to:  <3D58A45F.A7F5BDD@zip.com.au>
> > By author:    Andrew Morton <akpm@zip.com.au>
> > In newsgroup: linux.dev.kernel
> >=20
> > > --- linux-2.5.31/include/linux/kernel.h       Wed Jul 24 14:31:31 2002
> > > +++ 25/include/linux/kernel.h Mon Aug 12 23:09:31 2002
> > > @@ -13,6 +13,8 @@
> > >  #include <linux/types.h>
> > >  #include <linux/compiler.h>
> > >
> > > +#define __func__ __FUNCTION__        /* For old gcc's */
> > > +
> > >  /* Optimization barrier */
> > >  /* The "volatile" is due to gcc bugs */
> > >  #define barrier() __asm__ __volatile__("": : :"memory")
> >=20
> > Shouldn't this be conditional on the version?
>=20
> Could be.  But I don't know what version to use.

How about:=20

/* early gcc compilers lose on __func__ */=20
#ifndef __func__=20
#define __func__ __FUNCTION__
#endif /* !defined __func__ */=20
--=20
"Hmm.. Cache shrink failed - time to kill something?
 Mhwahahhaha! This is the part I really like. Giggle."
					 -- linux/mm/vmscan.c
http://vipe.technion.ac.il/~mulix/	http://syscalltrack.sf.net

--Jsn5+Lu/ZvzbAGtZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9WLxwKRs727/VN8sRArMGAJ9BN/4fcykCImR0lC0YayZZq03yMQCfTQlA
cUG+T2OhtksDi+ArS8ANm+g=
=2304
-----END PGP SIGNATURE-----

--Jsn5+Lu/ZvzbAGtZ--
