Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSHGFYj>; Wed, 7 Aug 2002 01:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSHGFYj>; Wed, 7 Aug 2002 01:24:39 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:40685 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317066AbSHGFYi>; Wed, 7 Aug 2002 01:24:38 -0400
Message-ID: <3D50AFEB.62B5D9A@attbi.com>
Date: Wed, 07 Aug 2002 01:28:11 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.30 i2c updates 1/4 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Please apply the following four patches that update
2.5.30 with these I2C changes:
o Support for SMBus 2.0 PEC Packet Error Checking
o New algorithm-i2c-algo-8xxx for MPC8XXX
o New algorithm-i2c-algo-ibm_ocp for IBM PPC 405
o New adapter-i2c-adap-ibm_ocp for IBM PPC 405
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-pcf-epp for PCF8584
o New adapter-i2c-pport for parallel port
o New adapter-i2c-rpx for embeded MPC8XX
o Replace depreciated cli()&sti() with spin_{un}lock_irq()
o Updated documentation
Thanks,
Albert
--- linux-2.5.30/drivers/i2c/Config.in.orig     2002-07-19 22:58:59.000000000 -0400
+++ linux/drivers/i2c/Config.in 2002-07-19 23:09:13.000000000 -0400
@@ -32,10 +32,10 @@
          dep_tristate '  Embedded Planet RPX Lite/Classic suppoort' CONFIG_I2C_RPXLITE $CONFIG_I2C_ALGO8XX
       fi
    fi
-   if [ "$CONFIG_405" = "y" ]; then
-      dep_tristate 'PPC 405 I2C Algorithm' CONFIG_I2C_PPC405_ALGO $CONFIG_I2C
-      if [ "$CONFIG_I2C_PPC405_ALGO" != "n" ]; then
-         dep_tristate '  PPC 405 I2C Adapter' CONFIG_I2C_PPC405_ADAP $CONFIG_I2C_PPC405_ALGO
+   if [ "$CONFIG_IBM_OCP" = "y" ]; then
+      dep_tristate 'IBM on-chip I2C Algorithm' CONFIG_I2C_IBM_OCP_ALGO $CONFIG_I2C
+      if [ "$CONFIG_I2C_IBM_OCP_ALGO" != "n" ]; then
+         dep_tristate '  IBM on-chip I2C Adapter' CONFIG_I2C_IBM_OCP_ADAP $CONFIG_I2C_IBM_OCP_ALGO
       fi
    fi
 

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
