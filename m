Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVCWDoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVCWDoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 22:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVCWDoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 22:44:21 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:63425 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262615AbVCWDoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 22:44:15 -0500
Date: Wed, 23 Mar 2005 14:43:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm1 3/3] perfctr: 64-bit values in register
 descriptors
Message-Id: <20050323144355.74253422.sfr@canb.auug.org.au>
In-Reply-To: <200503230300.j2N303Qo023641@harpo.it.uu.se>
References: <200503230300.j2N303Qo023641@harpo.it.uu.se>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__23_Mar_2005_14_43_55_+1100_gVmK4MXBTklaWAv_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__23_Mar_2005_14_43_55_+1100_gVmK4MXBTklaWAv_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Mar 2005 04:00:03 +0100 (MET) Mikael Pettersson <mikpe@csd.uu.se=
> wrote:
>
> diff -rupN linux-2.6.12-rc1-mm1/include/linux/perfctr.h linux-2.6.12-rc1-=
mm1.perfctr-update-common/include/linux/perfctr.h
> --- linux-2.6.12-rc1-mm1/include/linux/perfctr.h	2005-03-22 21:59:08.0000=
00000 +0100
> +++ linux-2.6.12-rc1-mm1.perfctr-update-common/include/linux/perfctr.h	20=
05-03-23 02:19:45.000000000 +0100
> @@ -27,10 +27,10 @@ struct vperfctr_control {
>  #define VPERFCTR_CONTROL_RESUME		0x03
>  #define VPERFCTR_CONTROL_CLEAR		0x04
> =20
> -/* common description of an arch-specific 32-bit control register */
> +/* common description of an arch-specific control register */
>  struct perfctr_cpu_reg {
>  	__u32 nr;
> -	__u32 value;
> +	__u64 value;
>  };

I don't know if you support 32 bit binaries on x86_64, but if you do (or
intend to), then this structure will need translating.  The x86 compiler
aligns 64 bit quantities on 32 bit boundaries (as far as I am aware)
whereas (I am pretty sure) the x86_64 compiler aligns them to 64 bit
boundaries. This is fine for ppc/ppc64 as both align 64bit quantities on
64 bit boundaries.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Mar_2005_14_43_55_+1100_gVmK4MXBTklaWAv_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCQOX74CJfqux9a+8RAl8NAJ9KDMai5NHWUTtenW8rSCQRNwddXQCePZyS
zDa6NKjhshseScu4AIUFszo=
=/xtM
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Mar_2005_14_43_55_+1100_gVmK4MXBTklaWAv_--
