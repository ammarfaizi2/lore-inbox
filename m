Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268244AbTALGkw>; Sun, 12 Jan 2003 01:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268247AbTALGkw>; Sun, 12 Jan 2003 01:40:52 -0500
Received: from h80ad2641.async.vt.edu ([128.173.38.65]:39553 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268246AbTALGkv>; Sun, 12 Jan 2003 01:40:51 -0500
Message-Id: <200301120649.h0C6nULE005008@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: some curiosities on the filesystems layout in kernel config 
In-Reply-To: Your message of "Sun, 12 Jan 2003 01:00:40 EST."
             <Pine.LNX.4.44.0301120053420.21687-100000@dell> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0301120053420.21687-100000@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-887247099P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jan 2003 01:49:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-887247099P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jan 2003 01:00:40 EST, "Robert P. J. Day" <rpjday@mindspring.com>  said:

> 2) shouldn't ext3 depend on ext2?

No, because somebody might want ext3 only, and have no intention or
desire to mount a filesystem in ext2 mode.  Everything on this laptop
is ext3...

> 3) currently, since quotas are only supported for ext2, ext3 and
>    reiserfs, shouldn't quotas depend on at least one of those
>    being selected?

Because if we did that, we'd be setting ourselves up for a mess when
fs/xfs/xfs_qm.c eventually shows up - like it already has ;)

Also, from my (possibly incorrect) reading of kernel/sys.c and
fs/quota.c, there won't be a sys_quotactl() in the kernel.  As a
result, if you have users who have 'quota -v' in their .login, things
might get interesting.  So you might want a config where the quota
system call is there, even if it doesn't do anything incredibly
useful...

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-887247099P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+IQ/5cC3lWbTT17ARAhiIAKC6U4/pBnxTAZ8hRb+9UsJFZs/FYQCg99fM
OKk51k5ycOJaWUURiPBufd4=
=Onph
-----END PGP SIGNATURE-----

--==_Exmh_-887247099P--
