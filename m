Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWBHX5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWBHX5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWBHX5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:57:23 -0500
Received: from cantor2.suse.de ([195.135.220.15]:15746 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422663AbWBHX5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:57:22 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation
Date: Thu, 9 Feb 2006 00:57:09 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, pj@sgi.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com> <20060208154332.715d617d.akpm@osdl.org> <Pine.LNX.4.62.0602081547180.5184@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602081547180.5184@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602090057.10232.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 00:54, Christoph Lameter wrote:
> On Wed, 8 Feb 2006, Andrew Morton wrote:
> 
> > > If a caller cannot handle NULL then __GFP_NOFAIL has to be set, right?
> > 
> > That would assume non-buggy code.  I'm talking about the exercising of
> > hitherto-unused codepaths.  We've fixed many, many pieces of code which
> > simply assumed that kmalloc(GFP_KERNEL) succeeds.  I doubt if many such
> > simple bugs still exist, but there will be more subtle ones in there.
> 
> We could add __GFP_NOFAIL to kmem_getpages in slab.c to insure that 
> kmalloc waits rather than return NULL. Also a too drastic measure right?

Definitely too drastic. I bet that would cause deadlocks in quite some loads.

-Andi

