Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTCJLHW>; Mon, 10 Mar 2003 06:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTCJLHW>; Mon, 10 Mar 2003 06:07:22 -0500
Received: from jello277.jellocom.de ([217.17.194.152]:39917 "EHLO
	jello277.jellocom.de") by vger.kernel.org with ESMTP
	id <S261290AbTCJLHV>; Mon, 10 Mar 2003 06:07:21 -0500
To: linux-kernel@vger.kernel.org
From: Thomas Bittermann <t.bittermann@jetzweb.de>
Subject: [PATCH] fix typo in drivers/net/Config.in, 2.4.21-pre5
Reply-To: t.bittermann@jetzweb.de
CC: Marcelo Tosatti <marcelo@freak.distro.conectiva>
Date: Mon, 10 Mar 2003 12:14:57 +0100
X-Originating-Host: 141.35.213.161 [141.35.213.161]; Mon, 10 Mar 2003 11:17:59 GMT
X-Mailer: jetzweb.de v1.0 (2001-05-31)
X-Browser: Mozilla/4.0 (compatible; MSIE 6.0; Linux 2.4.21-xsk0.9 i686) Opera 7.00  [en], JavaScript: On
Message-ID: <jUsT.aNoTheR.mEsSaGe.iD.104729507930525@mail.jetzweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch fixes the "define_mbool" typo in drivers/net/Config.in 
introduced in 2.4.21-pre5.

<patch>
diff -ruN linux-2.4.21-pre5-ac2-fixed/drivers/net/Config.in linux-
2.4.21-pre5-ac2/drivers/net/Config.in
--- linux-2.4.21-pre5-ac2-fixed/drivers/net/Config.in   2003-03-07 
08:37:49.000000000 +0100
+++ linux-2.4.21-pre5-ac2/drivers/net/Config.in 2003-03-07 09:42:
45.000000000 +0100
@@ -185,7 +185,7 @@
       dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102 
$CONFIG_PCI
       dep_tristate '    EtherExpressPro/100 support (eepro100, original 
Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
       if [ "$CONFIG_VISWS" = "y" ]; then
-         define_mbool CONFIG_EEPRO100_PIO y
+         define_bool CONFIG_EEPRO100_PIO y
       else
          dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO 
$CONFIG_EEPRO100
       fi
</patch>

Thomas






