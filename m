Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSENJEo>; Tue, 14 May 2002 05:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315547AbSENJEn>; Tue, 14 May 2002 05:04:43 -0400
Received: from cambot.suite224.net ([209.176.64.2]:56324 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S315544AbSENJEl>;
	Tue, 14 May 2002 05:04:41 -0400
Message-ID: <001501c1fb26$d5548660$8ff583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <7926.1021355489@kao2.melbourne.sgi.com>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 2
Date: Tue, 14 May 2002 05:07:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

Even if Linus isn't ready for it to be included in the kernel, I am planning
to star releasing a patchset similar to that of Dave Jones. Kbuild will be
the first thing that I will work into my patchset. I will keep both ways of
building the kernel as I work on it, since another set of patches that I am
going to add breaks kbuild, until I fix it.

Matthew D. Pitts
----- Original Message -----
From: "Keith Owens" <kaos@ocs.com.au>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>
Sent: Tuesday, May 14, 2002 1:51 AM
Subject: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 2


> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Content-Type: text/plain; charset=us-ascii
>
> Second attempt.  Original sent on May 2, no response from Linus.
>
> Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
> It is faster, better documented, easier to write build rules in, has
> better install facilities, allows separate source and object trees, can
> do concurrent builds from the same source tree and is significantly
> more accurate than the existing kernel build system.
>
> The current state is
>
>   kbuild-2.5-core-14 Fits any 2.4 and 2.5 kernel.
>   kbuild-2.5-common-2.5.15-3 2.5.15 arch independent files.
>
> There are several arch dependent files for 2.5.15 or earlier kernels.
>
>   kbuild-2.5-i386-2.5.15-2
>   kbuild-2.5-sparc64-2.5.15-1
>   kbuild-2.5-s390-2.5.15-1
>   kbuild-2.5-s390x-2.5.15-1
>   kbuild-2.5-ppc-2.5.14-1
>   kbuild-2.5-sh-2.5.12-1 (also fits 2.5.13)
>   kbuild-2.5-ia64-2.5.10-020426-1 (last Mosberger patch)
>
> That covers most of the architectures that currently build on 2.5.
>
>
> This version has only been tested on CML1.  kbuild 2.5 has support for
> an older version of CML2 but it has not been tested on newer versions
> of CML2.
>
> Before I send you the kbuild 2.5 patch, how do you want to handle it?
>
> * Coexist with the existing kernel build for one or two releases or
>   delete the old build system when kbuild 2.5 goes in?
>
>   Coexistence for a few days gives a backout, just in case.  It also
>   gives a kernel release where the old and new code can be compared,
>   useful for architectures that have not been converted yet.
>
>   Deleting the old system at the same time means that unconverted
>   architectures cannot build.  OTOH many architectures are already
>   broken in the 2.5 kernel.
>
> * I need a quiet period of 24-48 hours (no changes at all) after a new
>   kernel release to bring kbuild 2.5 up to the latest release, before
>   sending you the complete patch.  Which kernel release do you want
>   kbuild 2.5 against?
>
> I would like kbuild 2.5 to go in in the near future.  Keeping up to
> date with kernel changes is a significant effort, Makefiles change all
> the time, especially when major subsystems like sound and usb are
> reorganised.  There are also some changes to architecture code to do it
> right under kbuild 2.5 and tracking those against kernel changes can be
> painful.
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.4 (GNU/Linux)
> Comment: Exmh version 2.1.1 10/15/1999
>
> iD8DBQE84KXgi4UHNye0ZOoRAgucAKCAo9akupadD0YRWPly8HWxsB2FHwCgyXt5
> k31M4E5bhAhaFh3islVdik4=
> =O6CH
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

