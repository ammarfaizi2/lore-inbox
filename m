Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVDAUDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDAUDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVDAUDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:03:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:16323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261455AbVDAUDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:03:41 -0500
Date: Fri, 1 Apr 2005 12:03:24 -0800
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More I2C patches for 2.6.12-rc1
Message-ID: <20050401200324.GA12854@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I messed up on the last batch of i2c patches, and forgot 3 of them that
I had accepted, and were in my trees, but didn't get copied into the
tree that I sent for you to pull from.  All 3 of them are bugfixes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Patches will be posted to linux-kernel and sensors as a follow-up thread
for those who want to see them.

thanks,

greg k-h

 drivers/i2c/chips/adm1021.c  |    2 +
 drivers/i2c/chips/adm1025.c  |   12 +++++++++
 drivers/i2c/chips/adm1026.c  |   55 ++++++++++++++-----------------------------
 drivers/i2c/chips/adm1031.c  |   23 +++++++----------
 drivers/i2c/chips/asb100.c   |   25 +++++++++++++++++--
 drivers/i2c/chips/ds1621.c   |    6 +++-
 drivers/i2c/chips/fscher.c   |   34 ++++++++++++++++++++------
 drivers/i2c/chips/fscpos.c   |   18 ++++++++++----
 drivers/i2c/chips/gl518sm.c  |   25 +++++++++++++++----
 drivers/i2c/chips/gl520sm.c  |   43 ++++++++++++++++++++++-----------
 drivers/i2c/chips/it87.c     |   44 +++++++++++++++++++++++++++++-----
 drivers/i2c/chips/lm63.c     |   19 +++++++++++++-
 drivers/i2c/chips/lm75.c     |    3 ++
 drivers/i2c/chips/lm77.c     |   21 +++++++++++++---
 drivers/i2c/chips/lm78.c     |   30 +++++++++++++++++++++--
 drivers/i2c/chips/lm80.c     |   16 ++++++++++--
 drivers/i2c/chips/lm83.c     |    3 ++
 drivers/i2c/chips/lm85.c     |   44 ++++++++++++----------------------
 drivers/i2c/chips/lm87.c     |   31 +++++++++++++++++++++---
 drivers/i2c/chips/lm90.c     |   14 +++++++++-
 drivers/i2c/chips/lm92.c     |   10 ++++++-
 drivers/i2c/chips/max1619.c  |    3 ++
 drivers/i2c/chips/pc87360.c  |   29 ++++++++++++++++++++++
 drivers/i2c/chips/pcf8574.c  |   27 +++++++--------------
 drivers/i2c/chips/pcf8591.c  |    6 +++-
 drivers/i2c/chips/sis5595.c  |   28 +++++++++++++++++++--
 drivers/i2c/chips/smsc47m1.c |   24 ++++++++++++++----
 drivers/i2c/chips/via686a.c  |   21 +++++++++++++++-
 drivers/i2c/chips/w83627hf.c |   32 ++++++++++++++++++++++++-
 drivers/i2c/chips/w83781d.c  |   29 ++++++++++++++++++++--
 drivers/i2c/i2c-core.c       |   19 --------------
 include/linux/i2c.h          |   10 ++++++-
 32 files changed, 516 insertions(+), 190 deletions(-)
-----


Jean Delvare:
  o I2C: Fix a common race condition in hardware monitoring
  o I2C: Move functionality handling from i2c-core to i2c.h
  o I2C: pcf8574 doesn't need a lock

