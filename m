Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279581AbRJXNfr>; Wed, 24 Oct 2001 09:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279572AbRJXNfg>; Wed, 24 Oct 2001 09:35:36 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:5620 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279576AbRJXNf2>; Wed, 24 Oct 2001 09:35:28 -0400
Date: Wed, 24 Oct 2001 14:36:01 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Dave Garry <daveg@firsdown.demon.co.uk>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
Message-ID: <20011024143601.M7544@redhat.com>
In-Reply-To: <3BD6BF43.D347719B@firsdown.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5YKxbtAlDq2FnV+Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD6BF43.D347719B@firsdown.demon.co.uk>; from daveg@firsdown.demon.co.uk on Wed, Oct 24, 2001 at 02:16:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5YKxbtAlDq2FnV+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2001 at 02:16:51PM +0100, Dave Garry wrote:

> With kernel 2.4.12 and 2.4.13 the parallel port on
> my machine looks like this according to dmesg:
>=20
> parport0: PC-style at 0x378 [PCSPP,TRISTATE]

Yes.  It's showing you what modes it is prepared to use.

> Under 2.4.10 is looks like this:
[...]
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]

A bug; it was showing you what modes the hardware was capable of,
_despite_ knowing that it wasn't going to use it.

The parport driver will only use ECP and parallel port FIFO modes if
it has an IRQ to use.  Try 'irq=3Dauto'.

Tim.
*/

--5YKxbtAlDq2FnV+Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE71sPAyaXy9qA00+cRAq8eAKCl1bz0UtUuRid4FDD8VQini/rqVwCgmABS
WbiHDrVTBm0Htpum08eZfZU=
=/jCc
-----END PGP SIGNATURE-----

--5YKxbtAlDq2FnV+Q--
