Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUCPTNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbUCPTNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:13:37 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:58301
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261357AbUCPTNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:13:12 -0500
Date: Tue, 16 Mar 2004 14:22:26 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, EVMS <evms-devel@lists.sourceforge.net>
Subject: Re: deactivate dm disks?
Message-ID: <20040316142226.A13765@animx.eu.org>
References: <20040315205650.A11865@animx.eu.org> <200403160917.03810.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <200403160917.03810.kevcorry@us.ibm.com>; from Kevin Corry on Tue, Mar 16, 2004 at 09:17:03AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I was playing with evms (2.2 kernel 2.6.3 vanilla) and some reason, it
> > grabbed my usb disk (sde) and won't let go of it.  Is there any way I can
> > make it let go of the disk?  It grabbed sde1 and sde2 of the disk.
> 
> You can put entries in your /etc/evms.conf file to tell EVMS to ignore certain 
> disks (e.g. if you don't want it to examine sde). See the "legacy_devices" 
> section (for 2.4 kernels) and/or the "sysfs_devices" section (for 2.6 
> kernels).

Ok, great, that works.

> > I tried the deactivate which just gave me an invalid argument. I really do
> > not wish to reboot this machine just to remove the usb disk.
> 
> If you have the "dmsetup" tool, you can issue a "dmsetup remove_all" command 
> to deactivate all the DM devices. Just make sure all the DM devices are 
> unmounted, or it won't actually release the underlying disks. Dmsetup is part 
> of the device-mapper package, available at ftp://sources.redhat.com/pub/dm/.

Ahh, thanks.  That did the trick.

> > I also noticed it wanted to grab my partitions on sda which were already
> > mounted and couldn't grab them.
> 
> Again, you can add an "exclude" entry in your /etc/evms.conf if you want EVMS 
> to ignore sda. Otherwise, have a look at
> http://evms.sf.net/install/kernel.html#bdclaim

I think I'll only give it disks that I want in evms.  The "sde" is a USB
disk that I move around alot.

If you're not the right person to ask, please direct me to someone else.
I was going to do a raid5 across a few disks (this is in the future not
now).  Is there any way to add disks to that raid5 using evms?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
