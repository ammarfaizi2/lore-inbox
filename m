Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWBMKfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWBMKfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWBMKfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:35:41 -0500
Received: from nef2.ens.fr ([129.199.96.40]:45838 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751253AbWBMKfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:35:15 -0500
Date: Mon, 13 Feb 2006 11:35:12 +0100
From: Nicolas George <nicolas.george@ens.fr>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem for mobile hard drive
Message-ID: <20060213103512.GA5157@clipper.ens.fr>
References: <20060212150331.GA22442@clipper.ens.fr> <43EFD6E4.60601@cfl.rr.com> <20060213010701.GA8430@clipper.ens.fr> <43EFEE57.7070009@cfl.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <43EFEE57.7070009@cfl.rr.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 13 Feb 2006 11:35:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le quartidi 24 pluvi=F4se, an CCXIV, Phillip Susi a =E9crit=A0:
> Ahh yes, the per file limit.  BTW, why are you saying "To" and "Go" when=
=20
> you apparently mean "TB" and "GB"?

I use the french word octet instead of byte, because it is less error prone
(when you read "mb", does-it really mean megabit, or does it mean that the
author is lazy about capitalization?) and a little bit more precise. Tough I
actually am French, I did not start using a French word in English by
myself. I copy a practice of the IETF: the RFCs use octet more than byte.

> The fat data structures do not encourage fragmentation any more or less=
=20
> than ext2/3.  NTFS is slightly better, more comparable to reiserfs than=
=20
> ext2/3, but the difference is small.  What causes massive fragmentation=
=20
> is how the driver chooses to allocate new blocks as you write to files.=
=20
>  Microsoft has always used about the worst possible algorithm for doing=
=20
> this you can imagine, which is why fragmentation has always been a big=20
> problem on their OSes.  Linux is smarter and allocates blocks such that=
=20
> fragmentation is kept to a minimum.

I believe you about that.

> I have not done any testing, but I know no reason why it would be worse=
=20
> than fat.

That is a very good point. If windows can read UDF on hard drives and not
only DVD, UDF could probably supersede FAT completely.

Thank you for pointing me that direction.

>	    It does not do transaction logging, and there currently is no=20
> fsck for it, so for safety reasons, it may not be such a good choice.=20

I have a Solaris 9 near at hand, and I see a /lib/fs/udfs/fsck, and in the
source tarball of OpenSolaris, I find a directory
usr/src/cmd/fs.d/udfs/fsck/. It does not compile out of the box, but it may
be possible to port it with limited effort.

> I agree.  I think the VFS layer should process the uid/gid options.  By=
=20
> default it should replace nobody with the specified id, and fat and ntfs=
=20
> should just report all files as owned by nobody.  Then a new option=20
> should be added to force the translation for all ids, not just nobody.

I agree with that (except maybe for the NTFS part, which I do not know; let
us just say "UID-less filesystems"). Maybe a full UID translation system
similar th the one in NFS could be useful, or a generic hook for modules,
but having basic UID overriding would be great.

Unfortunately, the VFS subsystem is something too complex for me at this
time.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (SunOS)

iD8DBQFD8GDgsGPZlzblTJMRAqIIAKCz2OBbteJQ9Ui3HWvNI41TCJBA/QCaAgYQ
6roMPWlAURRGJsX/c/Caf7M=
=bDDq
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
