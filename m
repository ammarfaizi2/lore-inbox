Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUGHGLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUGHGLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUGHGLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:11:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:22410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265808AbUGHGLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:11:11 -0400
Date: Wed, 7 Jul 2004 23:09:33 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: Linda Xie <lxiep@us.ibm.com>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040708060933.GE548@kroah.com>
References: <20040707155907.G21634@forte.austin.ibm.com> <40EC9A02.1000507@us.ibm.com> <20040707190642.J21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707190642.J21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 07:06:42PM -0500, linas@austin.ibm.com wrote:
> On Wed, Jul 07, 2004 at 07:49:06PM -0500, Linda Xie wrote:
> > linas@austin.ibm.com wrote:
> > 
> > > 	}
> > > 	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
> > > 	/* do pci_scan_child_bus */
> > >-	pci_scan_child_bus(child_bus);
> > >+	// pci_scan_child_bus(child_bus);
> > > 
> > Why remove pci_scan_child_bus call?
> 
> Because it won't compile otherwise.  
> (Actually, I didn't mean to leave that in the patch, 
> it was a work-around to get my tree to compile).
> 
> pci_scan_child_bus() is currently defined only as a static fuction
> in drivers/pci/probe.c and thus cannot be called outside of that 
> file.  Maybe there's a patch to drivers/pci/probe.c that hasn't 
> been applied yet?

It's in the latest -bk tree, right?

greg k-h
