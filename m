Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUBYDBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBYDBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:01:53 -0500
Received: from smtp1.cwidc.net ([154.33.63.111]:55178 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S262422AbUBYDBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:01:47 -0500
Message-ID: <403C1011.5020400@tequila.co.jp>
Date: Wed, 25 Feb 2004 12:01:37 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040210
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Adaptec I2O raid driver in linux 2.6.3
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

actually heard Adaptec should have released 5 months ago or so ...
anyway, comiling Adpatec I2O raid controller into kernel fails:

make -f scripts/Makefile.build obj=drivers/scsi
~  gcc -Wp,-MD,drivers/scsi/.dpt_i2o.o.d -nostdinc -iwithprefix include
- -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall
- -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
- -pipe -mpreferred-stack-boundary=2 -march=pentium4
- -Iinclude/asm-i386/mach-default -O2     -DKBUILD_BASENAME=dpt_i2o
- -DKBUILD_MODNAME=dpt_i2o -c -o drivers/scsi/dpt_i2o.o
drivers/scsi/dpt_i2o.c
drivers/scsi/dpt_i2o.c:32:2: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/scsi/dpt_i2o.c: In function `adpt_install_hba':
drivers/scsi/dpt_i2o.c:977: warning: passing arg 2 of `request_irq' from
incompatible pointer type
drivers/scsi/dpt_i2o.c: In function `adpt_scsi_to_i2o':
drivers/scsi/dpt_i2o.c:2118: error: structure has no member named `address'
drivers/scsi/dpt_i2o.c: At top level:
drivers/scsi/dpt_i2o.c:165: warning: `dptids' defined but not used
make[2]: *** [drivers/scsi/dpt_i2o.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

I think I don't need to attach my .config here
- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPBAQjBz/yQjBxz8RAlnGAJ0dUiddig2sQduzBFv2A9RcC2CW2wCeKiW+
e/UT9h4vfmn1towCua8rUOM=
=Am9Z
-----END PGP SIGNATURE-----
