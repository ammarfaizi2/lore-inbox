Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262530AbRE3Ats>; Tue, 29 May 2001 20:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbRE3Ati>; Tue, 29 May 2001 20:49:38 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:6159 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262530AbRE3At2>; Tue, 29 May 2001 20:49:28 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300048.CAA04583@green.mif.pg.gda.pl>
Subject: [PATCH] net #9
To: alan@lxorguk.ukuu.org.uk (Alan Cox), jt@hpl.hp.com, tori@unhappy.mine.nu
Date: Wed, 30 May 2001 02:48:24 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch removes some zero initializers from statics

Andrzej

**************************** PATCH 9 *****************************
diff -uNr linux-2.4.5-ac4/drivers/net/dmfe.c linux/drivers/net/dmfe.c
--- linux-2.4.5-ac4/drivers/net/dmfe.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/dmfe.c	Wed May 30 01:16:04 2001
@@ -261,20 +261,20 @@
 static char version[] __devinitdata =
 	KERN_INFO "Davicom DM9xxx net driver, version " DMFE_VERSION "\n";
 
-static int dmfe_debug = 0;
+static int dmfe_debug;
 static unsigned char dmfe_media_mode = DMFE_AUTO;
-static u32 dmfe_cr6_user_set = 0;
+static u32 dmfe_cr6_user_set;
 
 /* For module input parameter */
-static int debug = 0;
-static u32 cr6set = 0;
+static int debug;
+static u32 cr6set;
 static unsigned char mode = 8;
 static u8 chkmode = 1;
-static u8 HPNA_mode = 0;	/* Default: Low Power/High Speed */
-static u8 HPNA_rx_cmd = 0;	/* Default: Disable Rx remote command */
-static u8 HPNA_tx_cmd = 0;	/* Default: Don't issue remote command */
-static u8 HPNA_NoiseFloor = 0;	/* Default: HPNA NoiseFloor */
-static u8 SF_mode = 0;		/* Special Function: 1:VLAN, 2:RX Flow Control
+static u8 HPNA_mode;		/* Default: Low Power/High Speed */
+static u8 HPNA_rx_cmd;		/* Default: Disable Rx remote command */
+static u8 HPNA_tx_cmd;		/* Default: Don't issue remote command */
+static u8 HPNA_NoiseFloor;	/* Default: HPNA NoiseFloor */
+static u8 SF_mode;		/* Special Function: 1:VLAN, 2:RX Flow Control
 				   4: TX pause packet */
 
 unsigned long CrcTable[256] = {
diff -uNr linux-2.4.5-ac4/drivers/net/wavelan.p.h linux/drivers/net/wavelan.p.h
--- linux-2.4.5-ac4/drivers/net/wavelan.p.h	Wed May 30 01:08:56 2001
+++ linux/drivers/net/wavelan.p.h	Wed May 30 01:16:05 2001
@@ -699,9 +699,9 @@
 
 #ifdef	MODULE
 /* Parameters set by insmod */
-static int	io[4]	= { 0, 0, 0, 0 };
-static int	irq[4]	= { 0, 0, 0, 0 };
-static char	name[4][IFNAMSIZ] = { "", "", "", "" };
+static int	io[4];
+static int	irq[4];
+static char	name[4][IFNAMSIZ];
 MODULE_PARM(io, "1-4i");
 MODULE_PARM(irq, "1-4i");
 MODULE_PARM(name, "1-4c" __MODULE_STRING(IFNAMSIZ));


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
