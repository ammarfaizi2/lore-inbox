Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTHaOYr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTHaOYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:24:47 -0400
Received: from h80ad2559.async.vt.edu ([128.173.37.89]:10368 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262357AbTHaOYq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:24:46 -0400
Message-Id: <200308311424.h7VEOIaA025557@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: 2.6.0-test4-mm3.1 oops with ext3 extended attributes on R/O filesystem 
In-Reply-To: Your message of "Sat, 30 Aug 2003 21:47:51 PDT."
             <20030830214751.5baaab4c.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200308310412.h7V4Cxd7013786@turing-police.cc.vt.edu>
            <20030830214751.5baaab4c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_553233904P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 31 Aug 2003 10:24:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_553233904P
Content-Type: text/plain; charset=us-ascii

On Sat, 30 Aug 2003 21:47:51 PDT, Andrew Morton said:

> Thanks.   It's a very straightforward bug; I'll fix it with the below patch.

Fix tested in -test4-mm4, program gets a proper '-EROFS', no signs of hanging
locks.  Looks good from here, please push to appropriate maintainers..

> A wider question is whether we should have got this far into the filesystem
> code if the fs is mounted read-only.  A check right up at the VFS
> setxattr() level might make sense.

Yes, I was a bit surprised at that as well...

> Regardless of that, this fix is needed because journal_start() could fail
> for other reasons.

Good point, and one I hadn't considered...

--==_Exmh_553233904P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/UgUScC3lWbTT17ARAib0AKDIv+b9BhBbno5L3uxFHl6duapoyQCfWv2b
4pQsPRIPxHAeV6vyKEhMZqE=
=/vuv
-----END PGP SIGNATURE-----

--==_Exmh_553233904P--
