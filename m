Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSHGXsf>; Wed, 7 Aug 2002 19:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSHGXse>; Wed, 7 Aug 2002 19:48:34 -0400
Received: from 205-158-62-131.outblaze.com ([205.158.62.131]:43241 "HELO
	ws5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S316857AbSHGXsP>; Wed, 7 Aug 2002 19:48:15 -0400
Message-ID: <20020807235150.11721.qmail@operamail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Matthew Bell" <mwsb@operamail.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Date: Thu, 08 Aug 2002 07:51:50 +0800
Subject: [PATCH] 2.4.19; drivers/parport/Config.in (parport_serial)
    <should depend on CONFIG_PCI>
X-Originating-Ip: 195.10.121.242
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Presumamby parport_serial.c should depend on CONFIG_PCI?
---parport_serial.diff------------------------------------- linux-2.4.19.orig/drivers/parport/Config.in 2001-12-21 17:41:55.000000000 +0000
+++ linux-2.4.19/drivers/parport/Config.in      2002-08-06 18:52:21.000000000 +0100
@@ -17,7 +17,7 @@
       else
          define_tristate CONFIG_PARPORT_PC_CML1 $CONFIG_PARPORT_PC
       fi
-      dep_tristate '    Multi-IO cards (parallel and serial)' CONFIG_PARPORT_SERIAL $CONFIG_PARPORT_PC_CML1
+      dep_tristate '    Multi-IO cards (parallel and serial)' CONFIG_PARPORT_SERIAL $CONFIG_PARPORT_PC_CML1 $CONFIG_PCI
    fi
    if [ "$CONFIG_PARPORT_PC" != "n" ]; then
       if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
---parport_serial.diff----------------------------------
-- 
_______________________________________________
Download the free Opera browser at http://www.opera.com/

Free OperaMail at http://www.operamail.com/

Powered by Outblaze
