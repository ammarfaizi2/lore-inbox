Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVACQKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVACQKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVACQKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:10:13 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:58844 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261484AbVACQKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:10:05 -0500
Date: Mon, 3 Jan 2005 17:10:03 +0100
From: Martin Waitz <tali@admingilde.org>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting inode no from current process file descriptor table
Message-ID: <20050103161003.GY31835@admingilde.org>
Mail-Followup-To: selvakumar nagendran <kernelselva@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20050103053724.43669.qmail@web60606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1fZJyN7nFm/tosmV"
Content-Disposition: inline
In-Reply-To: <20050103053724.43669.qmail@web60606.mail.yahoo.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1fZJyN7nFm/tosmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jan 02, 2005 at 09:37:24PM -0800, selvakumar nagendran wrote:
>    How can we get the inode number for a file provided
> we have the corresponding file descriptor. Can we use
> files_struct -> fd[fd] to get struct file ?. From that
> how can we get the corresponding inode number?

#include <linux/dcache.h>
#include <linux/file.h>
#include <linux/fs.h>

struct file * file =3D fget(fd);
inode_number =3D file->f_dentry->d_inode->i_ino;
fput(file);

--=20
Martin Waitz

--1fZJyN7nFm/tosmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB2W5bj/Eaxd/oD7IRAmhuAJwNkl7cNa9P2pjmbqlHFxz5+wuS0QCfR7sh
PJsAkZjrGdNgid1W94bwRjw=
=KfOc
-----END PGP SIGNATURE-----

--1fZJyN7nFm/tosmV--
