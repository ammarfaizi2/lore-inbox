Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVCUSFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVCUSFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCUSFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:05:32 -0500
Received: from fmr24.intel.com ([143.183.121.16]:9188 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261341AbVCUSFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:05:21 -0500
Date: Mon, 21 Mar 2005 10:04:57 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, akpm@osdl.org,
       len.brown@intel.com, tony.luck@intel.com, dely.l.sy@intel.com
Subject: Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Message-ID: <20050321100457.A4477@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com> <20050319051331.GC21485@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050319051331.GC21485@suse.de>; from gregkh@suse.de on Fri, Mar 18, 2005 at 09:13:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 09:13:32PM -0800, Greg KH wrote:
> 
> This all looks very good, nice job.  I only had one minor comment on the
> patches, which I'll reply to directly.
> 
> But I did have a few questions:
> 	- This series relys on Mathew's rewrite of the acpiphp driver.
> 	  Is that acceptable?  Is that patch necessary for your work?
> 	  And if so, can you include it in the whole series?

The last patch (12) in the series is the only one that depends on
Matthew's acpiphp rewrite.  I do have a really old version of my
patch that worked with the original acpiphp code base but this
version is cleaner. I could probably resurrect my old patch if you
want, but I'd rather prefer to work on and fix any other objections
you or others may have with Matthew's re-write, since that's the 
better overall approach.

> 	- Does this break the i386 acpiphp functionality?

Dely Sy had tested hotplug with an earlier version of my patches
(with minor differences from the current series) on i386 and it
worked fine. She probably hasn't tested the latest one. Dely,
could you check that please? The i386 hotplug capable box I
have doesn't seem to have the right firmware, so I haven't 
been able to test hotplug on that (I'm working on fixing that).
Of course, I tested my patches on i386 (ACPI as well as non-ACPI)
and x86_64 machines to make sure I didn't break boot on those.


> 	- Have you tested other pci hotplug systems with this patch
> 	  series?  Like pci express hotplug, standard pci hotplug,
> 	  cardbus, etc?

No, because I the one system I have access to isn't doing any
hot-plug. I'm working on fixing that but was also hoping to hear
from others who surely have access to more machines than I do.

> 	- Are you wanting the acpi specific patches to go into the tree
> 	  through the acpi developers?  How about the ia64 specific
> 	  patches?

I honestly don't know what the best approach is here - what do you
recommend? I did receive an email from Andrew indicating he wants
to pick these up for the next mm. Perhaps the best thing is to
let Andrew include the whole series after I've addressed all
feedback and you, Tony, Len etc. all agree these are OK to go in.

> 	- Have the acpi developers agreed with your acpi patches?
> 
This is the first time I sent the patches to the acpi list, so I do
need to give them a few days to weigh in. 

Rajesh

