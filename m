Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbUB2HwH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUB2HwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:52:07 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:20913 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262004AbUB2HwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:52:01 -0500
Message-ID: <40419A1C.5070103@helsinki.fi>
Date: Sun, 29 Feb 2004 09:51:56 +0200
From: Kliment Yanev <Kliment.Yanev@helsinki.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
References: <40408852.8040608@helsinki.fi> <20040228104105.5a699d32.rddunlap@osdl.org>
In-Reply-To: <20040228104105.5a699d32.rddunlap@osdl.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Randy.Dunlap wrote:
| All those errors should go away if you build the module correctly.
| Please read Documentation/kbuild/m*.txt or see LWN.net article
| on building modules:
|   http://lwn.net/Articles/21823/

Okay, using a kbuild makefile I still get tons of errors, though most of
the original ones are gone:

make -C /lib/modules/2.6.3-rc2-mm1/build
SUBDIRS=/home/kliment/Desktop/nokia_c110/src modules
make[1]: Entering directory `/usr/src/linux-2.6.3-rc2-mm1'
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
~  CHK     include/asm-i386/asm_offsets.h
~  CC [M]  /home/kliment/Desktop/nokia_c110/src/dmodule.o
In file included from /home/kliment/Desktop/nokia_c110/src/nokia_info.h:89,
~                 from /home/kliment/Desktop/nokia_c110/src/dmodule.c:35:
/home/kliment/Desktop/nokia_c110/src/nokia_priv.h:43:1: warning: "HZ"
redefined
In file included from include/linux/sched.h:4,
~                 from include/linux/module.h:10,
~                 from /home/kliment/Desktop/nokia_c110/src/nokia_info.h:42,
~                 from /home/kliment/Desktop/nokia_c110/src/dmodule.c:35:
include/asm/param.h:5:1: warning: this is the location of the previous
definition
/home/kliment/Desktop/nokia_c110/src/dmodule.c:57: warning: static
declaration for `cs_error' follows non-static
/home/kliment/Desktop/nokia_c110/src/dmodule.c: In function `cs_error':
/home/kliment/Desktop/nokia_c110/src/dmodule.c:61: warning: implicit
declaration of function `CardServices'
/home/kliment/Desktop/nokia_c110/src/dmodule.c: In function `d_init_module':
/home/kliment/Desktop/nokia_c110/src/dmodule.c:115: warning: implicit
declaration of function `register_pcmcia_driver'
/home/kliment/Desktop/nokia_c110/src/dmodule.c: In function
`d_cleanup_module':
/home/kliment/Desktop/nokia_c110/src/dmodule.c:124: warning: implicit
declaration of function `unregister_pccard_driver'
/home/kliment/Desktop/nokia_c110/src/dmodule.c: In function
`d_driver_attach':
/home/kliment/Desktop/nokia_c110/src/dmodule.c:182: error: structure has
no member named `release'
/home/kliment/Desktop/nokia_c110/src/dmodule.c:183: error: structure has
no member named `release'
/home/kliment/Desktop/nokia_c110/src/dmodule.c: In function
`d_driver_event':
/home/kliment/Desktop/nokia_c110/src/dmodule.c:401: error: structure has
no member named `release'
/home/kliment/Desktop/nokia_c110/src/dmodule.c:402: error: structure has
no member named `release'
/home/kliment/Desktop/nokia_c110/src/dmodule.c:407: error: structure has
no member named `bus'
make[2]: *** [/home/kliment/Desktop/nokia_c110/src/dmodule.o] Error 1
make[1]: *** [/home/kliment/Desktop/nokia_c110/src] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.3-rc2-mm1'
make: *** [default] Error 2


Other than the param.h error, all the errors related to kernel headers
are gone now. Thank you for the suggestion. However, what do I do next?
I got the pci-pcmcia converter working btw. It needed its base address
entered manually as well as irq scanning disabled and it would hang the
machine otherwise...Therefore I can test this now if it compiles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAQZocrPQTyNB9u9YRAtx8AKCBm+p8mSJYSDq0BO5kojTVkSTkKQCgoY+a
lR6FZayR6upvyBNtLnahoUo=
=WsqF
-----END PGP SIGNATURE-----
