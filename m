Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbTAQGJs>; Fri, 17 Jan 2003 01:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267409AbTAQGJr>; Fri, 17 Jan 2003 01:09:47 -0500
Received: from h80ad2561.async.vt.edu ([128.173.37.97]:14466 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267408AbTAQGJq>; Fri, 17 Jan 2003 01:09:46 -0500
Message-Id: <200301170618.h0H6IZxw013611@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Linux Geek <bourne@ToughGuy.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DUMB]: Is kernel oops always a kernel bug ??? 
In-Reply-To: Your message of "Fri, 17 Jan 2003 11:33:46 +0530."
             <3E279CC2.9040806@ToughGuy.net> 
From: Valdis.Kletnieks@vt.edu
References: <3E279CC2.9040806@ToughGuy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-730119788P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Jan 2003 01:18:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-730119788P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Jan 2003 11:33:46 +0530, Linux Geek <bourne@ToughGuy.net>  said:
> If a kernel oops,  then is the problem always with the kernel ? Can't a 
> user proggie ( running as root ) do something insane and make the
> kernel oops ?

At least in theory, there should be *nothing* that can happen in user space
that will kill the kernel.  However, in practice, if a program is running
as root, it can definitely blortch things up.  This is mostly due to the
assumption that the root user has a clue, and that if they are (for instance)
opening /proc/kcore for writing, that they know what they're doing.  Similarly,
if a program opens /dev/hda1 for writing and scribbles over the superblock,
it may be a bit difficult to mount the filesystem.

So in general, yes, the root user can screw things up in the kernel.  On the
other hand, the root user can also 'rm -rf /' which doesn't require any
extraordinary kernel assistance, just the unlink() system call.  The only
solution here is to not give root to clueless bozos, and to take regular
backups. ;)
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-730119788P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+J6A6cC3lWbTT17ARAtWxAKCeCZUX9ZVVnq5x4d9vXp+pMw9DFQCg9/O6
Kp3Rh631hUpWUb0DsvqzSIk=
=4XVs
-----END PGP SIGNATURE-----

--==_Exmh_-730119788P--
