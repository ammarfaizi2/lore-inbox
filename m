Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSHFUeT>; Tue, 6 Aug 2002 16:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSHFUeT>; Tue, 6 Aug 2002 16:34:19 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:39185 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315540AbSHFUeR>;
	Tue, 6 Aug 2002 16:34:17 -0400
Date: Tue, 6 Aug 2002 13:35:14 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug changes for 2.4.20-pre1
Message-ID: <20020806203513.GA2022@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This includes an ACPI PCI Hotplug driver update, and a IBM PCI Hotplug
driver update, both of which have been in the -ac kernel for a while.

	Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.4

Patches will follow (warning, the ACPI one is big, so I will not send
that to the mailing lists, it can be found at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/hotplug/2.4/pci_hp-acpiphp-2.4.20-pre1.patch
)

thanks,

greg k-h

 drivers/hotplug/pcihp_acpi.c      |  397 ---------
 drivers/hotplug/pcihp_acpi.h      |  231 -----
 drivers/hotplug/pcihp_acpi_ctrl.c |  642 ----------------
 drivers/hotplug/pcihp_acpi_glue.c |  757 -------------------
 drivers/hotplug/Makefile          |   14 
 drivers/hotplug/acpiphp.h         |  322 ++++++++
 drivers/hotplug/acpiphp_core.c    |  470 +++++++++++
 drivers/hotplug/acpiphp_glue.c    | 1514 ++++++++++++++++++++++++++++++++++++++
 drivers/hotplug/acpiphp_pci.c     |  763 +++++++++++++++++++
 drivers/hotplug/acpiphp_res.c     |  708 +++++++++++++++++
 drivers/hotplug/ibmphp.h          |   18 
 drivers/hotplug/ibmphp_core.c     |  208 +++--
 drivers/hotplug/ibmphp_ebda.c     |   65 +
 drivers/hotplug/ibmphp_hpc.c      |  141 +--
 14 files changed, 4064 insertions(+), 2186 deletions(-)
------

ChangeSet@1.686, 2002-08-06 12:04:18-07:00, greg@kroah.com
  IBM PCI Hotplug driver update
  
  This brings the driver up to the latest version, and includes the following fixes:
  	- timeout bug fixed (now large number of slots do not cause problems.)
  	- more different types of hardware supported.
  	- more slot information is now tracked.

 drivers/hotplug/ibmphp.h      |   18 ++-
 drivers/hotplug/ibmphp_core.c |  208 ++++++++++++++++++++++++++++++++----------
 drivers/hotplug/ibmphp_ebda.c |   65 ++++++++-----
 drivers/hotplug/ibmphp_hpc.c  |  141 ++++++++++++----------------
 4 files changed, 279 insertions(+), 153 deletions(-)
------

ChangeSet@1.685, 2002-08-06 12:00:20-07:00, greg@kroah.com
  ACPI PCI Hotplug driver update
  
  This is from Takayoshi KOCHI <i-kouchi@mvf.biglobe.ne.jp>

 drivers/hotplug/pcihp_acpi.c      |  397 ---------
 drivers/hotplug/pcihp_acpi.h      |  231 -----
 drivers/hotplug/pcihp_acpi_ctrl.c |  642 ----------------
 drivers/hotplug/pcihp_acpi_glue.c |  757 -------------------
 drivers/hotplug/Makefile          |   14 
 drivers/hotplug/acpiphp.h         |  322 ++++++++
 drivers/hotplug/acpiphp_core.c    |  470 +++++++++++
 drivers/hotplug/acpiphp_glue.c    | 1514 ++++++++++++++++++++++++++++++++++++++
 drivers/hotplug/acpiphp_pci.c     |  763 +++++++++++++++++++
 drivers/hotplug/acpiphp_res.c     |  708 +++++++++++++++++
 10 files changed, 3785 insertions(+), 2033 deletions(-)

