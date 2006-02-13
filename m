Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWBMBHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWBMBHL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWBMBHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:07:07 -0500
Received: from nef2.ens.fr ([129.199.96.40]:16390 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751112AbWBMBHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:07:04 -0500
Date: Mon, 13 Feb 2006 02:07:01 +0100
From: Nicolas George <nicolas.george@ens.fr>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem for mobile hard drive
Message-ID: <20060213010701.GA8430@clipper.ens.fr>
References: <20060212150331.GA22442@clipper.ens.fr> <43EFD6E4.60601@cfl.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <43EFD6E4.60601@cfl.rr.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 13 Feb 2006 02:07:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le quartidi 24 pluvi=F4se, an CCXIV, Phillip Susi a =E9crit=A0:
> If by FAT you mean FAT16, then yes, you have an 8 GB limit for the=20
> entire filesystem.  Fat32 on the other hand, can handle much more and so=
=20
> should be suitable in this aspect.

According to Wikipedia, and what I knew besides, FAT32 has a limit of 2 To
for the whole filesystem. But the limit I was talking of is the file size
limit: 4 Go perfile. Which is, nowadays, a bit short: an ISO image for a
DVD-R does not fit, for example.

>				      Fragmentation is also a property not=20
> of the filesystem, but of Microsoft's filesystem drivers.  I'm fairly=20
> sure that the linux fat implementations do not use absurdly stupid=20
> allocation algorithms that lead to lots of fragmentation.

I am not sure about that: you can not do really good algorthms on bad data
structures, and the data structures of FAT do not provide any support to do
smart allocation.

> This can be overcome with the UDF filesystem by using the uid and gid=20
> mount options, allowing the files to appear to be owned by the correct=20
> local user.

That is interesting. Do you know how efficient UDF is compared to others
filesystems on normal hard drives? It is optimized for CDs and DVDs, I would
not be surprised if the performances were poor on different supports.

>	       It would be nice if the other filesystems were patched to=20
> allow such options as well.

I believe that such options should not be done on a per-filesystem basis.
Something in the common code of the VFS would be more logical.=20

> Network filesystems are not on disk filesystems, so they have nothing to=
=20
> do with this discussion; you can't format a disk as "nfs" or "smb".

The idea was to mount the disk with its haphazard UIDs, and then export it
and mount it as a network filesystem over the loopback. By itself, it is
absolutely useless, but networked filesystems have UIDs mapping facilities.


Regards,

--=20
  Nicolas George

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (SunOS)

iD8DBQFD79u1sGPZlzblTJMRAiqkAKC/L4dkh2Vl42Nhtpf18Csiyh4cbgCff5Br
IEo8AD083IOA1qiJEIZ23kw=
=9uNn
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
