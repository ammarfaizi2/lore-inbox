Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264204AbUDRWgv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 18:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbUDRWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 18:36:51 -0400
Received: from smtp-out9.xs4all.nl ([194.109.24.10]:16908 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S264199AbUDRWgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 18:36:48 -0400
Subject: Re: reiser4 and megaraid problems with debian 2.6.5 (*solved*)
From: Paul Wagland <paul@wagland.net>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: reiserfs-list@Namesys.COM,
       Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Atul Mukker <atulm@lsil.com>, Domenico Andreoli <cavok@libero.it>,
       Hans Reiser <reiser@Namesys.COM>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1081987184.11193.87.camel@morsel.kungfoocoder.org>
References: <36927C82-8DE0-11D8-A41D-000A95CD704C@wagland.net>
	 <20040414090547.GB13578@raptus.homelinux.org>
	 <6699459A-8E10-11D8-A41D-000A95CD704C@wagland.net>
	 <16509.14375.539110.986025@laputa.namesys.com>
	 <295743F0-8E17-11D8-A41D-000A95CD704C@wagland.net>
	 <1081987184.11193.87.camel@morsel.kungfoocoder.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YGH7GBhT02j08IrkG0cH"
Message-Id: <1082327775.2003.5.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 00:36:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YGH7GBhT02j08IrkG0cH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

well partly solved anyway... I am just posting this so that if anyone
finds this thread later they can also find this conclusion... There is
still more work to be done before this problem can be properly closed,
but at least now I am certain that it has nothing to do with the
hardware :-)

It appears (my own unsupported theory) that the problem is that reiser4
is taking some time to free up the free blocks that are currently in use
by the wandering log. Since I was running a test that causes a lot of
wandering log to be created, and I was doing it on a filesystem with
very little free space, then I was running into the problem.

Rerunning the test with either a) more space, or b) a smaller data set
solved the problem. On the reiserfs-list we are now trying to find out
exactly why this is happening, and how to solve the problem properly.

Cheers,
Paul

--=-YGH7GBhT02j08IrkG0cH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAgwLftch0EvEFvxURAp5AAJ47g0pYpmfoLzcxbUJ4eymWDYhcbACfSMII
hSKeT05AHFB7jFC7SJuGIgE=
=covQ
-----END PGP SIGNATURE-----

--=-YGH7GBhT02j08IrkG0cH--

