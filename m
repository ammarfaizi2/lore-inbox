Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274287AbRITArW>; Wed, 19 Sep 2001 20:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274288AbRITArL>; Wed, 19 Sep 2001 20:47:11 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:7948 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274287AbRITAq7>;
	Wed, 19 Sep 2001 20:46:59 -0400
Date: Wed, 19 Sep 2001 17:44:02 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Subject: 2001-09-19 release of hotplug scripts
Message-ID: <20010919174402.A17423@kroah.com>
In-Reply-To: <20010424124116.A13291@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010424124116.A13291@kroah.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
	http://sourceforge.net/project/showfiles.php?group_id=17679

This release adds ieee1394 support and a try at SuSE support :)

Here's the full changelog:
	- Added ieee1394.agent from Kristian Hogsberg
	  <hogsberg@users.sourceforge.net>
	- with docs, "sh -x" debug support, minor fix.  Needs kernel
	  2.4.10 and modutils 2.4.9 to hotplug.
	- Some of the updates from SuSE:
		* add/use debug_msg macro in hotplug_functions
		modprobe -s (to syslog)
		* various agent tweaks/fixes
		* more usb.handmap entries (from usbmgr)
	- Added the fxload program
	- Rework root makefile and hotplug.spec to install in prefix
	  location without need of spec file for install.
	- Added installation directions to make the /var/run/usb
	  directory, and updated the rpm spec file to match.
	- added half of Stephen Williams <steve@icarus.com> REMOVER
	  patch. It is up to the install script to create the
	  /var/run/usb directory.  Something like the following would be
	  enough:
	  	mkdir /var/run/usb
		chmod 0700 /var/run/usb

Thanks,

greg k-h
