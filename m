Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSK0UR3>; Wed, 27 Nov 2002 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSK0UR3>; Wed, 27 Nov 2002 15:17:29 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:60243 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S264733AbSK0UR2>;
	Wed, 27 Nov 2002 15:17:28 -0500
Date: Wed, 27 Nov 2002 21:24:42 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.49-mm2
Message-ID: <20021127212442.B8411@jaquet.dk>
References: <3DE48C4A.98979F0C@digeo.com> <20021127210153.A8411@jaquet.dk> <3DE526FC.3D78DB54@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DE526FC.3D78DB54@digeo.com>; from akpm@digeo.com on Wed, Nov 27, 2002 at 12:11:40PM -0800
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2002 at 12:11:40PM -0800, Andrew Morton wrote:
> > Debug: Sleeping function called from illegal context at include/
> > linux/rwsem.h:66
> > Call Trace: __might_sleep+0x54/0x58
> >            sys_mprotect+0x97/0x22b
> >            syscall_call+0x7/0xb
>=20
> Oh that's cute.  Looks like we've accidentally disabled preemption
> somewhere...
>=20
> > Unable to handle kernel paging request at virtual address 4001360c
>=20
> And once you do that, the pagefault handler won't handle pagefaults.
> =20
> > (I did not copy the rest but can reproduce at will.)
>=20
> Please do.  And tell how you're making it happen.

I'm booting my debian testing system, going into kdm.
Various versions as per my last mail.

Does your 'Please do' mean that you would like the rest of
oops?

> Is that .config still current?

The .config used for -mm2 is at www.jaquet.dk/kernel/config-2.5.49-mm2

> Does it go away if you turn off preemption?

I'll test that right away.

Regards,=20
  Rasmus

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE95SoKlZJASZ6eJs4RAptAAJ41wNpu8Tw73QRdJ6hMN6CAACfh2gCfZ7Io
M8i2lZl2zmRMUBYKVQGjsfE=
=k7Bt
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
