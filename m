Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUDGWSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUDGWSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:18:08 -0400
Received: from ns.suse.de ([195.135.220.2]:53720 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261159AbUDGWSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:18:05 -0400
Date: Thu, 8 Apr 2004 00:16:29 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: NUMA API for Linux
Message-Id: <20040408001629.2ff39598.ak@suse.de>
In-Reply-To: <20040407145130.4b1bdf3e.akpm@osdl.org>
References: <1081373058.9061.16.camel@arrakis>
	<20040407145130.4b1bdf3e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004 14:51:30 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Matthew Dobson <colpatch@us.ibm.com> wrote:
> >
> > Just from the patches you posted, I would really disagree that these are
> > ready for merging into -mm.
> 
> I have them all merged up here.  I made a number of small changes -
> additional CONFIG_NUMA ifdefs, whitespace improvements, remove unneeded
> arch_hugetlb_fault() implementation.  The core patch created two copies of
> the same file in mempolicy.h, compile fix in mmap.c and a few other things.

Sorry about the bad patches. I will try to be more careful in the future.

What was the problem in mmap.c ? I compiled in various combinations (with
and without NUMA on i386 and x86-64) and it worked.

And why was arch_hugetlb_fault() unneeded?

> It builds OK for NUMAQ, although NUMAQ does have a problem:
> 
> drivers/built-in.o: In function `acpi_pci_root_add':
> drivers/built-in.o(.text+0x22015): undefined reference to `pci_acpi_scan_root'
> 
> ppc64+CONFIG_NUMA compiles OK.

ppc64 doesn't have the system calls hooked up, but I'm not sure how useful
it would be for these boxes anyways (afaik they are pretty uniform) 

-Andi
