Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWBKUcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWBKUcE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBKUcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:32:04 -0500
Received: from mh57.de ([217.160.165.8]:3538 "EHLO lamedon.mh57.de")
	by vger.kernel.org with ESMTP id S932355AbWBKUcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:32:03 -0500
Date: Sat, 11 Feb 2006 21:31:58 +0100
From: Martin Hermanowski <lkml@martin.mh57.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc2-mm1
Message-ID: <20060211203158.GA9020@mh57.de>
References: <20060207220627.345107c3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20060207220627.345107c3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::57
X-Spam-Score: -2.8 (--)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

2.6.16-rc2-mm1 is running fine on my IBM notebook, but the hdaps module
(acceleration sensor) does not work like I expected:

,----[ modprobe hdaps ]
| Feb 11 21:24:26 nimrais kernel: hdaps: inverting axis readings.
| Feb 11 21:24:26 nimrais kernel: hdaps: IBM ThinkPad T41p detected.
| Feb 11 21:24:26 nimrais kernel: hdaps: driver successfully loaded.
`----

AFAIK the module should create sysfs files in
/sys/devices/platform/hdaps/, but I see only `bus', `power' and
`uevent'.

When unloading the hdaps module, I get a BUG:

,----[ rmmod hdaps ]
| Feb 11 21:24:49 nimrais kernel:  <c011d8b6> release_resource+0x76/0x80 <c=
0265bf4> platform_device_del+0x44/0x60
| Feb 11 21:24:49 nimrais kernel:  <c0265c18> platform_device_unregister+0x=
8/0x10   <f9b9c8ed> hdaps_exit+0xd/0x25 [hdaps]
| Feb 11 21:24:49 nimrais kernel:  <f9b9c8e0> hdaps_exit+0x0/0x25 [hdaps] <=
c0132e05> sys_delete_module+0x145/0x1c0
| Feb 11 21:24:49 nimrais kernel:  <c0149901> remove_vma+0x41/0x50 <c014ab5=
7> do_munmap+0x1a7/0x200
| Feb 11 21:24:49 nimrais kernel:  <c0102d91> syscall_call+0x7/0xb =20
| Feb 11 21:24:49 nimrais kernel: hdaps: driver unloaded.
`----

Do you need more information?

--=20
Martin Hermanowski
http://mh57.de/martin

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7km+mGb6Npij0ewRAnpzAJ0ZR3hEqB1swe3kuA2ipViaXC96WQCgm/J3
8BU8ZKT3pQZSjXrH5EABOJU=
=B1dx
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
