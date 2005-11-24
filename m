Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVKXJFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVKXJFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVKXJFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:05:17 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:42882 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750768AbVKXJFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:05:15 -0500
Date: Thu, 24 Nov 2005 10:04:58 +0100
From: Harald Welte <laforge@netfilter.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-ID: <20051124090457.GB31478@sunbeam.de.gnumonks.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <6bffcb0e0511230615y7531e268n@mail.gmail.com> <20051123112218.73f68926.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rnlqu3Le5Ibonik3"
Content-Disposition: inline
In-Reply-To: <20051123112218.73f68926.akpm@osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rnlqu3Le5Ibonik3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2005 at 11:22:18AM -0800, Andrew Morton wrote:
> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> >
> >  Debug: sleeping function called from invalid context at
> >  include/asm/semaphore.h:123
> >  in_atomic():1, irqs_disabled():0
> >   [<c0103be6>] dump_stack+0x17/0x19
> >   [<c011a0c3>] __might_sleep+0x9c/0xae
> >   [<fd9a090d>] translate_table+0x147/0xc14 [ip_tables]
> >   [<fd9a2b2a>] ipt_register_table+0x93/0x20d [ip_tables]
> >   [<f98fe027>] init+0x27/0x9e [iptable_filter]
> >   [<c01376d0>] sys_init_module+0xd7/0x26c
> >   [<c0102cc7>] sysenter_past_esp+0x54/0x75
> >  ---------------------------
> >  | preempt count: 00000001 ]
> >  | 1 level deep critical section nesting:
> >  ----------------------------------------
> >  .. [<fd9a2aca>] .... ipt_register_table+0x33/0x20d [ip_tables]
> >  .....[<f98fe027>] ..   ( <=3D init+0x27/0x9e [iptable_filter])
> >=20
>=20
> ipt_register_table() does get_cpu() then calls translate_table(), and
> somewhere under translate_table() we do something which sleeps, only I'm =
not
> sure what it is - netfilter likes to hide things in unexpected places.

I'll investigate this.  the get_cpu() scheme was introduced as a fix for
a different (less serious) problem. =20

You'll get a reply until later today.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--rnlqu3Le5Ibonik3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDhYI5XaXGVTD0i/8RAr57AJwMnfyvTxDyiQc1FV2KjYMX5ce8zACgn5X9
/bPL939wCbi1T0zeZ6UKhsI=
=p8cd
-----END PGP SIGNATURE-----

--rnlqu3Le5Ibonik3--
