Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbTHESzC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHESzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:55:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:31399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269036AbTHESyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:54:55 -0400
Date: Tue, 5 Aug 2003 11:54:20 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: [ANNOUNCE] 2003-08-05 release of hotplug scripts
Message-ID: <20030805185420.GA4933@kroah.com>
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
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_08_05.tar.gz
or for those who like bz2 packages:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_08_05.tar.bz2

I've also packaged up some pre-built (and signed) Red Hat 7.3 based rpms:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_08_05-1_rh73.noarch.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-base-2003_08_05-1_rh73.noarch.rpm
and some pre-built (and signed) Red Hat 9 based rpms:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_08_05-1_rh9.noarch.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-base-2003_08_05-1_rh9.noarch.rpm

The source rpm is available if you want to rebuild it for other distros
or versions of Red Hat at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_08_05-1_rh73.src.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_08_05-1_rh9.src.rpm
 
The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/
which contains lots of documentation on the whole linux-hotplug
process.


This release is recommended for _anyone_ using the 2.6.0-test and beyond
kernels, as a number of changes have been made in order to support the recent
kernel changes.  These include:
	- fix usb autoloading of modules for 2.6 (it wasn't working).
	- changed network code to accept 2.5's change to the way network
	  interfaces are brought up and down (now "add" and "remove"
	  like all the other hotplug types.)
	
The release is still backwards compatible with 2.4, so there is no need
to worry about upgrading.

The full ChangeLog extract since the last release is included below for
those who want to know everything that's been changed, and who to blame
for them :)

thanks,

greg k-h


--------------
Tue Aug 5 2003 kroah
        - 2003_08_05 release

Sun Aug 3 2003 kroah
        - fix usb autoloading of modules for 2.6 (it wasn't working).

Fri Jun 27 2003 kroah
        - changed network code to accept 2.5's change to the way network
          interfaces are brought up and down (now "add" and "remove" like all
          the other hotplug types.)

Fri Jun 6 2003 dbrownell
    hotplug.functions fixes from:
        - Olaf Hering:  #!/bin/bash gone, VIM modeline,
          logger location can vary, and should include PID
        - Ian Abbot: correct init of LOADED (fixes sf.net bug filing)
    Other sf.net bugs resolved
        - pointless pci.rc message [538243]
        - Makefile should ignore tape drives [578462]
