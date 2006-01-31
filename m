Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWAaK24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWAaK24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWAaK24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:28:56 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:27046 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750742AbWAaK2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:28:55 -0500
Date: Tue, 31 Jan 2006 11:28:52 +0100
From: Harald Welte <laforge@netfilter.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Linux Netdev List <netdev@vger.kernel.org>
Subject: Re: ip_conntrack related slab error (Re: Fw: Re: 2.6.16-rc1-mm3)
Message-ID: <20060131102852.GV4603@sunbeam.de.gnumonks.org>
References: <20060130221429.5f12d947.akpm@osdl.org> <20060131092447.GL4603@sunbeam.de.gnumonks.org> <43DF3677.8040701@reub.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tWRTUBMosAF2WQf4"
Content-Disposition: inline
In-Reply-To: <43DF3677.8040701@reub.net>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tWRTUBMosAF2WQf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2006 at 11:05:43PM +1300, Reuben Farrelly wrote:

> >>slab error in kmem_cache_destroy(): cache `ip_conntrack': Can't free al=
l objects
> >>  [<b010412b>] show_trace+0xd/0xf
> >>  [<b01041cc>] dump_stack+0x17/0x19
> >>  [<b0155d04>] kmem_cache_destroy+0x9b/0x1a9
> >>  [<f0ebf701>] ip_conntrack_cleanup+0x5d/0x10e [ip_conntrack]
> >>  [<f0ebe31e>] init_or_cleanup+0x1f8/0x283 [ip_conntrack]
> >>  [<f0ec2c4e>] fini+0xa/0x66 [ip_conntrack]
> >>  [<b0136d06>] sys_delete_module+0x161/0x1fb
> >>  [<b0102b3f>] sysenter_past_esp+0x54/0x75
> >>Removing netfilter NETLINK layer.
> >>[root@tornado log]#
> >>I was just reading IMAP mail at the time, ie same as I'd been doing for=
 an hour or two beforehand and not=20
> >>altering config of the box in any way.  I was able to log on via consol=
e but lost all network connectivity and=20
> >>had to reboot :(
> >The codepath you see in that backtrace is only hit during load or
> >removal of the 'ip_conntrack' module.  While this certainly still should
> >not oops, your description of 'not doing anything but IMAP reading' is
> >certainly not true. =20
>=20
> With the greatest of respect (which I do have for you Harald), I don't
> think being essentially called a liar is very fair.

I didn't want to imply that you are lying, but merely point out that
something was going on on your system that you didn't be aware of.

Sorry if that was to be misunderstood.

Without knowing what actually happened at the time you encountered the
bug, it is hard for me to try and reproduce / understand it.

This is not a lame excuse.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--tWRTUBMosAF2WQf4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD3zvkXaXGVTD0i/8RAhA1AKCxE/aFmCfpCURTvDJrUh4ZGWrd0gCfUAp6
hkco6uCZK4UVkPMdaRO7zrA=
=l9sR
-----END PGP SIGNATURE-----

--tWRTUBMosAF2WQf4--
