Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTFKEwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 00:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTFKEwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 00:52:08 -0400
Received: from [61.95.53.28] ([61.95.53.28]:44298 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S264143AbTFKEwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 00:52:05 -0400
Date: Wed, 11 Jun 2003 15:05:40 +1000
From: Simon Fowler <simon@himi.org>
To: Andrew Morton <akpm@digeo.com>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-ID: <20030611050540.GD2852@himi.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	jsimmons@infradead.org, linux-kernel@vger.kernel.org
References: <20030610061654.GB25390@himi.org> <20030610130204.GC27768@himi.org> <20030610141440.26fad221.akpm@digeo.com> <20030611021926.GA2241@himi.org> <20030610201641.220a4927.akpm@digeo.com> <20030611035525.GB2852@himi.org> <20030610211607.2bb55b41.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <20030610211607.2bb55b41.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2003 at 09:16:07PM -0700, Andrew Morton wrote:
> Simon Fowler <simon@himi.org> wrote:
> >
> > > > >=20
> > > > > It might be worth reverting this chunk, see if that fixes it:
> > > > >=20
> > > > > --- b/drivers/char/mem.c        Thu Jun  5 23:36:40 2003
> > > > > +++ b/drivers/char/mem.c        Sun Jun  8 05:02:24 2003
> > > > > @@ -716 +716 @@
> > > > > -__initcall(chr_dev_init);
> > > > > +subsys_initcall(chr_dev_init);
> > > > >=20
> > > > And we have a winner . . . Reverting this hunk fixes the oops.
> > > >=20
<snippage>=20
> Thanks for testing.
>=20
> All the initcall ordering of chardevs versus pci, pci versus pci and who
> knows what else is all bollixed up.
>=20
> Unfortunately I do not have the bandwidth to work on this.

Since this seems to be a showstopper for people using radeonfb,
getting the 'fix' above in might be a good idea . . .

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5rijQPlfmRRKmRwRAqyVAKCdLP0taSrZhVDMB9Ne/0pfKrPZlwCffF3K
vIgeSQ4dbvoE1mnoEnZFyaY=
=xgHP
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
