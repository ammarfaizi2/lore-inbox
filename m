Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTEFWxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTEFWxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:53:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:12536 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262028AbTEFWwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:44 -0400
Date: Tue, 6 May 2003 16:05:39 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI hotplug changes for 2.5.69
Message-ID: <20030506230539.GA4007@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some patches that fix the pci hotplug drivers so that they now
work again.  Sorry it's taken so long to get these done...

I've also included a patch from Torben Mathiasen that adds PCI-X support
to the Compaq PCI Hotplug driver.  This patch is in the 2.4 tree
already.  There are also a few other minor fixes and cleanups in this
fixing build configurations, and removing unused variables.


Please pull from:  bk://kernel.bkbits.net/gregkh/linux/pci-2.5


thanks,

greg k-h


 Documentation/DocBook/kernel-api.tmpl |    1 
 drivers/acpi/acpi_ksyms.c             |    1 
 drivers/hotplug/Kconfig               |    2 
 drivers/hotplug/acpiphp_glue.c        |    6 
 drivers/hotplug/cpqphp.h              |  414 ++++++++++++++++++++++++++++++++--
 drivers/hotplug/cpqphp_core.c         |  114 ++++++++-
 drivers/hotplug/cpqphp_ctrl.c         |  296 +++++++++++++-----------
 drivers/hotplug/cpqphp_pci.c          |   21 -
 drivers/hotplug/ibmphp_core.c         |   14 -
 9 files changed, 688 insertions(+), 181 deletions(-)
-----


<rusty:linux.co.intel.com>:
  o PCI Hotplug: kernel-api docbook fix for now non-existant PCI hotplug

<torben.mathiasen:hp.com>:
  o PCI Hotplug: cpqphp 66/100/133MHz PCI-X support

Greg Kroah-Hartman:
  o PCI Hotplug: export the acpi_resource_to_address64 function, as the acpi pci hotplug driver needs it
  o PCI Hotplug: fix dependancies for CONFIG_HOTPLUG_PCI_ACPI
  o PCI Hotplug: fix up the acpi driver to work properly again
  o PCI Hotplug: fix compiler warning in ibm driver
  o PCI Hotplug: fix up the ibm driver to work properly again
  o PCI Hotplug: fix up the compaq driver to work properly again

Hanna V. Linder:
  o patch: remove unnecessary proc stuff from controller struct

