Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273751AbRIQX2g>; Mon, 17 Sep 2001 19:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273753AbRIQX2Q>; Mon, 17 Sep 2001 19:28:16 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:4615 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S273751AbRIQX2L>;
	Mon, 17 Sep 2001 19:28:11 -0400
Date: Mon, 17 Sep 2001 16:25:38 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.10-pre10
Message-ID: <20010917162538.A1090@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another release of the Compaq Hotplug PCI driver is available against
2.4.10-pre10 is at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2001_09_17-2.4.10-pre10.patch.gz
With a full changelog at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-Changelog

Changes since the last release:
 	- forward ported to 2.4.10-pre10
	- removed lots of dead code in the Compaq driver that was not
	  being used.
	- created pci_read_config_*_nodev and pci_write_config_*_nodev
	  that corresponds with the pci_read_config_* and
	  pci_write_config_* functions.  These functions can be used
	  when there is not a valid struct pci_dev available for the
	  device.  The functions will fallback to using the
	  pci_write_config_* and pci_read_config_* functions if a struct
	  pci_dev is found for the specified device.
	- enabled the hotplug_pci core to be compiled into the kernel.
	- added documentation to the hotplug_pci interface.

Again, the old Compaq tool will not work with this version of the
driver.  An updated version must be downloaded from the cvs tree at
sf.net at:
	http://sourceforge.net/cvs/?group_id=32538

I'm awaiting some comments from some people at IBM for what pieces of
the resource management code would be useful to have split out from the
Compaq driver.  Any comments from other groups who are working on
hotplug pci drivers is very welcome.

Next up is removing the horrid /proc interface the driver uses :)

thanks,

greg k-h
