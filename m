Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTKTRO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 12:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTKTRO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 12:14:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:13967 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262040AbTKTROy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 12:14:54 -0500
Date: Thu, 20 Nov 2003 09:00:25 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Olaf Hering <olh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, christophe.varoqui@free.fr,
       patmans@us.ibm.com
Subject: Re: [ANNOUNCE] udev 006 release
Message-ID: <20031120170025.GH26720@kroah.com>
References: <20031119162912.GA20835@kroah.com> <20031119234708.GC23529@kroah.com> <20031120065920.GC14930@suse.de> <200311200725.34868.dsteklof@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311200725.34868.dsteklof@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 07:25:34AM -0800, Daniel Stekloff wrote:
> On Wednesday 19 November 2003 10:59 pm, Olaf Hering wrote:
> >  On Wed, Nov 19, Greg KH wrote:
> > > 	- I've added two external programs to the udev tarball, under
> > > 	  the extras/ directory.  They are the scsi-id program from Pat
> > > 	  Mansfield, and the multipath program from Christophe Varoqui.
> > > 	  Both of them can work as CALLOUT programs.  I don't think they
> > > 	  currently build properly within the tree, by linking against
> > > 	  klibc, but patches to their Makefiles to fix this would be
> > > 	  gladly accepted :)
> >
> > There is no make install target for the headers and the libs. Both
> > packages disgree on the location. I use the patch below. Can you make a
> > decision where the headers should be located?
> 
> 
> As a note, the package sysfsutils that contains libsysfs installs the headers 
> into /usr/include/sysfs. Are we going to have conflicts since udev has its 
> own private libsysfs statically included? Should the extra programs build off 
> udev's libsysfs, since they are included with the package? Or, should they 
> require a shared libsysfs from sysfsutils? If udev is to have its own static 
> edition of libsysfs, perhaps it'd be best if it didn't install headers and 
> the extras either used its static version or required the shared libsysfs to 
> be installed.

I think the extras/ programs should probably build against the udev
version of libsysfs, in order to provide a "build everything"
experience, and not rely on people having to get a verison of libsysfs
too.

thanks,

greg k-h
