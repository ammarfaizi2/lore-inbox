Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269171AbUIRHmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269171AbUIRHmD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUIRHmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:42:02 -0400
Received: from ozlabs.org ([203.10.76.45]:51899 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269152AbUIRHll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:41:41 -0400
Date: Sat, 18 Sep 2004 09:43:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PPC64] Remove LARGE_PAGE_SHIFT constant
Message-ID: <20040917234357.GA23252@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040917011320.GA6523@zax> <20040917170328.GB2179@logos.cnet> <1095446429.4088.3.camel@localhost> <20040917173334.GC2179@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917173334.GC2179@logos.cnet>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 02:33:34PM -0300, Marcelo Tosatti wrote:
> On Fri, Sep 17, 2004 at 11:40:29AM -0700, Dave Hansen wrote:
> > On Fri, 2004-09-17 at 10:03, Marcelo Tosatti wrote:
> > > On Fri, Sep 17, 2004 at 11:13:20AM +1000, David Gibson wrote:
> > > > Andrew, please apply:
> > > > 
> > > > For historical reasons, ppc64 has ended up with two #defines for the
> > > > size of a large (16M) page: LARGE_PAGE_SHIFT and HPAGE_SHIFT.  This
> > > > patch removes LARGE_PAGE_SHIFT in favour of the more widely used
> > > > HPAGE_SHIFT.
> > > 
> > > Nitpicking, "LARGE_PAGE_xxx" is used by x86/x86_64:
> > > 
> > > #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
> > > #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
> > > 
> > > Wouldnt it be nice to keep consistency between archs?
> > 
> > Actually, if everybody makes sure to define PMD_SHIFT, we should be able
> > to use common macros, right?
> 
> Yeap. 

No.  The large page shift is not necessarily the same as the
PMD_SHIFT.  It's the same on x86, but it is less on sparc64 and sh,
and greater on ppc64.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
