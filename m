Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSHaTrT>; Sat, 31 Aug 2002 15:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317977AbSHaTrT>; Sat, 31 Aug 2002 15:47:19 -0400
Received: from ppp-217-133-221-247.dialup.tiscali.it ([217.133.221.247]:4824
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317950AbSHaTrS>; Sat, 31 Aug 2002 15:47:18 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15728.61345.184030.293634@charged.uio.no>
References: <15728.61345.184030.293634@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-sYEUNULf6EqN04Wodilt"
X-Mailer: Ximian Evolution 1.0.5 
Date: 31 Aug 2002 21:51:40 +0200
Message-Id: <1030823500.4408.133.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sYEUNULf6EqN04Wodilt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Forgot to mention that, of course, the vfs_cred_groups struct needs to
be recreated if modified and we must keep an atomic reference count in
it.
This allows to avoid having to copy the whole groups array for each task
on modification.
uid and gid instead are placed directly in task_struct since checking
them is faster and thus needs more optimization.
Same reasoning applies for eventual ACLs or similar structures.


--=-sYEUNULf6EqN04Wodilt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cR5Mdjkty3ft5+cRAnmqAJ9KTOt3XBm/Uvb+ckyeaI9cL2hODwCfcmPa
LC/gUQmq0D812qZf+TimNyo=
=GAtG
-----END PGP SIGNATURE-----

--=-sYEUNULf6EqN04Wodilt--
