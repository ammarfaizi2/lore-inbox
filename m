Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267063AbTGKXXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 19:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267064AbTGKXXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 19:23:24 -0400
Received: from mailb.telia.com ([194.22.194.6]:21225 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S267063AbTGKXXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 19:23:23 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de
In-Reply-To: <200307120030.31958.kernel@kolivas.org>
References: <200307112053.55880.kernel@kolivas.org>
	 <1068.::ffff:217.208.49.177.1057927722.squirrel@lanil.mine.nu>
	 <200307120030.31958.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+Yd4GE0dZvuLdg4m6Uga"
Organization: LANIL
Message-Id: <1057966657.4326.6.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jul 2003 01:37:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Yd4GE0dZvuLdg4m6Uga
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-11 at 16:30, Con Kolivas wrote:
> On Fri, 11 Jul 2003 22:48, Christian Axelsson wrote:
> > Ok complies and boot fine
> >
> > BUT... after loading X up and gnome-theme-manager I start clicking arou=
nd
> > abit.. then gnome-theme-manager starts eating 99.9% CPU (prolly a bug i=
n
> > the program). Problem here is that the machine stops responding to inpu=
t,
> > at first I can move mouse around (but Im stuck in the current focused
> > X-client) and later it all stalls... Cant even get in via SSH.
> > Ive put on a top before repeating this showing gnome-theme-manager eati=
ng
> > all CPU-time (PRI 15/NICE 0) and load showing ~55% user ~45% system.
> >
> > Anything I can do to help debugging?
>=20
> Can you try this patch instead which should stop the machine from getting=
 into=20
> a deadlock? I dont think I have found the problem but at least it should =
be=20
> easier to diagnose without the machine locking up.

Deadlock is gone but problem is still there.
Running processes (state R) keep running smooth until they try to access
any resource (ie. xmms keeps playing the current file but gets stuck
when trying to open next one, top keeps running with full
interactivity). Spawning new processes is impossible.
I had top running over SSH and when I exited I managed to type 1 char
then it hung up. A note is that sometimes the load is ~45% user ~55%
system instead of ~55% user and ~45% system. There are always those
values.
I tried to reproduce by creating a while(1){} loop but it runs smooth.

Any suggestions on methods to debug this?

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-+Yd4GE0dZvuLdg4m6Uga
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/D0pAyqbmAWw8VdkRAnM8AKDcWK4i7whUD75yON0t9dC22rfhHwCgs0X0
0znl7oiIMCZxB74cPT1qRAc=
=9dmI
-----END PGP SIGNATURE-----

--=-+Yd4GE0dZvuLdg4m6Uga--

