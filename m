Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUA0XdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUA0XdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:33:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:6591 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265665AbUA0Xc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:32:58 -0500
Date: Tue, 27 Jan 2004 15:32:42 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-ID: <20040127233242.GA28891@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes for 2.6.2-rc2.  It's all a bit of small
bugfixes and documentation updates.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/porting-clients    |    5 --
 drivers/i2c/busses/i2c-parport.h     |    7 ++-
 drivers/i2c/busses/i2c-philips-par.c |    4 +-
 drivers/i2c/busses/i2c-piix4.c       |   48 +++++++++++++-----------
 drivers/i2c/chips/lm75.c             |   12 +++---
 drivers/i2c/chips/lm78.c             |   12 +++---
 drivers/i2c/chips/lm85.c             |   69 ++++++++++-------------------------
 7 files changed, 67 insertions(+), 90 deletions(-)
-----


Greg Kroah-Hartman:
  o I2C: remove printk() calls in lm85, and clean up debug logic

Jean Delvare:
  o I2C: Bring lm75 and lm78 in compliance with sysfs naming conventions
  o I2C: Add ADM1025EB support to i2c-parport
  o I2C: Fix bus reset in i2c-philips-par
  o I2C: undo documentation change

Mark M. Hoffman:
  o I2C: i2c-piix4.c bugfix

