Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVA3Ilx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVA3Ilx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 03:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVA3Ilx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 03:41:53 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:31691 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261659AbVA3Ilo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 03:41:44 -0500
Date: Sun, 30 Jan 2005 09:41:28 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Om <okuttan@netd.com>
Cc: Rock Gordon <rockgordon@yahoo.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: userspace vs. kernelspace address
Message-ID: <20050130084128.GA27925@vagabond>
References: <20050128075209.GA14153@vagabond> <20050128214051.34768.qmail@web41411.mail.yahoo.com> <20050129042355.GA5527@netd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20050129042355.GA5527@netd.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 28, 2005 at 20:23:55 -0800, Om wrote:
> On Fri, Jan 28, 2005 at 01:40:51PM -0800, Rock Gordon wrote:
> > Hi everbody,
> >=20
> > Thanks for your replies.
> >=20
> > However I think my copy_to_user and copy_from_user are
> > failing since the kernel-mode thread is copying data
> > into another process's address space, and I am not
> > sure how to do this. Do the get_fs() and set_fs()
> > combinations let you do that? If not, then how do I do
> My idea is on kernel thread is limited. But I think it is not possible to
> any userspace address from any kernel thread because they do not have acc=
ess
> to it. Their proc_struct->mm field is empty.

Right. You can't access any user-space from kernel thread, because it
does not have any.

> I am not sure whether set_fs and get_fs help in this case.

Sure it can. set_fs(KERNEL_DS) sets things so, that if you pass kernel
address to copy_to/from_user, it will silently accept it and copy
to/from there.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB/J23Rel1vVwhjGURAt8yAKCAnsvmer3v7fj9occmM3KYY5fZDACgg2qz
wZIZ2ELUJLOG/X7Rze1ZCd0=
=NS8f
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
