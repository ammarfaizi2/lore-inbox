Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTISHk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 03:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTISHk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 03:40:28 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:43758 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261411AbTISHkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 03:40:23 -0400
Subject: Re: netpoll/netconsole minor tweaks
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jesper Juhl <jju@dif.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0309190103240.10809@jju_lnx.backbone.dif.dk>
References: <20030917112447.A24623@osdlab.pdx.osdl.net>
	 <1063888205.15962.20.camel@dhcp23.swansea.linux.org.uk>
	 <20030918094832.A16499@osdlab.pdx.osdl.net>
	 <1063919555.16536.5.camel@dhcp23.swansea.linux.org.uk>
	 <Pine.LNX.4.56.0309190103240.10809@jju_lnx.backbone.dif.dk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y5BIoBu86KvJLE7+SOAs"
Organization: Red Hat, Inc.
Message-Id: <1063957207.5394.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Fri, 19 Sep 2003 09:40:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y5BIoBu86KvJLE7+SOAs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-09-19 at 01:10, Jesper Juhl wrote:
> 00; wait++)
>                 if (inb(cmd_ioaddr) =3D=3D 0) return;
> -       for (; wait <=3D 20000; wait++)
> +       for (; wait <=3D 20000; wait++) {
>                 if (inb(cmd_ioaddr) =3D=3D 0) return;
>                 else udelay(1);
> +               cpu_relax();
> +       }

udelay() should have cpu_relax() inside it already basically..

--=-y5BIoBu86KvJLE7+SOAs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/arLXxULwo51rQBIRAn7MAJ4jkXDHOCWMHSQck/XM1La86kREoACfZ35U
Z0JM2hndhMge3moXbwgKxIU=
=MyxD
-----END PGP SIGNATURE-----

--=-y5BIoBu86KvJLE7+SOAs--
