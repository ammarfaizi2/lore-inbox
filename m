Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbSIYLpy>; Wed, 25 Sep 2002 07:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261959AbSIYLpy>; Wed, 25 Sep 2002 07:45:54 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:40206 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261944AbSIYLpx>; Wed, 25 Sep 2002 07:45:53 -0400
Date: Wed, 25 Sep 2002 13:51:03 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: James D Strandboge <jstrand1@rochester.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BIOS or kernel APM bug?
Message-ID: <20020925115102.GB1215@arthur.ubicom.tudelft.nl>
References: <1032744662.6912.69.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <1032744662.6912.69.camel@sirius.strandboge.cxm>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2002 at 09:31:02PM -0400, James D Strandboge wrote:
> I recently purchased a usb webcam and found that polling /proc/apm
> causes the webcam in xawtv to skip.  I can so this either by doing 'cat
> /proc/apm' or using the gnome battstat-applet.  Disabling the
> battstat-applet and not touching /proc/apm lets xawtv work fine.
>=20
> Polling /proc/apm also causes clock drift.
>=20
> I have a Dell Inspiron 8200 laptop (1.6Ghz Pentium 4).  Using kernel
> 2.4.18 with rmap12h and preempt-kernel patch.

BIOS bug. Reading /proc/apm causes the APM BIOS to switch the CPU to
SMM mode with interrupts disabled so it can slowly poll the battery
about it's status. Result: lost interrupts, dropped frames, dropped
serial characters, clock slowdown. Workaround: don't use a battery
monitor, or don't let it poll every two seconds.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9kaMm/PlVHJtIto0RAlKHAJ9B4Hf0moK118VtCAFQnOPUIyPZpQCeLMbc
Vp/hSjwtm4GKjvGH0iW2y9I=
=Xco8
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
