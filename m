Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVFSXCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVFSXCq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 19:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVFSXCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 19:02:46 -0400
Received: from h80ad2661.async.vt.edu ([128.173.38.97]:59657 "EHLO
	h80ad2661.async.vt.edu") by vger.kernel.org with ESMTP
	id S261335AbVFSXCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 19:02:43 -0400
Message-Id: <200506192302.j5JN2M5P009849@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jan De Luyck <lkml@kcore.org>
Cc: Edwin Eefting <psy@datux.nl>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.12] XFS: Undeletable directory 
In-Reply-To: Your message of "Sun, 19 Jun 2005 20:34:18 +0200."
             <200506192034.18690.lkml@kcore.org> 
From: Valdis.Kletnieks@vt.edu
References: <200506191904.49639.lkml@kcore.org> <Pine.LNX.4.63.0506191924430.7686@hobbybop>
            <200506192034.18690.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119222140_7087P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Jun 2005 19:02:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119222140_7087P
Content-Type: text/plain; charset=us-ascii

On Sun, 19 Jun 2005 20:34:18 +0200, Jan De Luyck said:
> On Sunday 19 June 2005 21:25, Edwin Eefting wrote:
> > ls -la 4207214/ also shows nothing?

> Nothing out of the ordinary:
> 
> devilkin@precious:/lost+found$ ls -la 4207214/
> total 8
> drwxrwxrwx  2 root root 8192 Jun 19  2005 .
> drwxr-xr-x  3 root root   20 Jun 19  2005 ..

Might want to do 'ls -lai' to get the inode numbers for . and .. and
then go sanity check them ('.' should have the same inode number as
lost+found/4207214, and '..' should have the same inode number as lost+found)

(and yes, I *know* fsck should whinge loudly if this is the case.  Wouldn't
be the first time I've seen an fsck fail to pick up on obvious corruption...)

--==_Exmh_1119222140_7087P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCtfl8cC3lWbTT17ARAnbIAJ4nFX/5XX57+dudJNxdU+Vtc5CQXACfTtoR
5ugck2GH9ITwOPO285ZSEqg=
=JRxM
-----END PGP SIGNATURE-----

--==_Exmh_1119222140_7087P--
