Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129990AbQKJMhF>; Fri, 10 Nov 2000 07:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130439AbQKJMg4>; Fri, 10 Nov 2000 07:36:56 -0500
Received: from mxbh4.isus.emc.com ([168.159.208.52]:32260 "EHLO
	mxbh4.isus.emc.com") by vger.kernel.org with ESMTP
	id <S129990AbQKJMge>; Fri, 10 Nov 2000 07:36:34 -0500
Message-ID: <51FA50304EBCD2119EEC00A0C9F2C9D0B1C427@ITMI1MX1>
From: Ballabio_Dario@emc.com
To: linux-kernel@vger.kernel.org
Subject: PATCH:  Pcmcia/Cardbus/xircom_tulip in 2.4.0-test10. 
Date: Fri, 10 Nov 2000 07:36:15 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have the xircom_tulip pcmcia cardbus working again with 
recent kernels, it is necessary to specify:
 
ifconfig eth0 -multicast

Moreover if the card is configured by itself into the kernel 
(i.e. with the default ne2000 pcmcia support removed),
the enclosed patch is required as well.

Cheers,

*******************************************
Ph.D. Dario Ballabio
Regional Installation Manager Europe South
EMC Computer Systems Italia spa
Mobile phone +393487978851
Office phone +390244571315
Email ballabio_dario@emc.com

diff -r -u linux-2.4.0-test10/drivers/net/pcmcia/Config.in
linux/drivers/net/pcmcia/Config.in
--- linux-2.4.0-test10/drivers/net/pcmcia/Config.in	Sun Aug 13 19:21:20
2000
+++ linux/drivers/net/pcmcia/Config.in	Wed Nov  1 17:55:18 2000
@@ -36,7 +36,8 @@
      "$CONFIG_PCMCIA_FMVJ18X" = "y" -o "$CONFIG_PCMCIA_PCNET" = "y" -o \
      "$CONFIG_PCMCIA_NMCLAN" = "y" -o "$CONFIG_PCMCIA_SMC91C92" = "y" -o \
      "$CONFIG_PCMCIA_XIRC2PS" = "y" -o "$CONFIG_PCMCIA_RAYCS" = "y" -o \
-     "$CONFIG_PCMCIA_NETWAVE" = "y" -o "$CONFIG_PCMCIA_WAVELAN" = "y" ];
then
+     "$CONFIG_PCMCIA_NETWAVE" = "y" -o "$CONFIG_PCMCIA_WAVELAN" = "y" -o \
+     "$CONFIG_PCMCIA_XIRTULIP" = "y" ]; then
    define_bool CONFIG_PCMCIA_NETCARD y
 fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
