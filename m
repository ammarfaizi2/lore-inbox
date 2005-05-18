Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVERV4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVERV4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVERV4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:56:52 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:9095 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262305AbVERVzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:55:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Subject: Re: HT scheduler: is it really correct? or is it feature of HT?
Date: Thu, 19 May 2005 07:56:13 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <377362e10505181142252ec930@mail.gmail.com>
In-Reply-To: <377362e10505181142252ec930@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7937152.cqMbBxRjDo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505190756.16413.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7937152.cqMbBxRjDo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 19 May 2005 04:42, Tetsuji "Maverick" Rai wrote:
> I'm wondering linux kernel's HT support is correct or not, or whether
> it's a feature of P4 HT.
>
> I'm running boinc/seti in the background with nice=3D19 on my P4 2.8G HT
> enabled linux box, kernel 2.6.11.9, where SMT/HT is enabled.
>
> I often watch system monitor applet on gnome desktop or top command in
> a termianl window and see when no other applications than boinc is
> running, boinc takes full power of both virtual cpus.   It is designed
> to run to "fill" the idle power of the cpu(s).   However any
> application is running, there is always some "idle" part appears on
> virtual cpus, hence it looks like it wastes up to half of cpu power as
> "idle."
>
> For ex, see this "top" result while a vmware is running.   (HT is
> enabled)  setiathome-4.7(blah--) are the background boinc applications
> with nice=3D19.

Hyperthread sibling cpus share cpu power. If you let a nice 19 task run ful=
l=20
power on the sibling cpu of a nice 0 task it will drain performance from th=
e=20
nice 0 task and make it run approximately 40% slower. The only way around=20
this is to temporarily make the sibling run idle so that a nice 0 task gets=
=20
the appropriate proportion of cpu resources compared to a nice 19 task. It =
is=20
intentional and quite unique to the linux cpu scheduler as far as I can tel=
l.=20
On any other scheduler or OS a nice 19 "background" task will make your=20
machine run much slower.

Cheers,
Con

--nextPart7937152.cqMbBxRjDo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCi7oAZUg7+tp6mRURAnSQAJ94h+tx+W2AVub5QwFBeKnVA+Sm6QCdHgUQ
Ij8tgplQLmaYCCrrEC7g4R0=
=P8Ju
-----END PGP SIGNATURE-----

--nextPart7937152.cqMbBxRjDo--
