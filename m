Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbTCJLfV>; Mon, 10 Mar 2003 06:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbTCJLfV>; Mon, 10 Mar 2003 06:35:21 -0500
Received: from jello277.jellocom.de ([217.17.194.152]:11246 "EHLO
	jello277.jellocom.de") by vger.kernel.org with ESMTP
	id <S261300AbTCJLfU>; Mon, 10 Mar 2003 06:35:20 -0500
From: Thomas Bittermann <t.bittermann@online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix typo in drivers/net/Config.in, 2.4.21-pre5
Date: Mon, 10 Mar 2003 12:45:38 +0100
User-Agent: KMail/1.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200303101245.51899.t.bittermann@online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

this patch fixes the "define_mbool" typo in drivers/net/Config.in
introduced in 2.4.21-pre5.

<patch>
diff -ruN linux-2.4.21-pre5-ac2-fixed/drivers/net/Config.in linux-2.4.21-pre5-ac2/drivers/net/Config.in
- --- linux-2.4.21-pre5-ac2-fixed/drivers/net/Config.in   2003-03-07 08:37:49.000000000 +0100
+++ linux-2.4.21-pre5-ac2/drivers/net/Config.in 2003-03-07 09:42:45.000000000 +0100
@@ -185,7 +185,7 @@
       dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102 $CONFIG_PCI
       dep_tristate '    EtherExpressPro/100 support (eepro100, original Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
       if [ "$CONFIG_VISWS" = "y" ]; then
- -         define_mbool CONFIG_EEPRO100_PIO y
+         define_bool CONFIG_EEPRO100_PIO y
       else
          dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO $CONFIG_EEPRO100
       fi
</patch>

Greetings,
Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+bHrp3E3TGgPB70IRApx6AKCM5Oo71ZEzV9zWEl8jdL4pL1mdlgCgmuG8
yGzg+y4PC1xQlNh1pkLZK8M=
=GETl
-----END PGP SIGNATURE-----

