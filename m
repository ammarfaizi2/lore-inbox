Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTFKU0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTFKU03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:26:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13712 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264454AbTFKUVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:21:11 -0400
Date: Wed, 11 Jun 2003 13:35:44 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: [BK PATCH] More i2c driver changes for 2.5.70
Message-ID: <20030611203544.GA26458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more i2c driver changes for 2.5.70.  These consist of a new i2c
client driver, a new i2c bus driver, some coding style fixes for the new bus
driver, and a bunch of sparse warning removels.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

-----

 drivers/i2c/Kconfig        |    4 
 drivers/i2c/Makefile       |    1 
 drivers/i2c/chips/Kconfig  |   19 
 drivers/i2c/chips/Makefile |    1 
 drivers/i2c/chips/lm85.c   | 1223 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c     |   36 -
 drivers/i2c/i2c-dev.c      |   10 
 drivers/i2c/i2c-iop3xx.c   |  868 +++++++++++++++++++++++++------
 drivers/i2c/i2c-iop3xx.h   |  238 ++++++--
 include/linux/i2c-dev.h    |    6 
 include/linux/i2c.h        |    4 
 11 files changed, 2150 insertions(+), 260 deletions(-)
-----

<margitsw:t-online.de>:
  o I2C: add LM85 driver

<peterm:remware.demon.co.uk>:
  o I2C: add New bus driver: XSCALE iop3xx

Greg Kroah-Hartman:
  o I2C: fix up sparse warnings in the i2c-dev driver
  o I2C: fix up sparse warnings in drivers/i2c/i2c-core.c
  o I2C: fix some errors found by sparse in include/linux/i2c.h
  o I2C: coding style updates for i2c-iop3xx driver

