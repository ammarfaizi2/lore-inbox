Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVCSFNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVCSFNp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 00:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVCSFNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 00:13:45 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:54620 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262409AbVCSFNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 00:13:43 -0500
Date: Fri, 18 Mar 2005 21:13:32 -0800
From: Greg KH <gregkh@suse.de>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Message-ID: <20050319051331.GC21485@suse.de>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 01:38:57PM -0800, Rajesh Shah wrote:
> Here is a series of patches to support ACPI hot-add of a root
> bridge hierarchy. The added hierarchy may contain other p2p 
> bridges and end/leaf I/O devices too. The root bridge itself is
> assumed to have been assigned resource ranges, but the p2p
> bridges and end devices are not required to be initialized by
> firmware. Most of the code changes are to make the existing code
> flows suitable for such a hierarchy of bridges & devices.
> 
> This code supports hot-add on ia64 only for now.It does not yet
> support I/O APIC hot-add, which is needed to make this fully
> functional.  The patches are against 2.6.11-mm4 (plus the patch 
> needed for ia64 to boot). I've tested to make sure this does not 
> break end/leaf device hotplug on the hotplug capable ia64 box I have.

This all looks very good, nice job.  I only had one minor comment on the
patches, which I'll reply to directly.

But I did have a few questions:
	- This series relys on Mathew's rewrite of the acpiphp driver.
	  Is that acceptable?  Is that patch necessary for your work?
	  And if so, can you include it in the whole series?
	- Does this break the i386 acpiphp functionality?
	- Have you tested other pci hotplug systems with this patch
	  series?  Like pci express hotplug, standard pci hotplug,
	  cardbus, etc?
	- Are you wanting the acpi specific patches to go into the tree
	  through the acpi developers?  How about the ia64 specific
	  patches?
	- Have the acpi developers agreed with your acpi patches?

thanks,

greg k-h
