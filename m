Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWD1AUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWD1AUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWD1AT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:19:56 -0400
Received: from ns.suse.de ([195.135.220.2]:23001 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751735AbWD1ATb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:19:31 -0400
Date: Thu, 27 Apr 2006 17:17:58 -0700
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add pci_assign_resource_fixed -- allow fixed address assignments
Message-ID: <20060428001758.GA18917@kroah.com>
References: <Pine.LNX.4.44.0604271242410.25641-100000@gate.crashing.org> <20060427153432.5f3f4c12.akpm@osdl.org> <116674A8-64F4-4F49-8AAC-06C94159B3B3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116674A8-64F4-4F49-8AAC-06C94159B3B3@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 07:12:14PM -0500, Kumar Gala wrote:
> 
> On Apr 27, 2006, at 5:34 PM, Andrew Morton wrote:
> 
> >Kumar Gala <galak@kernel.crashing.org> wrote:
> >>
> >>On some embedded systems the PCI address for hotplug devices are  
> >>not only
> >>known a priori but are required to be at a given PCI address for  
> >>other
> >>master in the system to be able to access.
> >>
> >>An example of such a system would be an FPGA which is setup from  
> >>user space
> >>after the system has booted.  The FPGA may be access by DSPs in  
> >>the system
> >>and those DSPs expect the FPGA at a fixed PCI address.
> >>
> >>Added pci_assign_resource_fixed() as a way to allow assignment of  
> >>the PCI
> >>devices's BARs at fixed PCI addresses.
> >
> >Is there any sane way in which we can arrange for this function to  
> >not be
> >present in vmlinux's which don't need it?
> >
> >Options would be
> >
> >a) Put it in a .a file.
> >
> >   - messy from a source perspective
> >
> >   - doesn't work if the only reference is from a module
> >
> >   - small gains anyway.
> >
> >b) Use CONFIG_EMBEDDED.
> 
> I'm fine with wrapping it in a CONFIG_EMBEDDED, Greg?

That's fine with me.  Care to send me an updated patch?  I'll drop the
other one then.

thanks,

greg k-h
