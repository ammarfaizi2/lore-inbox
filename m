Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUE3M2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUE3M2p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUE3M2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:28:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263389AbUE3M2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:28:42 -0400
Subject: Re: [PATCH] ppc32: reorg DMA API, add coherent alloc in irq
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: akpm@osdl.org, torvalds@osdl.org, mporter@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200405291908.i4TJ8a5l011479@hera.kernel.org>
References: <200405291908.i4TJ8a5l011479@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6119RzQ9kNXxG2xNMS05"
Organization: Red Hat UK
Message-Id: <1085920115.6882.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 30 May 2004 14:28:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6119RzQ9kNXxG2xNMS05
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-05-29 at 19:56, Linux Kernel Mailing List wrote:
> ChangeSet 1.1770, 2004/05/29 10:56:14-07:00, akpm@osdl.org
>=20
> 	[PATCH] ppc32: reorg DMA API, add coherent alloc in irq
> =09
> 	From: Matt Porter <mporter@kernel.crashing.org>

this breaks the acenic driver:

In file included from drivers/net/acenic.c:186:
drivers/net/acenic.h:598: error: syntax error before
"DECLARE_PCI_UNMAP_ADDR"
drivers/net/acenic.h:598: warning: no semicolon at end of struct or
union
drivers/net/acenic.h:609: error: syntax error before
"DECLARE_PCI_UNMAP_ADDR"
drivers/net/acenic.h:609: warning: no semicolon at end of struct or
union
drivers/net/acenic.h:621: error: field `tx_skbuff' has incomplete type
drivers/net/acenic.h:622: error: field `rx_std_skbuff' has incomplete
type
drivers/net/acenic.h:623: error: field `rx_mini_skbuff' has incomplete
type
drivers/net/acenic.h:624: error: field `rx_jumbo_skbuff' has incomplete
type
drivers/net/acenic.c: In function `acenic_remove_one':
drivers/net/acenic.c:667: warning: implicit declaration of function
`pci_unmap_addr'
drivers/net/acenic.c: In function `ace_load_std_rx_ring':
drivers/net/acenic.c:1704: warning: implicit declaration of function
`pci_unmap_addr_set'
drivers/net/acenic.c: In function `ace_rx_int':
drivers/net/acenic.c:2036: error: dereferencing pointer to incomplete
type
drivers/net/acenic.c:2037: error: dereferencing pointer to incomplete
type
drivers/net/acenic.c:2039: error: `mapping' undeclared (first use in
this function)
drivers/net/acenic.c:2039: error: (Each undeclared identifier is
reported only once
drivers/net/acenic.c:2039: error: for each function it appears in.)
drivers/net/acenic.c: In function `ace_tx_int':


... etc ...

--=-6119RzQ9kNXxG2xNMS05
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAudNyxULwo51rQBIRAm/5AJ44t3IPJNP3LREZrstmCuVOQ/sq6gCaAo5S
twPVSgTuSqhg7g7axU4cMFY=
=w/Qu
-----END PGP SIGNATURE-----

--=-6119RzQ9kNXxG2xNMS05--

