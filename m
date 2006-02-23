Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWBWXTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWBWXTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWBWXTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:19:23 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:62857 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751803AbWBWXTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:19:22 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Fri, 24 Feb 2006 09:16:15 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060223121707.GP13621@elf.ucw.cz> <200602232337.31075.rjw@sisk.pl>
In-Reply-To: <200602232337.31075.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5984913.fOseBdtqi8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602240916.20854.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5984913.fOseBdtqi8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 February 2006 08:37, Rafael J. Wysocki wrote:
> Hi,
>
> On Thursday 23 February 2006 13:17, Pavel Machek wrote:
> > > > Ok, I have no problems with visions.
> > > >
> > > > > I think we should try to get the pagecache stuff right first
> > > > > anyway.
> > > >
> > > > Are you sure it is worth doing? I mean... it only helps on small
> > > > machines, no?
> > > >
> > > > OTOH having it for benchmarks will be nice, and perhaps we could use
> > > > that kind it to speed up boot and similar things...
> > >
> > > Currently some people can't suspend with the mainline code because it
> > > cannot free as much memory as needed on their boxes.  I think we shou=
ld
> > > care for them too.
> >
> > But saving pagecache will not help them *at all*!
> >
> > [Because pagecache is freeable, anyway, so it will be freed. Now... I
> > have seen some problems where free_some_memory did not free enough,
> > and schedule()/retry helped a bit... that probably should be fixed.]
>
> It seems I need to understand correctly what the difference between what
> we do and what Nigel does is.  I thought the Nigel's approach was to save
> some cache pages to disk first and use the memory occupied by them to
> store the image data.  If so, is the page cache involved in that or
> something else?

You're right. The only point I would query is that I'm not sure on terminol=
ogy=20
=2D whether 'page cache' =3D=3D LRU. In case there's any difference, I'll s=
ay that=20
I treat pages on the active and inactive LRU lists separately, saving them =
to=20
disk first and using the memory occupied by them for the atomic copy (with=
=20
the exception, of course, of pages belonging to processes such as userui -=
=20
these are made part of the atomic copy and not overwritten).

Regards,

Nigel

--nextPart5984913.fOseBdtqi8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/kJEN0y+n1M3mo0RAjU7AJ4gws/MlPSqvcinhS8ENKdsM2viBACfUhlm
UVKDj29C+oZ6zxGu8G1LUCU=
=VVl7
-----END PGP SIGNATURE-----

--nextPart5984913.fOseBdtqi8--
