Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSLBHQ5>; Mon, 2 Dec 2002 02:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSLBHQ5>; Mon, 2 Dec 2002 02:16:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44294 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265333AbSLBHQ4>;
	Mon, 2 Dec 2002 02:16:56 -0500
Date: Mon, 2 Dec 2002 00:24:43 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug changes for 2.5.50
Message-ID: <20021202082443.GA12121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This also includes Adam's patch for pci.h

Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5

thanks,

greg k-h


 drivers/hotplug/Makefile            |    9 ++++---
 drivers/hotplug/cpci_hotplug_core.c |   15 +++---------
 drivers/hotplug/cpci_hotplug_pci.c  |    8 +++---
 drivers/hotplug/ibmphp_ebda.c       |   16 ++++++-------
 drivers/hotplug/pci_hotplug_core.c  |   43 +++++++++++++++++++++++++-----------
 include/linux/pci.h                 |   22 ++++++++----------
 6 files changed, 62 insertions(+), 51 deletions(-)
-----

ChangeSet@1.954, 2002-12-01 23:09:28-08:00, greg@kroah.com
  Merge kroah.com:/home/linux/linux/BK/bleeding-2.5
  into kroah.com:/home/linux/linux/BK/pci_hp-2.5

 include/linux/pci.h |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)
------

ChangeSet@1.924.3.3, 2002-11-30 01:28:13-08:00, greg@kroah.com
  PCI: changed pci_?et_drvdata to use the generic driver model functions
       instead of accessing the data directly.

 include/linux/pci.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.924.3.2, 2002-11-30 01:18:05-08:00, adam@yggdrasil.com
  [PATCH] Patch/resubmit(2.5.50): Eliminate pci_dev.driver_data
  
  	To review, this patch deletes pci_dev.driver_data, using the
  existing pci_dev.device.driver_data field instead, thereby shrinking
  struct pci_dev by four bytes on 32-bit machines.  The few device
  drivers that attempted to directly reference pci_dev.driver_data were
  fixed in a patch of mine that Jeff Garzik got into 2.5.45.  Also,
  making this change should help with memory allocation improvements in
  the future, although that's a separate issue.

 include/linux/pci.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)
------

ChangeSet@1.871.3.2, 2002-11-26 11:26:14-08:00, ahaas@airmail.net
  [PATCH] C99 initializers for drivers/hotplug
  
  Here's a small set of patches for switching drivers/hotplug to use C99
  initializers. The patches are against 2.5.49.

 drivers/hotplug/cpci_hotplug_pci.c |    8 ++++----
 drivers/hotplug/ibmphp_ebda.c      |   16 ++++++++--------
 drivers/hotplug/pci_hotplug_core.c |   16 ++++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)
------

ChangeSet@1.871.3.1, 2002-11-26 11:23:49-08:00, greg@kroah.com
  PCI hotplug: moved cpci_hotplug.o to be built into pci_hotplug.o if enabled.

 drivers/hotplug/Makefile            |    9 +++++----
 drivers/hotplug/cpci_hotplug_core.c |   15 ++++-----------
 drivers/hotplug/pci_hotplug_core.c  |   27 +++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 19 deletions(-)
------

