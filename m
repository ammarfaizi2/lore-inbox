Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTI3Etl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 00:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTI3Etl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 00:49:41 -0400
Received: from h80ad253c.async.vt.edu ([128.173.37.60]:15488 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263117AbTI3Etj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 00:49:39 -0400
Message-Id: <200309300449.h8U4nSvl002308@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was Re: [PATCH] i386 do_machine_check() is redundant. 
In-Reply-To: Your message of "Mon, 29 Sep 2003 23:36:06 +0200."
             <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org> <1064775868.5045.4.camel@laptop.fenrus.com> <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz> <20030929202604.GA23344@nevyn.them.org>
            <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1727047812P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Sep 2003 00:49:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1727047812P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 Sep 2003 23:36:06 +0200, Mikulas Patocka said:

> and compile programs with -mregparm=3 -ffreestanding even on normal linux
> distribution. I didn't try it for larger program, for simple it works. (it
> works as long as program doesn't call libc function via pointer to
> function).

I discovered that -test6-mm1 doesn't build with -ffreestanding with gcc 3.3.1,
for an odd reason:  when I specify -ffreestanding, it generates 'call abs' calls
where it was able to do it inline otherwise. -ffreestanding says there's no library,
so it can't inline the library call (which leaves no external call to 'abs()').



--==_Exmh_1727047812P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/eQtXcC3lWbTT17ARAkFeAJ4qwGJVfZLbcrBsctmKUQxODnD6DQCeLNm1
YSLu18cXFseZ/qjiMJoCqwA=
=Vknt
-----END PGP SIGNATURE-----

--==_Exmh_1727047812P--
