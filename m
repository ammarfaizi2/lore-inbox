Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTBDJtO>; Tue, 4 Feb 2003 04:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTBDJtO>; Tue, 4 Feb 2003 04:49:14 -0500
Received: from relay.dera.gov.uk ([192.5.29.49]:3732 "HELO relay.dstl.gov.uk")
	by vger.kernel.org with SMTP id <S267219AbTBDJtM>;
	Tue, 4 Feb 2003 04:49:12 -0500
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not  2.4.x,
From: Tony Gale <gale@syntax.dstl.gov.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1030203155651.28323A-100000@dstl.gov.uk>
References: <Pine.LNX.3.96.1030203155651.28323A-100000@dstl.gov.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-asqFefW2nfMW7q/Nq35a"
Organization: 
Message-Id: <1044352722.18392.6.camel@syntax.dstl.gov.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 04 Feb 2003 09:58:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-asqFefW2nfMW7q/Nq35a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-02-03 at 21:04, Bill Davidsen wrote:
>=20
> That is a problem with processes left running. I do not forward
> connections, I do not forward X, I do not (in normal practice) leave
> anything running. A typical thing to do is to go to each machine in a
> cluster and look for a user activity:
>   grep "user" log/stats.readers
>   exit
> nothing more. And every once in a while that hangs after executing the
> logout sequence. With the patch it hasn't to date.
>=20
> That doesn't mean it's a fix, I don't see it every day, I just haven't
> seen it in a few days since I put in the patch.

The ssh hang on exit "problem" is a policy of the ssh coders. It'll
happen when you have a background job still running when you exit, which
is still connected to the terminal.

As I said, it's an ssh policy issue (which many people disagree with)
and not a bug.

-tony


--=-asqFefW2nfMW7q/Nq35a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQCVAwUAPj+O0h/0GZs/Z0FlAQKbkgQAzRglvGGrNxRdod0gWhs93eYFG3KwkJ/a
LkJ9HoxAhItOcLXQOyuarJHooq44ME9Ym3Q3N2FpjFVsbrVi+/DIh2hQlF9QW/f5
PyjZIYQRBsebLm/U9uI9wqPfqaNM6jC8ulU1cRQfrYJ9CkIKhBhtbG1a7VuATgCi
S4eP/vovOx8=
=5H++
-----END PGP SIGNATURE-----

--=-asqFefW2nfMW7q/Nq35a--

