Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVHJNPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVHJNPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVHJNPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:15:50 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:27660 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S965098AbVHJNPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:15:50 -0400
Date: Wed, 10 Aug 2005 14:15:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050810131529.GB2840@linux-mips.org>
References: <20050810080057.GA5295@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810080057.GA5295@lst.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:

> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.
> 
> Some architectures have a too different ptrace so we have to exclude
> them: alpha, ia64, m32r, parisc, sparc, sparc64.  They continue to
> keep their implementations.  For sh64 I had to add a sh64_ptrace wrapper
> because it does some initialization on the first call.  For um I removed
> an ifdefed SUBARCH_PTRACE_SPECIAL block, but SUBARCH_PTRACE_SPECIAL
> isn't defined anywhere in the tree.
> 
> Only tested on ppc32 so far.

MIPS bits looking good.

  Ralf
