Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSANUBo>; Mon, 14 Jan 2002 15:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSANUAR>; Mon, 14 Jan 2002 15:00:17 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:59148 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288969AbSANT5E>;
	Mon, 14 Jan 2002 14:57:04 -0500
Date: Mon, 14 Jan 2002 11:53:48 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Subject: [ANNOUNCE] 2002-01-14 release of hotplug scripts
Message-ID: <20020114195348.GA21076@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
 	http://sourceforge.net/project/showfiles.php?group_id=17679

Or from your favorite kernel.org mirror at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2001_09_19.tar.gz

I've also packaged up some Red Hat 7.2 based rpms:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2002_01_14-1.noarch.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-fxload-2002_01_14-1.i386.rpm

The source rpms are available if you want to rebuild them for other
distros at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2002_01_14-1.src.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-fxload-2002_01_14-1.src.rpm

The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/
which contains lots of documentation on the whole linux-hotplug
process.  There are also links to kernel patches, not currently in the
main kernel tree, that provide hotplug functionality to new subsystems
(like CPU, SCSI, Memory, etc.)

Here's the changes (and who made them) from the last release:

  Changes from me:
	- created hotplug-fxload.spec to split the .rpm up into two
	  packages which lets the hotplug rpm be "noarch" again.
	- changed hotplug.spec to only be one package again.
	- fixed type on ieee1394.agent that prevented version matches
	  from working properly.

  Changes from Fumitoshi UKAI
	- usb.agent: fix work around 2.2 brokenness. it didn't handle
	  ab.c or ab.cd propoerly (it becomes PRODUCT=X/Y/ab.c0,
	  X/Y/ab.cd) It should be PRODUCT=X/Y/abc0, X/Y/abcd
	- usb.agent: define REMOVER for system without usbdevfs
	- update debian/ files

  Changes from David Brownell
	- updated the hotplug.8 man page
	- rmmod boot protocol drivers too
	- mention environment variables in the hotplug core script's
	  comments
	- created the fxload.8 man page
	- fxload changes:
		- fail on firmware download errors; add "-v" flag
		- merge adjacent hex records, and optionally show writes
		- Add sanity check: reject requests to load off-chip
		  memory, The EZ-USB devices just fail silently in these
		  cases.

thanks,

greg k-h
