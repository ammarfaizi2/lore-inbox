Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWJWLry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWJWLry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWJWLry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:47:54 -0400
Received: from agent.admingilde.org ([213.95.21.5]:61674 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932129AbWJWLrx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:47:53 -0400
Date: Mon, 23 Oct 2006 13:47:36 +0200
From: Martin Waitz <tali@admingilde.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       hch@infradead.org, jack@suse.cz
Subject: Re: [PATCH 01 of 23] VFS: change struct file to use struct path
Message-ID: <20061023114736.GA15167@admingilde.org>
Mail-Followup-To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, torvalds@osdl.org,
	viro@ftp.linux.org.uk, hch@infradead.org, jack@suse.cz
References: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu> <b212ecc85fa3ad0382f6.1161411446@thor.fsl.cs.sunysb.edu> <20061021002200.4731cdeb.akpm@osdl.org> <20061021072807.GF30620@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20061021072807.GF30620@filer.fsl.cs.sunysb.edu>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Oct 21, 2006 at 03:28:07AM -0400, Josef Sipek wrote:
> > why?
>=20
> It's little cleaner than having two pointers. In general, there is a numb=
er
> of users of dentry-vfsmount pairs in the kernel, and struct path nicely
> wraps it.

Sure, but you can split the patch up:

First, change struct file and introduce the #defines so that everything
still works as before.
If this is accepted upstream, you can start to move other kernel
code to use the new names.
If all active trees have finally moved to only use the new name,
then you can remove the #define.

--=20
Martin Waitz

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFPKvYj/Eaxd/oD7IRAi3zAJ9qSZFesBjkZrGY7oji3jOwz4QLmACfb4wV
M0NkF7IKaZtHjtr+0RJAlPY=
=X3Lv
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
