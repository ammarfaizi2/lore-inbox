Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTESXCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTESW5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:57:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15350 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263309AbTESW5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:57:38 -0400
Date: Mon, 19 May 2003 16:11:56 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: [BK PATCH] Yet more i2c driver changes for 2.5.69
Message-ID: <20030519231156.GA27535@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are yet more minor i2c fixups for 2.5.69.  They add another i2c bus
driver, and fix some bugs in the existing drivers (i287 and i2c-dev.)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/Kconfig      |   25 ++
 drivers/i2c/busses/Makefile     |    1 
 drivers/i2c/busses/i2c-piix4.c  |    4 
 drivers/i2c/busses/i2c-sis96x.c |  376 ++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/it87.c        |    1 
 drivers/i2c/i2c-dev.c           |  228 +++++++++++++++++-------
 drivers/pci/quirks.c            |   80 ++++++++
 include/linux/i2c-id.h          |    2 
 include/linux/pci_ids.h         |    3 
 9 files changed, 648 insertions(+), 72 deletions(-)
-----

<mhoffman:lightlink.com>:
  o i2c: Add SiS96x I2C/SMBus driver

<warp:mercury.d2dc.net>:
  o I2C: And yet another it87 patch

Greg Kroah-Hartman:
  o i2c: fix up i2c-dev driver based on previous core changes
  o i2c: piix4 driver: turn common error message to a debug level and rename the sysfs driver name

