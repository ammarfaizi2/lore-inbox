Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVIVHss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVIVHss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVIVHsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:48:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:40114 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751433AbVIVHsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:18 -0400
Date: Thu, 22 Sep 2005 00:46:43 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 00/18] USB and PCI Fixes for 2.6.14-rc2
Message-ID: <20050922074643.GA15053@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of USB and PCI fixes for 2.6.14-rc2.  There's also a
patch in here to remove me as the I2C maintainer, as Jean is doing such
a good job that I don't need to be listed there anymore.  I'll still be
the conduit for the i2c and hwmon patches into the main kernel tree, but
Jean will be taking care of the full day-to-day duties of it now.

Below is the diffstat of the whole series.

thanks,

greg k-h

 Documentation/usb/URB.txt            |   77 ++++++++++++++---------------------
 MAINTAINERS                          |    4 -
 drivers/base/class.c                 |   14 +++++-
 drivers/base/dd.c                    |    5 +-
 drivers/block/ub.c                   |   59 ++++++++++++++------------
 drivers/pci/hotplug.c                |    6 --
 drivers/pci/hotplug/rpadlpar_sysfs.c |    6 +-
 drivers/pci/hotplug/sgi_hotplug.c    |    6 +-
 drivers/pci/pci-sysfs.c              |    4 -
 drivers/pci/probe.c                  |    6 +-
 drivers/s390/cio/ccwgroup.c          |    2 
 drivers/usb/core/message.c           |    2 
 drivers/usb/core/usb.c               |    6 +-
 drivers/usb/gadget/pxa2xx_udc.c      |    4 -
 drivers/usb/gadget/pxa2xx_udc.h      |   10 ++--
 drivers/usb/host/sl811-hcd.c         |   18 ++++++--
 drivers/usb/net/pegasus.c            |   31 +++++++++-----
 drivers/usb/serial/airprime.c        |    5 +-
 drivers/usb/serial/ftdi_sio.c        |   10 ++--
 drivers/usb/serial/option.c          |   15 +++++-
 include/linux/device.h               |    7 ++-
 21 files changed, 168 insertions(+), 129 deletions(-)
