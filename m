Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVGNBDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVGNBDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 21:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVGNBDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 21:03:52 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:62654 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262863AbVGNBAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 21:00:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Thu, 14 Jul 2005 11:00:37 +1000
User-Agent: KMail/1.8.1
Cc: David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200507122110.43967.kernel@kolivas.org> <Pine.LNX.4.62.0507131726390.11024@qynat.qvtvafvgr.pbz> <200507141046.27788.kernel@kolivas.org>
In-Reply-To: <200507141046.27788.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3093510.mWXdhLEdDB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507141100.41159.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3093510.mWXdhLEdDB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 14 Jul 2005 10:46, Con Kolivas wrote:
> On Thu, 14 Jul 2005 10:31, David Lang wrote:
> > On Thu, 14 Jul 2005, Con Kolivas wrote:
> > > On Thu, 14 Jul 2005 03:54, Bill Davidsen wrote:
> > >> Con Kolivas wrote:
> > >>> On Tue, 12 Jul 2005 21:57, David Lang wrote:
> > >>>> for audio and video this would seem to be a fairly simple scaleing
> > >>>> factor (or just doing a fixed amount of work rather then a fixed
> > >>>> percentage of the CPU worth of work), however for X it is probably
> > >>>> much more complicated (is the X load really linearly random in how
> > >>>> much work it does, or is it weighted towards small amounts with
> > >>>> occasional large amounts hitting? I would guess that at least beyo=
nd
> > >>>> a certin point the liklyhood of that much work being needed would =
be
> > >>>> lower)
> > >>>
> > >>> Actually I don't disagree. What I mean by hardware changes is more
> > >>> along the lines of changing the hard disk type in the same setup.
> > >>> That's what I mean by careful with the benchmarking. Taking the
> > >>> results from an athlon XP and comparing it to an altix is silly for
> > >>> example.
> > >>
> > >> I'm going to cautiously disagree. If the CPU needed was scaled so it
> > >> represented a fixed number of cycles (operations, work units) then t=
he
> > >> effect of faster CPU would be shown. And the total power of all
> > >> attached CPUs should be taken into account, using HT or SMP does have
> > >> an effect of feel.
> > >
> > > That is rather hard to do because each architecture's interpretation =
of
> > > fixed number of cycles is different and this doesn't represent their
> > > speed in the real world. The calculation when interbench is first run
> > > to see how many "loops per ms" took quite a bit of effort to find just
> > > how many loops each different cpu would do per ms and then find a way
> > > to make that not change through compiler optimised code. The "loops p=
er
> > > ms" parameter did not end up being proportional to cpu Mhz except on
> > > the same cpu type.
> >
> > right, but the amount of cpu required to do a specific task will also
> > vary significantly between CPU families for the same task as well. as
> > long as the loops don't get optimized away by the compiler I think you
> > can setup some loops to do the same work on each CPU, even if they take
> > significantly different amounts of time (as an off-the-wall, obviously
> > untested example you could make your 'loop' be a calculation of Pi and
> > for the 'audio' test you compute the first 100 digits, for the video te=
st
> > you compute the first 1000 digits, and for the X test you compute a
> > random number of digits between 10 and 10000)
>
> Once again I don't disagree, and the current system of loops_per_ms does
> exactly that and can be simply used as a fixed number of loops already. My
> point was there'd be argument about what sort of "loop" or load should be
> used as each cpu type would do different "loops" faster and they won't
> necessarily represent video, audio or X in the real world. Currently the
> loop in interbench is simply:
> 	for (i =3D 0 ; i < loops ; i++)
> 	     asm volatile("" : : : "memory");
>
> and if noone argues i can use that for fixed workload.

What I mean is if you take the loops_per_ms from one machine and plug it in=
=20
using the -l option on another you can do it now without any modification t=
o=20
the interbench code.

Cheers,
Con

--nextPart3093510.mWXdhLEdDB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1bk5ZUg7+tp6mRURAq/hAJ91MhutIKZUNhspzg/5OgLjESivTACfVwBG
8YMomwFd8/UhJ/jhuAR/Jgw=
=5VWt
-----END PGP SIGNATURE-----

--nextPart3093510.mWXdhLEdDB--
