Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUBIXP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUBIXOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:14:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:53433 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265366AbUBIXNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:13:44 -0500
Date: Mon, 9 Feb 2004 15:13:02 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fixes for 2.6.3-rc1
Message-ID: <20040209231301.GA2393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver updates for 2.6.3-rc1.  It's a few small
bugfixes and tree new i2c drivers.  All of the bugfixes and two of the
i2c drivers have been in the last few -mm trees with no problems.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 MAINTAINERS                    |   12 
 drivers/i2c/busses/Kconfig     |   12 
 drivers/i2c/busses/Makefile    |    1 
 drivers/i2c/busses/i2c-hydra.c |  186 +++++++++++
 drivers/i2c/chips/Kconfig      |   22 +
 drivers/i2c/chips/Makefile     |    2 
 drivers/i2c/chips/fscher.c     |  681 +++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/gl518sm.c    |  612 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/lm85.c       |    6 
 drivers/i2c/chips/w83l785ts.c  |   63 ++-
 drivers/i2c/i2c-core.c         |    2 
 include/linux/i2c-id.h         |    1 
 12 files changed, 1571 insertions(+), 29 deletions(-)
-----

<ender:debian.org>:
  o I2C: fix typos

Geert Uytterhoeven:
  o I2C: add Hydra i2c bus driver

Greg Kroah-Hartman:
  o I2C: fix oops when CONFIG_I2C_DEBUG_CORE is enabled and the bttv driver is loaded

Jean Delvare:
  o I2C: add new chip driver: fscher
  o I2C: Update I2C maintainers entry
  o I2C: add new driver, gl518sm
  o I2C: Handle read errors in w83l785ts
  o I2C: Bring w83l785ts in compliance with sysfs naming conventions

