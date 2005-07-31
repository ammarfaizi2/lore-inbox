Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263146AbVGaEfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbVGaEfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 00:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbVGaEfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 00:35:42 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:1690 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263146AbVGaEfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 00:35:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [sched, patch] better wake-balancing, #2
Date: Sun, 31 Jul 2005 14:35:06 +1000
User-Agent: KMail/1.8.2
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Ingo Molnar <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ia64 <linux-ia64@vger.kernel.org>
References: <200507301929_MC3-1-A601-D4C2@compuserve.com>
In-Reply-To: <200507301929_MC3-1-A601-D4C2@compuserve.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6421577.OHCWCaKClm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507311435.09225.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6421577.OHCWCaKClm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 31 Jul 2005 09:26, Chuck Ebbert wrote:
> On Fri, 29 Jul 2005 at 17:02:07 +0200, Ingo Molnar wrote:
> > do wakeup-balancing only if the wakeup-CPU is idle.
> >
> > this prevents excessive wakeup-balancing while the system is highly
> > loaded, but helps spread out the workload on partly idle systems.
>
> I tested this with Volanomark on dual-processor PII Xeon -- the
> results were very bad:
>
> Before: 5863 messages per second

> After: 5569 messages per second

Can you check schedstats or otherwise to find if volanomark uses=20
sched_yield() ? When last this benchmark came up, it appeared that no jvm=20
used futexes and left locking to yielding. We really should find out if tha=
t=20
is the case before trying to optimise for this benchmark.

Cheers,
Con

--nextPart6421577.OHCWCaKClm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC7FT9ZUg7+tp6mRURAk7zAJ4vwv1n0picU3J4ODTzTg6IUBT6ogCfaby4
FN2C76fkrGxucZeWjfMY1FY=
=sKKn
-----END PGP SIGNATURE-----

--nextPart6421577.OHCWCaKClm--
