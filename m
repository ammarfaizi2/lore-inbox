Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVA2XVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVA2XVv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVA2XVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:21:51 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:41135 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261595AbVA2XVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:21:45 -0500
Date: Sun, 30 Jan 2005 00:20:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
In-Reply-To: <200501291750.50886.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0501300008381.6118@scrub.home>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
 <200501291750.50886.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-854617330-1107040821=:6118"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-854617330-1107040821=:6118
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Sat, 29 Jan 2005, Dmitry Torokhov wrote:

> On Saturday 29 January 2005 17:20, Roman Zippel wrote:
> > --- linux-2.6.11.orig/drivers/input/serio/Kconfig=A0=A0=A0=A0=A0=A0=A02=
005-01-29 22:50:43.404946203 +0100
> > +++ linux-2.6.11/drivers/input/serio/Kconfig=A0=A0=A0=A02005-01-29 22:5=
6:42.549085439 +0100
> > @@ -3,6 +3,7 @@
> > =A0#
> > =A0config SERIO
> > =A0=A0=A0=A0=A0=A0=A0=A0tristate "Serial i/o support" if EMBEDDED || !X=
86
> > +=A0=A0=A0=A0=A0=A0=A0depends on INPUT
>=20
> ????
>=20
> serio_raw works fine without INPUT.

All current serio users depend on INPUT, it's maybe not a strict=20
dependency, but it pretty much needs INPUT anyway to be usable, so I don't=
=20
see the problem.
The alternative is to move it completely out of the input menu, if it's=20
really that important for the user being able to select it without input.

bye, Roman
---1463811837-854617330-1107040821=:6118--
