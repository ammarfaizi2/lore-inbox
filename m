Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTJVCcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 22:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTJVCcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 22:32:51 -0400
Received: from h80ad256b.async.vt.edu ([128.173.37.107]:63872 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263339AbTJVCcu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 22:32:50 -0400
Message-Id: <200310220232.h9M2WY08007068@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in 
In-Reply-To: Your message of "Tue, 21 Oct 2003 17:53:46 EDT."
             <20031021215346.GA15109@thunk.org> 
From: Valdis.Kletnieks@vt.edu
References: <175701c397e6$b36e5310$24ee4ca5@DIAMONDLX60> <20031021193128.GA18618@helium.inexs.com> <Pine.LNX.4.53.0310211558500.19942@chaos> <200310212021.h9LKLQK3009397@turing-police.cc.vt.edu>
            <20031021215346.GA15109@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1292895902P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Oct 2003 22:32:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1292895902P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Oct 2003 17:53:46 EDT, "Theodore Ts'o" said:

> Read the e2fsck man page, and pay attention to the -c, -l, and -L
> options....

Yes, I knew this was doable if the filesystem was unmounted - the fun is of
course that if you get a bad block in /usr or someplace similar, it would
REALLY be nice to be able to do something about it without taking it offline..

The cynic in me says that if I have to take it down to flag a bad block, I'm
going to use the downtime to just replace the *bleep*ing thing with something
more acquainted with the concept of block relocation - if it didn't relocate
it, either the relocation sectors are used up or the drive has pessimal
microcode, both of which are bad news.

I admit I haven't cooked up a test filesystem and actually checked what happens
if you feed the -l flag a block that's already in a file (presumably it
deallocates it from the inode and leaves a sparse hole) or a block that
contains inodes or a superblock copy...


--==_Exmh_1292895902P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/lexCcC3lWbTT17ARAvQsAJ93RjELxda7xicV75qeM9tp29blcwCg+5kL
zqAKd2nfnCfxnyKkHvCYPOk=
=5vvq
-----END PGP SIGNATURE-----

--==_Exmh_1292895902P--
