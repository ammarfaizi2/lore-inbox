Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSDJS0K>; Wed, 10 Apr 2002 14:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313493AbSDJS0J>; Wed, 10 Apr 2002 14:26:09 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:2311 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313492AbSDJS0J>;
	Wed, 10 Apr 2002 14:26:09 -0400
Date: Wed, 10 Apr 2002 11:23:34 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI Hotplug changes for 2.5.8-pre3
Message-ID: <20020410182334.GA17535@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5


 arch/i386/kernel/i386_ksyms.c |    4 ++++
 drivers/hotplug/Config.in     |    4 +++-
 drivers/hotplug/Makefile      |   12 ------------
 drivers/hotplug/ibmphp_core.c |    2 +-
 4 files changed, 8 insertions(+), 14 deletions(-)
------

ChangeSet@1.460, 2002-04-10 11:00:08-07:00, greg@kroah.com
  export the IO_APIC_get_PCI_irq_vector function, as the IBM PCI Hotplug
  driver needs this.  This is already done in 2.4.x

 arch/i386/kernel/i386_ksyms.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.459, 2002-04-10 10:59:15-07:00, greg@kroah.com
  IBM PCI Hotplug driver
  
  fixed linker bug when driver is compiled into the kernel.

 drivers/hotplug/ibmphp_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.458, 2002-04-10 10:58:16-07:00, greg@kroah.com
  PCI Hotplug Makefile cleanup
  
  removed the list-multi targets, as they aren't needed anymore.

 drivers/hotplug/Makefile |   12 ------------
 1 files changed, 12 deletions(-)
------

ChangeSet@1.457, 2002-04-10 10:57:36-07:00, greg@kroah.com
  IBM PCI Hotplug driver
  
  Only build the IBM PCI hotplug driver if CONFIG_X86_IO_APIC is selected

 drivers/hotplug/Config.in |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
------

