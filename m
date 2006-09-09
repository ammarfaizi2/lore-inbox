Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWIIISb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWIIISb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 04:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWIIISb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 04:18:31 -0400
Received: from ns1.suse.de ([195.135.220.2]:45284 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932353AbWIIIS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 04:18:29 -0400
Date: Sat, 9 Sep 2006 01:18:16 -0700
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: State of the Linux PCI Subsystem for 2.6.18-rc6
Message-ID: <20060909081816.GA13058@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a summary of the current state of the Linux PCI subsystem, as of
2.6.18-rc6.

If the information in here is incorrect, or anyone knows of any
outstanding issues not listed here, please let me know.

List of outstanding regressions from 2.6.17:
	- none known.

List of outstanding regressions from older kernel versions:
	- none known.


If interested, the list of all currently open PCI bugs can be seen at:
    http://bugzilla.kernel.org/showdependencytree.cgi?id=5829&hide_resolved=1


Future patches that are currently in my quilt tree (as found at
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
) for the PCI subsystem are as follows.  All of these will be submitted
for inclusion into 2.6.19, except as noted:

	- MSI rework currently being tested out in the -mm tree.
	- PCI Express AER implementation.
	- few minor PCI Hotplug driver fixes and cleanups.
	- resource minor tweak.
	- PCI sort device lists in breadth-first to fix the regression
	  of PCI device order from the 2.4 kernel tree.  This can be
	  disabled by a command line option if anyone is wed to the old
	  2.6 buggy way.

Note that there are some PCI API changes that happen in my driver tree.
See that status report for details on those changes (nothing was done to
break anything, only new stuff was added.)

No other new PCI driver API changes are pending that I am aware of.  The
PCI sort order change will affect some people's userspace ordering of
network devices, restoring it to the proper 2.4 ordering.  It was never
intended that this be broken, and since no one has noticed this for the
past 3 years, it was not broken in a severe way.

thanks,

greg k-h

