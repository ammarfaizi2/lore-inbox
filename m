Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUALTkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 14:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266206AbUALTkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 14:40:18 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:41906 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S266177AbUALTkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 14:40:05 -0500
Subject: Bug found (Was: Re: Nick's scheduler v19a)
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Timothy Miller <miller@techsource.com>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FBE3B0D.8030501@techsource.com>
References: <3FB62608.4010708@cyberone.com.au>
	 <1069361130.13479.12.camel@midux> <3FBD4F6E.3030906@cyberone.com.au>
	 <1069395102.16807.11.camel@midux> <3FBDAE99.9050902@cyberone.com.au>
	 <1069405566.18362.5.camel@midux> <3FBDD790.5060401@cyberone.com.au>
	 <1069407179.18505.11.camel@midux>  <yw1xy8uaujv0.fsf@kth.se>
	 <1069410094.18790.2.camel@midux>  <3FBE3B0D.8030501@techsource.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s/4ZpCVk6AvmbjbTRoFY"
Message-Id: <1073936402.3523.2.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 21:40:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s/4ZpCVk6AvmbjbTRoFY
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-11-21 at 18:19, Timothy Miller wrote:
> Are you interested only in the performance of your own computer, or do=20
> you have any interest in the performance of other people's computers as=20
> well?
>=20
> If there's a bug, there's a bug, and you've identified it.  Contrary to=20
> the attitude of our friends in Redmond, the open source community tends=20
> to see bugs as being really evil.  If you've found a bug, we want to=20
> investigate it and fix it.
FYI:
Badness in pci_find_subsys at drivers/pci/search.c:132
Call Trace:
 [<c024ef38>] pci_find_subsys+0xe8/0xf0
 [<c024ef6f>] pci_find_device+0x2f/0x40
 [<c024ee28>] pci_find_slot+0x28/0x50
 [<f9e21099>] os_pci_init_handle+0x39/0x70 [nvidia]
 [<f9cb586f>] _nv001243rm+0x1f/0x24 [nvidia]
 [<f9dfc095>] _nv000816rm+0x2f5/0x384 [nvidia]
 [<f9d648ac>] _nv003801rm+0xd8/0x100 [nvidia]
 [<f9dfbbcf>] _nv000809rm+0x2f/0x34 [nvidia]
 [<f9d656d0>] _nv003816rm+0xf0/0x104 [nvidia]
 [<f9d63f8e>] _nv003795rm+0x6ea/0xaec [nvidia]
 [<f9cce277>] _nv004046rm+0x3a3/0x3b0 [nvidia]
 [<f9dcfb27>] _nv001476rm+0x277/0x45c [nvidia]
 [<f9cb83aa>] _nv000896rm+0x4a/0x64 [nvidia]
 [<f9cb9bc4>] rm_isr_bh+0xc/0x10 [nvidia]
 [<c0123df6>] tasklet_action+0x46/0x70
 [<c0123c10>] do_softirq+0x90/0xa0
 [<c010d22d>] do_IRQ+0xfd/0x130
 [<c010b574>] common_interrupt+0x18/0x20

Badness in pci_find_subsys at drivers/pci/search.c:132
Call Trace:
 [<c024ef38>] pci_find_subsys+0xe8/0xf0
 [<c024ef6f>] pci_find_device+0x2f/0x40
 [<c024ee28>] pci_find_slot+0x28/0x50
 [<f9e21099>] os_pci_init_handle+0x39/0x70 [nvidia]
 [<f9cb586f>] _nv001243rm+0x1f/0x24 [nvidia]
 [<f9d669dd>] _nv003797rm+0xa9/0x128 [nvidia]
 [<f9dd3421>] _nv001490rm+0x55/0xe4 [nvidia]
 [<f9dfc0d4>] _nv000816rm+0x334/0x384 [nvidia]
 [<f9d648ac>] _nv003801rm+0xd8/0x100 [nvidia]
 [<f9dfbbcf>] _nv000809rm+0x2f/0x34 [nvidia]
 [<f9d656d0>] _nv003816rm+0xf0/0x104 [nvidia]
 [<f9d63f8e>] _nv003795rm+0x6ea/0xaec [nvidia]
 [<f9cce277>] _nv004046rm+0x3a3/0x3b0 [nvidia]
 [<f9dcfb27>] _nv001476rm+0x277/0x45c [nvidia]
 [<f9cb83aa>] _nv000896rm+0x4a/0x64 [nvidia]
 [<f9cb9bc4>] rm_isr_bh+0xc/0x10 [nvidia]
 [<c0123df6>] tasklet_action+0x46/0x70
 [<c0123c10>] do_softirq+0x90/0xa0
 [<c010d22d>] do_IRQ+0xfd/0x130
 [<c010b574>] common_interrupt+0x18/0x20

As I said, it is nvidia.
(Sorry for the long respond time but I got somekind of debug information
just now...)
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-s/4ZpCVk6AvmbjbTRoFY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAvgR3+NhIWS1JHARArIxAKCHUhsTyFYOo1mNf6at23/4pmhQNQCg0pJq
/MLLn2BqWH1ERabzzzQK2Xw=
=XZUE
-----END PGP SIGNATURE-----

--=-s/4ZpCVk6AvmbjbTRoFY--

