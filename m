Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUBDROb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUBDROa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:14:30 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:27008 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263850AbUBDRO2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:14:28 -0500
Message-Id: <200402041714.i14HEIVD005246@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Bill Davidsen <davidsen@tmr.com>
Cc: the grugq <grugq@hcunix.net>, "Theodore Ts'o" <tytso@mit.edu>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch 
In-Reply-To: Your message of "Wed, 04 Feb 2004 12:05:07 EST."
             <40212643.4000104@tmr.com> 
From: Valdis.Kletnieks@vt.edu
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz> <20040204062936.GA2663@thunk.org> <4020EEB0.50002@hcunix.net>
            <40212643.4000104@tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1074340878P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Feb 2004 12:14:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1074340878P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 Feb 2004 12:05:07 EST, Bill Davidsen said:

> It would be useful to have this as a directory option, so that all files 
> in directory would be protected. I think wherever you do it you have to 
> prevent hard links, so that unlink really removes the data.

This of course implies that 'chattr +s' (or whatever it was) has to fail
if the link count isn't exactly one.  Also makes for lots of uglyiness
if it's a directory option - you then have to walk all the entries in the
directory and check *their* link counts.  Bad Juju doing it in the kernel
if you have a directory with a million entries - and racy as hell if you
do it in userspace.

--==_Exmh_1074340878P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIShqcC3lWbTT17ARAlCmAKCMlmrBT0afpFha7+Sq5NACsrZnkACg6MMe
5pSmkJD7jg8u3/N+JhO7FxA=
=bIOC
-----END PGP SIGNATURE-----

--==_Exmh_1074340878P--
