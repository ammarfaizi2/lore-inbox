Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130500AbRBWJeY>; Fri, 23 Feb 2001 04:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRBWJeQ>; Fri, 23 Feb 2001 04:34:16 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:40410 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130500AbRBWJeG>; Fri, 23 Feb 2001 04:34:06 -0500
Date: Fri, 23 Feb 2001 09:33:58 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Giacomo Catenazzi <cate@debian.org>
Cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 OOPS on parport loading [pci_register_driver] // parport slow
Message-ID: <20010223093358.C1147@redhat.com>
In-Reply-To: <3A96154F.8A791FF6@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A96154F.8A791FF6@debian.org>; from cate@debian.org on Fri, Feb 23, 2001 at 08:46:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2001 at 08:46:23AM +0100, Giacomo Catenazzi wrote:

> After writing the report, I disabled parport resources in BIOS
> and I maked:
>=20
> cate3:~# modprobe parport_pc
> Unable to handle kernel paging request at virtual address
> c3a5f640
>  printing eip:
> .....
> Segmentation fault
> cate3:~#

Please try 2.4.2-ac2, which should have a fix for this.

> In 2.4.x (and also in 2.3.x) the parport is slow!

Please describe what you mean here.  Is it consistently slow, or does
it print fine for a bit and then stall?

> cate3:~# cat /proc/interrupts

It is expected behaviour that the interrupt handler isn't registered
until you actually need it.  Print something and take a look at
/proc/ioports and you will see it.

Tim.
*/

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6li6FONXnILZ4yVIRAntGAJwI0eYd+Nx164DuFfKqlV5FALIOzwCcDTRb
F0DFQRP/sKADZlBcVhbZoE8=
=UjJ8
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
