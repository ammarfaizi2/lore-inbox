Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbSJHXOq>; Tue, 8 Oct 2002 19:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSJHXNh>; Tue, 8 Oct 2002 19:13:37 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:49417 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261475AbSJHXNZ>;
	Tue, 8 Oct 2002 19:13:25 -0400
Date: Tue, 8 Oct 2002 16:15:11 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008231511.GA11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series also has 2 driver core patches that Pat has approved.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 MAINTAINERS                    |    9 
 drivers/base/hotplug.c         |    2 
 drivers/media/video/cpia.h     |    8 
 drivers/media/video/cpia_usb.c |    2 
 drivers/usb/core/driverfs.c    |   29 ++
 drivers/usb/core/usb.c         |    8 
 drivers/usb/misc/usbtest.c     |  541 +++++++++++++++++++++++++++++++++++++----
 drivers/usb/serial/pl2303.c    |    2 
 include/linux/device.h         |   19 +
 9 files changed, 557 insertions(+), 63 deletions(-)
-----

ChangeSet@1.705, 2002-10-08 15:25:23-07:00, greg@kroah.com
  merge of Randy's cpia fix over Davej's

 drivers/media/video/cpia.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.573.92.20, 2002-10-08 14:57:12-07:00, greg@kroah.com
  USB: removed unused DEVFS /sbin/hotplug attribute

 drivers/usb/core/usb.c |    8 --------
 1 files changed, 8 deletions(-)
------

ChangeSet@1.573.92.19, 2002-10-08 14:55:41-07:00, greg@kroah.com
  USB: add device speed driverfs file.

 drivers/usb/core/driverfs.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+)
------

ChangeSet@1.573.92.18, 2002-10-08 14:55:11-07:00, greg@kroah.com
  driver core: rename DEVICE to DEVPATH for /sbin/hotplug call to prevent conflict with USB

 drivers/base/hotplug.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.573.92.17, 2002-10-08 09:33:07-07:00, dsteklof@us.ibm.com
  driver core: add generic logging macros for devices.

 include/linux/device.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)
------

ChangeSet@1.573.92.16, 2002-10-07 23:51:47-07:00, rddunlap@osdl.org
  [PATCH] build cpia video driver
  
  This patch enables the cpia driver to build on 2.5.41.

 drivers/media/video/cpia.h     |    4 ++--
 drivers/media/video/cpia_usb.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.573.92.15, 2002-10-07 16:24:07-07:00, greg@kroah.com
  [PATCH] USB: fix ctsrts handling in pl2303 driver.
  
  Thanks to the prolific engineers for pointing this out to me.

 drivers/usb/serial/pl2303.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.573.92.14, 2002-10-07 16:23:30-07:00, david-b@pacbell.net
  [PATCH] usbtest: mo'betta devices, control tests
  
  This updates the usbtest driver:
  
  - Supports more devices for the basic i/o tests,
     using full speed ez-usb firmware (and usbtest
     tweaks!) provided by Martin Diehl.
  
  - Adds another test case, which issues control
     messages to devices.  There will be further
     updates in this area (control queueing, and
     likely improving usbcore api coverage).
  
  - Adds a "generic device" mode where vendor
     (and optionally product) ids can be given as
     module parameters.  Those devices can be used
     for testing control traffic.

 drivers/usb/misc/usbtest.c |  541 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 498 insertions(+), 43 deletions(-)
------

ChangeSet@1.573.92.13, 2002-10-07 16:22:58-07:00, johannes@erdfelt.com
  [PATCH] USB: Trivial MAINTAINERS update
  

 MAINTAINERS |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)
------

