Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSHBXwA>; Fri, 2 Aug 2002 19:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317328AbSHBXwA>; Fri, 2 Aug 2002 19:52:00 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:51980 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317251AbSHBXvr>;
	Fri, 2 Aug 2002 19:51:47 -0400
Date: Fri, 2 Aug 2002 16:53:22 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI changes for 2.5.30
Message-ID: <20020802235321.GA1999@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two small PCI changes, one for organizational sake, and the other to fix
a PCI hotplug bug.

Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5

thanks,

greg k-h


 drivers/pci/Makefile |    3 ++-
 drivers/pci/compat.c |   14 ++++++++++++++
 drivers/pci/names.c  |   10 +++++-----
 drivers/pci/pci.c    |   12 ------------
 4 files changed, 21 insertions(+), 18 deletions(-)
------

ChangeSet@1.515, 2002-08-02 16:45:14-07:00, t-kouchi@mvf.biglobe.ne.jp
  [PATCH] [PATCH] PCI Hotplug patch to drivers/pci/names.c
  
  I found that both compaq and ibm PCI hotplug driver call pci_scan_slot(),
  which eventually call pci_name_device() in drivers/pci/names.c.
  
  pci_name_device() is declared as __devinit while other data are
  declared as __initdata.
  This may result in undefined behavior for example, /proc/pci.

 drivers/pci/names.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.514, 2002-08-02 16:40:20-07:00, greg@kroah.com
  PCI: move the EXPORT_SYMBOL(pcibios_*) declarations to the proper file.

 drivers/pci/Makefile |    3 ++-
 drivers/pci/compat.c |   14 ++++++++++++++
 drivers/pci/pci.c    |   12 ------------
 3 files changed, 16 insertions(+), 13 deletions(-)
------

