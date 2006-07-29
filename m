Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWG2WpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWG2WpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 18:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWG2WpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 18:45:25 -0400
Received: from home.keithp.com ([63.227.221.253]:8715 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750738AbWG2WpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 18:45:24 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Keith Packard <keithp@keithp.com>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: keithp@keithp.com, Bill Huey <billh@gnuppy.monkey.org>,
       Jim Gettys <jg@laptop.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060729214334.GA8624@localhost.localdomain>
References: <44C67E1A.7050105@zytor.com>
	 <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <1153861094.1230.20.camel@localhost.localdomain>
	 <44C6875F.4090300@zytor.com>
	 <1153862087.1230.38.camel@localhost.localdomain>
	 <44C68AA8.6080702@zytor.com>
	 <1153863542.1230.41.camel@localhost.localdomain>
	 <20060729042820.GA16133@gnuppy.monkey.org>
	 <20060729125427.GA6669@localhost.localdomain>
	 <20060729204107.GA20890@gnuppy.monkey.org>
	 <20060729214334.GA8624@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J+9FAUi0dZspKFfzClxw"
Date: Sat, 29 Jul 2006 15:45:19 -0700
Message-Id: <1154213119.28839.76.camel@neko.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J+9FAUi0dZspKFfzClxw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-07-29 at 17:43 -0400, Neil Horman wrote:

> Sure, an mmaped jiffy counter would certainly be usefull.  I think the on=
ly
> thing left to be determined in this thread is if adding mmap to the rtc d=
river
> has any merit regardless of any potential users (iow, would current users=
 of
> /dev/rtc find it helpful to have the rtc driver provide an mmap interface=
.)

A jiffy counter is sufficient for the X server; all I need is some
indication that time has passed with a resolution of 10 to 20 ms. I
check this after each X request is processed as that is the scheduling
granularity. An X request can range in time from .1us to 100 seconds, so
I really want to just check after each request rather than attempt some
heuristic.

--=20
keith.packard@intel.com

--=-J+9FAUi0dZspKFfzClxw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEy+T/Qp8BWwlsTdMRAh4WAKCdXKxUvYwHHKVCiIebXGMJUJJ09wCfQsr5
3RK2EfUFYrx/kw1edUQihO0=
=zOr2
-----END PGP SIGNATURE-----

--=-J+9FAUi0dZspKFfzClxw--
