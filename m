Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUDPGRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 02:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUDPGRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 02:17:42 -0400
Received: from ozlabs.org ([203.10.76.45]:31131 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262476AbUDPGRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 02:17:38 -0400
Date: Fri, 16 Apr 2004 16:15:42 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [2/3]
Message-ID: <20040416061542.GE26707@zax>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, 'Andrew Morton' <akpm@osdl.org>
References: <20040416044917.GB26707@zax> <200404160556.i3G5uFF14323@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404160556.i3G5uFF14323@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 10:56:14PM -0700, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, April 15, 2004 9:49 PM
> > > > If we could get rid of follow_hugetlb_pages() it would remove an ugly
> > > > function from every arch, which would be nice.
> > >
> > > I hope the goal here is not to trim code for existing prefaulting scheme.
> > > That function has to go for demand paging, and demand paging comes with
> > > a performance price most people don't realize.  If the goal here is to
> > > make the code prettier, I vote against that.
> >
> > Well, I'm attempting to understand the hugepage code across all the
> > archs, so that I can try to implement copy-on-write with a minimum of
> > arch specific gunk.  Simplifying and consolidating the existing code
> > across archs would be a helpful first step, if possible.
> 
> Looks like everyone has their own agenda, COW is related to demand paging,
> and has it's own set of characteristics to deal with.  I would hope do one
> thing at a time.

Which is why I've attempted to factor things out of your patches which
don't appear to be inherent to demand paging.  Consolidating the
existing hugepage code will make both demand-paging and COW patches
much more palatable.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
