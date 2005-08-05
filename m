Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVHETWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVHETWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbVHETWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:22:07 -0400
Received: from imap.gmx.net ([213.165.64.20]:46983 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262819AbVHETU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:20:59 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
Date: Fri, 5 Aug 2005 21:23:45 +0200
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200508051958.12853.dominik.karall@gmx.net> <Pine.LNX.4.61.0508051939390.6479@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508051939390.6479@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2438131.0QWGBzcVeZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508052123.49640.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2438131.0QWGBzcVeZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 05 August 2005 20:46, Hugh Dickins wrote:
> On Fri, 5 Aug 2005, Dominik Karall wrote:
> > On Friday 05 August 2005 17:22, Ingo Molnar wrote:
> > > please enable CONFIG_FRAME_POINTERS!
> >
> > I'm sorry, but I think I can't enable CONFIG_FRAME_POINTERS.
> > Depends on: DEBUG_KERNEL && (X86 && !X86_64 || CRIS || M68K || M68KNOMMU
> > || FRV || UML)
> >
> > Seems to be disabled for x86_64.
>
> It is disabled for x86_64, but not for any very good reason (beyond
> reducing the test matrix).  I work with CONFIG_FRAME_POINTERS on x86_64
> with no trouble, just add in the patch below, make oldconfig, choose
> frame pointers and rebuild).  But I can't guarantee it'll actually
> reveal the info Ingo and all are longing to see.

With FRAME_POINTERS enabled:

BUG: mono[3193] exited with nonzero preempt_count 1!
---------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<ffffffff80400a46>] .... _spin_lock+0x16/0x80
.....[<ffffffff801ed30c>] ..   ( <= sys_semtimedop+0x28c/0x7c0)

hth, let me know!

dominik

--nextPart2438131.0QWGBzcVeZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQvO8xQvcoSHvsHMnAQKEQwP/ViOIrZbe+i47SW4K6boQehgMuR6t9M1X
EBKtXpBa8zQALKTmcNhtkGlrnkvq1JZxd9R0Mmc+fcegjZUDo50Qh8oZP6C9RlUp
7dm7pqkb8PtvChY4NxF4pqllkZQLiV8BJWOpL8ZEp6hOYVNhJ+rCyvHwsGGeIMaQ
pFpLIWlkAfc=
=g2Xe
-----END PGP SIGNATURE-----

--nextPart2438131.0QWGBzcVeZ--
