Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSCDB1P>; Sun, 3 Mar 2002 20:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290796AbSCDB1E>; Sun, 3 Mar 2002 20:27:04 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:45062 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S289621AbSCDB0r>;
	Sun, 3 Mar 2002 20:26:47 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: thibaut@celestix.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20020304073729.59946087.thibaut@celestix.com> (message from
	Thibaut Laurent on Mon, 4 Mar 2002 07:37:29 +0800)
Subject: Re: [PATCH] NatSemi SCx200 Support
In-Reply-To: <Pine.LNX.4.21.0202281244330.2117-100000@freak.distro.conectiva>
	<20020302160110.11DE1F5B@acolyte.hack.org> <20020304073729.59946087.thibaut@celestix.com>
Message-Id: <20020304012642.D56C7F5B@acolyte.hack.org>
Date: Mon,  4 Mar 2002 02:26:42 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thibaut Laurent <thibaut@celestix.com> wrote:
> There's a typo in drivers/i2c/Config.in.
> CONFIG_SCx200_I2C is defined but CONFIG_I2C_SCx200 is tested...
> 
> +      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_ARCH_SCx200 $CONFIG_I2C_ALGOBIT
> +      if [ "$CONFIG_I2C_SCx200" != "n" ]; then
>               ^^^^^^^^^^^^^^^^^
>      this should be CONFIG_SCx200_I2C

You are absolutely correct.  I switched the names around and must have
missed that.  A patch is attached.

Thanks,
 /Christer

diff -ur linux/drivers/i2c/Config.in.orig linux/drivers/i2c/Config.in
--- linux/drivers/i2c/Config.in.orig	Mon Mar  4 01:24:27 2002
+++ linux/drivers/i2c/Config.in	Mon Mar  4 01:25:18 2002
@@ -14,7 +14,7 @@
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
       dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
       dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_ARCH_SCx200 $CONFIG_I2C_ALGOBIT
-      if [ "$CONFIG_I2C_SCx200" != "n" ]; then
+      if [ "$CONFIG_SCx200_I2C" != "n" ]; then
          int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL -1
          int  '    GPIO pin used for SDA' CONFIG_SCx200_I2C_SDA -1
       fi

-- 
"Just how much can I get away with and still go to heaven?"
