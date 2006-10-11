Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWJKSg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWJKSg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWJKSg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:36:56 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:30671 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751281AbWJKSgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:36:55 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC] Avoid PIT SMP lockups
Date: Wed, 11 Oct 2006 21:37:01 +0300
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
References: <1160170736.6140.31.camel@localhost.localdomain> <200610111349.32231.caglar@pardus.org.tr> <1160589556.5973.1.camel@localhost.localdomain>
In-Reply-To: <1160589556.5973.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1200356.elZ65ZtI46";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610112137.01160.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1200356.elZ65ZtI46
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

11 Eki 2006 =C3=87ar 20:59 tarihinde, john stultz =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> > Yep, [1] here is whole screen and used config, and as andi suggested i
> > recompiled this kernel [pure vanilla 2.6.18] from scratch.
> >
> > [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/
>
> Huh.. that's an odd trace.  Looks like the alternative code is involved.
>
> Mind booting w/ "noreplacement" to see if that avoids it?

Booting with "noreplacement" solved panics (i tried booting 10 times with b=
oth=20
kernel) for both vanilla one and yours patch included one.

By the way i just realize, panic occurs between

Checking if this processor honours the WP bit even in supervisor mode... Ok.

and

Calibrating delay using timer specific routine.. xxxxx BogoMIPS (lpj=3Dxxxx=
x)

lines, and system waits there about 5 sec. maybe more (no matter if it pani=
cs=20
or continues to boot somehow)

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1200356.elZ65ZtI46
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLTnNy7E6i0LKo6YRApjbAJ414siXVQN6j8eRk5TZ6vFHLZXrOACgihlY
FP+MkVwcKP1ZUOiyJ459rc0=
=KJbJ
-----END PGP SIGNATURE-----

--nextPart1200356.elZ65ZtI46--
