Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWGEIA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWGEIA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWGEIA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:00:56 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:1210 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S932382AbWGEIAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:00:55 -0400
Subject: Re: [Hdaps-devel] Generic interface for accelerometers (AMS,
	HDAPS, ...)
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Henrique de Moraes Holschuh <hmh@debian.org>,
       Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       hdaps-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org
In-Reply-To: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
References: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
	 <20060703124823.GA18821@khazad-dum.debian.net>
	 <20060704075950.GA13073@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DUAQiRPhRRQMyEHONu9U"
Date: Wed, 05 Jul 2006 10:00:15 +0200
Message-Id: <1152086415.4995.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
X-sips-origin: submit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DUAQiRPhRRQMyEHONu9U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[I hope I managed to not break the thread]

> Also, there's a small issue with polling frequency. hdapsd needs a
> fairly high frequency (say, 50Hz) to gather statistics and keep
> response latency low, whereas the hdaps driver's internal polling
> (routing to the input infrastructure) is currently done at only 20Hz.
> We'll need to increase the latter, thereby slightly increasing system
> load when hdaps isn't running.

Note that with AMS we're better off -- it has two interrupts telling us
when something is wrong.

Hence, most of the discussion about loads of input values only applies
to hdaps, the actual head-park functionality can be implemented with AMS
without ever reading any sensor values.

Hence we also need much less complexity in userland -- once an interrupt
comes in we trigger the hd park...

johannes

--=-DUAQiRPhRRQMyEHONu9U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKtxjaVg1VMiehFYAQJBdhAApV5HMvMs9GE1CT9wL5mvHIixsTqmK5dB
frbUS3GcBAsXurWvkoHqMepNIPLK8Jb6gpnvdwtz7tZmFF0xgsP5Xoy7it0qt2/H
RSi8VlZ0dY7LOw/9dDlgfRGCI5yecYdgakMWh65OJVxCHTo0iRrIHeHDCEP9RLpB
RN5PBhfTGo+4MF9HFWtKgo3UUfqWOlQNnWXnsJQLu+12pOi90hlrkQg7xzuqMGql
5SFEFqyh6z1B3h5UGiXWB2E0H5Y+a/oyOtgtRNVxGbJvpM78JLnY9t0GLYbjE9Xi
HZpRrIGCqn458JKDXEv6P5i7URQftULi6l9VQqISWp9qc2dpSWDyWKKUDoSFgKMA
XwdiYJDlyXX0MugkgZhsIMbG1uUgpYXOzGD1DrAx2ZhehK83MpYGSDL3Pk9TP4OS
cwvEwZRyEjAD2RxbqZnvi5kX2evP2f3QTAqXSouwfyBXyUJe7bZ94p5QABSrCMCA
o1WwKvQ/LB8kTQCnaCyEjlR1clZBdfwFsD/C7dHQ7teGMO555fxujQW5EytP46/n
yJ2gmsahK1Q2G7GYeSJe10nnV88owjXuWipWpYZZsDqvPYzqn1ef3b+EAYe0Wgyk
ckd3RbDHcQ3dfhtcysX2nktS9huRgJqpU7TaHj8FdLtY1Ndt/iNczA6oV/ryCRH0
dmF1JXY3Vj8=
=3RF5
-----END PGP SIGNATURE-----

--=-DUAQiRPhRRQMyEHONu9U--

