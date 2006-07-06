Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWGFCm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWGFCm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWGFCm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:42:27 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:19944 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751138AbWGFCm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:42:27 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: ext4 features
Date: Thu, 6 Jul 2006 12:42:19 +1000
User-Agent: KMail/1.9.1
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060705214133.GA28487@fieldses.org> <44AC7647.2080005@tmr.com>
In-Reply-To: <44AC7647.2080005@tmr.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1848871.GN2QJfhoY2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607061242.23811.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1848871.GN2QJfhoY2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

There are so many points in this conversation where I could jump in and mak=
e=20
the comment I want to provide (below). Sorry if I haven't picked the best=20
one.

On Thursday 06 July 2006 12:32, Bill Davidsen wrote:
> No comment, I would have to see a state table to be sure I saw the races
> or that there were none. With a single writer and a sinple dirty bit
> there is no issue, it behaves like an elevator, more or less. With
> multiple writers I bet changes are written in the order submitted rather
> than the order done, but multiple writers without locks are a train
> wreck waiting to happen anyway.

One application I can see for this careful checking is checkpointing. IIRC,=
=20
Linus recently said he'd like to see suspending to disk treated as a specia=
l=20
case of checkpointing, and I can see good sense in that. But the support is=
=20
just not there at the moment. An important part of implementing that would =
be=20
having a filesystem where we could know exactly what the state of the=20
filesystem was at the last checkpoint, and roll back to it if necessary.

Of course this would need to be tied to tracking changes in memory and to=20
writing the memory state to storage, but they're separate problems.

Ext3 has a history of being the best filesystem to use in developing and=20
testing suspend to disk. It would be great if ext4 was the basis for=20
implementing serious checkpointing support.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1848871.GN2QJfhoY2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErHiPN0y+n1M3mo0RAomGAKC4Dcn2BQmYDpersPj49g+QW3TZdACgjzRt
PEIWEuQ9ULJZYoltN6zXaRk=
=G+ZN
-----END PGP SIGNATURE-----

--nextPart1848871.GN2QJfhoY2--
