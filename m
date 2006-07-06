Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWGFBpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWGFBpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 21:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWGFBpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 21:45:14 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:24795 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965122AbWGFBpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 21:45:12 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
Date: Thu, 6 Jul 2006 11:45:04 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, klibc@zytor.com
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <200607061037.11177.ncunningham@linuxmail.org> <44AC5F5C.7070907@zytor.com>
In-Reply-To: <44AC5F5C.7070907@zytor.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5033695.ZKGVtOOb76";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607061145.08590.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5033695.ZKGVtOOb76
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 06 July 2006 10:54, H. Peter Anvin wrote:
> Nigel Cunningham wrote:
> > Ah. So it's still valid to have resume=3D and noresume on the commandli=
ne,
> > and klibc greps /proc/cmdline?
>
> Correct.
>
> > So, for Suspend2, would I be ok just leaving people to add the echo
> >
> >>/proc/suspend2/do_resume, as we currently do for initrds and initramfse=
s?
>
> Well, presumably you want to adjust kinit so that it invokes
> /proc/suspend2/do_resume, instead of or in addition to
> /sys/power/resume; see usr/kinit/resume.c (the code should be bloody
> obvious, I hope...)

It is.

Is there a klibc howto somewhere? I tried googling for 'klibc howto', readi=
ng=20
the files in Documentation/ and browsing your klibc mailing list archive=20
before asking!

What I'm wondering specifically is: Say a user needs to run some commands t=
o=20
set up access to encrypted storage before they can resume. At the moment,=20
we'd tell them to put these commands and the echo > do_resume in their=20
linuxrc (or init) script prior to mounting their root filesystem. Forgive m=
e=20
if I'm asking a stupid question but it's not immediately obvious to me how=
=20
they would now do that. I'd much rather follow a simple howto than spend a=
=20
good amount of time tracing function calls etc. I still see init/initramfs.=
c,=20
and it mentions both CONFIG_BLK_DEV_INITRD and CONFIG_BLK_DEV_RAM. Would I =
be=20
right in surmising that you can still have an initrd or ramfs to do such=20
things as the above, after klibc has done its work? If not, is there some=20
other way I'm ignorant of?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart5033695.ZKGVtOOb76
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErGskN0y+n1M3mo0RAkJsAJsFovtKrN3kJbLEFexp1SwNnoKS/gCeK09m
VrAn2hs5EOJ9vP3gdKY7uGQ=
=g9QU
-----END PGP SIGNATURE-----

--nextPart5033695.ZKGVtOOb76--
