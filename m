Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUJLQK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUJLQK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUJLQK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:10:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266048AbUJLQHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:07:49 -0400
Message-Id: <200410121607.i9CG7PsQ001076@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.9-rc4-mm1 Oops [2] 
In-Reply-To: Your message of "Tue, 12 Oct 2004 11:39:11 +0200."
             <877jpwi8cg.fsf@barad-dur.crans.org> 
From: Valdis.Kletnieks@vt.edu
References: <416B9517.7010708@blueyonder.co.uk>
            <877jpwi8cg.fsf@barad-dur.crans.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1229272470P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Oct 2004 12:07:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1229272470P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Oct 2004 11:39:11 +0200, Mathieu Segaud said:
> Sid Boyce <sboyce=40blueyonder.co.uk> disait derni=E8rement que :
>=20
> > This one on attempting to start firefox.
> > Regards
> > Sid.
>=20
> about the 2 reports you made about oopses, try this
> cd /path/to/your/kernel/source
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.=
9-rc4/
2.6.9-rc4-mm1/nroken-out/optimize-profile-path-slightly.patch
> patch -R -p1 -i optimize-profile-path-slightly.patch

I started seeing the same problem on -rc4-mm1, and couldn't figure out wh=
y
I didn't see it on -rc3-mm3.  Finally figured out that it was because the=

-rc3-mm3 had a -VP patch on it, and the -rc4-mm1 didn't (because of the
UP build problems in -T5).  Ingo's patch also reverts that patch, so I go=
t
the fix 'free of charge'....

Ingo: Was that intentional, or it just happened?

--==_Exmh_-1229272470P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBbAE5cC3lWbTT17ARAsB8AJ0dKuIzamqc88UrOIEOuFKXYiF0cQCfUbvN
ALHFKmCrcvXxlPKH2/1/Yl8=
=GpJD
-----END PGP SIGNATURE-----

--==_Exmh_-1229272470P--
