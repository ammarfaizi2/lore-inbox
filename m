Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292991AbSB0Wah>; Wed, 27 Feb 2002 17:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293011AbSB0WaK>; Wed, 27 Feb 2002 17:30:10 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:39181 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293009AbSB0W3l>;
	Wed, 27 Feb 2002 17:29:41 -0500
Date: Wed, 27 Feb 2002 14:23:05 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug driver changes for 2.5.6-pre1
Message-ID: <20020227222305.GA7760@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5


 drivers/hotplug/Config.help        |   11 
 drivers/hotplug/Config.in          |    5 
 drivers/hotplug/Makefile           |   12 
 drivers/hotplug/cpqphp_proc.c      |    2 
 drivers/hotplug/ibmphp.h           |  745 +++++++++++++
 drivers/hotplug/ibmphp_core.c      | 1480 ++++++++++++++++++++++++++
 drivers/hotplug/ibmphp_ebda.c      |  851 +++++++++++++++
 drivers/hotplug/ibmphp_hpc.c       | 1135 ++++++++++++++++++++
 drivers/hotplug/ibmphp_pci.c       | 1719 ++++++++++++++++++++++++++++++
 drivers/hotplug/ibmphp_res.c       | 2067 +++++++++++++++++++++++++++++++++++++
 drivers/hotplug/pci_hotplug_core.c |   98 -
 11 files changed, 8061 insertions(+), 64 deletions(-)

------
ChangeSet@1.423, 2002-02-27 14:12:18-08:00, greg@kroah.com
  PCI Hotplug Core cleanups:
  	- pcihpfs cleanup, removing unneeded file operations.
  	- Added facility to have the files change their timestamps if the data
  	  within the file changes.

 drivers/hotplug/pci_hotplug_core.c |   98 ++++++++++++++-----------------------
 1 files changed, 38 insertions(+), 60 deletions(-)

------
ChangeSet@1.424, 2002-02-27 14:13:28-08:00, greg@kroah.com
  Compaq PCI Hotplug controller driver:
  	- changed proc entry creation to use the proper parent directory variable.

 drivers/hotplug/cpqphp_proc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

------
ChangeSet@1.425, 2002-02-27 14:15:44-08:00, greg@kroah.com
  Added new IBM PCI Hotplug controller driver.
  
  Written by Irene Zubarev, Tong Yu, Jyoti Shah, Chuck Cole, and me.

 drivers/hotplug/Config.help   |   11 
 drivers/hotplug/Config.in     |    5 
 drivers/hotplug/Makefile      |   12 
 drivers/hotplug/ibmphp.h      |  745 +++++++++++++++
 drivers/hotplug/ibmphp_core.c | 1480 ++++++++++++++++++++++++++++++
 drivers/hotplug/ibmphp_ebda.c |  851 +++++++++++++++++
 drivers/hotplug/ibmphp_hpc.c  | 1135 +++++++++++++++++++++++
 drivers/hotplug/ibmphp_pci.c  | 1719 ++++++++++++++++++++++++++++++++++
 drivers/hotplug/ibmphp_res.c  | 2067 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 8022 insertions(+), 3 deletions(-)

