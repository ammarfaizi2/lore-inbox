Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVHCGeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVHCGeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVHCGeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:34:25 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:47775 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262093AbVHCGeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:34:22 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Documentation - how to apply patches for various trees
Date: Wed, 3 Aug 2005 08:40:30 +0200
User-Agent: KMail/1.8.1
References: <200508022332.21380.jesper.juhl@gmail.com>
In-Reply-To: <200508022332.21380.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2357105.CPPuyseDXc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508030840.39852@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2357105.CPPuyseDXc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jesper Juhl wrote:

>+Where can I download the patches?

Maybe it would be useful to once again mention that local mirrors should be=
=20
used at least for stable releases and */testing/*.

>+The 2.6.x kernels
[...]
>+# moving from 2.6.11 to 2.6.12
>+$ cd ~/linux-2.6.11			# change to kernel source dir
>+$ patch -p1 < ../patch-2.6.12		# apply the 2.6.12 patch

patch also nows "-i": patch -p1 -i ../patch-2.6.12

More likely the user will get the patch compressed either with bzip2 or gzi=
p,=20
so I think it would be useful to tell once more how to apply such a patch:

bzcat ../patch-2.6.12.bz2 | patch -p1

>+The 2.6.x.y kernels

>+$ cd ~/linux-2.6.12.2			# change into the kernel source dir
>+$ patch -p1 -R < ../patch-2.6.12.2	# revert the 2.6.12.2 patch
>+$ patch -p1 < ../patch-2.6.12.3		# apply the new 2.6.12.3 patch
>+$ cd ..
>+$ mv linux-2.6.12.2 linux-2.6.12.3	# rename the kernel source dir

The better way would probably be to use interdiff. Another goodie is that=20
interdiff knows about -z:

cd ~/linux-2.6.12.2
interdiff -z ../patch-2.6.12.2.bz2 ../patch-2.6.12.3.gz | patch -p1

This should only be shown as "another way" to do so. Sometimes interdiff ge=
t's=20
confused and breaks things, although this is very unlikely for the stable=20
diffs.

>+The -mm kernels

>+ These kernels in=20
>+ addition to all the other experimental patches they contain usually also
>+ contain any changes in the mainline -git kernels available at the time of
>+ release.=20

These two "contain"'s that close to each user are likely to confuse. In a=20
German text I would but a comma before "in addition" and behind the first=20
"contain", don't know what the rules for this are in English.

Eike

--nextPart2357105.CPPuyseDXc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC8GbnXKSJPmm5/E4RAnzWAJ4z+3Pwx4pc0bH1onWkVJCHFolfowCdFtoy
kw1AP4+Q2EB1ljTQdGHGRs0=
=LYyS
-----END PGP SIGNATURE-----

--nextPart2357105.CPPuyseDXc--
