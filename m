Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWBUWpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWBUWpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWBUWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:45:14 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:51102 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751199AbWBUWpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:45:12 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 22 Feb 2006 07:00:50 +1000
User-Agent: KMail/1.9.1
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602202319.15018.dtor_core@ameritech.net> <200602212140.57566.rjw@sisk.pl>
In-Reply-To: <200602212140.57566.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart27174856.oxOlyUKcOS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602220700.55207.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart27174856.oxOlyUKcOS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Rafael.

On Wednesday 22 February 2006 06:40, Rafael J. Wysocki wrote:
> On Tuesday 21 February 2006 05:19, Dmitry Torokhov wrote:
> > On Monday 20 February 2006 21:57, Nigel Cunningham wrote:
> > > For the record, my thinking went: swsusp uses n (12?) bytes of meta
> > > data for every page you save, where as using bitmaps makes that much
> > > closer to a constant value (a small variable amount for recording whe=
re
> > > the image will be stored in extents). 12 bytes per page is 3MB/1GB. If
> > > swsusp was to add support for multiple swap partitions or writing to
> > > files, those requirements might be closer to 5MB/GB.
> >
> > 5MB/GB amounts to 0.5% overhead, I don't think you should be concerned
> > here. Much more important IMHO is that IIRC swsusp requires to be able =
to
> > free 1/2 of the physical memory whuch is hard on low memory boxes.
>
> I see another point in using bitmaps: we could avoid modifying page flags
> and use bitmaps to store all of the temporary information.  I thought abo=
ut
> it for some time and I think it's doable.

It is doable - I'm doing it now, but am thinking about reverting part of th=
e=20
code to use pbes again. If you're going to look at using bitmaps in place o=
f=20
pbes, me changing would be a waste of time. Do you want me to hold off for =
a=20
while? (I'll happily do that, as I have far more than enough to keep me=20
occupied at the moment anyway).

Regards,

Nigel

--nextPart27174856.oxOlyUKcOS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+3+HN0y+n1M3mo0RAumhAJ9m2XbVhCX0EJpL2sQEYXUamkGenwCg5/eV
VzbxQV/zP9LwLsOFSL3wd40=
=RYOc
-----END PGP SIGNATURE-----

--nextPart27174856.oxOlyUKcOS--
