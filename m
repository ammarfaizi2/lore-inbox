Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUF1Xwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUF1Xwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUF1Xwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:52:53 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:60307 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S265170AbUF1Xwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:52:49 -0400
Date: Mon, 28 Jun 2004 16:52:34 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, Scott Wood <scott@timesys.com>,
       oliver@neukum.org, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040628235234.GD8502@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	"David S. Miller" <davem@redhat.com>,
	Scott Wood <scott@timesys.com>, oliver@neukum.org, greg@kroah.com,
	arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
	linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
	david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270631.41102.oliver@neukum.org> <20040626233423.7d4c1189.davem@redhat.com> <200406271242.22490.oliver@neukum.org> <20040627142628.34b60c82.davem@redhat.com> <20040628141517.GA4311@yoda.timesys> <20040628132531.036281b0.davem@redhat.com> <20040628205058.GB8502@one-eyed-alien.net> <20040628140157.5813bc73@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <20040628140157.5813bc73@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2004 at 02:01:57PM -0700, Pete Zaitcev wrote:
> On Mon, 28 Jun 2004 13:50:58 -0700
> Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
>=20
> > > 	struct txd {
> > > 		u32 dma_addr;
> > > 		u32 length;
> > > 	};
> > >=20
> > > It is just total and utter madness to put a packed or the proposed
> > > __nopadding__ attribute on that structure.  Yet this seems to be
> > > what was suggested now and at the beginning of this thread.
> >=20
> > I guess, in the end, what this comes down to is the fact that we're all
> > going to get bitten on the ass when we finally get to a platform where =
the
> > default alignment is 64-bits, which would then (by default) add padding=
 to
> > the above structure.
> >=20
> > How long until that time comes?  Likely within my lifetime, and I'd rat=
her
> > not have to re-write working code into more working code because I coul=
dn't
> > express to the compiler what I needed it to do.
>=20
> I, for one, am not engaging into such flights of fancy as a platform
> with larger than natural alignment requirements. Would you even read
> what you're writing? The whole freaking world abandons silly platforms
> and moves to x86 extensions and you're fantasizing about a return
> to Cray-1. It just ain't happening!

Actually, I've been working with a controller for the last several months
(the "latest and greatest", state-of-the-art technology), which can only to
loads/stores in 64-byte units at a minimum.

Yes, I mean "byte".  128-bits wide * 4 DDR beats (2 dobule-edged clocks).
There are no DM pins on the memory interface, so any write less than that
size must be a read-modify-write.

And, I was just having a conversation with a compiler group which was
considering moving to 64-byte alignment as a speed optimization for this
platform, or at least 16-byte (64 bit), which also aligns well with the
native load/store of the CPU involved.

I only wish I was fantasizing about this.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

P:  Nine more messages in admin.policy.
M: I know, I'm typing as fast as I can!
					-- Pitr and Mike
User Friendly, 11/27/97

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA4K9CIjReC7bSPZARAqYaAKDCl+38Tw4oCvWNK+wb7OpmFYpfrQCgr7PJ
fAa747ZegmaR3Qe6U87+bik=
=NT30
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
