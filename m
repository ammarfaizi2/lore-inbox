Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVAQXt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVAQXt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVAQV6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:58:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:54994 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262909AbVAQVtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:21 -0500
Date: Mon, 17 Jan 2005 13:45:43 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C fixes for 2.6.11-rc1
Message-ID: <20050117214543.GB28400@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes and updates for 2.6.11-rc1.  There is a
new chip and a new bus driver, as well as a bunch of minor fixes.  All
of these patches have been in the past few -mm releases.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 drivers/i2c/busses/Kconfig    |    6 -
 drivers/i2c/busses/i2c-i801.c |    2 
 drivers/i2c/busses/i2c-mpc.c  |  171 +++++++++++++++++++++++++------
 drivers/i2c/chips/adm1026.c   |   11 +-
 drivers/i2c/chips/eeprom.c    |   47 ++++----
 drivers/i2c/chips/it87.c      |  230 +++++++++++++++++++++++++++++++++---------
 drivers/i2c/chips/lm63.c      |    4 
 drivers/i2c/chips/lm85.c      |   76 +++++++++++--
 drivers/i2c/chips/via686a.c   |    9 -
 9 files changed, 427 insertions(+), 129 deletions(-)
-----


<jason.d.gaston:intel.com>:
  o I2C support for Intel ICH7 - 2.6.10 - resubmit

<rafael.espindola:gmail.com>:
  o I2C: add EMC6D100 support in lm85 driver

Greg Kroah-Hartman:
  o I2C: add MODULE_DEVICE_TABLE to via686a.c driver

Jean Delvare:
  o I2C: Improve it87 super-i/o detection
  o I2C: Cleanups to the eeprom driver
  o I2C: Fix bogus bitmask in lm63 debug message

Jonas Munsin:
  o I2C: fix it87 sensor driver stops CPU fan
  o I2C: it87 fan update

Justin Thiessen:
  o I2C: adm1026.c fixes

Kumar Gala:
  o I2C-MPC: Convert to platform_device driver
  o I2C-MPC: use wait_event_interruptible_timeout between transactions

