Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbREaKNW>; Thu, 31 May 2001 06:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263064AbREaKNL>; Thu, 31 May 2001 06:13:11 -0400
Received: from krynn.axis.se ([193.13.178.10]:43968 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S263060AbREaKNF>;
	Thu, 31 May 2001 06:13:05 -0400
Date: Thu, 31 May 2001 12:14:06 +0200 (CEST)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Only 5 undocumented configuration symbols left
In-Reply-To: <20010530190744.A2027@thyrsus.com>
Message-ID: <Pine.LNX.4.21.0105311213261.28884-100000@godzilla.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Eric S. Raymond wrote:
> CONFIG_ETRAX_FLASH_BUSWIDTH
> CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C

--- Configure.help      2001/05/08 14:22:21     1.24
+++ Configure.help      2001/05/31 10:11:20
@@ -17564,6 +17564,10 @@
 CONFIG_ETRAX_DRAM_SIZE
   Size of DRAM (decimal in MB) typically 2, 8 or 16.
 
+ETRAX Flash Memory configuration
+CONFIG_ETRAX_FLASH_BUSWIDTH
+  Width in bytes of the Flash bus (1, 2 or 4). Is usually 2.
+
 LED configuration on PA
 CONFIG_ETRAX_PA_LEDS
   The Etrax network driver is responsible for flashing LED's when
@@ -17991,6 +17995,14 @@
        ioctl(fd, _IO(ETRAXI2C_IOCTYPE, I2C_WRITEREG), i2c_arg);
        i2c_arg = I2C_READARG(STA013_READ_ADDR, reg);
        val = ioctl(fd, _IO(ETRAXI2C_IOCTYPE, I2C_READREG), i2c_arg);
+
+Etrax100 I2C configuration
+CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C
+  Select whether to use the special I2C mode in the PB I/O register or
+  not. This option needs to be selected in order to use some drivers that
+  accesses the I2C I/O pins directly instead of going through the I2C
+  driver, like the DS1302 realtime-clock driver. If you are uncertain, 
+  choose yes here.
 
 Etrax100 I2C EEPROM (NVRAM) support
 CONFIG_ETRAX_I2C_EEPROM



