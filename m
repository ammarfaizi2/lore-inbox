Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVILUKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVILUKM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVILUKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:10:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:24003 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932193AbVILUKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:10:11 -0400
Date: Mon, 12 Sep 2005 13:04:42 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] More I2C and hwmon patches for 2.6.13
Message-ID: <20050912200441.GA22930@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more i2c and hwmon patches.  They are all bugfixes, with
the exception of the addition of the new hdaps driver.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing lists, if anyone
wants to see them.

thanks,

greg k-h

 MAINTAINERS                      |    7 
 drivers/hwmon/Kconfig            |   17 
 drivers/hwmon/Makefile           |    1 
 drivers/hwmon/hdaps.c            |  739 +++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/sis5595.c          |    5 
 drivers/hwmon/smsc47m1.c         |    4 
 drivers/hwmon/via686a.c          |    5 
 drivers/hwmon/w83627hf.c         |   14 
 drivers/i2c/busses/i2c-nforce2.c |    5 
 9 files changed, 779 insertions(+), 18 deletions(-)

Jean Delvare:
  hwmon: Update smsc47m1 head comment
  hwmon: fix sis5595, via686a force_addr module parameter
  hwmon: w83627hf: no reset by default
  I2C: i2c-nforce2: drop unused define

Robert Love:
  updated hdaps driver.

