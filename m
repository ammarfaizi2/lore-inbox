Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTJUBUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTJUBUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:20:12 -0400
Received: from h80ad257c.async.vt.edu ([128.173.37.124]:12416 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263036AbTJUBUH (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:20:07 -0400
Message-Id: <200310210120.h9L1K3Fg002814@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8 - CONFIG_PCI_CONSOLE
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1900595014P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Oct 2003 21:20:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1900595014P
Content-Type: text/plain; charset=us-ascii

in drivers/video/console/Kconfig, we have:

config PCI_CONSOLE
        bool
        depends on FRAMEBUFFER_CONSOLE
        default y

However, it's unclear what this variable actually *DOES*:

[/usr/src/linux-2.6.0-test8-mm1-a]2 find . ! -name '*.o' | xargs grep PCI_CONS
./drivers/video/console/Kconfig:config PCI_CONSOLE
./arch/ppc/configs/power3_defconfig:CONFIG_PCI_CONSOLE=y
./arch/ppc/configs/common_defconfig:CONFIG_PCI_CONSOLE=y
./arch/ppc/configs/sandpoint_defconfig:CONFIG_PCI_CONSOLE=y
./arch/ppc/configs/ibmchrp_defconfig:CONFIG_PCI_CONSOLE=y
./arch/ppc/configs/pmac_defconfig:CONFIG_PCI_CONSOLE=y
./arch/ppc/defconfig:CONFIG_PCI_CONSOLE=y
./arch/sparc64/defconfig:CONFIG_PCI_CONSOLE=y
./arch/ia64/defconfig:CONFIG_PCI_CONSOLE=y
./arch/ppc64/defconfig:CONFIG_PCI_CONSOLE=y
./arch/parisc/defconfig:CONFIG_PCI_CONSOLE=y
./.config.old:CONFIG_PCI_CONSOLE=y
./config.old:CONFIG_PCI_CONSOLE=y

References in defconfig files, and in my .config, and that's about it...

It's been apparently dead code at least as far back as -test5-mm3.

--==_Exmh_1900595014P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/lInDcC3lWbTT17ARAixLAJ4r79yKS31IVMhkJg+wQO5jDFMDRgCgkK5k
s/HdoAVN4BN7V4s3BcuxWlE=
=zUtw
-----END PGP SIGNATURE-----

--==_Exmh_1900595014P--
