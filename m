Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWGLX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWGLX1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGLX1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:27:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:30092 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932175AbWGLX1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:27:51 -0400
Date: Wed, 12 Jul 2006 16:23:59 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Jean Delvare <khali@linux-fr.org>
Subject: [GIT PATCH] I2C and hwmon fixes for 2.6.18-rc1
Message-ID: <20060712232359.GA22679@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some i2c and hwmon fixes for 2.6.18-rc1.  They fix quite a few
bugs and update the documentation.

They all have been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h


 Documentation/feature-removal-schedule.txt |   11 ++++++++++
 Documentation/hwmon/abituguru              |   32 ++++++++++++++++++++++++++--
 Documentation/i2c/busses/i2c-sis96x        |    4 ++--
 MAINTAINERS                                |   14 +++++++++---
 drivers/hwmon/abituguru.c                  |   21 +++++++++++++++++-
 drivers/i2c/algos/i2c-algo-bit.c           |    4 +---
 drivers/i2c/algos/i2c-algo-ite.c           |    4 +---
 drivers/i2c/algos/i2c-algo-pca.c           |    6 +++--
 drivers/i2c/algos/i2c-algo-pcf.c           |    8 ++++---
 drivers/i2c/algos/i2c-algo-sibyte.c        |    4 +---
 drivers/i2c/busses/i2c-iop3xx.c            |   17 +++++++++------
 drivers/i2c/busses/i2c-iop3xx.h            |    2 +-
 drivers/i2c/busses/i2c-powermac.c          |    4 +---
 drivers/i2c/busses/scx200_acb.c            |   20 +++++++++++-------
 drivers/i2c/chips/pca9539.c                |   12 ++++++-----
 drivers/i2c/i2c-core.c                     |    4 ++--
 include/linux/i2c.h                        |    2 ++
 17 files changed, 118 insertions(+), 51 deletions(-)

---------------

Ben Gardner:
      pca9539: Honor the force parameter

Charles Spirakis:
      hwmon: New maintainer for w83791d

Hans de Goede:
      hwmon: Fix for first generation Abit uGuru chips
      hwmon: Documentation update for abituguru

Jean Delvare:
      scx200_acb: Fix the block transactions
      i2c-powermac: Fix master_xfer return value
      i2c-ite: Plan for removal
      i2c: New mailing list

Mark M. Hoffman:
      i2c: Fix 'ignore' module parameter handling in i2c-core
      i2c: Handle i2c_add_adapter failure in i2c algorithm drivers

Peter Milne:
      i2c-iop3xx: Avoid addressing self

Thomas Andrews:
      scx200_acb: Fix the state machine

Uwe Bugla:
      i2c-algo-bit: Wipe out dead code

