Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSFGUpf>; Fri, 7 Jun 2002 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317344AbSFGUpe>; Fri, 7 Jun 2002 16:45:34 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:49424 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317342AbSFGUpd>;
	Fri, 7 Jun 2002 16:45:33 -0400
Date: Fri, 7 Jun 2002 13:42:28 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI Hotplug changes for 2.5.20
Message-ID: <20020607204227.GA16439@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5


 drivers/hotplug/ibmphp_core.c      |    6 -
 drivers/hotplug/ibmphp_ebda.c      |   17 ++--
 drivers/hotplug/ibmphp_hpc.c       |  131 +++++++++++++++++--------------------
 drivers/hotplug/ibmphp_res.c       |   15 ++--
 drivers/hotplug/pci_hotplug_core.c |    1 
 5 files changed, 84 insertions(+), 86 deletions(-)
------

ChangeSet@1.468, 2002-06-07 13:32:51-07:00, greg@kroah.com
  IBM PCI Hotplug driver: added __init and __exit to functions that needed it.
  
  Thanks to Andrey Panin <pazke@orbita1.ru> for pointing these out to me.

 drivers/hotplug/ibmphp_core.c |    4 ++--
 drivers/hotplug/ibmphp_ebda.c |   17 +++++++++--------
 drivers/hotplug/ibmphp_hpc.c  |   17 +++++++++--------
 drivers/hotplug/ibmphp_res.c  |   15 ++++++++-------
 4 files changed, 28 insertions(+), 25 deletions(-)
------

ChangeSet@1.467, 2002-06-07 13:29:15-07:00, greg@kroah.com
  PCI Hotplug core: added #include <linux/namei.h> to fix compile time warning

 drivers/hotplug/pci_hotplug_core.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.466, 2002-06-07 13:27:01-07:00, greg@kroah.com
  IBM PCI Hotplug driver:  polling thread locking cleanup
  
  removed a lot of bizzare polling locking logic, causing the driver to not sleep
  for 2 seconds with some locks held.  This improves userspace interaction by
  a few orders of magnitude :)

 drivers/hotplug/ibmphp_core.c |    2 
 drivers/hotplug/ibmphp_hpc.c  |  114 +++++++++++++++++++-----------------------
 2 files changed, 55 insertions(+), 61 deletions(-)
------

