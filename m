Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbUCMWne (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbUCMWne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:43:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263212AbUCMWnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:43:32 -0500
Subject: Re: finding out the value of HZ from userspace
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Micha Feigin <michf@post.tau.ac.il>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040313221018.GE5960@luna.mooo.com>
References: <20040311141703.GE3053@luna.mooo.com>
	 <1079198671.4446.3.camel@laptop.fenrus.com>
	 <20040313221018.GE5960@luna.mooo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gozE6bnRlxifdHYLEY5c"
Organization: Red Hat, Inc.
Message-Id: <1079217685.4915.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 13 Mar 2004 23:41:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gozE6bnRlxifdHYLEY5c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-03-13 at 23:10, Micha Feigin wrote:
> On Sat, Mar 13, 2004 at 06:24:31PM +0100, Arjan van de Ven wrote:
> > On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> > > Is it possible to find out what the kernel's notion of HZ is from use=
r
> > > space?
> > > It seem to change from system to system and between 2.4 (100 on i386)
> > > to 2.6 (1000 on i386).
> >=20
> > if you can see 1000 from userspace that is a bad kernel bug; can you sa=
y
> > where you find something in units of 1000 ?
>=20
> I can't see it from user space. Its in the kernel headers. The thing is
> I am working on fixes to laptop mode. The problem is it requires
> changing bdflush and journaled file systems journal flush times. The
> problem is that some of these (bdflush, xfs) expect the value in jiffies
> and not seconds or milliseconds so making the initiation script portable
> requires knowing the value of HZ.

the kernel side is supposed to use clock_t_to_jiffies() and co for this
to present a unified HZ to userspace. The internal kernel HZ should
*NOT* leak out to usespace. Heck it's quite thinkable that in the future
there will be no such HZ.
=20


--=-gozE6bnRlxifdHYLEY5c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAU44VxULwo51rQBIRAkOuAJ0QDpUyCyKv1CVEGGEfUw831kY+1QCfWFoY
ecLeftFOjC82/RLDr55erVQ=
=zMK4
-----END PGP SIGNATURE-----

--=-gozE6bnRlxifdHYLEY5c--

