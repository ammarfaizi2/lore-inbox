Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVABWn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVABWn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 17:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVABWn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 17:43:27 -0500
Received: from h80ad2465.async.vt.edu ([128.173.36.101]:33469 "EHLO
	h80ad2465.async.vt.edu") by vger.kernel.org with ESMTP
	id S261304AbVABWnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 17:43:23 -0500
Message-Id: <200501022243.j02MhANg004075@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: 7eggert@gmx.de
Cc: Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users 
In-Reply-To: Your message of "Sun, 02 Jan 2005 13:38:29 +0100."
             <E1Cl509-0000TI-00@be1.7eggert.dyndns.org> 
From: Valdis.Kletnieks@vt.edu
References: <fa.iji5lco.m6nrs@ifi.uio.no> <fa.fv0gsro.143iuho@ifi.uio.no>
            <E1Cl509-0000TI-00@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_445324364P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Jan 2005 17:43:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_445324364P
Content-Type: text/plain; charset=us-ascii

On Sun, 02 Jan 2005 13:38:29 +0100, Bodo Eggert said:

> Maybe it's possible to extend the semantics of umount -l to change all
> cwds under that mountpoint to be deleted directories which will no
> longer cause the mountpoint to be busy (e.g. by redirecting them to a
> special inode on initramfs). Most applications can cope with that (if
> not, they're buggy),

You mean that a program is *buggy* if it does:

	cwd("/home/user");
	/* do some stuff while we get our cwd ripped out from under us */
	file = open("./.mycconfrc");

and expects the file to be opened in /home/user???

--==_Exmh_445324364P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB2Hj+cC3lWbTT17ARAnVwAKCT6h3UiBujMisfiYGPWMiHSXiJQACbBiBs
YIUTi5z4cBnG5q5HQ5zbHK0=
=c6R/
-----END PGP SIGNATURE-----

--==_Exmh_445324364P--
