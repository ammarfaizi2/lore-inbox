Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUAESfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbUAESfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:35:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:6818 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265277AbUAESfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:35:20 -0500
Date: Mon, 5 Jan 2004 10:30:58 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: [ANNOUNCE] 2004-01-05 release of hotplug scripts
Message-ID: <20040105183058.GA22066@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
 	http://sourceforge.net/project/showfiles.php?group_id=17679
 
Or from your favorite kernel.org mirror at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_01_05.tar.gz
or for those who like bz2 packages:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_01_05.tar.bz2

I've also packaged up some pre-built (and signed) Red Hat FC 1 based rpms:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_01_05-1.noarch.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-base-2004_01_05-1.noarch.rpm

The source rpm is available if you want to rebuild it for other distros
or versions of Red Hat at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_01_05-1.src.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_01_05-1.src.rpm
 
The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/
which contains lots of documentation on the whole linux-hotplug
process.

This release is recommended for _anyone_ using the 2.6.0 and beyond
kernels who is still using hotplug scripts older than 2003_08_05, as a
number of changes have been made in order to support the 2.6 kernel
properly.
	
The release is still backwards compatible with 2.4, so there is no need
to worry about upgrading.

The full ChangeLog extract since the last release is included below for
those who want to know everything that's been changed, and who to blame
for them :)

thanks,

greg k-h
 
--------------

Mon Jan 5 2004 kroah
        - 2004_01_05 release

Mon Oct 13 2003 kroah
        - sysfs entries for usb devices are in hex.  Patch from Andrey
          Borzenkov <arvidjaar@mail.ru>
        - add input.rc and input.agent for input systems.  Patch from Andrey
          Borzenkov <arvidjaar@mail.ru>

Tue Oct 7 2003 kroah
        - keep already loaded modules from causing messages in the syslog.
        - added firmware.agent file from Marcel Holtmann <marcel@holtmann.org>
        - Lots of patches from Bill Nottingham <notting@redhat.com> to try to
          sync back up with the Red Hat hotplug package:
                - hotplug-2003_08_05-networkdown.patch
                  Don't bring up network devices if the network service isn't
                  started.
                - hotplug-2002_04_01-joydev.patch
                  Some extra joystick devices.
                - hotplug-2003_08_05-tunnel.patch
                  Exclude tunl*/tun*/tap* from being brought up via hotplug
                  events
                - hotplug-2002_04_01-wacom.patch
                  Some wacom tablets for evdev.
                - hotplug-2002_04_01-usblcd.patch
                  usblcd mappings
                - hotplug-2002_04_01-inhotplug.patch
                  Set IN_HOTPLUG environment variable as something users can
                  check in case they don't want some interface to be
                  automatically brought up.
                - hotplug-2003_08_05-updfstab.patch
                  Run updfstab on usb-storage insertion, and general removal
                  (Probably needs to run on firewire, and other sorts of
                  removal devices). upfstab is a Red Hat specific program that
                  edits /etc/fstab to add entries for removable devices.
        - added dasd (s390 stuff) tape and dasd agent files from SuSE and Red
          Hat's hotplug package.

Wed Sep 24 2003 kroah
        - fixed status display of usb drivers in the 2.6 kernel as
          /proc/bus/usb/drivers is no longer present.
        - fixed typo in the /sbin/hotplug comments as found by
          Gary_Lerhaupt@Dell.com

Tue Sep 16 2003 kroah
        - remove devlabel calls, it should just put its own link in
          /etc/hotplug.d


