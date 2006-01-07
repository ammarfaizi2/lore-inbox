Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030563AbWAGTty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbWAGTty (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbWAGTty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:49:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17134 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030563AbWAGTtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:49:53 -0500
Message-ID: <43C01B3E.5030101@redhat.com>
Date: Sat, 07 Jan 2006 11:49:18 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: dsingleton@mvista.com
CC: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: robust futex deadlock detection patch
References: <Pine.LNX.4.44L0.0601051820000.3110-100000@lifa02.phys.au.dk>	 <EB15893A-7F26-11DA-9F72-000A959BB91E@mvista.com> <a36005b50601071145y7e2ead9an4a4ca7896f35a85e@mail.gmail.com>
In-Reply-To: <a36005b50601071145y7e2ead9an4a4ca7896f35a85e@mail.gmail.com>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E4C01C9A65E9D766B446CE6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E4C01C9A65E9D766B446CE6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Robust futexes will have -EDEADLK returned to them since there is no
> POSIX specification for
> robust mutexes,  yet, and  returning -EDEADLK is more in the spirit of
> robustness.

I disagree.  Robustness is only an additional mutex attribute on top of
the mutex type.  I.e., there can be robust
normal/error-checking/recursive mutexes.  What kind it is can be told to
the kernel at the time the robust mutex is registered with the kernel.

This is the way I'll write up the proposal for robust mutexes for
inclusion in the next POSIX revision.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig2E4C01C9A65E9D766B446CE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDwBtD2ijCOnn/RHQRAv4gAJ47Hj4zFL8LhxkNTny6bXkNHNTpQwCfa07M
M/f737cdYLkivM6InnwPszA=
=q5tl
-----END PGP SIGNATURE-----

--------------enig2E4C01C9A65E9D766B446CE6--
