Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTJJXVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTJJXUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:20:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:29154 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263172AbTJJXUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:20:00 -0400
Date: Fri, 10 Oct 2003 16:10:24 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test7
Message-ID: <20031010231024.GB18320@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes for 2.6.0-test7.  They fix a bug in the
i2c-dev class code, fix oopses in the i2c-sis630 driver, and fix a
potential use-before-initialized error in the i2c chip drivers.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

thanks,

greg k-h

 drivers/i2c/busses/Kconfig      |    4 +-
 drivers/i2c/busses/i2c-sis630.c |   67 ++++++++++++++++++++++++++++------------
 drivers/i2c/chips/Kconfig       |   16 ++++-----
 drivers/i2c/chips/adm1021.c     |    6 ++-
 drivers/i2c/chips/it87.c        |    7 ++--
 drivers/i2c/chips/lm75.c        |    5 ++
 drivers/i2c/chips/lm78.c        |    7 ++--
 drivers/i2c/chips/lm85.c        |    6 ++-
 drivers/i2c/chips/via686a.c     |    7 ++--
 drivers/i2c/chips/w83781d.c     |    6 ++-
 drivers/i2c/i2c-dev.c           |   17 ++++++++--
 11 files changed, 99 insertions(+), 49 deletions(-)
-----

<amalysh:web.de>:
  o I2C: i2c-sis630 driver fixes

Greg Kroah-Hartman:
  o I2C: fix i2c-dev class release function bug

Jean Delvare:
  o I2C: correct some errors in i2c/chips/Kconfig
  o I2C: Chip driver initialization fixes

