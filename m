Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWHaRiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWHaRiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWHaRiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:38:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50821 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932392AbWHaRir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:38:47 -0400
Subject: Re: [RFC][PATCH 4/9] ia64 generic PAGE_SIZE
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608301652270.5789@schroedinger.engr.sgi.com>
References: <20060830221604.E7320C0F@localhost.localdomain>
	 <20060830221607.1DB81421@localhost.localdomain>
	 <Pine.LNX.4.64.0608301652270.5789@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 10:38:30 -0700
Message-Id: <1157045910.31295.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 16:57 -0700, Christoph Lameter wrote:
> On Wed, 30 Aug 2006, Dave Hansen wrote:
> 
> > @@ -64,11 +64,11 @@
> >   * Base-2 logarithm of number of pages to allocate per task structure
> >   * (including register backing store and memory stack):
> >   */
> > -#if defined(CONFIG_IA64_PAGE_SIZE_4KB)
> > +#if defined(CONFIG_PAGE_SIZE_4KB)
> >  # define KERNEL_STACK_SIZE_ORDER		3
> > -#elif defined(CONFIG_IA64_PAGE_SIZE_8KB)
> > +#elif defined(CONFIG_PAGE_SIZE_8KB)
> >  # define KERNEL_STACK_SIZE_ORDER		2
> > -#elif defined(CONFIG_IA64_PAGE_SIZE_16KB)
> > +#elif defined(CONFIG_PAGE_SIZE_16KB)
> >  # define KERNEL_STACK_SIZE_ORDER		1
> >  #else
> >  # define KERNEL_STACK_SIZE_ORDER		0
> 
> Could we replace these lines with
> 
> #define KERNEL_STACK_SIZE_ORDER (max(0, 15 - PAGE_SHIFT)) 

My next series will be to clean up stack size handling.  Do you mind if
it waits until then?

-- Dave

