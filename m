Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUJEGde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUJEGde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268838AbUJEGde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:33:34 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:52360 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268832AbUJEGd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:33:26 -0400
Date: Mon, 4 Oct 2004 23:33:24 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041005063324.GA7445@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040907i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

It seems that make (possibly among other things) has been affected by
some change in 2.6.9-rcX that prevents it from resuming some jobs.

I created this Makefile as a testcase:

all:
	sleep 5
	echo Hi
	sleep 5

The result:

darjeeling:~{0}% make
sleep 5

zsh: suspended  make
darjeeling:~{1}% bg
[1]  + continued  make
make: *** wait: No child processes.  Stop.
make: *** Waiting for unfinished jobs....
darjeeling:~{1}% echo Hi
Hi
make: *** Waiting for unfinished jobs....
sleep 5
make: *** Waiting for unfinished jobs....

[1]  + exit 2     make

This happens with bash also. I'm pretty sure it didn't use to happen
with older kernels. Any ideas?

Thanks

--=20
Joshua Kwan

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQWJANKOILr94RG8mAQJ78hAA824BFss0UlMvjIoaX5K8hlPKgMp6MNnl
hq3+FenSkzbLBh+YMx7QEeh84tczNUjv0Za/xizhklPFPwv0U+tGR6ckmxgzUCb3
65zTCg+yYmY22k3L6aAi9PahPw+ux24i4+IvIm7qQPGNLPRGStbX0J9dXcoipvLQ
ahLbZqP3SRNt9sqhTmynf6cF8Z7MALsyJfZcZiDZDBki8uqK49O99GC+QKvn6Upt
xmdUxWL5ireLgoXhpREKpbYspUWyhhwE47SojfuYpklxS12DkzcVKz+qKpcbXQwB
b2tInzTDXZQCWxALEzc4tT5RLdluKaWUoe7prhLAd8Ar4KCY/9fWMt2arEsp4icL
DCDVQI8kkGVhG3r02nQiRJPmDTE9zTt2ZsOuVWPmFmgORkV4LToQvackNtC8Tyvg
RxNWgEc/CR/KeJygwGip05Km+vKSgstL2Oj5IR06t4rn/DdeBJ8WyT3F5PhsSp3x
fsF9YM4GNf/rYCYdxAPtaU857y4Neq6yrYYU3wlqkq7N6t/CIgL+I3Abw9I3q8zx
LmRuj0baX5LaR7gC4wPFQY2Wz0xOMq10dWrfyuDHBPO/VXD/xCG2Oj3OGDnZrDfI
bjKX8QUlS2yeHpvrE2/bCPdnw6lErSvXPxbkM2w3BOlbWKSHfTV7wBNFprI+fNuS
748HVZ2mUNI=
=j74m
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
