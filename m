Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUBGFJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 00:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266634AbUBGFJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 00:09:16 -0500
Received: from h80ad250c.async.vt.edu ([128.173.37.12]:2944 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266627AbUBGFJO (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 00:09:14 -0500
Message-Id: <200402070505.i17553g6002224@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.2-mm1, selinux, and initrd 
In-Reply-To: Your message of "Fri, 06 Feb 2004 22:39:45 EST."
             <Xine.LNX.4.44.0402062238390.17854-100000@thoron.boston.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0402062238390.17854-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-634023388P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 07 Feb 2004 00:05:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-634023388P
Content-Type: text/plain; charset=us-ascii

On Fri, 06 Feb 2004 22:39:45 EST, James Morris said:

> Can you please try the patch below against  the 2.6.2-mm1 kernel and let 
> me know if you still see the problem.

> diff -urN -X dontdiff linux-2.6.2-mm1.o/fs/super.c linux-2.6.2-mm1.w/fs/super
.c
> --- linux-2.6.2-mm1.o/fs/super.c	2004-02-05 09:24:12.000000000 -0500
> +++ linux-2.6.2-mm1.w/fs/super.c	2004-02-06 22:32:43.309927664 -0500
> @@ -709,7 +709,6 @@
>  	struct super_block *sb = ERR_PTR(-ENOMEM);
>  	struct vfsmount *mnt;
>  	int error;
> -	char *secdata = NULL;

Yes, backing out that part of the 3 patches that hits fs/super.c makes
a kernel that boots with selinux enabled.

--==_Exmh_-634023388P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAJHH+cC3lWbTT17ARAlxkAKDemKjxYkWCbX7skDNHxbd19izIgQCgk2we
9vaCVIyxj2vHacJPS5JhIYA=
=pZve
-----END PGP SIGNATURE-----

--==_Exmh_-634023388P--
