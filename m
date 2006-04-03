Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWDCMtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWDCMtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDCMtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:49:20 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:6572 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932309AbWDCMtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:49:20 -0400
Date: Mon, 3 Apr 2006 13:49:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unify PFN_* macros
Message-ID: <20060403124916.GA14044@linux-mips.org>
References: <20060323162459.6D45D1CE@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323162459.6D45D1CE@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 08:24:59AM -0800, Dave Hansen wrote:

> Just about every architecture defines some macros to do operations on
> pfns.  They're all virtually identical.  This patch consolidates all
> of them.
> 
> One minor glitch is that at least i386 uses them in a very skeletal
> header file.  To keep away from #include dependency hell, I stuck
> the new definitions in a new, isolated header.
> 
> Of all of the implementations, sh64 is the only one that varied by a
> bit.  It used some masks to ensure that any sign-extension got
> ripped away before the arithmetic is done.  This has been posted to
> that sh64 maintainers and the development list.
> 
> Compiles on x86, x86_64, ia64 and ppc64.

Ehhh...  Looks at this patch I wonder if you actually read the MIPS bits
before submitting it:

 o replaces PFN_ALIGN with PAGE_ALIGN
 o replaces the IP27 definition of PFN_ALIGN with a different one.

How about posting such stuff to linux-arch?  No sane person follows l-k.

  Ralf
