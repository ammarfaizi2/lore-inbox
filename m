Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266601AbUF3JQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266601AbUF3JQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266602AbUF3JQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:16:28 -0400
Received: from www.kisikew.org ([66.11.160.83]:58522 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S266601AbUF3JQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:16:22 -0400
Date: Wed, 30 Jun 2004 09:16:16 +0000
From: simon@nuit.ca
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot access '/dev/pts/292': Value too large for defined data type
Message-ID: <20040630091616.GA3103@nuit.ca>
References: <20040626151108.GA8778@nuit.ca> <20040626135948.7b4396e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20040626135948.7b4396e9.akpm@osdl.org>
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040523i
X-Scan-Signature: smtp.nuit.ca 1BfbCT-0008SM-6i 2b486641b560c8c41c4d45d832e50bf1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ce jour Sat, 26 Jun 2004, Andrew Morton a dit:

> simon@nuit.ca wrote:
> >
> > whenever i try open a new pseudo-pty, i get a similar message to=20
> >  the one in the subject, and one like "fstat: Value too large for defin=
ed data
> >  type" if i open an xterm.
>=20
> It appears that you're using some variant of the 2.6.7 kernel, yes?
>=20
> That kernel (and many preceding ones) will create large pty indexes and o=
ld
> (and/or buggy) userspace fails to handle it correctly.
>=20
> Post-2.6.7, the allocation of pty indexes was switched to first-fit and
> things should now work OK.
>=20
> Please test a current kernel and send a report.

ok. well, i'm currently running the 2.6.7-bk10, and it runs really
nicely for one thing, and the other is that the pty behaviour is exactly
like the old one (which i've just been told 'first fit' *is* the old
behaviour).=20

in a way i like the newer behaviour, but hmm, maybe have both
behaviours? first fit for some old/buggy apps, and the new one for ones
that correctly detect the new capabilities. though IME most of the
applications i've used don't recognise the new one, and having varying
levels of freakiness - from a warning to outright not working as
expected (e.g., my problem with screen, the "Value too large" message).

thanks :)


--=20
Software Patents are patently wrong:
http://swpat.ffii.org/papiere/eubsa-swpat0202/ustr0309/index.en.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQGVAwUBQOKE32qIeuJxHfCXAQJh3wv+Me+qNdAYSfoj2WEkjQFUMMahwcykF7+0
zNVx2uy3fgEPvaUF6RideNcivtOUUuZWIA0ZCHw/zGrFUCXAqCUyY1myt66knuFA
uPjMTdWSVQW3tuDhN+SNTBTG4Oi0K1ddZc83Y8NpRQDiW8SVaIn2rrWHIHHKcuBi
Aqg3qXB6BBVlODRKVCnCUyOaIVmdrN3xWYjhTf8aJBGhODQS64GNfNuQ9lyGSjLa
ZZPZHiUdsZH7abR4wF4peBXy85Z0TNZb8eZDBRJIGX5cW+6/PpXcpjb8mBIpyFGP
s++hYdnrA7B7q1MqTBy2F+X+EmSWz9iZqlPJO3utbVSSfH+eqpMXe/yoURw66MyL
V7SI17l1QskbDrpUDkVRSNMatY3Ae9x90ZVp8Mtoc2scmWrkyWgOUdpjIgeB/8PX
blrFGJm5u0BeB2gAwoTI3imrI47TzJ+nRZZZZ4L7WhRdmvQi6PF66UcJHaRkf3RD
r9KmxMEkchX0nZUJgDjSLpHtZ2utJ8ZF
=qqWI
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
