Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264095AbUE1WEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUE1WEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbUE1WBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:01:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:45757 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264058AbUE1V7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:59:53 -0400
Date: Fri, 28 May 2004 14:59:08 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C update for 2.6.7-rc1
Message-ID: <20040528215908.GA13626@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes for 2.6.7-rc1.  There is also a new i2c
chip driver in here.  The majority of these patches have been in the
past few -mm releases.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 drivers/i2c/busses/Kconfig       |    8 
 drivers/i2c/busses/i2c-ibm_iic.c |   48 +++-
 drivers/i2c/busses/i2c-parport.h |   14 +
 drivers/i2c/chips/Kconfig        |   10 +
 drivers/i2c/chips/Makefile       |    1 
 drivers/i2c/chips/eeprom.c       |    5 
 drivers/i2c/chips/max1619.c      |  378 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c           |   21 +-
 8 files changed, 457 insertions(+), 28 deletions(-)
-----

<faikuygur:tnn.net>:
  o I2C: use idr_get_new to allocate a bus id in drivers/i2c/i2c-core.c

<fishor:gmx.net>:
  o I2C: add max1619 driver

Eugene Surovegin:
  o I2C PPC4xx IIC driver: 0-length transaction temporary fix
  o I2C PPC4xx IIC driver: fix debug build with gcc3
  o I2C PPC4xx IIC driver: Kconfig cleanup
  o I2C PPC4xx IIC driver: upgrade to new OCP infrastructre

Jean Delvare:
  o I2C: i2c-parport: support the ADM1031 evaluation board
  o I2C: Incomplete AT24RF08 corruption prevention in i2c eeprom

