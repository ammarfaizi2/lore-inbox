Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQLPLGz>; Sat, 16 Dec 2000 06:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbQLPLGp>; Sat, 16 Dec 2000 06:06:45 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:9485 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129752AbQLPLGi>; Sat, 16 Dec 2000 06:06:38 -0500
Message-ID: <3A3B53BE.41C31B99@t-online.de>
Date: Sat, 16 Dec 2000 12:36:30 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Patch: test13-pre2 fails "make xconfig" in isdn/Config.in
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
apply this patch if like to fix this obvious error
with "make xconfig" on plain tree:
	./tkparse < ../arch/i386/config.in >> kconfig.tk
	drivers/isdn/Config.in: 98: can't handle dep_bool/dep_mbool/dep_tristate condition
	make[1]: *** [kconfig.tk] Error 1
	make[1]: Leaving directory `/usr/src/linux/scripts'

-
Gunther




--- linux/drivers/isdn/Config.in-240t13pre2-orig        Sat Dec 16 12:20:59 2000
+++ linux/drivers/isdn/Config.in        Sat Dec 16 12:21:48 2000
@@ -95,7 +95,7 @@
       dep_bool  '    Eicon PCI DIVA Server BRI/PRI/4BRI support' CONFIG_ISDN_DRV_EICON_PCI $CONFIG_PCI
       bool      '    Eicon S,SX,SCOM,Quadro,S2M support' CONFIG_ISDN_DRV_EICON_ISA
    fi
-   dep_tristate '  Build Eicon driver type standalone' CONFIG_ISDN_DRV_EICON_DIVAS
+   bool '  Build Eicon driver type standalone' CONFIG_ISDN_DRV_EICON_DIVAS
 fi
 
 # CAPI subsystem
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
