Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262315AbREUB3d>; Sun, 20 May 2001 21:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262316AbREUB3W>; Sun, 20 May 2001 21:29:22 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:6410 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262315AbREUB3M>; Sun, 20 May 2001 21:29:12 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105210129.DAA06203@green.mif.pg.gda.pl>
Subject: [PATCH] ppc xconfig 2.2.5-pre4
To: cort@fsmlabs.com, torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 21 May 2001 03:29:31 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes ppc xconfig potential problem introduced in
2.4.5-pre4.

Andrzej

***********************************************************************
diff -uNr linux-2.4.5-pre4/arch/ppc/config.in linux-pre4/arch/ppc/config.in
--- linux-2.4.5-pre4/arch/ppc/config.in	Mon May 21 03:17:02 2001
+++ linux-pre4/arch/ppc/config.in	Mon May 21 03:22:51 2001
@@ -135,7 +135,8 @@
      define_bool CONFIG_PCI $CONFIG_PCI_QSPAN
   else
      if [ "$CONFIG_APUS" = "y" ]; then
-       bool 'PCI for Permedia2' CONFIG_PCI
+       bool 'PCI for Permedia2' CONFIG_PCI_PERMEDIA
+       define_bool CONFIG_PCI $CONFIG_PCI_PERMEDIA
      else
        define_bool CONFIG_PCI y
      fi

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
