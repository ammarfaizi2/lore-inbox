Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266431AbUA3El3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 23:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266455AbUA3El3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 23:41:29 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:63106 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266431AbUA3El0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 23:41:26 -0500
Subject: Re: [ANNOUNCE] udev 015 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <1075401020.7680.25.camel@nosferatu.lan>
References: <20040126215036.GA6906@kroah.com>
	 <1075401020.7680.25.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9zjx+F2jdkuXrr/R8kj2"
Message-Id: <1075437687.7206.2.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Jan 2004 06:41:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9zjx+F2jdkuXrr/R8kj2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-29 at 20:30, Martin Schlemmer wrote:

<snip>

> --- udev-015/logging.c  2004-01-29 19:20:40.673380296 +0200
> +++ udev-015.log_option/logging.c       2004-01-29 20:02:41.316184344 +02=
00
> @@ -26,6 +26,7 @@
>  #include <unistd.h>
>  #include <syslog.h>
> =20
> +#include "udev.h"
>  #include "logging.h"
> =20
> =20
> @@ -47,6 +48,9 @@ int log_message(int level, const char *f
>  {
>         va_list args;
> =20
> +       if (0 !=3D strncmp(udev_log_str, "yes", BOOL_SIZE))

This should be:

--
+       if (0 !=3D strncmp(udev_log_str, UDEV_LOG_DEFAULT, BOOL_SIZE))
--

of course ...

> +               return 0;
> +
>         if (!logging_init)
>                 init_logging();
>         va_start(args, format);


--=20
Martin Schlemmer

--=-9zjx+F2jdkuXrr/R8kj2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAGeB2qburzKaJYLYRAgn/AKCRIDlO9N20YhdwFDGXSYoypLAZSwCggT7C
3uI7sejANFsPCDFJndOBT3k=
=auiz
-----END PGP SIGNATURE-----

--=-9zjx+F2jdkuXrr/R8kj2--

