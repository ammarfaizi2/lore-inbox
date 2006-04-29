Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWD2HxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWD2HxP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWD2HxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 03:53:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:16566 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750757AbWD2HxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 03:53:14 -0400
Date: Sat, 29 Apr 2006 00:51:33 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Holzheu <holzheu@de.ibm.com>, schwidefsky@de.ibm.com,
       penberg@cs.helsinki.fi, ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060429075133.GA1886@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060428234441.1407c82f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428234441.1407c82f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 11:44:41PM -0700, Andrew Morton wrote:
> Michael Holzheu <holzheu@de.ibm.com> wrote:
> >
> >  As mount point for the filesystem /sys/hypervisor is created.
> 
> What does this mean, btw?  I don't see code there creating a new sysfs
> directory, and userspace cannot do this.

The call to subsystem_register() does this.

> Also, "/sys/hypervisor" is probably insufficiently specific.  In a few
> years time people will be asking "Which hypervisor?  We have eighteen of them!".

I agree, the xen people are already clammering for some kind of sysfs
tree and wanted to create /sys/hypervisor/xen.  How about
/sys/hypervisor/s390?

thanks,

greg k-h
