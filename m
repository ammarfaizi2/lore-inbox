Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUDAStk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbUDAStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:49:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:47539 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263024AbUDASte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:49:34 -0500
Date: Thu, 1 Apr 2004 10:48:52 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: [ANNOUNCE] 2004-04-01 release of hotplug scripts
Message-ID: <20040401184852.GA13967@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_04_01.tar.gz
or for those who like bz2 packages:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_04_01.tar.bz2

As this release was primarily a sync up with a bunch of pending Gentoo
patches, I did not build rpm packages, as there was nothing really new
that any Red Hat user would care much about.  That's also why I didn't
update the sf.net page (besides it being a big pain to do so...)

The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/
which contains lots of documentation on the whole linux-hotplug
process.
 
The release is still backwards compatible with 2.4, so there is no need
to worry about upgrading.

The full ChangeLog extract since the last release is included below for
those who want to know everything that's been changed, and who to blame
for them :)

thanks,

greg k-h

Thu Apr  1 2004 kroah
        - 2004_04_01 release
        - From Martin Hicks <mort@bork.org>
                - fix hotplug.spec file, adding clean rule.
        - Sync up with fixes in Gentoo tree:
                - return proper error value in pci.rc
                - handle system overrides properly in usb.rc
                - handle system overrides properly in usb.agent
                - fix LOADED test in hotplug.functions
                - add ability to start network scripts properly.
                - add ability to stop network scripts properly.

Thu Apr  1 2004 ukai
        - hotplug.functions: $MODULE need s/-/_/g to match with lsmod output
        - usb.agent: use $DEVPATH for $REMOVER if $DEVPATH is defined.
           when coldplugging on 2.6.*, we don't know $DEVICE, but $DEVPATH,
           so $DEVPATH should be used for unique string to device.

Web Mar 31 2004 ukai
        - input.agent: don't try to check empty $dev_bits in input_match_bits
           some posix shell may complain on it.



