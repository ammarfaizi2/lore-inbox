Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTEVNwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 09:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTEVNwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 09:52:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10112 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261868AbTEVNwl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 09:52:41 -0400
Message-Id: <200305221405.h4ME5aKx003125@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Disallow compilation with gcc 3.2.3 (was: Re: 2.5.69-mm6: pccard oops while booting:) 
In-Reply-To: Your message of "Thu, 22 May 2003 15:24:06 +0200."
             <3ECCCF76.3020800@gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com> <20030514191735.6fe0998c.akpm@digeo.com> <1052998601.726.1.camel@teapot.felipe-alfaro.com> <20030515130019.B30619@flint.arm.linux.org.uk> <1053004615.586.2.camel@teapot.felipe-alfaro.com> <20030515144439.A31491@flint.arm.linux.org.uk> <1053037915.569.2.camel@teapot.felipe-alfaro.com> <20030515160015.5dfea63f.akpm@digeo.com> <1053090184.653.0.camel@teapot.felipe-alfaro.com> <1053110098.648.1.camel@teapot.felipe-alfaro.com> <20030516132908.62e54266.akpm@digeo.com> <1053121346.569.1.camel@teapot.felipe-alfaro.com> <3EC56173.1000306@gmx.net> <1053166275.586.9.camel@teapot.felipe-alfaro.com> <20030517031840.486683fc.akpm@digeo.com> <1053169552.613.1.camel@teapot.felipe-alfaro.com> <3EC61B63.9020906@gmx.net> <1053175886.660.4.camel@teapot.felipe-alfaro.com> <1053286732.812.5.camel@teapot.felipe-alfaro.com>
            <3ECCCF76.3020800@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-104199101P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 May 2003 10:05:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-104199101P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 22 May 2003 15:24:06 +0200, Carl-Daniel Hailfinger said:

> Nobody has found an error in the code we talked about, so a compiler bu=
g
> in gcc 3.2.3 seems to be the only explanation.

In the last 20 years, I've come across lots of cases where optimizers did=

foolish things that broke code.  I've also come across the odd case or th=
ree
where the optimizer merely exposed a bug.  Favorite cases here are where
the optimizer removes what it thinks is a dead/redundant load/store, and
exposes a race condition on a variable that should have been 'volatile' b=
ut
wasn't, odd corner cases where sequence points actually matter (one of th=
ese was
just posted here the other day, in fact)... stuff like that.

So yes.  It's probably something borked in gcc 3.2.3 - but we probably wo=
n't
know for sure till somebody goes over the assembler output with a fine to=
oth
comb...

--==_Exmh_-104199101P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+zNkvcC3lWbTT17ARAuX0AJ0foGS95xmrR8uRQRFV78Rr69MtxQCgsJ9Y
f1OA9coczD/e9Sic46OHFR4=
=SwSV
-----END PGP SIGNATURE-----

--==_Exmh_-104199101P--
