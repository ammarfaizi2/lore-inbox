Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTFPLzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 07:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTFPLzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 07:55:31 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:53202 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263775AbTFPLza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 07:55:30 -0400
Date: Mon, 16 Jun 2003 16:09:12 +0400
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq consolidation
Message-ID: <20030616120912.GA11652@pazke>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
References: <20030607040515.GB28914@krispykreme> <20030607044803.GE28914@krispykreme> <20030607101848.A22665@flint.arm.linux.org.uk> <20030612113405.GH1195@krispykreme>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20030612113405.GH1195@krispykreme>
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 163, 06 12, 2003 at 09:34:06PM +1000, Anton Blanchard wrote:
>=20
> > I believe Andrey's IRQ consolidation provides a single flat IRQ
> > structure.  Unfortunately, this doesn't reflect the reality that we
> > have on many ARM platforms - it remains the case that we need to
> > decode IRQs on a multi-level basis.
>=20
> Yes its still a flat structure. On ppc32/64 we offset the interrupts on
> the main controller to provide a space for ISA interrupts to go. Not
> great but it works for us.

May be I missed the point, but it isn't flat.

You can define HAVE_ARCH_IRQ_DESC and provide your own irq_desc(irq)
function which will translate irq number to the corresponding=20
irq_desc_t structure. You are free to implement any irq mappings
behind the irq_desc(). NR_IRQS is used only as maximal irq number.
So what is the problem ?
=20
> One thing Paul suggested was to have a flag to mark an interrupt as a
> cascade in the irq descriptor. If its set then we also provide a
> get_irq() method (perhaps stashed away in the ->action field). That gives
> us nested interrupt handling in generic code. (assuming you can
> partition your irq numbers somehow)
>=20
> Anton

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7bNoby9O0+A2ZecRAsA5AKCA4rJBVWpl/AaDcBfCtarpmsMsWACfQgPP
1HAQ/x5TKmDhxbN+Nzbm9r8=
=Z0Wk
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
