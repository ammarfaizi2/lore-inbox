Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUEMPhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUEMPhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUEMPhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:37:02 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:28906 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264260AbUEMPg6 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:36:58 -0400
Message-Id: <200405131536.i4DFaaSE017433@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Kronos <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb 
In-Reply-To: Your message of "Thu, 13 May 2004 17:15:49 +0200."
             <20040513151549.GB31123@wohnheim.fh-wedel.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040513134847.GA2024@dreamland.darkstar.lan> <20040513145640.GA3430@dreamland.darkstar.lan>
            <20040513151549.GB31123@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-867745868P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 13 May 2004 11:36:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-867745868P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 13 May 2004 17:15:49 +0200, =3D?iso-8859-1?Q?J=3DF6rn?=3D Engel s=
aid:

> Even quicker fix:
> =

> --- linux-2.6/drivers/video/aty/radeon_base.c~	2004-05-13 16:51:08.000
000000 +0200
> +++ linux-2.6/drivers/video/aty/radeon_base.c	2004-05-13 16:55:09.00000=
0000 +
0200
> @@ -1397,7 +1397,7 @@
>  {
>  	struct radeonfb_info *rinfo =3D info->par;
>  	struct fb_var_screeninfo *mode =3D &info->var;
> -	struct radeon_regs newmode;
> +	static struct radeon_regs newmode;
>  	int hTotal, vTotal, hSyncStart, hSyncEnd,
>  	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
>  	u8 hsync_adj_tab[] =3D {0, 0x12, 9, 9, 6, 5};

Is that racy if you have more than one graphics card installed?

--==_Exmh_-867745868P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAo5YEcC3lWbTT17ARAtZkAJ9DRW5FLRd+eaqkJPxs5azzTiHLXgCaAlV8
9GfjjsfiBJWkUryChYGRxrg=
=aV8l
-----END PGP SIGNATURE-----

--==_Exmh_-867745868P--
