Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVGLL5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVGLL5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVGLLy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:54:58 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:44762 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261346AbVGLLwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:52:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Eric Piel <Eric.Piel@lifl.fr>
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
Date: Tue, 12 Jul 2005 21:52:23 +1000
User-Agent: KMail/1.8.1
Cc: Ken Moffat <ken@kenmoffat.uklinux.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net> <Pine.LNX.4.58.0507121203450.7944@ppg_penguin.kenmoffat.uklinux.net> <42D3AE47.7070208@lifl.fr>
In-Reply-To: <42D3AE47.7070208@lifl.fr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5552441.4FEbOI5BtM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507122152.26106.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5552441.4FEbOI5BtM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 12 Jul 2005 21:49, Eric Piel wrote:
> 07/12/2005 01:11 PM, Ken Moffat wrote/a =C3=A9crit:
> > On Tue, 12 Jul 2005, Ken Moffat wrote:
> >> I was going to say that niceness didn't affect what I was doing, but
> >>I've just rerun it [ in 2.6.11.9 ] and I see that tar and bzip2 show up
> >>with a niceness of 10.  I'm starting to feel a bit out of my depth here
> >
> > OK, Con was right, and I didn't initially make the connection.
> >
> >  In 2.6.11, untarring a .tar.bz2 causes tar and bzip2 to run with a
> > niceness of 10, but everything is fine.
> >
> >  In 2.6.12, ondemand _only_ has an effect for me in this example if I
> > put on my admin hat and renice the bzip2 process (tried 0, that works) -
> > renicing the tar process has no effect (obviously, that part doesn't
> > push the processor).
> >
> > So, from a user's point of view it's broken.
>
> Well, it's just the default settings of the kernel which has changed. If
> you want the old behaviour, you can use (with your admin hat):
> echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice
> IMHO it seems quite fair, if you have a process nice'd to 10 it probably
> means you are not in a hurry.

That's not necessarily true. Most people use 'nice' to have the cpu bound t=
ask=20
not affect their foreground applications, _not_ because they don't care how=
=20
long they take. I nice my kernel compiles and keep web browsing etc (actual=
ly=20
I run them SCHED_BATCH but this has the same effect with the default ondema=
nd=20
governor now).

>
> Just by couriosity, I wonder how your processes are automatically
> reniced to 10 ?

Shell environment settings.

Cheers,
Con

--nextPart5552441.4FEbOI5BtM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC0676ZUg7+tp6mRURAqklAKCQJo2rzbVynqyu1O1ih9tNw5jUuQCffcNI
LIhU/1YkM7Du2DFhJYxM83o=
=0nwC
-----END PGP SIGNATURE-----

--nextPart5552441.4FEbOI5BtM--
