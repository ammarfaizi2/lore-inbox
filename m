Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293559AbSBZKIW>; Tue, 26 Feb 2002 05:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293560AbSBZKIM>; Tue, 26 Feb 2002 05:08:12 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:2564 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S293559AbSBZKIF>;
	Tue, 26 Feb 2002 05:08:05 -0500
Date: Tue, 26 Feb 2002 13:12:08 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unneeded inode semaphores from driverfs
Message-ID: <20020226101208.GA285@pazke.ipt>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020226085946.GB278@pazke.ipt> <20020226085952.GA30564@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20020226085952.GA30564@kroah.com>
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2002 at 12:59:53AM -0800, Greg KH wrote:
> On Tue, Feb 26, 2002 at 11:59:46AM +0300, Andrey Panin wrote:
> > Hi,
> >=20
> > __remove_file() in driverfs/inode.c calls down(&dentry->d_inode->i_sem)
> > before calling vfs_unlink(dentry->d_parent->d_inode,dentry) which=20
> > tries to claim the same semaphore causing the livelock.
> > driverfs_remove_dir() makes the same calling vfs_rmdir().
>=20
> What kernel version did you generate this patch for?  This patch doesn't
> apply at all to 2.5.5, and it looks like this problem is already fixed.

It's against 2.5.5-pre1, I was out of the net for some days and
couldn't check final 2.5.5.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8e194Bm4rlNOo3YgRAtJeAJ9WQoLpB10wnJp7Hi/nz1sszNqtwgCbB8WW
ASsiKKLkMVfyeaCJdmTRj1E=
=+1O+
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
