Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbULPTi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbULPTi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbULPTi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:38:56 -0500
Received: from almesberger.net ([63.105.73.238]:5902 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262021AbULPTie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:38:34 -0500
Date: Thu, 16 Dec 2004 16:38:16 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [RFC] Generalized prio_tree, revisited
Message-ID: <20041216163816.X1229@almesberger.net>
References: <20041216053118.M1229@almesberger.net> <41C1A3F4.2090707@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C1A3F4.2090707@umich.edu>; from vrajesh@umich.edu on Thu, Dec 16, 2004 at 10:04:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian wrote:
> I wonder whether we should use [start, last]

Yes, good idea. I've changed it in my tree.

> prio_tree_replace should be static in prio_tree.c.

Indeed. Thanks !

> > +struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter);
> 
> Should we go with prio_tree_iter_init and remove prio_tree_first
> (similar to vma_prio_tree_next) ? I am not very particular about it,
> though.

You mean to roll prio_tree_first and prio_tree_iter_init into a
single call, so that prio_tree_first would look similar to the
one in 2.6.7 ?

> > +static void get_index(const struct prio_tree_root *root,
> 
> Should be "inline" ?

That's of course what we hope to happen, but I'd leave the inlining
decision to the compiler. After all, it's supposed to be really
good at such things nowadays ;-)

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
