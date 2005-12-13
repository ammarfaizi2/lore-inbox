Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVLMMQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVLMMQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 07:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVLMMQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 07:16:29 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:40376 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750766AbVLMMQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 07:16:28 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: 2.6.15-rc5-mm2 :-)
Date: Tue, 13 Dec 2005 23:16:11 +1100
User-Agent: KMail/1.9
References: <20051211041308.7bb19454.akpm@osdl.org> <200512131652.10117.kernel@kolivas.org> <1916802326.20051213121330@dns.toxicfilms.tv>
In-Reply-To: <1916802326.20051213121330@dns.toxicfilms.tv>
MIME-Version: 1.0
Message-Id: <200512132316.14118.kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed;
  boundary="nextPart1895324.oxDZcNMopj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1895324.oxDZcNMopj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 13 December 2005 22:13, Maciej Soltysiak wrote:
> Hello Con,
>
> Tuesday, December 13, 2005, 6:52:09 AM, you wrote:
> > I missed this announcement (been on leave for a while). This SCHED_BATCH
> > implementation is by Ingo and it it is not "idle" scheduling as I have
> > implemented in the staircase scheduler. This is just to restrict a task
> > to not having any interactive bonus at any stage and to have predictable
> > scheduling behaviour I guess.
>
> Thanks a lot. That's good anyway.
>
> If I understand correctly, if Ingo's version gets merged with linus' tree
> your implementions of SCHED_BATCH in -ck will be replacing the one from
> Ingo.

Yes. SCHED_BATCH in Ingo's implementation is more like turning off the=20
interactive setting in staircase, and the idle scheduling staircase offers =
is=20
extremely useful.

> A silly question. Is SCHED_BATCH-kind-of-thing a standard in Unices or
> general operating system engineering know-how? Or is this concept only
> available for Linux?

=46airly standard in Unices but prone to all sorts of priority inversion=20
starvation scenarios so very few implement it. In freebsd for example you c=
an=20
use their idle scheduling only if you are root to prevent this starvation -=
=20
which kind of makes it useless in practice. My implementation is fairly=20
robust at avoiding the priority inversion problem - at least I haven't seen=
 a=20
bug report about it for years since I address it :)

Cheers,
Con

--nextPart1895324.oxDZcNMopj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDnruOZUg7+tp6mRURApanAJ97/ELCoyAiuumfuLj0iVwZROfK6gCffn5J
p2kJOLAaIy51Vy+pqNYLSqg=
=MX1t
-----END PGP SIGNATURE-----

--nextPart1895324.oxDZcNMopj--
