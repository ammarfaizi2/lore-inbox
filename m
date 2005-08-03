Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVHCVSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVHCVSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVHCVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:18:46 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:28333 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261270AbVHCVS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:18:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jim MacBaine <jmacbaine@gmail.com>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Thu, 4 Aug 2005 07:16:21 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <3afbacad05080312201d388f8e@mail.gmail.com>
In-Reply-To: <3afbacad05080312201d388f8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7645559.zjMdlOdnWq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508040716.24346.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7645559.zjMdlOdnWq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 4 Aug 2005 05:20, Jim MacBaine wrote:
> On 8/3/05, Con Kolivas <kernel@kolivas.org> wrote:
> > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> > Patch for 2.6.13-rc5
> >
> > There were a couple of things that I wanted to change so here is an
> > updated version. This code should have stabilised enough for general
> > testing now.
>
> Runs very well here on a (noname) laptop, even with apic timer, the
> desktop does not "feel" different from static 1000HZ.=20

I did find performance dropped off substantially in interbench but usually=
=20
below the human perceptible range. Real time performance dropped off=20
substantially, but is back to mainline performance when disabled (ie config=
=20
on but disabled at runtime/boottime).

> But dtck=20
> reproducibly breaks software-suspend2; the kernel will simply stall on
> resume.  Also stalls with dyntick=3Dnoapic.  As soon as I set
> CONFIG_NO_IDLE_HZ =3D n, resume works again.

What happens when you disable it at runtime before suspending?

echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/enable

Cheers,
Con

--nextPart7645559.zjMdlOdnWq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC8TQoZUg7+tp6mRURAqlTAJ4zlUXVNA6LgipsHeeQIMluWfl7WgCfVBep
XdYpF2kGL7kytNcTQr25gpk=
=0ZKh
-----END PGP SIGNATURE-----

--nextPart7645559.zjMdlOdnWq--
