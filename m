Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbULGXbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbULGXbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbULGXbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:31:34 -0500
Received: from mout1.freenet.de ([194.97.50.132]:23271 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261952AbULGXbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:31:31 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH, RFC] protect call to set_tsk_need_resched() by the rq-lock
Date: Wed, 8 Dec 2004 00:30:58 +0100
User-Agent: KMail/1.7.1
References: <200412062339.52695.mbuesch@freenet.de> <20041207131006.GB3710@elte.hu>
In-Reply-To: <20041207131006.GB3710@elte.hu>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, kernel@kolivas.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1451247.fII86qRS4U";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412080031.08490.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1451247.fII86qRS4U
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Ingo Molnar <mingo@elte.hu>:
>=20
> * Michael Buesch <mbuesch@freenet.de> wrote:
>=20
> > The two attached patches (one against vanilla kernel and one against
> > ck patchset) moves the rq-lock a few lines up in scheduler_tick() to
> > also protect set_tsk_need_resched().
> >=20
> > Is that neccessary?
>=20
> scheduler_tick() is a special case,


> 'current' is pinned and cannot go=20
> away, nor can it get off the runqueue.
Can you explain in short, why this is the case, please?
I don't really get behind it.
How are the two things enforced?

> So the patch is not needed.=20
>=20
>  Ingo

Thanks.

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart1451247.fII86qRS4U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtj08FGK1OIvVOP4RAs8oAKCbZEGpKMmLzaW7AhCMJfYXP+X92ACePgWr
6LHTIfAFE/LoHc/Z/CnBk7s=
=p9Sv
-----END PGP SIGNATURE-----

--nextPart1451247.fII86qRS4U--
