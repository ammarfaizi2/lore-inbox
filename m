Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272221AbTHIAg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272215AbTHIAda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:33:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:61375 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272164AbTHIAc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:26 -0400
Date: Fri, 8 Aug 2003 16:55:02 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] More i2c driver fixes for 2.6.0-test2
Message-ID: <20030808235501.GA2795@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more i2c driver fixes for 2.6.0-test2.  They include a fix
for the driver model code (no release function, so easy oopses could
happen by users), and removing usage of the struct device.name field as
that is about to go away.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/i2c-ali1535.c          |    6 +----
 drivers/i2c/busses/i2c-ali15x3.c          |    6 +----
 drivers/i2c/busses/i2c-amd756.c           |    6 +----
 drivers/i2c/busses/i2c-amd8111.c          |    2 -
 drivers/i2c/busses/i2c-i801.c             |    6 +----
 drivers/i2c/busses/i2c-isa.c              |    4 ---
 drivers/i2c/busses/i2c-nforce2.c          |    6 +----
 drivers/i2c/busses/i2c-piix4.c            |    8 ++----
 drivers/i2c/busses/i2c-sis96x.c           |    6 +----
 drivers/i2c/busses/i2c-viapro.c           |    6 +----
 drivers/i2c/chips/adm1021.c               |    2 -
 drivers/i2c/chips/it87.c                  |    2 -
 drivers/i2c/chips/lm75.c                  |    2 -
 drivers/i2c/chips/lm78.c                  |    2 -
 drivers/i2c/chips/lm85.c                  |   12 +++++-----
 drivers/i2c/chips/via686a.c               |    2 -
 drivers/i2c/chips/w83781d.c               |    4 +--
 drivers/i2c/i2c-algo-bit.c                |    2 -
 drivers/i2c/i2c-core.c                    |   35 +++++++++++++++++++++++++++---
 drivers/i2c/i2c-dev.c                     |    6 +----
 drivers/i2c/i2c-elektor.c                 |    4 ---
 drivers/i2c/i2c-elv.c                     |    4 ---
 drivers/i2c/i2c-philips-par.c             |    4 ---
 drivers/i2c/i2c-prosavage.c               |    5 ----
 drivers/i2c/i2c-velleman.c                |    4 ---
 drivers/i2c/scx200_acb.c                  |    4 +--
 drivers/media/common/saa7146_i2c.c        |    3 --
 drivers/media/video/adv7175.c             |   22 +++++++-----------
 drivers/media/video/bt819.c               |   24 +++++++++-----------
 drivers/media/video/bt856.c               |   20 +++++++----------
 drivers/media/video/bttv-cards.c          |    2 -
 drivers/media/video/msp3400.c             |    2 -
 drivers/media/video/saa5249.c             |    6 +----
 drivers/media/video/saa7110.c             |   10 +++-----
 drivers/media/video/saa7111.c             |   15 +++++-------
 drivers/media/video/saa7134/saa7134-i2c.c |    2 -
 drivers/media/video/saa7185.c             |   13 ++++-------
 drivers/media/video/tda9840.c             |    6 ++---
 drivers/media/video/tda9887.c             |    4 ---
 drivers/media/video/tea6415c.c            |    6 ++---
 drivers/media/video/tea6420.c             |    6 ++---
 drivers/media/video/tuner-3036.c          |    4 ---
 drivers/media/video/tuner.c               |    8 ++----
 drivers/pci/quirks.c                      |    9 +++++--
 include/linux/i2c.h                       |   12 +++++++---
 45 files changed, 152 insertions(+), 172 deletions(-)
-----

<seanlkml:rogers.com>:
  o I2C: Additional P4B subsystem id for hidden asus smbus

<wodecki:gmx.de>:
  o I2C: i2c sysfs rant

Greg Kroah-Hartman:
  o I2C: fix up driver model programming error
  o I2C: move the name field back into the i2c_client and i2c_adapter structures

