Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRICUO3>; Mon, 3 Sep 2001 16:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271802AbRICUOU>; Mon, 3 Sep 2001 16:14:20 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:40197 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S271800AbRICUOE>;
	Mon, 3 Sep 2001 16:14:04 -0400
Date: Mon, 3 Sep 2001 13:14:19 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.9, 2.4.10-pre4, and 2.4.9-ac6
Message-ID: <20010903131419.A3271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've made a release of the Compaq Hotplug PCI driver against a few
different kernels available at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2.4.9.patch.gz
	http://www.kroah.com/linux/hotplug/pci-hotplug-2.4.10-pre4.patch.gz
	http://www.kroah.com/linux/hotplug/pci-hotplug-2.4.9-ac6.patch.gz

Changes since last release:
	- forward ported to the different kernels
	- the 2.4.10-pre4 and 2.4.9-ac6 patches allow the driver to be
	  compiled directly into the kernel.

I'm going to start splitting up the code in this driver into a "generic"
section, and a Compaq PCI hotplug controller specific piece.  This will
allow other PCI hotplug drivers to use the generic functionality that is
provided in the current driver (resource allocations, userspace
interaction, etc.)  This should allow me to port the current driver to
the ia64 platform, and add support for some IBM hotplug controllers.  If
anyone wants to help out with any of this, please let me know.

thanks,

greg k-h
