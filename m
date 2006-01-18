Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWARDdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWARDdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWARDdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:33:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32911 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964894AbWARDdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:33:10 -0500
Date: Tue, 17 Jan 2006 21:32:54 -0600
From: Robin Holt <holt@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Robin Holt'" <holt@sgi.com>, Dave McCracken <dmccr@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <20060118033254.GA28446@lnx-holt.americas.sgi.com>
References: <20060117235302.GA22451@lnx-holt.americas.sgi.com> <200601180127.k0I1R8g18386@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601180127.k0I1R8g18386@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 05:27:09PM -0800, Chen, Kenneth W wrote:
> Robin Holt wrote on Tuesday, January 17, 2006 3:53 PM
> > This appears to work on ia64 with the attached patch.  Could you
> > send me any test application you think would be helpful for me
> > to verify it is operating correctly?  I could not get the PTSHARE_PUD
> > to compile.  I put _NO_ effort into it.  I found the following line
> > was invalid and quit trying.
> > 
> > --- linux-2.6.orig/arch/ia64/Kconfig	2006-01-14 07:16:46.149226872 -0600
> > +++ linux-2.6/arch/ia64/Kconfig	2006-01-14 07:25:02.228853432 -0600
> > @@ -289,6 +289,38 @@ source "mm/Kconfig"
> >  config ARCH_SELECT_MEMORY_MODEL
> >  	def_bool y
> >  
> > +
> > +config PTSHARE_HUGEPAGE
> > +	bool
> > +	depends on PTSHARE && PTSHARE_PMD
> > +	default y
> > +
> 
> You need to thread carefully with hugetlb ptshare on ia64. PTE for
> hugetlb page on ia64 observe full page table levels, not like x86
> that sits in the pmd level.

I did no testing with hugetlb pages.

Robin
