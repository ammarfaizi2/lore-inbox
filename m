Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUEMGM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUEMGM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUEMGM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:12:58 -0400
Received: from mx1.actcom.net.il ([192.114.47.13]:7568 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263802AbUEMGM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:12:56 -0400
Date: Thu, 13 May 2004 09:05:50 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513060549.GA12695@mulix.org>
References: <20040513055520.GF27403@zax>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20040513055520.GF27403@zax>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2004 at 03:55:20PM +1000, David Gibson wrote:

> --- working-2.6.orig/mm/mmap.c	2004-04-20 10:50:09.000000000 +1000
> +++ working-2.6/mm/mmap.c	2004-04-27 13:40:01.062285976 +1000
> @@ -21,6 +21,7 @@
>  #include <linux/profile.h>
>  #include <linux/module.h>
>  #include <linux/mount.h>
> +#include <linux/err.h>
> =20
>  #include <asm/uaccess.h>
>  #include <asm/pgalloc.h>
> @@ -62,6 +63,9 @@
>  EXPORT_SYMBOL(sysctl_max_map_count);
>  EXPORT_SYMBOL(vm_committed_space);
> =20
> +int mmap_use_hugepages =3D 0;
> +int mmap_hugepages_map_sz =3D 256;

These two global variables do not appear to be used anywhere in this
patch?=20

> +static inline unsigned long __do_mmap_pgoff(struct file * file, unsigned=
 long addr,

__do_mmap_pgoff seems rather long to be inline?=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoxA9KRs727/VN8sRAk+5AKCXXawy1oY9GV8pf0Z8rBg6WFc3sgCfaLP8
GLMSwfNncqpOq4QWhD6yf2U=
=0cGi
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
