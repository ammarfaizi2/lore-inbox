Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVGOBxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVGOBxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 21:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbVGOBxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 21:53:03 -0400
Received: from ozlabs.org ([203.10.76.45]:29661 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261811AbVGOBxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 21:53:02 -0400
Date: Fri, 15 Jul 2005 11:14:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: RFC: Hugepage COW
Message-ID: <20050715011428.GC7750@localhost.localdomain>
Mail-Followup-To: Christoph Lameter <christoph@lameter.com>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
References: <20050707055554.GC11246@localhost.localdomain> <Pine.LNX.4.62.0507141022440.14347@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507141022440.14347@graphe.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 10:24:33AM -0700, Christoph Lameter wrote:
> On Thu, 7 Jul 2005, David Gibson wrote:
> 
> > Now that the hugepage code has been consolidated across the
> > architectures, it becomes much easier to implement copy-on-write.
> > Hugepage COW is of limited utility of itself, however, it is
> > essentially a prerequisite for any of a number of methods of allowing
> > userland programs to automatically use hugepages without code changes
> > e.g. hugepage malloc() libraries, implicit hugepage mmap(), hugepage
> > ELF segments.  For certain applications (particularly enormous HPC
> > FORTRAN programs), these can result in a large performance
> > improvement.
> > 
> > Thoughts?  Flames?
> 
> Great stuff. I am glad that you are cleaning up the hugepages and are 
> making progress improving them. What are your thoughts on implementing 
> fault handling for huge pages?

Well, the COW patch implements a fault handler, obviously.  What
specifically where you thinking about?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
