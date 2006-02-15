Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWBOK66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWBOK66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWBOK66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:58:58 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:33159 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751137AbWBOK66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:58:58 -0500
Date: Wed, 15 Feb 2006 11:58:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: time patches by Roman Zippel
In-Reply-To: <43F2E59D.24184.A70C2D5@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0602151132430.30994@scrub.home>
References: <43F1F2B4.7205.6BBE301@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <43F2E59D.24184.A70C2D5@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-67307697-1140001136=:30994"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-67307697-1140001136=:30994
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 15 Feb 2006, Ulrich Windl wrote:

> > > Assuming 1024Hz interrupt frequency:
> > > (1=B5s * 1000) / 1024 =3D=3D 0ns; 0 * 1024 =3D=3D 0=B5s, not 1=B5s
> > > (2=B5s * 1000) / 1024 =3D=3D 1ns; 1 * 1024 =3D=3D 1.024=B5s, not 2=B5=
s
> >=20
> > Ok, I didn't put much effort into optimizing it for uncommon HZ values.=
=20
> > Why is it so important? It's currently unused on any Linux machine=20
> > synchronized via NTP.
>=20
> Roman,
>=20
> how do you know? When using "disable kernel", NTP relies on adjtime() to =
adjust=20
> the time. Some people even prefer that, because the algorithms do floatin=
g point=20
> math in user space instead of fixed-point maths in kernel space.

This still requires they choose an uncommon HZ value, which is not really=
=20
likely. Anyway, it's not really difficult to add the remainder to=20
time_adj_curr. Since the adjtime() has only a usec resolution and this=20
rounding error is only 1 usec, I didn't consider it to be that important.

bye, Roman
---1463811837-67307697-1140001136=:30994--
