Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVA1Pt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVA1Pt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVA1Pt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:49:56 -0500
Received: from mail.suse.de ([195.135.220.2]:5001 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261465AbVA1Pty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:49:54 -0500
Date: Fri, 28 Jan 2005 16:49:53 +0100
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Message-ID: <20050128154953.GJ6703@wotan.suse.de>
References: <20050128133927.GC6703@wotan.suse.de> <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com> <20050128143010.GE6703@wotan.suse.de> <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com> <20050128151839.GI6703@wotan.suse.de> <Pine.LNX.4.61.0501281534420.7304@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281534420.7304@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 03:46:05PM +0000, Hugh Dickins wrote:
> On Fri, 28 Jan 2005, Andi Kleen wrote:
> 
> > > Forgive me for not wading through the code, but it really needs to
> > > be spelt out in the comments: what's wrong with the existing kernel,
> > > with "noapic nolapic" in the distro's bootstring by default?
> > 
> > It's harder to explain and traditionally in LILO you couldn't remove
> > any options (in grub you can now).
> 
> And it's just that initial installation boot, via grub, which really
> matters.  Thereafter can be edited, before perhaps switching to LILO.

I now remember another reason for it: upgrades. SUSE always did it this
way (It goes back many moons to 2.2 based kernels when the UP APIC code
was added). It would be probably rather fragile to change this
automatically during an update.

I realize this isn't a big concern for mainline, but given that
people are always complaining about distributions having too many
patches it may be still good to add it to mainline because 
the SUSE kernel has it. Unless people think it is totally unsuitable (?),
but I don't think it is that bad.

Also I must add in addition to the CONFIG there are valuable bugfixes
in there too.

-Andi

