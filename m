Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUHVGG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUHVGG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUHVGG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:06:26 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:44160 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S266242AbUHVGGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:06:21 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
Date: Sat, 21 Aug 2004 23:06:12 -0700
User-Agent: KMail/1.7
Cc: "David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20040821135516.GA3872@elte.hu> <200408212242.33562.ryan@spitfire.gotdns.org> <1093154401.817.43.camel@krustophenia.net>
In-Reply-To: <1093154401.817.43.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1329955.9gS4bAM6yN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408212306.15012.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1329955.9gS4bAM6yN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 21 August 2004 23:00, Lee Revell wrote:
> On Sun, 2004-08-22 at 01:42, Ryan Cumming wrote:
> > On Saturday 21 August 2004 21:46, David S. Miller wrote:
> > > FWIW, I would recommend a sparse bitmap implementation for the
> > > ioport stuff.
> >
> > The problem is that the sparse bitmap would have to be unpacked to the
> > "dense" bitmap that lives in the TSS on context switch.
>
> Can someone supply a link to the original LKML post with the ioport
> change?  I was not able to find it in my mailbox nor in the archives.

Here's what I could dig up:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-m=
m2/broken-out/larger-io-bitmap.patch
http://www.uwsg.iu.edu/hypermail/linux/kernel/0211.0/0477.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/9807.1/1079.html

Looks like x86-64 does in fact need a similar change to the x86 one. It's l=
ate=20
here, but it should be pretty trivial to port over.

=2DRyan

--nextPart1329955.9gS4bAM6yN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKDfWW4yVCW5p+qYRAuCLAJkB7syFWCvbzADiW4TgQQE2fE/gXQCfW6r1
7kNF3F8QGpkZ7V8pqEaCtv4=
=X6qd
-----END PGP SIGNATURE-----

--nextPart1329955.9gS4bAM6yN--
