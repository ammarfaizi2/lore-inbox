Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUCBBuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 20:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUCBBuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 20:50:03 -0500
Received: from aun.it.uu.se ([130.238.12.36]:49031 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261534AbUCBBuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 20:50:00 -0500
Date: Tue, 2 Mar 2004 02:49:40 +0100 (MET)
Message-Id: <200403020149.i221nelX024890@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de, davej@redhat.com
Subject: Re: [start_kernel] Suggest to move parse_args() before trap_init()
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, yi.zhu@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004 20:54:26 +0000, Dave Jones wrote:
>On Mon, Mar 01, 2004 at 09:46:38PM +0100, Andi Kleen wrote:
>
> > > I think the only problem with this is if we get a fault during
> > > parse_args(), the kernel flies off into outer space.  So you lose some
> > > debuggability when using an early console.
> > > 
> > > But 2.4 does trap_init() after parse_args() and nobody has complained, as
> > > did 2.6 until recently.  So the change is probably OK.
> > 
> > The standard way to fix this is to add an explicit check for lapic
> > to the early argument parsing in setup.c (but keep the __setup so that
> > no unknown argument is reported).
>
>This just got me thinking of a sort-of related problem.
>Some laptops hang when local apic is enabled, and we couldn't
>blacklist them in 2.4 due to us not doing the dmi scan early enough.
>
>Did that get fixed in 2.6 ?

My patch for early DMI scan and local APIC blacklisting
was included in 2.5.6 and 2.4.19. This was done mainly
to handle all those broken Dell laptops.

/Mikael
