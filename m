Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTEPRKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTEPRKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:10:53 -0400
Received: from camus.xss.co.at ([194.152.162.19]:29708 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264515AbTEPRKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:10:52 -0400
Message-ID: <3EC51E98.1070600@xss.co.at>
Date: Fri, 16 May 2003 19:23:36 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc2-ac2
References: <200305121756.h4CHu4t20051@devserv.devel.redhat.com>
In-Reply-To: <200305121756.h4CHu4t20051@devserv.devel.redhat.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

There are still a few glitches remaining (sorry, no patches yet)...

*) "make xconfig" fails
   (Again, but on a different place than in plain 2.4.21-rc2...
    kernel hackers just don't seem to like "make xconfig"...)

root@install:/usr/src/linux {511} $ make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.21-rc2-ac2/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/ide/Config.in: 69: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.21-rc2-ac2/scripts'
make: *** [xconfig] Error 2

*) Unresolved symbols in xfs.o
root@install:~ {501} $ depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc2-ac2/kernel/fs/xfs/xfs.o
depmod:         find_trylock_page
depmod:         path_lookup

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+xR6QxJmyeGcXPhERAtGEAJ4w83NzN/UV8kBJDGdrUnIbPADxoQCgkh5/
9pQCmndk6pIMA6W7H0qSsXc=
=e8mM
-----END PGP SIGNATURE-----

