Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVECEOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVECEOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 00:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVECEOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 00:14:11 -0400
Received: from ozlabs.org ([203.10.76.45]:55684 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261365AbVECEOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 00:14:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17014.64136.49697.910612@cargo.ozlabs.ibm.com>
Date: Tue, 3 May 2005 14:14:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] pgtable.h and other header cleanups
In-Reply-To: <20050503033332.GC22453@localhost.localdomain>
References: <20050503002608.GA22453@localhost.localdomain>
	<20050503012343.GB22453@localhost.localdomain>
	<20050503033332.GC22453@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson writes:

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
> 	- Fix some bugs which broke compile with STRICT_MM_TYPECHECKS.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
