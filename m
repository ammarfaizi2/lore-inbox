Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTEVVHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTEVVHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:07:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4736 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263285AbTEVVHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:07:13 -0400
Subject: Re: 2.5.69-mm8
From: Paul Larson <plars@linuxtestproject.org>
To: Andrew Morton <akpm@digeo.com>
Cc: felipe_alfaro@linuxmail.org, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20030522131434.710a0c7d.akpm@digeo.com>
References: <20030522021652.6601ed2b.akpm@digeo.com>
	<1053629620.596.1.camel@teapot.felipe-alfaro.com>
	<1053631843.2648.3248.camel@plars>  <20030522131434.710a0c7d.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-5CkkLvCYSVkIlJfIr2yh"
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 May 2003 16:19:49 -0500
Message-Id: <1053638390.599.3318.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5CkkLvCYSVkIlJfIr2yh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-22 at 15:14, Andrew Morton wrote:
> Paul Larson <plars@linuxtestproject.org> wrote:
> >
> > 2.5.69-mm8 is bleeding for me. :)  See bugs #738 and #739.
>=20
> #739 seems to be the b_committed_data race.  Alex is cooking up a fix for
> that.  Sorry, I didn't realise it was that easy to trigger.
>=20
> I'm fairly amazed about #738.  The asertion at fs/jbd/transaction.c:2023
> (J_ASSERT_JH(jh, kernel_locked())) is bogus and should be removed.
Yep, a few quick tests suggest that #739 looks to be fixed by Alex's
patch, and it removes the assert from 2023, so if that's bogus then his
patch fixes that too.  I did see a hang with his patch and I wasn't able
to get any output or sysrq, so I'm going to go back and try with
nmi_watchdog to see if it'll tell me anything new.  I'm not sure if I
just didn't get far enough to see this without his patch, or if it comes
in the door with it though.  Also a few extra "sleeping function called
from illegal context" goodies on boot with it.  I'm going to get this
test kicked of right now but I'll be out until Tuesday so if it doesn't
show up again quickly I won't be seeing it until then.

Thanks,
Paul Larson

--=-5CkkLvCYSVkIlJfIr2yh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj7NPvQACgkQbkpggQiFDqdw8QCeOq2CQR5KTri6a2Q3mxQxSUsL
CScAn3opAXr7X+mh3Oykygmj6VKJBJOI
=SxW5
-----END PGP SIGNATURE-----

--=-5CkkLvCYSVkIlJfIr2yh--

