Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUHFDMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUHFDMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUHFDMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:12:22 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:3256 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S265222AbUHFDMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:12:13 -0400
Date: Thu, 5 Aug 2004 21:03:13 -0500
From: Michael Halcrow <lkml@halcrow.us>
To: James Morris <jmorris@redhat.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>,
       "David S. Miller" <davem@redhat.com>, cryptoapi@lists.logix.cz,
       Michal Ludvig <mludvig@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
Message-ID: <20040806020313.GA21309@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20040805194914.GC23994@certainkey.com> <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 05, 2004 at 10:47:12PM -0400, James Morris wrote:
> On Thu, 5 Aug 2004, Jean-Luc Cooke wrote:
>=20
> > Would you be against a patch to cryptoapi to have access to a
> > non-scatter-list set of calls?
> >=20
> > I know a few people would like to see that , and I would also like to u=
se
> > some low-level:
> >=20
> > crypto_digest_update_byte(struct digest_alg *digest,
> >                           unsigned char *buf,
> >                           unsigned int  nbytes);
> > crypto_cipher_encrypt_byte(struct cipher_alg *cipher,
> >                            unsigned char *dst,
> >                            unsigned char *src,
> >                            unsigned int  nbytes);
> >=20
> > I'm in the middle of preparing for a paper and would like to get code r=
unning
> > without scatterlists.
>=20
> The idea of the scatterlist API is to encourage encryption at the
> page level.  Can you demonstrate a compelling need for raw access to
> the algorithms via the API?

I often have a virtual address to work with in the first place, and
the data that I hash usually occupies less than one page (passphrases,
keys, etc.).

Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D
--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBEubhLTz92j62YB0RAjYsAKCEMIvxsqd0rmyn/1p2GqgPLrmoYQCg8AbW
zKBVzxLbeo6HqeQL2+vXtHw=
=fMAE
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
