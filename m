Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWEBV40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWEBV40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWEBV40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:56:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:5058 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965011AbWEBV4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:56:25 -0400
Date: Tue, 2 May 2006 14:54:17 -0700
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Michael Holzheu <holzheu@de.ibm.com>,
       akpm@osdl.org, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi,
       ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060502215417.GA26451@kroah.com>
References: <20060429215501.GA9870@kroah.com> <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com> <20060501203815.GE19423@kroah.com> <2DBA690E-B11A-478E-B2E0-0529F4CE45A9@mac.com> <20060502040053.GA14413@kroah.com> <20060502052341.GD11150@vrfy.org> <20060502053703.GA12992@kroah.com> <20060502114603.GA14568@vrfy.org> <20060502212845.GA30957@kroah.com> <20060502213352.GA18192@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502213352.GA18192@vrfy.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 11:33:52PM +0200, Kay Sievers wrote:
> On Tue, May 02, 2006 at 02:28:45PM -0700, Greg KH wrote:
> > On Tue, May 02, 2006 at 01:46:03PM +0200, Kay Sievers wrote:
> > > On Mon, May 01, 2006 at 10:37:03PM -0700, Greg KH wrote:
> > > > On Tue, May 02, 2006 at 07:23:41AM +0200, Kay Sievers wrote:
> > > > > If the count of values handled in a transaction is not to high and it
> > > > > makes sense to group these values logically, why not just create an
> > > > > attribute group for every transaction, which creates dummy attributes
> > > > > to fill the values in, and use an "action" file in that group, that
> > > > > commits all the values at once to whatever target? That should fit into
> > > > > the ioctl use pattern, right?
> > > > 
> > > > That's what configfs can handle easier.  I think the issue is getting
> > > > stuff from the kernel in one atomic snapshot (all the different file
> > > > values from the same point in time.)
> > > 
> > > Sure, but just like an ioctl, the kernel could return the values after
> > > writing to the "action" file in the dummy attributes. That would be
> > > something like a snapshot, right?
> > 
> > Yes, but where would the buffer be to return the data to on a write?  In
> > the data that the user passed to write?
> 
> In the "dummy attribute", allocated by the device instance.

Ok, I'm totally confused and don't understand anymore.  Care to walk
this through again as to how it would work?

sorry,

greg k-h
