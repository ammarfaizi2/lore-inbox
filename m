Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbUAPMxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 07:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUAPMxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 07:53:34 -0500
Received: from mail.actcom.co.il ([192.114.47.15]:40641 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S265393AbUAPMxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 07:53:32 -0500
Date: Fri, 16 Jan 2004 14:53:18 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: chas@cmf.nrl.navy.mil
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ATM]: refcount atm sockets
Message-ID: <20040116125317.GD734@actcom.co.il>
References: <200401161217.i0GCHNjW019602@hera.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <200401161217.i0GCHNjW019602@hera.kernel.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Howdy, in this patchset for 2.4:

On Fri, Jan 16, 2004 at 10:02:24AM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1405.1.4, 2004/01/16 02:02:24-08:00, chas@cmf.nrl.navy.mil
>=20
> 	[ATM]: refcount atm sockets

> diff -Nru a/net/atm/common.c b/net/atm/common.c
> --- a/net/atm/common.c	Fri Jan 16 04:17:24 2004
> +++ b/net/atm/common.c	Fri Jan 16 04:17:24 2004
> @@ -242,6 +242,8 @@
>  		printk(KERN_DEBUG "vcc_sock_destruct: wmem leakage (%d bytes) detected=
=2E\n", atomic_read(&sk->wmem_alloc));
> =20
>  	kfree(sk->protinfo.af_atm);
> +
> +	MOD_DEC_USE_COUNT;

This has the usual wellknown races involved with handling the module's
refcount from within the moodule. Is there a way to push the
refcounting to the caller?=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAB969KRs727/VN8sRAruRAJ9BPDNi+RyM++Y5mVvEUggT3QVtCgCfZVZa
+STrs0NeMkmPxZ0WMCxy7PM=
=jLCO
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
