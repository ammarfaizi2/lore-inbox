Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264786AbUEKPce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbUEKPce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264787AbUEKPce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:32:34 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:63363 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264786AbUEKPcc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:32:32 -0400
Message-Id: <200405111532.i4BFWQIs029188@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: John McGowan <jmcgowan@inch.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: Kernel 2.6.6: Removing the last large file does not reset filesystem properties 
In-Reply-To: Your message of "Tue, 11 May 2004 09:00:33 EDT."
             <20040511084510.J33555@shell.inch.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040511002008.GA2672@localhost.localdomain> <20040511004956.70f7e17d.akpm@osdl.org>
            <20040511084510.J33555@shell.inch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-262474000P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 11:32:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-262474000P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2004 09:00:33 EDT, John McGowan said:

> fsck does fix it. Or should the removal of the last large file have
> resulted in the change without the mismatch between the "largefile"
> property being set with no large files?

Then fsck should exit RC=1.   At least the Fedora Core 2 initscripts think
that's OK and specifically check for that case (a few lines later it remounts /
r/w, which *should* refresh all the important in-core blocks that might have
gotten changed out from under it - I think. If that's not true, somebody squawk
so we can fix that assumption in the initscrips. ;)

> I know what's happening and how to patch the initscript to get an
> automatic reboot on exit code 2. Is that the proper way to handle it?

NO.

Consider - if you *do* scrog your filesystem, you'll get hung in a loop
of fsck/reboot/fsck/reboot/fsck/reboot.  You really *do* want the system
to yell for help from a human at that point....


--==_Exmh_-262474000P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoPIKcC3lWbTT17ARAivcAJ4qHAMgY3M5g4RuSKFxWy2VyNrTVwCdEiMa
XrMRv0S4ph6jo1Xtyi533uw=
=GrJZ
-----END PGP SIGNATURE-----

--==_Exmh_-262474000P--
