Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbTJ1Rd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTJ1Rd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:33:58 -0500
Received: from h80ad275b.async.vt.edu ([128.173.39.91]:25493 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264048AbTJ1Rdy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:33:54 -0500
Message-Id: <200310281733.h9SHXfxF028624@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup 
In-Reply-To: Your message of "Tue, 28 Oct 2003 17:51:48 +0100."
             <yw1xy8v54863.fsf@kth.se> 
From: Valdis.Kletnieks@vt.edu
References: <3F9E707B.7030609@freemail.hu> <Pine.LNX.4.53.0310280936550.20004@chaos> <200310281539.h9SFdixF024951@turing-police.cc.vt.edu> <Pine.LNX.4.53.0310281048130.21561@chaos> <200310281637.h9SGb5xF026894@turing-police.cc.vt.edu>
            <yw1xy8v54863.fsf@kth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1071259582P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Oct 2003 12:33:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1071259582P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2003 17:51:48 +0100, mru@kth.se (=3D?iso-8859-1?q?M=3DE5ns=
_Rullg=3DE5rd?=3D)  said:

> Doing that mistake would give a linker error.

Not necessarily.  Consider shared libraries.  Load module1.so, load modul=
e2.so,
and then load module3.so that has an unresolved reference that both of th=
e
other two happen to have. Oh wow.. results that are dependent on the orde=
r of
-l flags in a non-obvious way...  And '-z muldefs' is always a good way t=
o
shoot yourself in the foot.....

Yes, it's stupid, yes, it's a mistake - my point is that the design of C =
makes that
sort of mistake more likely.  If there *did* exist a "private to all the =
pieces of the
module" status similar to the "private to THIS .c 'static'", it wouldn't =
be anywhere
near the problem.

And don't tell me that the Linux kernel hasn't seen similar issues - a su=
pposedly
private interface that didn't have 'static' because it *was* called from =
2 other
=2Ec files in the directory.  And then we have to tell people "don't call=
 that interface,
it's private".

--==_Exmh_1071259582P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/nqh1cC3lWbTT17ARAr4LAKDWxFj3pd8s4IaOjmomRjO5fWGBrgCg2uRX
s2zT0E/MsFamKhCX7L7nylM=
=wR2b
-----END PGP SIGNATURE-----

--==_Exmh_1071259582P--
