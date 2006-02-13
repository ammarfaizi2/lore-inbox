Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWBMK1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWBMK1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWBMK1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:27:05 -0500
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:23441 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1751722AbWBMK1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:27:04 -0500
Date: Mon, 13 Feb 2006 11:26:56 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove duplicate #includes
Message-ID: <20060213102656.GC26627@wavehammer.waldi.eu.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060213093959.GA10496@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <20060213093959.GA10496@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2006 at 10:39:59AM +0100, Herbert Poetzl wrote:
> diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/drm/drm.h linux-2.6.1=
6-rc2-mpf/drivers/char/drm/drm.h
> --- linux-2.6.16-rc2/drivers/char/drm/drm.h	2006-02-07 11:52:24 +0100
> +++ linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h	2006-02-13 01:48:55 +0100
> @@ -51,11 +51,9 @@
>  #if defined(__FreeBSD__) && defined(IN_MODULE)
>  /* Prevent name collision when including sys/ioccom.h */
>  #undef ioctl
> -#include <sys/ioccom.h>
>  #define ioctl(a,b,c)		xf86ioctl(a,b,c)
> -#else
> -#include <sys/ioccom.h>
>  #endif				/* __FreeBSD__ && xf86ioctl */
> +#include <sys/ioccom.h>
>  #define DRM_IOCTL_NR(n)		((n) & 0xff)
>  #define DRM_IOC_VOID		IOC_VOID
>  #define DRM_IOC_READ		IOC_OUT

This one changes the behaviour. But do we want to have this non-linux
hacks in the tree?

Bastian

--=20
It would be illogical to assume that all conditions remain stable.
		-- Spock, "The Enterprise Incident", stardate 5027.3

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkPwXvAACgkQnw66O/MvCNH53gCdF3XV1FySZLfsVwJxD70OgLrG
yfEAnR/EEs0TtsFfV6ercg11WdW6oNf4
=PZUv
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
