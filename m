Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273534AbRIYUgz>; Tue, 25 Sep 2001 16:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273533AbRIYUgo>; Tue, 25 Sep 2001 16:36:44 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:267 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S273497AbRIYUgk>;
	Tue, 25 Sep 2001 16:36:40 -0400
Date: Tue, 25 Sep 2001 13:32:34 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.10
Message-ID: <20010925133234.A14610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another release of the Compaq Hotplug PCI driver is available against
2.4.10 is at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2001_09_25-2.4.10.patch.gz
With a full changelog at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-Changelog

Changes since the last release:
 	- forward ported to 2.4.10
	- added MODULE_LICENSE("GPL") to the modules.
	- fixed 64 bit problems in the hotplug_pci core (thanks to Arjan
	  van de Ven for pointing this out to me)
	- changed the hotplug pci core interface from a controller based
	  interface to a physical slot based one.
	- modified the Compaq driver to match the new hotplug pci core
	  changes.
	- code documentation updates.
        - added MODULE support to the hotplug_pci core to prevent a
          a child module from disappearing while it is being called.
	- no more oops if the hotplug_slot_ops structure is missing a
	  field.

Again, the old Compaq tool will not work with this version of the
driver.  An updated version must be downloaded from the cvs tree at
sf.net at:
	http://sourceforge.net/cvs/?group_id=32538

Note:  This is probably the LAST release of this driver that the Compaq
user interface tools will work on.  If you care about compatiblity with
these tools, please grab this release and keep it :)  Also, please let
me know if you have a problem with this.

TODO:
	- move the /proc/cpqphpd code out of the compaq driver and into
	  the hotplug_pci core code.
	- change the /proc/cpqphpd interface into a real filesystem.
	- either remove the Compaq BIOS specific code or fix it to not
	  use direct memory accesses (any opinions?)

thanks,

greg k-h
