Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUE0RkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUE0RkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUE0RkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:40:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2749 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264902AbUE0Rj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:39:58 -0400
Subject: Re: [2.6.7-rc1-mm1] lp int copy_to_user replaced
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: FabF <fabian.frederick@skynet.be>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1085679127.2070.21.camel@localhost.localdomain>
References: <1085679127.2070.21.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AG0XfFGcDRx7mygzyzQZ"
Organization: Red Hat UK
Message-Id: <1085679588.7179.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 19:39:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AG0XfFGcDRx7mygzyzQZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-27 at 19:32, FabF wrote:
> Andrew,
>=20
> 	Here's a patch to have standard __put_user for integer transfers in lp
> driver.Is it correct ?

no it's not. You need to use put_user() not __put_user() at least, to
make sure the destination address is checked to not be in kernel
space...


--=-AG0XfFGcDRx7mygzyzQZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtifkxULwo51rQBIRAibNAJ9wMWIdshwThB+Fbd5D4r4XiKpCSwCgoFB8
utrT1/fBwaXpX2oSrNHWPK0=
=hbIS
-----END PGP SIGNATURE-----

--=-AG0XfFGcDRx7mygzyzQZ--

