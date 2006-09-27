Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965486AbWI0JqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965486AbWI0JqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965485AbWI0JqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:46:12 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:57822 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S965486AbWI0JqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:46:11 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.18 Nasty Lockup
Date: Wed, 27 Sep 2006 12:45:34 +0300
User-Agent: KMail/1.9.4
Cc: Greg Schafer <gschafer@zip.com.au>, linux-kernel@vger.kernel.org
References: <20060926123640.GA7826@tigers.local> <200609270015.51465.caglar@pardus.org.tr> <1159311057.17071.5.camel@localhost>
In-Reply-To: <1159311057.17071.5.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2150761.UAnWX5xmVd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609271245.39591.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2150761.UAnWX5xmVd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

27 Eyl 2006 =C3=87ar 01:50 tarihinde, john stultz =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> On Wed, 2006-09-27 at 00:15 +0300, S.=C3=87a=C4=9Flar Onur wrote:
> > 26 Eyl 2006 Sal 15:36 tarihinde, Greg Schafer =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:
> > > This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> > > completely dead machine with only option the reset button. Usually
> > > happens within a couple of minutes of desktop use but is 100%
> > > reproducible. Problem is still there in a fresh checkout of current
> > > Linus git tree (post 2.6.18).
> >
> > Same symptoms here and its reproducible after starting the irqbalance
> > (0.12 or 0.13), if i disable irqbalance then everything is going fine.
>
> Hmm.. Not sure about the connection to irqbalance. You're using the TSC
> clocksource, so I'm curious if your cpu TSC's are out of sync. Can you
> boot w/ "clocksource=3Dacpi_pm" to see if that resolves it?

Yep, it solves the problem and system boot normally with irqbalance enabled.

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart2150761.UAnWX5xmVd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGkhDy7E6i0LKo6YRAueGAJ9XpPwIW8EPii7ANZvkbXFcyHoFvACfW8XX
Xhulfjw6afPSMpVh2hNbvlQ=
=D7KM
-----END PGP SIGNATURE-----

--nextPart2150761.UAnWX5xmVd--
