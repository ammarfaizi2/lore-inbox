Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVJBDig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVJBDig (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 23:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVJBDif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 23:38:35 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:32712 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750957AbVJBDif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 23:38:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marc Perkel <marc@perkel.com>
Subject: Re: Making nice niser for system hogging programs
Date: Sun, 2 Oct 2005 13:38:19 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <433F4563.5060700@perkel.com> <200510021307.10372.kernel@kolivas.org> <433F519B.5070505@perkel.com>
In-Reply-To: <433F519B.5070505@perkel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5960790.Q4EmFYMhsO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510021338.22326.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5960790.Q4EmFYMhsO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 2 Oct 2005 13:18, Marc Perkel wrote:
> Con Kolivas wrote:
> >On Sun, 2 Oct 2005 12:26, Marc Perkel wrote:
> >>Just a thought -----
> >>
> >>Programs like cp -a /bigdir /backup and rsync usually bring the server
> >>to a crawl no matter how much "nice" you put on them. Is there any way
> >>to make "nice" smarter in that it limits io as well as processor usage?
> >>If cp and rsyne ran a little slower IO wise then everything else could
> >>run too.
> >
> >The latest cfq io scheduler supports io nice levels. By default it links
> > the io nice levels to the cpu nice levels so if you use cfq and set your
> > file commands nice 19 they will use as little io priority as possible.
> > Note this only works on the read side but that makes a dramatic
> > difference already.
>
> Kewl - so - what version is it in?

2.6.13 already has it. Note that the io priority is only inherited when a=20
process first starts so doing renice to something already running will only=
=20
change the cpu nice, not the ionice. You can do that on the fly using the=20
ionice application. If you look in the kernel source in=20
Documentation/block/ioprio.txt you'll find the source to ionice.c=20

Cheers,
Con

P.S. It is considered routine to reply-to-all when posting to lkml and not=
=20
stripping anybody on the cc list.

--nextPart5960790.Q4EmFYMhsO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDP1YuZUg7+tp6mRURAl08AJ93nVj9DY/yslHYhhLxAo1J+Lt/HQCff1jJ
7mzg3nsrXQDTVYUjQgpJbEI=
=LsQZ
-----END PGP SIGNATURE-----

--nextPart5960790.Q4EmFYMhsO--
