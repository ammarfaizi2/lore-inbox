Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUAHDDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUAHDDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:03:34 -0500
Received: from h80ad2593.async.vt.edu ([128.173.37.147]:28800 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263605AbUAHDDb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:03:31 -0500
Message-Id: <200401072038.i07KcDwL017059@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Richard Troth <rtroth@bmc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev 
In-Reply-To: Your message of "Wed, 07 Jan 2004 14:25:44 CST."
             <Pine.LNX.4.53.0401071418300.7097@rmt-desk.bmc.com> 
From: Valdis.Kletnieks@vt.edu
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <Pine.LNX.4.58.0401071123490.12602@home.osdl.org> <20040107195032.GB823@kroah.com>
            <Pine.LNX.4.53.0401071418300.7097@rmt-desk.bmc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1099027620P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Jan 2004 15:38:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1099027620P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Jan 2004 14:25:44 CST, Richard Troth said:

> Consider the long-range ramifications
> if a device can also be a directory,  just "magically".
> I'm not going to automatically diss the idea  (other than my
> natural reaction above)  but please consider beyond the immediate hack.

If it's so ugly, why do Solaris and Irix not have a problem in making a
device graph that looks somewhat like that as well?  The idea is *not*
so crazy as to discard out-of-hand.  Perhaps what you need is:

/dev/hda/disk  whole-disk access
/dev/hda/0     partition 0
/dev/hda/1     partition 1
... etc

> It reminds me of AIX from the days when it ran on PCs.
> They had this neat trick of  "hidden directories"  (for a different
> purpose).   It looked like an executable,  but really was a
> directory containing multiple executables for various platforms.
> (This version of AIX also ran on the mainframe, AIX/386 and AIX/370.)
> There were/are better ways of solving the problem they were addressing.

You think that was ugly, you should have seen it around the F17 level when
there were still some bugs in there (you haven't lived till you see the ooglyness
of an 'rsh' between TCF cluster members of different flavors - it propagated
the environment variable that controlled that stuff.. :)

Incidentally, I'm told that HP/UX has a similar concept, at least in some
releases...


--==_Exmh_1099027620P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE//G40cC3lWbTT17ARAqcvAJ9plo3py/o6fNMrdQ8qsNGtxOSSBACffe3i
2PkjanrvzGqr0bT4iko0N5Q=
=ZETh
-----END PGP SIGNATURE-----

--==_Exmh_1099027620P--
