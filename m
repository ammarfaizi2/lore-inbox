Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945929AbWANAom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945929AbWANAom (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945928AbWANAof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:44:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:34201 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1945916AbWANAoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:44:16 -0500
Date: Fri, 13 Jan 2006 16:44:03 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] SPI patches for 2.6.15
Message-ID: <20060114004403.GA21106@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few patches for 2.6.15 that add a SPI driver subsystem to the
kernel tree.  All of these patches have been in the -mm tree for a long
time, and David and Vitaly have finally agreed that this code base is
the proper one to work from for future SPI development.

These patches also add a few SPI drivers that use the subsystem, with
more promised to be coming soon.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/spi-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/spi-2.6.git/

The full patches will be sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/spi/butterfly         |   57 ++
 Documentation/spi/spi-summary       |  497 +++++++++++++++++++++-
 arch/arm/Kconfig                    |    2 
 drivers/Kconfig                     |    2 
 drivers/Makefile                    |    1 
 drivers/input/touchscreen/Kconfig   |   13 
 drivers/input/touchscreen/Makefile  |    1 
 drivers/input/touchscreen/ads7846.c |  717 ++++++++++++++++++++++++++++++--
 drivers/mtd/devices/Kconfig         |   16 
 drivers/mtd/devices/Makefile        |    2 
 drivers/mtd/devices/m25p80.c        |  634 +++++++++++++++++++++++++++--
 drivers/mtd/devices/mtd_dataflash.c |  653 +++++++++++++++++++++++++++++
 drivers/spi/Kconfig                 |  109 ++++
 drivers/spi/Makefile                |   25 +
 drivers/spi/spi.c                   |  756 ++++++++++++++++++++++++++++++++--
 drivers/spi/spi_bitbang.c           |  546 +++++++++++++++++++++++--
 drivers/spi/spi_butterfly.c         |  423 +++++++++++++++++++
 include/linux/spi/ads7846.h         |   20 
 include/linux/spi/flash.h           |   31 +
 include/linux/spi/spi.h             |  786 +++++++++++++++++++++++++++++++++---
 include/linux/spi/spi_bitbang.h     |  135 ++++++
 21 files changed, 5168 insertions(+), 258 deletions(-)


Andrew Morton:
      spi: remove fastcall crap

David Brownell:
      spi: mtd dataflash driver
      spi: simple SPI framework
      spi: add spi_driver to SPI framework
      spi: ads7846 driver
      SPI core tweaks, bugfix
      spi: ads7836 uses spi_driver
      spi: add spi_bitbang driver
      SPI: add spi_butterfly driver
      spi: misc fixes

Mike Lavender:
      spi: M25 series SPI flash

Vitaly Wool:
      spi: use linked lists rather than an array

