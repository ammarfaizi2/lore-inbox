Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270740AbTHOSqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270739AbTHOSei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:34:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:56708 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270759AbTHOSdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:33:14 -0400
Date: Fri, 15 Aug 2003 11:32:07 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test3
Message-ID: <20030815183207.GA3851@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes for 2.6.0-test3.  They include a fix for
the i2c-dev driver that has gone into 2.4 and a pii4x bugfix from Tom
Rini.  I've also added adapter and client "name" files in sysfs as the
driver core no longer supplies them.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/i2c-nforce2.c |   29 ++++-----------------------
 drivers/i2c/busses/i2c-piix4.c   |   13 ++++++++++--
 drivers/i2c/chips/Makefile       |    4 ++-
 drivers/i2c/chips/adm1021.c      |    8 +++----
 drivers/i2c/i2c-core.c           |   28 ++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c            |   41 ++++++++++++++++++++++++---------------
 6 files changed, 77 insertions(+), 46 deletions(-)
-----

<khali:linux-fr.org>:
  o i2c: user/kernel bug and memory leak in i2c-dev

Greg Kroah-Hartman:
  o I2C: add adapter and client name files as the driver core no longer provides them
  o I2C: fix up the wording for the pii4x bugfix
  o i2c: move w83481d to top of link order due to chip address takeover ability
  o i2c: fix up "raw" printk() call

Mark M. Hoffman:
  o I2C: i2c nforce2.c fixes

Rusty Lynch:
  o I2C: bugfix for initialization bug in adm1021 driver

Tom Rini:
  o I2C: Fix for i2c-piix4 with on some boards

