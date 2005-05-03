Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVECBXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVECBXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVECBXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:23:52 -0400
Received: from ozlabs.org ([203.10.76.45]:58092 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261275AbVECBXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:23:50 -0400
Date: Tue, 3 May 2005 11:23:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] pgtable.h and other header cleanups
Message-ID: <20050503012343.GB22453@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20050503002608.GA22453@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503002608.GA22453@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 10:26:08AM +1000, David Gibson wrote:
> Andrew, please apply.
> 
> This patch started as simply removing a few never-used macros from
> asm-ppc64/pgtable.h, then kind of grew.  It now makes a bunch of
> cleanups to the ppc64 low-level header files (with corresponding
> changes to .c files where necessary) such as:
> 	- Abolishing never-used macros
> 	- Eliminating multiple #defines with the same purpose
> 	- Removing pointless macros (cases where just expanding the
> macro everywhere turns out clearer and more sensible)
> 	- Removing some cases where macros which could be defined in
> terms of each other weren't
> 	- Moving imalloc() related definitions from pgtable.h to their
> own header file (imalloc.h)
> 	- Re-arranging headers to group things more logically
> 	- Moving all VSID allocation related things to mmu.h, instead
> of being split between mmu.h and mmu_context.h
> 	- Removing some reserved space for flags from the PMD - we're
> not using it.

Aargh!  Don't apply, patch is broken (missing imalloc.h).  Grr... I
could have sworn I'd quilt added it.  Fixed version coming shortly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
