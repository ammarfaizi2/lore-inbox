Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSLNT2w>; Sat, 14 Dec 2002 14:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSLNT2w>; Sat, 14 Dec 2002 14:28:52 -0500
Received: from 205-158-62-131.outblaze.com ([205.158.62.131]:50048 "HELO
	ws5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S265830AbSLNT2v>; Sat, 14 Dec 2002 14:28:51 -0500
Message-ID: <20021214193638.32177.qmail@operamail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Matthew Bell" <mwsb@operamail.com>
To: Philip.Blundell@pobox.com, linux-parport@torque.net,
       marcelo@connectiva.com.br, linux-kernel@vger.kernel.org
Date: Sun, 15 Dec 2002 03:36:38 +0800
Subject: [PATCH] Obvious: parport_serial depends on PCI.
X-Originating-Ip: 195.10.122.134
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is valid for 2.4.20 and earlier at the least; just annoying and pedantic really...
--- linux.orig/drivers/parport/Config.in        2001-12-21 17:41:55.000000000 +0000
+++ linux/drivers/parport/Config.in     2002-08-06 18:52:21.000000000 +0100
@@ -17,7 +17,7 @@
       else
          define_tristate CONFIG_PARPORT_PC_CML1 $CONFIG_PARPORT_PC
       fi
-      dep_tristate '    Multi-IO cards (parallel and serial)' CONFIG_PARPORT_SERIAL $CONFIG_PARPORT_PC_CML1
+      dep_tristate '    Multi-IO cards (parallel and serial)' CONFIG_PARPORT_SERIAL $CONFIG_PARPORT_PC_CML1 $CONFIG_PCI
    fi
    if [ "$CONFIG_PARPORT_PC" != "n" ]; then
       if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then

-- 
_______________________________________________
Get your free email from http://mymail.operamail.com

Powered by Outblaze
