Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVHELmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVHELmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 07:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVHELmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 07:42:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:62149 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262989AbVHELmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 07:42:07 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] preempt-trace.patch
Date: Fri, 5 Aug 2005 13:44:54 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <20050804152858.2ef2d72b.akpm@osdl.org> <20050805104819.GA20278@elte.hu>
In-Reply-To: <20050805104819.GA20278@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2655351.RW4KK5tHXM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508051344.58848.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2655351.RW4KK5tHXM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 05 August 2005 12:48, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> > I think Ingo was planning on coming up with some infrastructure which
> > would allow us to debug this further.
>
> yeah. I've done this today and have split it out of the -RT tree, see
> the patch below. After some exposure in -mm i'd like this feature to go
> upstream too.
>
> the patch is against recent Linus trees, 2.6.13-rc4 or later should all
> work. Dominik, could you try it and send us the new kernel logs whenever
> you happen to hit that warning message again? (Please also enable
> CONFIG_KALLSYMS_ALL, so that we get as much symbolic data as possible.)

I tried to compile the patch on top of 2.6.13-rc4-mm1, it applied with a fe=
w=20
offsets, but it looked ok.
Here is the error I get when I compiled it:

  CC      arch/x86_64/kernel/traps.o
arch/x86_64/kernel/traps.c: In function `show_trace':
arch/x86_64/kernel/traps.c:228: warning: implicit declaration of function=20
`print_traces'
arch/x86_64/kernel/traps.c:228: error: `task' undeclared (first use in this=
=20
function)
arch/x86_64/kernel/traps.c:228: error: (Each undeclared identifier is repor=
ted=20
only once
arch/x86_64/kernel/traps.c:228: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/traps.o] Error 1

I took a look at the traps.c file, but couldn't find any solution, as there=
 is=20
no print_traces function and task variable too in this section.

dominik

--nextPart2655351.RW4KK5tHXM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQvNROgvcoSHvsHMnAQIWLwP+O51sz/EyXEWjNbDHal4SuPNUepuyPpF+
SseRJAymy41nsklYqR2Y+x2tHYusN+DwVTUb3zcn2YG4h+/A6yqQPZINzJZMu847
GjyeuuyDV250zl6nSFAlGZJuD+b1KKni9UKFjzd0JPV+R6qvcV+4cNdxkF8Bx9Fy
uob3j7LPOYQ=
=vsfW
-----END PGP SIGNATURE-----

--nextPart2655351.RW4KK5tHXM--
