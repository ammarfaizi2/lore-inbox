Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131293AbRBNXyS>; Wed, 14 Feb 2001 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131540AbRBNXyI>; Wed, 14 Feb 2001 18:54:08 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:54541 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S131539AbRBNXxu>;
	Wed, 14 Feb 2001 18:53:50 -0500
Date: Wed, 14 Feb 2001 15:49:16 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Subject: 2001-02-14 release of hotplug scripts
Message-ID: <20010214154916.A13258@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest hotplug scripts into a release, and
they can be found at:
        http://download.sourceforge.net/linux-hotplug/hotplug-2001_02_14.tar.gz
        http://download.sourceforge.net/linux-hotplug/hotplug-2001_02_14-1.noarch.rpm
        http://download.sourceforge.net/linux-hotplug/hotplug-2001_02_14-1.src.rpm
depending on which format you prefer.

Changes in this version from the last release are:
	- rpm makes the subsystem scripts executable
	- some logging fixes
	- insistence on having a writable /tmp so bash works properly
	- added support for pcimodules
	- Fixes some problems seen with Redhat 7 systems when the
	  partial USB setup in /etc/rc.sysinit was not disabled.  The
	  failure mode was that all USB modules got loaded, rather than
	  only modules for the devices that were connected.
	- In conjunction with the "usbmodules" and "pcimodules" patches
	  to "usbutils-0.7" and "pciutils-2.1.8", devices that are
	  connected at boot time will also be configured.  If you don't
	  have those utilities, you'll need to plug USB and CardBus
	  devices in after the system is booted, otherwise they can't be
	  properly configured.
	- other small fixes.

If you haven't patched your version of usbutils and pciutils, you can
get the patch at:
	http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=98141435915986&w=2

Hopefully updated versions of these two packages will be released with
these changes in them soon.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
