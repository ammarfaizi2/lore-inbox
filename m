Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263967AbTEWJCB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTEWJCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:02:01 -0400
Received: from N061P016.adsl.highway.telekom.at ([213.33.7.144]:55425 "EHLO
	server.lan") by vger.kernel.org with ESMTP id S263967AbTEWJB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:01:59 -0400
From: Melchior FRANZ <mfranz@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc3
Date: Fri, 23 May 2003 09:00:12 +0200
User-Agent: KMail/1.5.9
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200305230900.18528@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti -- Friday 23 May 2003 00:47:
> Here goes the third release candidate of 2.4.21.

o The i2c "Philips style parallel port adapter" is only selectable
  as a module in "make menuconfig", although the help text suggests
  that it can be compiled in.

o With all i2c options activated, I still get this:
  drivers/i2c/i2c.o: In function `scx200_i2c_setscl':
  drivers/i2c/i2c.o(.text+0x636f): undefined reference to `scx200_gpio_base'
  drivers/i2c/i2c.o(.text+0x6396): undefined reference to `scx200_gpio_shadow'
  drivers/i2c/i2c.o(.text+0x63a1): undefined reference to `scx200_gpio_shadow'
  drivers/i2c/i2c.o(.text+0x63b4): undefined reference to `scx200_gpio_shadow'
  drivers/i2c/i2c.o: In function `scx200_i2c_setsda':
  drivers/i2c/i2c.o(.text+0x63cf): undefined reference to `scx200_gpio_base'
  drivers/i2c/i2c.o(.text+0x63f6): undefined reference to `scx200_gpio_shadow'
  drivers/i2c/i2c.o(.text+0x6401): undefined reference to `scx200_gpio_shadow'
  drivers/i2c/i2c.o(.text+0x6414): undefined reference to `scx200_gpio_shadow'
  drivers/i2c/i2c.o: In function `scx200_i2c_getscl':
  drivers/i2c/i2c.o(.text+0x6423): undefined reference to `scx200_gpio_base'
  drivers/i2c/i2c.o: In function `scx200_i2c_getsda':
  drivers/i2c/i2c.o(.text+0x6463): undefined reference to `scx200_gpio_base'
  drivers/i2c/i2c.o: In function `scx200_i2c_init':
  drivers/i2c/i2c.o(.text+0x64f0): undefined reference to `scx200_gpio_base'
  drivers/i2c/i2c.o(.text+0x655b): undefined reference to `scx200_gpio_configure'
  drivers/i2c/i2c.o(.text+0x6578): undefined reference to `scx200_gpio_configure'

o Some help texts are missing, e.g for
  "Generic PCI IDE Chipset Support"
  i2c/"NatSemi SCx200 I2C using GPIO pins"

Apart from that, 2.4.21-rc3 compiles, boots and runs OK.

m.
