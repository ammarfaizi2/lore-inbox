Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVHCVQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVHCVQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVHCVQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:16:54 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:48319 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261193AbVHCVQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:16:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Thu, 4 Aug 2005 07:13:57 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <42F12100.5020006@mnsu.edu>
In-Reply-To: <42F12100.5020006@mnsu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4784562.YbJyoWpLcJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508040713.59972.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4784562.YbJyoWpLcJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 4 Aug 2005 05:54, Jeffrey Hundstad wrote:
> Con Kolivas wrote:
> >This is the dynamic ticks patch for i386 as written by Tony Lindgen
> ><tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> >Patch for 2.6.13-rc5
> >
> >There were a couple of things that I wanted to change so here is an
> > updated version. This code should have stabilised enough for general
> > testing now.
> >
> >The sysfs interface was moved to its own directory
> >in /sys/devices/system/dyn_tick and split into separate files to
> >enable/disable dynamic ticks and usage of apic on the fly. It makes sense
> > to enable dynamic ticks and usage of apic by default if they're actually
> > built into the kernel so that is now done.
>
> I am successfully running the dynamic tick patch on an old IBM ThinkPad
> A22m.  When I enable the APIC support console beeps, you know bash -c
> 'echo -e "\a"', takes a REALLY long time to finish.  I'm assuming this
> is a badly written program and not a kernel problem.  Correct?

I think the config option which recommends leaving apic support off and=20
describes this behaviour should make it clearer. Indeed I found running wit=
h=20
apic on produced weird results unlike running with PIT.

> BTW: how do you know what HZ your machine is running at?

vmstat 5 will show you the average interrupts per second over 5 seconds in =
the=20
"in" column. The interrupts are obviously more than your Hz but often only =
a=20
little more.=20

The pmstats script by Tony will tell you more accurately:
http://www.muru.com/linux/dyntick/tools/pmstats-0.2.gz

Cheers,
Con

--nextPart4784562.YbJyoWpLcJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC8TOXZUg7+tp6mRURAlgWAJ4qCK8Wb3XD2m3V9YMWd1aZxST72gCgksGm
AE87sEfNMKkpqLg6mExtRxM=
=nt8L
-----END PGP SIGNATURE-----

--nextPart4784562.YbJyoWpLcJ--
