Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUIQSzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUIQSzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUIQSzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:55:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268937AbUIQSzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:55:19 -0400
Date: Fri, 17 Sep 2004 14:33:34 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PPC64] Remove LARGE_PAGE_SHIFT constant
Message-ID: <20040917173334.GC2179@logos.cnet>
References: <20040917011320.GA6523@zax> <20040917170328.GB2179@logos.cnet> <1095446429.4088.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095446429.4088.3.camel@localhost>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 11:40:29AM -0700, Dave Hansen wrote:
> On Fri, 2004-09-17 at 10:03, Marcelo Tosatti wrote:
> > On Fri, Sep 17, 2004 at 11:13:20AM +1000, David Gibson wrote:
> > > Andrew, please apply:
> > > 
> > > For historical reasons, ppc64 has ended up with two #defines for the
> > > size of a large (16M) page: LARGE_PAGE_SHIFT and HPAGE_SHIFT.  This
> > > patch removes LARGE_PAGE_SHIFT in favour of the more widely used
> > > HPAGE_SHIFT.
> > 
> > Nitpicking, "LARGE_PAGE_xxx" is used by x86/x86_64:
> > 
> > #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
> > #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
> > 
> > Wouldnt it be nice to keep consistency between archs?
> 
> Actually, if everybody makes sure to define PMD_SHIFT, we should be able
> to use common macros, right?

Yeap. 
