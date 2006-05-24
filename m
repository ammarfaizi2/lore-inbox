Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWEXSSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWEXSSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 14:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWEXSSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 14:18:14 -0400
Received: from a80-127-56-249.adsl.xs4all.nl ([80.127.56.249]:53996 "EHLO
	nasng.slim") by vger.kernel.org with ESMTP id S932391AbWEXSSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 14:18:14 -0400
Subject: Re: [PATCH 0/6]  EDAC Patch Set
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
Reply-To: gtm.kramer@inter.nl.net
To: Doug Thompson <norsk5@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060524174303.2323.qmail@web50102.mail.yahoo.com>
References: <20060524174303.2323.qmail@web50102.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 20:17:56 +0200
Message-Id: <1148494676.3282.8.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 10:43 -0700, Doug Thompson wrote:
> This patch set applies to kernel 2.6.17-rc4 fine and to 2.6.17-rc4-mm1 with slight
> fuzz in the MAINTAINERs file.
> 
> The following set of patches to EDAC provide various cleanups of the EDAC core and
> memory controller drivers.  Most of which came from Dave Peterson and from others.
> 
> edac-pci_dep.patch
> Change MC drivers from using CVS revisions strings for their version number,
> Now each driver has its own local string.
> 
> Remove some PCI dependencies from the core EDAC module.  Most of the code
> changes here are from a patch by Dave Jiang.
> It may be best to eventually move the PCI-specific code into a separate source file.
> 
> edac-mc_numbers_1_of_2.patch
> This is part 1 of a 2-part patch set.  The code changes are split into two
> parts to make the patches more readable.
> 
> Remove add_mc_to_global_list().  In next patch, this function will be
> reimplemented with different semantics.
> 
> edac-mc_numbers_2_of_2.patch
> This is part 2 of a 2-part patch set.
> 
> - Reimplement add_mc_to_global_list() with semantics that allow the caller to
>   determine the ID number for a mem_ctl_info structure.  Then modify
>   edac_mc_add_mc() so that the caller specifies the ID number for the new
>   mem_ctl_info structure.  Platform-specific code should be able to assign the
>   ID numbers in a platform-specific manner.  For instance, on Opteron it makes
>   sense to have the ID of the mem_ctl_info structure match the ID of the node
>   that the memory controller belongs to.
> 
> - Modify callers of edac_mc_add_mc() so they use the new semantics.
> 
> edac-probe1_cleanup_1_of_2.patch
> This is part 1 of a 2-part patch set.  The code changes are split into two
> parts to make the patches more readable.
> 
> Add lower-level functions that handle various parts of the initialization done
> by the xxx_probe1() functions.  Some of the xxx_probe1() functions are much
> too long and complicated (see "Chapter 5: Functions" in
> Documentation/CodingStyle).
> This is part 2 of a 2-part patch set.
> 
> Modify the xxx_probe1() functions so they call the lower-level functions
> created by the first patch in the set.

Will this patchset fix/suppress the "Non-Fatal Error PCI Express B"
messages I see with the E7525 edac?

I am running 2.6.16 (or more specific FC5 2.6.16-1.2111) with seems to
already include this version:

MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 May  4 2006

This version still floods my syslog with "Non-Fatal Error...." messages.

Jurgen


