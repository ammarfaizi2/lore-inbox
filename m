Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264824AbUEKQRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264824AbUEKQRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264818AbUEKQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:17:32 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:39122 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264825AbUEKQQA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:16:00 -0400
Message-Id: <200405111615.i4BGFiXe013665@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: maneesh@in.ibm.com
Cc: Richard A Nelson <cowboy@debian.org>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm1 Oops with dummy network device (sysfs related?) 
In-Reply-To: Your message of "Wed, 06 Oct 2004 15:26:02 +0530."
             <20041006095602.GB2004@in.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0405101654130.5731@erartnqr.onqynaqf.bet> <20040510141829.467a2bb6@dell_ss3.pdx.osdl.net> <Pine.LNX.4.58.0405101909450.31018@onpx40.onqynaqf.bet>
            <20041006095602.GB2004@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_680267400P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 12:15:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_680267400P
Content-Type: text/plain; charset=us-ascii

On Wed, 06 Oct 2004 15:26:02 +0530, Maneesh Soni said:

> o Fix sysfs_rename_dir(). The sysfs_lookup() does not hash
>   negative dentries so just hash it before calling d_move
> 
>  fs/sysfs/dir.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN fs/sysfs/dir.c~sysfs-backing-store-sysfs_rename_dir-fix fs/sysfs/dir.c
> --- linux-2.6.6-mm1/fs/sysfs/dir.c~sysfs-backing-store-sysfs_rename_dir-fix	2004-10-06 15:21:37.000000000 +0530
> +++ linux-2.6.6-mm1-maneesh/fs/sysfs/dir.c	2004-10-06 15:22:03.000000000 +0530

Confirming that this patch also resolves my 'nameif' issue...  System booted fine
with the sysfs-backing-store patches and this one on top...



--==_Exmh_680267400P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoPwwcC3lWbTT17ARAvegAJ95gN5Y2baRoMkNPMMScNMIgMWyYgCgpImh
AEKZ0Ce7zXfMusmR23tFxHg=
=XXSf
-----END PGP SIGNATURE-----

--==_Exmh_680267400P--
