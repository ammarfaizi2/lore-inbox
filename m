Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTDIWTQ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTDIWSs (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:18:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35980 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263895AbTDIWRn (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:17:43 -0400
Date: Wed, 9 Apr 2003 15:31:17 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver changes for 2.5.67
Message-ID: <20030409223117.GA2812@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver changes for 2.5.67.  These include a number of
compile fixes, and a build fix due to my previous patches.  Also a patch
to help out the i2c based video drivers is in here.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/chips/Kconfig   |    5 
 drivers/i2c/chips/via686a.c |  551 ++++++++++++++++++++++++--------------------
 drivers/i2c/chips/w83781d.c |    6 
 drivers/i2c/i2c-adap-ite.c  |    4 
 drivers/i2c/i2c-dev.c       |   97 +++----
 drivers/i2c/i2c-frodo.c     |    4 
 drivers/i2c/scx200_i2c.c    |    6 
 include/linux/i2c-dev.h     |    6 
 include/linux/i2c.h         |   13 -
 9 files changed, 376 insertions(+), 316 deletions(-)
-----

<azarah@gentoo.org>:
  o i2c: remove compiler warning in w83781d sensor driver
  o i2c: Fix w83781d sensor to use Milli-Volt for in_* in sysfs

<j.dittmer@portrix.net>:
  o i2c: convert via686a i2c driver to sysfs

<schlicht@uni-mannheim.de>:
  o i2c: fix compilation error for various i2c-devices

Gerd Knorr <kraxel@bytesex.org>:
  o i2c: add i2c_clientname()

Greg Kroah-Hartman <greg@kroah.com>:
  o i2c: clean up i2c-dev.c's formatting, DEBUG, and ioctl mess
  o i2c: fix up compile error in scx200_i2c driver
  o i2c: fix up via686a.c driver based on previous i2c api changes
  o i2c: fix up CONFIG_I2C_SENSOR configuration logic

