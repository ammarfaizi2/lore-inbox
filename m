Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274661AbRITVfj>; Thu, 20 Sep 2001 17:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274659AbRITVfa>; Thu, 20 Sep 2001 17:35:30 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:14094 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274661AbRITVfN>;
	Thu, 20 Sep 2001 17:35:13 -0400
Date: Thu, 20 Sep 2001 14:32:06 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.10-pre12
Message-ID: <20010920143206.A21749@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another release of the Compaq Hotplug PCI driver is available against
2.4.10-pre12 is at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2001_09_20-2.4.10-pre12.patch.gz
With a full changelog at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-Changelog

Changes since the last release:
 	- forward ported to 2.4.10-pre12
	- cleaned up the portions of the patch that touched the pci core
	  kernel code.  The patch against those files is now smaller and
	  less intrusive.
	- pci core only exports symbols needed by the hotplug pci
	  drivers if CONFIG_HOTPLUG is enabled
	- Compaq driver cleanups, with more global symbols removed, and
	  a common namespace for the driver.
	- Compaq controller specific /proc interface has been moved to
	  the proper /proc/drivers location.
	- lots of testing with different pci device types.

Again, the old Compaq tool will not work with this version of the
driver.  An updated version must be downloaded from the cvs tree at
sf.net at:
	http://sourceforge.net/cvs/?group_id=32538

The current generic hotplug_pci interface is based on a controller
model.  This will be changed to a slot based model, which will enable
the userspace interface code to be much cleaner, and models what the pci
hotplug spec recommends.  Any comments on this is appreciated.

thanks,

greg k-h
