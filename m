Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266519AbRGDHVd>; Wed, 4 Jul 2001 03:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266523AbRGDHVW>; Wed, 4 Jul 2001 03:21:22 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:2062 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266519AbRGDHVI>;
	Wed, 4 Jul 2001 03:21:08 -0400
Date: Wed, 4 Jul 2001 00:19:42 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.6 and 2.4.5-ac24
Message-ID: <20010704001942.B30811@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've made a patch for the Compaq/Intel Hotplug PCI driver against both
2.4.6 and 2.4.5-ac24 available at:
	http://www.kroah.com/linux/hotplug/

Here is a list of the things that have been changed since the last patch
I sent out:
	- forward ported to 2.4.6
	- added Configure.help entries
	- fixed the directory structure to be a bit more sane
	- renamed the files to make more sense
	- fixed spinlock bugs
	- split the Compaq NVRAM portion of the driver to be a compile
	  time option for those without Compaq servers (will make i64
	  port a bit easier.)
	- cleaned up the symbol namespace.  Now plays well with the rest
	  of the kernel.
	- fixed a number of bugs when the driver attempts to be loaded
	  on a system that does not actually have the Compaq Hotplug PCI
	  device (no more oopses!)
	- got rid of almost all non-Linux specific code.  There is one
	  pci function that needs to be still cleaned up, but it is very
	  minor.
	- added MODULE_DEVICE_TABLE support (yes the Hotplug PCI driver
	  is now /sbin/hotplug compatible :)
	- lots of dead code removal.
	- cleaned up the function comment style.
	- loads of other little changes.
	  
I've tested this patch on both Compaq and Intel hotplug controllers.

There are only a few minor things left to do:
	- incorporate native list types where possible.
	- add support for other archs (ia64)
	- get driver into the kernel tree.

If anyone has any problems or questions about this version, please let
me know.

thanks,

greg k-h

