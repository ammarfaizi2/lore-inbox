Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUBLFw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 00:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266294AbUBLFw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 00:52:28 -0500
Received: from h80ad25b9.async.vt.edu ([128.173.37.185]:56516 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266289AbUBLFw0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 00:52:26 -0500
Message-Id: <200402120552.i1C5qAHS024041@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4 
In-Reply-To: Your message of "Wed, 11 Feb 2004 23:22:36 +0100."
             <402AAB2C.8050207@gmx.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040115225948.6b994a48.akpm@osdl.org> <4007B03C.4090106@gmx.de> <400EC908.4020801@gmx.de> <200401211920.i0LJKZ2a003504@turing-police.cc.vt.edu>
            <402AAB2C.8050207@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_869715608P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Feb 2004 00:52:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_869715608P
Content-Type: text/plain; charset=us-ascii

On Wed, 11 Feb 2004 23:22:36 +0100, "Prakash K. Cheemplavam" said:

> > If this is the NVidia graphics driver, it's been doing it at least since 2.
5.6something,
> > at least that I've seen.  It's basically calling pci_find_slot in an interr
upt context,
> > which ends up calling pci_find_subsys which complains about it.  One possib
le
> > solution would be for the code to be changed to call pci_find_slot during m
odule
> > initialization and save the return value, and use that instead.  Yes, I kno
w this
> > prevents hotplugging.  Who hotplugs graphics cards? ;)
> 
> Could you advise me how to make a dirty hack to get this going? Once 
> again I am back to 2.6.1-rc1 kernel, which seems to be the last one 
> stable for me. 2.6.3-rc1-mm1 locked up quite fast..

1) 'badness in pci_find_subsys' is a warning only.  If your system is
locking up, there's something else at issue, probably.

2) NVidia released the 5336 level of drivers, which apparently have been
fixed to support 2.6 without the warning being triggered.

--==_Exmh_869715608P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAKxSIcC3lWbTT17ARAsKLAJ9XlhvUUtzDAIXe9w0aK1R7XOF4nwCglCfb
PisAQ2g1pe4C6OeQhucU0RE=
=mCYk
-----END PGP SIGNATURE-----

--==_Exmh_869715608P--
