Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTISHew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 03:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTISHew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 03:34:52 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:43246 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261403AbTISHev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 03:34:51 -0400
Subject: Re: [PATCH 4/13] use cpu_relax() in busy loop
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20030918163156.H16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net>
	 <20030918162748.F16499@osdlab.pdx.osdl.net>
	 <20030918162930.G16499@osdlab.pdx.osdl.net>
	 <20030918163156.H16499@osdlab.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZjpfLR9rm6KLrGZEtIl4"
Organization: Red Hat, Inc.
Message-Id: <1063956884.5394.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Fri, 19 Sep 2003 09:34:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZjpfLR9rm6KLrGZEtIl4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-09-19 at 01:31, Chris Wright wrote:
> Replace busy loop nop with cpu_relax().
>=20
> =3D=3D=3D=3D=3D drivers/cdrom/sonycd535.c 1.39 vs edited =3D=3D=3D=3D=3D
> --- 1.39/drivers/cdrom/sonycd535.c	Tue Sep  9 07:41:30 2003
> +++ edited/drivers/cdrom/sonycd535.c	Thu Sep 18 10:52:41 2003
> @@ -1526,7 +1526,8 @@
>  		enable_interrupts();
>  		outb(0, read_status_reg);	/* does a reset? */
>  		delay =3D jiffies + HZ/10;
> -		while (time_before(jiffies, delay)) ;
> +		while (time_before(jiffies, delay))
> +			cpu_relax();

mdelay ?

--=-ZjpfLR9rm6KLrGZEtIl4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/arGUxULwo51rQBIRAsayAKCojVz2qMERFsfd5IerxsjESdQDxACdFvNt
ofPpifwWsMH/LAYcGMplS90=
=ubfa
-----END PGP SIGNATURE-----

--=-ZjpfLR9rm6KLrGZEtIl4--
