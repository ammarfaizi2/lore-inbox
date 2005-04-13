Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVDMKax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVDMKax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDMK3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:29:49 -0400
Received: from lug-owl.de ([195.71.106.12]:15052 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261296AbVDMK3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:29:17 -0400
Date: Wed, 13 Apr 2005 12:29:16 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Tomko <tomko@haha.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why system call need to copy the date from the userspace before using it
Message-ID: <20050413102916.GS4965@lug-owl.de>
Mail-Followup-To: Tomko <tomko@haha.com>,
	linux-kernel@vger.kernel.org
References: <425C9E55.6010607@haha.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JB7KW7Ey7eB5HOHs"
Content-Disposition: inline
In-Reply-To: <425C9E55.6010607@haha.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JB7KW7Ey7eB5HOHs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-04-13 12:21:41 +0800, Tomko <tomko@haha.com>
wrote in message <425C9E55.6010607@haha.com>:
> While i am reading the source code of the linux system call , i find=20
> that the system call need to call copy_from_user() to copy the data from=
=20
> user space to kernel space before using it . Why not use it directly as=
=20
> the system call has got the address ?  Furthermore , how to distinguish=
=20
> between user space and kernel space ?

Think about the memory access. The page that contains the data could be
swapped out, so the kernel isn't allowed to just access it, because it's
not there.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--JB7KW7Ey7eB5HOHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCXPR8Hb1edYOZ4bsRAglSAJ9j/glGSCAW8a+4a2RiYlwF8DBC0gCfen5r
hMWD4bfymselxiM0vVV4oNM=
=x6nX
-----END PGP SIGNATURE-----

--JB7KW7Ey7eB5HOHs--
