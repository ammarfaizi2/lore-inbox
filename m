Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUIMOvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUIMOvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUIMOvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:51:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267661AbUIMOri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:47:38 -0400
Subject: RE: 2.4.28-pre3: broken ips update
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Hammer, Jack" <Jack_Hammer@adaptec.com>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <A121ABA5B472B74EB59076B8E3C8F019796579@rtpe2k01.adaptec.com>
References: <A121ABA5B472B74EB59076B8E3C8F019796579@rtpe2k01.adaptec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iyaDR6oWh8xxOr29elQg"
Organization: Red Hat UK
Message-Id: <1095086785.2624.20.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 16:46:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iyaDR6oWh8xxOr29elQg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-09-13 at 16:28, Hammer, Jack wrote:
> Marcelo,

> --- linux.orig/drivers/scsi/ips.h	Mon Sep 13 09:40:04 2004
> +++ linux/drivers/scsi/ips.h	Mon Sep 13 09:40:27 2004
> @@ -97,7 +97,7 @@
> =20
>     #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
>    =20
> -      #ifndef irqreturn_t
> +      #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
>           typedef void irqreturn_t;
>        #endif=20
>=20

your fix is wrong.
you should nuke all version codes, and ONLY ifndef for  IRQ_NONE and
nothing else. That's not just cosmetics, that's also to make keep
working with those exact vendor kernels  you claim to have tested on :)


--=-iyaDR6oWh8xxOr29elQg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBRbLBxULwo51rQBIRAv0uAKCV2Q7/x35BH4h9pDD3qfMHwv4EwwCgqrm2
h9tY3E5l0+5SImK6m13y51I=
=lVuI
-----END PGP SIGNATURE-----

--=-iyaDR6oWh8xxOr29elQg--

