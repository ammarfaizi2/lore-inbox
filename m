Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVCVMGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVCVMGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVCVMGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:06:47 -0500
Received: from downeast.net ([204.176.212.2]:56001 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S262659AbVCVMGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:06:34 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Tue, 22 Mar 2005 07:06:07 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <200503212241.26780.pmcfarland@downeast.net> <200503212249.09512.dtor_core@ameritech.net>
In-Reply-To: <200503212249.09512.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6827646.ptdGDFebDh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503220706.13029.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6827646.ptdGDFebDh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 21 March 2005 10:49 pm, Dmitry Torokhov wrote:
> On Monday 21 March 2005 22:41, Patrick McFarland wrote:
> > On Monday 21 March 2005 10:15 pm, Dmitry Torokhov wrote:
> > > Looks good, I was wondering if you had GAMEPORT=3Dm and SND_ENS1371=
=3Dy.
> >
> > Yes, that would be quite silly. ;)
> >
> > > > For the curious, what was the first kernel to be released that had
> > > > your sysfs stuff in it?
> > >
> > > 2.6.11-mm and 2.6.12-rc1. Vanilla 2.6.11 does not have it.
> >
> > I'll go compile 2.6.11 to see if it works there.
> >
> > > Could you verify that you enabled joystick port on card? What does
> > > "cat /sys/module/snd_ens1371/parameters/joystick_port" show?
> >
> > 0,0,0,0,0,0,0,0
>
> Ok, it looks like setup problem. Try doing:
>
>  modprobe snd-ens1371 joystick_port=3D1

I already tried that before I mailed the great and almighty source of all=20
information kernely (aka the lkml). Infact, I tried both joystick=3D1 and=20
joystick_port=3D1 (some drivers use one, others use the other, and I wasn't=
=20
sure at the time which es1371 used).

It didn't work.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart6827646.ptdGDFebDh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCQAo08Gvouk7G1cURAsjtAKC+x8OI246bEtHWoXxy8VdaB3/K8QCeI5GH
UZSMYRb7UoLqlyEi0OqEbH8=
=cPSg
-----END PGP SIGNATURE-----

--nextPart6827646.ptdGDFebDh--
