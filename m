Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSCDAUa>; Sun, 3 Mar 2002 19:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSCDAUU>; Sun, 3 Mar 2002 19:20:20 -0500
Received: from [202.172.46.73] ([202.172.46.73]:26885 "HELO mail.celestix.com")
	by vger.kernel.org with SMTP id <S290713AbSCDAUF>;
	Sun, 3 Mar 2002 19:20:05 -0500
Date: Mon, 4 Mar 2002 07:37:29 +0800
From: Thibaut Laurent <thibaut@celestix.com>
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NatSemi SCx200 Support
Message-Id: <20020304073729.59946087.thibaut@celestix.com>
In-Reply-To: <20020302160110.11DE1F5B@acolyte.hack.org>
In-Reply-To: <Pine.LNX.4.21.0202281244330.2117-100000@freak.distro.conectiva>
	<20020302160110.11DE1F5B@acolyte.hack.org>
Organization: Celestix Networks Pte Ltd
X-Mailer: Sylpheed version 0.7.2claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Mar 2002 17:01:10 +0100 (CET)
Christer Weinigel <wingel@acolyte.hack.org> wrote:

 | Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
 | > Your patch does not apply cleanly to my tree, probably due to some
 | > already applied patches.
 | > 
 | > Please regenerate your patch against -pre2 as soon as its released.
 | 
 | This is an updated patch for SCx200 support.  This patch is against
 | linux-2.4.19-pre2 and adds support for some SCx200 specific features
 | such as the GPIO pins, the watchdog and flash mapping via the DOCCS
 | pin.  Compared to the earlier patch, I've cleaned up a few more
 | things, and have also added a driver for the ACCESS.bus found in the
 | SCx200 CPUs.

There's a typo in drivers/i2c/Config.in.
CONFIG_SCx200_I2C is defined but CONFIG_I2C_SCx200 is tested...

+      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_ARCH_SCx200 $CONFIG_I2C_ALGOBIT
+      if [ "$CONFIG_I2C_SCx200" != "n" ]; then
              ^^^^^^^^^^^^^^^^^
     this should be CONFIG_SCx200_I2C


Regards,

Thibaut

