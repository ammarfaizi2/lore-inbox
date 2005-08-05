Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVHERza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVHERza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVHERza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:55:30 -0400
Received: from pop.gmx.de ([213.165.64.20]:44944 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262824AbVHERzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:55:23 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
Date: Fri, 5 Aug 2005 19:58:10 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200508051626.56910.dominik.karall@gmx.net> <20050805152245.GA12650@elte.hu>
In-Reply-To: <20050805152245.GA12650@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2967062.cxH0HmVIBH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508051958.12853.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2967062.cxH0HmVIBH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 05 August 2005 17:22, Ingo Molnar wrote:
> * Dominik Karall <dominik.karall@gmx.net> wrote:
> > BUG: mono[10011] exited with nonzero preempt_count 1!
> > ---------------------------
> >
> > | preempt count: 00000001 ]
> > | 1 level deep critical section nesting:
> >
> > ----------------------------------------
> > .. [<ffffffff803f791e>] .... _spin_lock+0xe/0x70
> > .....[<0000000000000000>] ..   ( <=3D 0x0)
> >
> > If there is anything I should test, let me know!
>
> please enable CONFIG_FRAME_POINTERS!
>
> we now know that it's a spin_lock reference that got leaked, but we dont
> (yet) know the parent.

I'm sorry, but I think I can't enable CONFIG_FRAME_POINTERS.
Depends on: DEBUG_KERNEL && (X86 && !X86_64 || CRIS || M68K || M68KNOMMU ||=
=20
=46RV || UML)

Seems to be disabled for x86_64.

dominik

--nextPart2967062.cxH0HmVIBH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQvOotAvcoSHvsHMnAQK4fAP9EneTLtjZpklttF3l/Iazzaiy+RvnMAu1
E1XXYgKJQp2AeXPZ60eGGJ+QanjGAdVaNnhPMCWvGBVdDmPV3GhKQLfWKsMzJOHH
7GrocobXxBh4Tkp2tUUT+49x4Jri8pFRKGELF/L8TPqCbtTWSMbHA/9IcWj6Q399
ZJWWxNpBWqs=
=5UxB
-----END PGP SIGNATURE-----

--nextPart2967062.cxH0HmVIBH--
