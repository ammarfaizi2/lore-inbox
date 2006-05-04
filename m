Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWEDPfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWEDPfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWEDPfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:35:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:18127 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932317AbWEDPfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:35:50 -0400
Date: Thu, 4 May 2006 08:34:11 -0700
From: Greg KH <greg@kroah.com>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060504153411.GA27485@kroah.com>
References: <20060504144259.GA26668@kroah.com> <OF99AF266B.81368F01-ON42257164.00523E52-42257164.0052802A@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF99AF266B.81368F01-ON42257164.00523E52-42257164.0052802A@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 05:01:07PM +0200, Michael Holzheu wrote:
> Hi Greg,
> 
> Greg KH <greg@kroah.com> wrote on 05/04/2006 04:42:59 PM:
> > > I would suggest do do it like /sys/kernel and put the code
> > > into kernel/ksysfs.c and include/linux/kobject.h
> >
> > No, if you do that then every kernel gets that mount point, when almost
> > no one really wants it :)
> >
> > If you leave it as a separate file, then the build system can just
> > include the file as needed.
> >
> 
> So you want a new config option CONFIG_HYPERVISOR?

Sure.  But don't make it a user selectable config option, but rather,
one your S390 option sets.

That way the Xen and other groups can also set it when they need it.

> When no one except for us wants it, wouldn't it be best
> then to create /sys/hypervisor first in the hypfs code?
> 
> If someone else needs it in the future, we still can move
> it common code.

The Xen people need it too.  Now who knows when their code will ever hit
mainline...

thanks,

greg k-h
