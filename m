Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVBUNvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVBUNvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 08:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVBUNvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 08:51:41 -0500
Received: from downeast.net ([204.176.212.2]:65231 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261974AbVBUNtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 08:49:15 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: linux-kernel@veger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Date: Mon, 21 Feb 2005 08:48:41 -0500
User-Agent: KMail/1.7.2
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       darcs-users@darcs.net
References: <20050214020802.GA3047@bitmover.com> <20050219171457.GA20285@abridgegame.org> <20050219175348.GE7247@opteron.random>
In-Reply-To: <20050219175348.GE7247@opteron.random>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1810925.H8bE1E9Wk1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502210848.47045.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1810925.H8bE1E9Wk1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 19 February 2005 12:53 pm, Andrea Arcangeli wrote:
> Wouldn't using the CVS format help an order of magnitude here? With
> CVS/SCCS format you can extract all the patchsets that affected a single
> file in a extremely efficient manner, memory utilization will be
> extremely low too (like in cvsps indeed). You'll only have to lookup the
> "global changeset file", and then open the few ,v files that are
> affected and extract their patchsets. cvsps does this optimally
> already. The only difference is that what cvsps is a "readonly" cache,
> while with a real SCM it would be a global file that control all the
> changesets in an atomic way.

But then that makes darcs do stuff the cvs way, and would make darcs exactl=
y=20
the opposite of how us darcs users want it, imho. If you're worried about=20
darcs needing to open a billion files, nothing stops people from,  say,=20
hacking darcs to use a SQL database to store patches in (they just have to=
=20
code it, and I think I saw a SQL module for haskell around somewhere...)

May be I just don't understand the argument of why the CVS file format is=20
anything short of insane, backwards, and outdated. We want each chunk of=20
information to be both independent and have a clear history (ie, what patch=
es=20
does this patch rely on). CVS does not provide this, it is not fine grained=
=20
enough for what darcs needs.

(David Roundy and Co can fill in the technical details of this, I'm not a=20
versioning system expert)

In short, we need to move as far away from the CVS way of doing things,=20
because ultimately its the wrong way. This is why I am somewhat dismayed wh=
en=20
I hear of projects who move to SVN from CVS... SVN is just CVS with a few=20
flaws fixed, and a few things like atomic commits added. It isn't the next=
=20
step: it is just a small stepping stone between CVS and the next step.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart1810925.H8bE1E9Wk1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCGea+8Gvouk7G1cURAmasAJ0XY09/e00r/jeapqJ8JT6mLWvEHQCgkiMl
VI1MnJBhQmg9PJCW+1SPG38=
=8gIy
-----END PGP SIGNATURE-----

--nextPart1810925.H8bE1E9Wk1--
