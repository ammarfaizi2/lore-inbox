Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318591AbSHUSMw>; Wed, 21 Aug 2002 14:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318601AbSHUSMw>; Wed, 21 Aug 2002 14:12:52 -0400
Received: from monster.nni.com ([216.107.0.51]:25618 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318591AbSHUSMv>;
	Wed, 21 Aug 2002 14:12:51 -0400
Date: Wed, 21 Aug 2002 14:16:42 -0400
From: Andrew Rodland <arodland@noln.com>
To: moret@cs.umn.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with modules (modutils) and 2.5.31 kernel
Message-Id: <20020821141642.5eab2a42.arodland@noln.com>
In-Reply-To: <7675.1029905417@kao2.melbourne.sgi.com>
References: <20020821022519.GA2554@cs.unm.edu>
	<7675.1029905417@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="N_q7sw1=.ZzOqBKV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--N_q7sw1=.ZzOqBKV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2002 14:50:17 +1000
Keith Owens <kaos@ocs.com.au> wrote:

> On Tue, 20 Aug 2002 20:25:19 -0600, 
> moret@cs.unm.edu wrote:
> >I searched for, but could not find references to, a problem
> >I have with 2.5.31 and modutils.
> >  insmod, depmod, update-modules all fail with the message:
> >
> >=>   kernel: QM_SYMBOLS: Bad address
> 
> Disable CONFIG_PREEMPT and rebuild the kernel.

or, as per a previous thread on the same issue, change line 181 of
arch/i386/mm/fault.c from:

if (preempt_count() || !mm)

to:

if (in_interrupt() || !mm)

and rebuild.

Sorry, no time to fool around with diff right now. Hope it was helpful.
--hobbs

--N_q7sw1=.ZzOqBKV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Y9kPQ3MWXxdwvVwRAuQbAJ4o4rLFrP18gdMBjXYEx2ezP2mToQCfR42Q
ms7Akr6o89B8heESB8qnXpw=
=2EJg
-----END PGP SIGNATURE-----

--N_q7sw1=.ZzOqBKV--
