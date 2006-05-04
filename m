Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWEDOoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWEDOoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWEDOoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:44:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39880 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751157AbWEDOoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:44:46 -0400
Date: Thu, 4 May 2006 07:42:59 -0700
From: Greg KH <greg@kroah.com>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060504144259.GA26668@kroah.com>
References: <20060503221037.GA17181@kroah.com> <OF3B24B2D7.E24F3E4F-ON42257164.0038D454-42257164.0039028B@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3B24B2D7.E24F3E4F-ON42257164.0038D454-42257164.0039028B@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 12:22:42PM +0200, Michael Holzheu wrote:
> Greg KH <greg@kroah.com> wrote on 05/04/2006 12:10:37 AM:
> 
> > > Fine with me! Then I will create /sys/hypervisor/s390. Should I
> > > create /sys/hypervisor in the hpyfs code or should it be
> > > created somewhere else?
> >
> > Somewhere else is probably best.
> >
> > drivers/base/hypervisor.c ?
> >
> 
> We could do that, but then we have to create two new files
> hypervisor.c and hypervisor.h just for one new mountpoint
> in sysfs.
> 
> I would suggest do do it like /sys/kernel and put the code
> into kernel/ksysfs.c and include/linux/kobject.h

No, if you do that then every kernel gets that mount point, when almost
no one really wants it :)

If you leave it as a separate file, then the build system can just
include the file as needed.

thanks,

greg k-h
