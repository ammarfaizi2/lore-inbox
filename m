Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbUKXAqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbUKXAqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUKXApe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:45:34 -0500
Received: from dreamcraft.com.au ([202.55.152.18]:44930 "EHLO
	dreamcraft.com.au") by vger.kernel.org with ESMTP id S261391AbUKXAkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:40:45 -0500
Date: Wed, 24 Nov 2004 11:40:37 +1100
From: Simon Fowler <simon@himi.org>
To: Roger Luethi <rl@hellgate.ch>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] visor: Don't count outstanding URBs twice
Message-ID: <20041124004037.GA4954@himi.org>
Mail-Followup-To: Roger Luethi <rl@hellgate.ch>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041123193604.GA12605@k3.hellgate.ch> <20041123194557.GB1196@kroah.com> <20041123203023.GA13663@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20041123203023.GA13663@k3.hellgate.ch>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2004 at 09:30:23PM +0100, Roger Luethi wrote:
> On Tue, 23 Nov 2004 11:45:58 -0800, Greg KH wrote:
> > Your email client is putting headers in the messages that say not to do
> > this.  Please fix your client :)
>=20
> D'oh! Fixed (I think).
>=20
> > But I'm not seeing people actually hit the write limit, according to the
> > logs that people are posting.
>=20
> What I found is bound to cause exactly the kind of problem Simon
> described, so I didn't check any further. _But_ comparing his log and
> the code, I can't help but notice that the missing "write limit hit"
> is the only instance of a dev_dbg in this driver. Coincidence?
>=20
> Roger
>=20
Your extra patch has fixed the problem - I was able to do a full
sync with it.

Greg: your suggestion of backing visor.c out to an earlier working
version made all sorts of badness happen - I can get you the logs if
you want, but I assume since Roger's patches fix the problem you
don't care about it any more . . .

Thanks for the prompt fix!

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBo9iFQPlfmRRKmRwRApFDAJ9jZ47tWhXpomIrUC+1mhRjPPiSgwCZAZQd
HUnVzweeYDDeaXErBrVOelg=
=ckYX
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
