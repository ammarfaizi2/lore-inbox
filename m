Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269105AbUIXUHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269105AbUIXUHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269104AbUIXUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:07:23 -0400
Received: from reptilian.maxnet.nu ([212.209.142.131]:61959 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S269105AbUIXUFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:05:47 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Date: Fri, 24 Sep 2004 21:58:27 +0200
User-Agent: KMail/1.7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409230123.30858.thomas@habets.pp.se> <20040923234520.GA7303@pclin040.win.tue.nl> <1096031971.9791.26.camel@localhost.localdomain>
In-Reply-To: <1096031971.9791.26.camel@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200409242158.40054.thomas@habets.pp.se>
Content-Type: multipart/signed;
  boundary="nextPart2974400.JcfRHIfDnj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2974400.JcfRHIfDnj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Once upon a midnight dreary, Alan Cox pondered, weak and weary:
> The rest of us just turn on "no overcommit" in /proc/sys.

$ cat /proc/sys/vm/overcommit_{memory,ratio}
0
50

Well that didn't help.
Me thinks the text in Documentation/filesystems/proc.txt may be out of date=
,=20
especially considering it doesn't say the same as=20
Documentation/vm/overcommit-accounting.txt.

overcommit_memory
=2D----------------

This file  contains  one  value.  The following algorithm is used to decide=
 if
there's enough  memory:  if  the  value of overcommit_memory is positive, t=
hen
there's always  enough  memory. This is a useful feature, since programs of=
ten
malloc() huge  amounts  of  memory 'just in case', while they only use a sm=
all
part of  it.  Leaving  this value at 0 will lead to the failure of such a h=
uge
malloc(), when in fact the system has enough memory for the program to run.

On the  other  hand,  enabling this feature can cause you to run out of mem=
ory
and thrash the system to death, so large and/or important servers will want=
 to
set this value to 0.


And also, I'd like to see how a misbehaving airline passenger could start t=
o=20
gain weight not originally on the plane, causing the flight attendants to=20
start executing people because of OOF. And IIRC most airlines don't like=20
having women onboard who are way too pregnant, so no forking either.

=2D--------
typedef struct me_s {
  char name[]      =3D { "Thomas Habets" };
  char email[]     =3D { "thomas@habets.pp.se" };
  char kernel[]    =3D { "Linux" };
  char *pgpKey[]   =3D { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   =3D { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

--nextPart2974400.JcfRHIfDnj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBVHxwKGrpCq1I6FQRAodSAJ9AjIKfbg+eic3liNlXs5ZCrN3ysACg8flo
oFpShoVjpQTDSj0bZD9CvvU=
=T24s
-----END PGP SIGNATURE-----

--nextPart2974400.JcfRHIfDnj--
