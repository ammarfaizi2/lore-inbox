Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbUCUJxH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 04:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUCUJxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 04:53:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263622AbUCUJxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 04:53:03 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Jaroslav Kysela <perex@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040320235445.B24744@flint.arm.linux.org.uk>
References: <20040320133025.GH9009@dualathlon.random>
	 <20040320144022.GC2045@holomorphy.com>
	 <20040320150621.GO9009@dualathlon.random>
	 <20040320154419.A6726@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz>
	 <20040320160911.B6726@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz>
	 <20040320222341.J6726@flint.arm.linux.org.uk>
	 <20040320224518.GQ2045@holomorphy.com>
	 <20040320235445.B24744@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zRNBk9vpxNtFyjDZzajk"
Organization: Red Hat, Inc.
Message-Id: <1079862762.5295.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 21 Mar 2004 10:52:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zRNBk9vpxNtFyjDZzajk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-03-21 at 00:54, Russell King wrote:
> On Sat, Mar 20, 2004 at 02:45:18PM -0800, William Lee Irwin III wrote:
> > Is there any possibility of an extension to remap_area_pages() that
> > could resolve this? I can't say I fully understood and/or remember
> > the issue with it that you pointed out.
>=20
> The issues are:
>=20
> 1. ALSA wants to mmap the buffer used to transfer data to/from the
>    card into user space.  This buffer may be direct-mapped RAM,
>    memory allocated via dma_alloc_coherent(), an on-device buffer,
>    or anything else.


fwiw an ideal DRI/DRM driver would do the same with the video cards
ringbuffer so the problem isn't unique to alsa, it's a generic issue.

--=-zRNBk9vpxNtFyjDZzajk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAXWXqxULwo51rQBIRAocUAJ968lq4qmQmBh9L0mKOOlEhYhPKNwCfSqdn
kf+Cbklza8rEKvDbZkOmJGM=
=Slyb
-----END PGP SIGNATURE-----

--=-zRNBk9vpxNtFyjDZzajk--

