Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVKASMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVKASMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVKASMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:12:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36616 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751072AbVKASMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:12:07 -0500
Date: Tue, 1 Nov 2005 18:12:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH consolidate sys_ptrace
Message-ID: <20051101181200.GB18205@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20051101050900.GA25793@lst.de> <20051101051221.GA26017@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101051221.GA26017@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 06:12:21AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 01, 2005 at 06:09:00AM +0100, Christoph Hellwig wrote:
> > [Let's try again now that sys_ptrace returns long everywhere mainline..]
> > 
> > The sys_ptrace boilerplate code (everything outside the big switch
> > statement for the arch-specific requests) is shared by most
> > architectures.  This patch moves it to kernel/ptrace.c and leaves the
> > arch-specific code as arch_ptrace.
> > 
> > Some architectures have a too different ptrace so we have to exclude
> > them.  They continue to keep their implementations.  For sh64 I had to
> > add a sh64_ptrace wrapper because it does some initialization on the
> > first call.  For um I removed an ifdefed SUBARCH_PTRACE_SPECIAL block,
> > but SUBARCH_PTRACE_SPECIAL isn't defined anywhere in the tree.
> 
> Umm, it might be a good idea to actually send the current patch instead
> of the old one.  I really should write this text from scratch instead
> of copying it :)
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks Christoph.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
