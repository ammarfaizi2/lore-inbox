Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVKQSIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVKQSIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVKQSIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:08:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:29090 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932610AbVKQSEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:14 -0500
Date: Thu, 17 Nov 2005 09:46:09 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 00/22] USB patches for 2.6.15-rc1
Message-ID: <20051117174609.GA11174@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB patches for 2.6.15-rc1.  They fix some build errors,
add some more device ids, delete some unneeded #ifdef checks, delete a
driver that was grabbing too many USB devices, and adds a new USB
driver.

thanks,

greg k-h

----

 Documentation/devices.txt            |   12 
 Documentation/usb/bluetooth.txt      |   44 --
 drivers/usb/atm/Makefile             |    4 
 drivers/usb/atm/usbatm.h             |    5 
 drivers/usb/core/Makefile            |    4 
 drivers/usb/core/buffer.c            |    8 
 drivers/usb/core/config.c            |    5 
 drivers/usb/core/devio.c             |    6 
 drivers/usb/core/file.c              |    6 
 drivers/usb/core/hcd-pci.c           |    7 
 drivers/usb/core/hcd.c               |    5 
 drivers/usb/core/hub.c               |    5 
 drivers/usb/core/inode.c             |    7 
 drivers/usb/core/message.c           |   10 
 drivers/usb/core/notify.c            |    6 
 drivers/usb/core/sysfs.c             |    7 
 drivers/usb/core/urb.c               |    6 
 drivers/usb/core/usb.c               |    7 
 drivers/usb/gadget/dummy_hcd.c       |    4 
 drivers/usb/host/ohci-lh7a404.c      |    2 
 drivers/usb/image/microtek.c         |   35 +
 drivers/usb/image/microtek.h         |    2 
 drivers/usb/input/Makefile           |    4 
 drivers/usb/input/hid-core.c         |   12 
 drivers/usb/input/itmtouch.c         |    7 
 drivers/usb/input/keyspan_remote.c   |    5 
 drivers/usb/input/mtouchusb.c        |    7 
 drivers/usb/input/pid.c              |    2 
 drivers/usb/input/touchkitusb.c      |    4 
 drivers/usb/input/wacom.c            |  133 +++++-
 drivers/usb/misc/Makefile            |    6 
 drivers/usb/misc/auerswald.c         |    1 
 drivers/usb/misc/phidgetservo.c      |    3 
 drivers/usb/misc/rio500.c            |    2 
 drivers/usb/misc/usbled.c            |    3 
 drivers/usb/misc/usbtest.c           |    3 
 drivers/usb/misc/uss720.c            |    2 
 drivers/usb/net/Makefile             |    4 
 drivers/usb/net/asix.c               |    3 
 drivers/usb/net/cdc_ether.c          |    3 
 drivers/usb/net/cdc_subset.c         |    3 
 drivers/usb/net/gl620a.c             |    3 
 drivers/usb/net/kaweth.c             |   13 
 drivers/usb/net/net1080.c            |    3 
 drivers/usb/net/pegasus.c            |    2 
 drivers/usb/net/plusb.c              |    3 
 drivers/usb/net/rndis_host.c         |    3 
 drivers/usb/net/usbnet.c             |    3 
 drivers/usb/net/zaurus.c             |    3 
 drivers/usb/serial/ChangeLog.history |  730 +++++++++++++++++++++++++++++++++++
 drivers/usb/serial/ChangeLog.old     |  730 -----------------------------------
 drivers/usb/serial/Kconfig           |   18 
 drivers/usb/serial/Makefile          |    2 
 drivers/usb/serial/anydata.c         |  123 +++++
 drivers/usb/serial/cp2101.c          |    1 
 drivers/usb/serial/generic.c         |    1 
 drivers/usb/serial/nokia_dku2.c      |  142 ------
 drivers/usb/serial/pl2303.c          |    6 
 drivers/usb/serial/pl2303.h          |    2 
 drivers/usb/storage/Kconfig          |    2 
 drivers/usb/storage/shuttle_usbat.c  |    2 
 drivers/usb/storage/unusual_devs.h   |   10 
 62 files changed, 1069 insertions(+), 1137 deletions(-)

