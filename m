Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUKPBtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUKPBtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKPBtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:49:17 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:26756 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261752AbUKPBsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:48:23 -0500
Date: Mon, 15 Nov 2004 20:48:15 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@lazuli.engin.umich.edu
To: Werner Almesberger <werner@almesberger.net>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
In-Reply-To: <20041115213515.B28802@almesberger.net>
Message-ID: <Pine.GSO.4.58.0411152043100.12962@lazuli.engin.umich.edu>
References: <20041114235646.K28802@almesberger.net>
 <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu>
 <20041115175415.X28802@almesberger.net> <Pine.LNX.4.58.0411151559070.30860@red.engin.umich.edu>
 <20041115184240.Y28802@almesberger.net> <Pine.GSO.4.58.0411151705260.6691@lazuli.engin.umich.edu>
 <20041115195946.Z28802@almesberger.net> <Pine.GSO.4.58.0411151814440.6691@lazuli.engin.umich.edu>
 <20041115213515.B28802@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, Werner Almesberger wrote:

> Rajesh Venkatasubramanian wrote:
> > Yeap. That looks sane. However, if you are planning to produce
> > a patch, please consider the following names:
> >
> > 	struct prio_tree_node {
> > 		unsigned long start, end;
> > 		struct raw_prio_tree_node prio_tree_node;
> > 	};
>
> Okay. Any reason why you've put "start, end" before "prio_tree_node" ?
> The other way around would seem to make things a lot easier.

I don't have any reason. I am okay with either.

> > I think the r_index and h_index names are only meaningful in
> > prio_tree.c. My guess is start and end will be more palatable
> > to users of prio_tree.
>
> Yes, they're a bit confusing :-) It would actually be nice if you
> could write a little paper describing this particular type of radix
> priority search tree, since it differs quite a bit from the original.
> Also, the original paper is comparably difficult to obtain if you
> don't have a university library at hand. Better documentation of how
> prio_tree works might also encourage new uses of it.

I have already started doing that. Please check
Documentation/prio_tree.txt in 2.6.10-rc2. The document can be
improved a lot, but for now it tries to explain the differences
from the original paper. Yes. I got a copy of the original paper
from my university library, there are no digital copies available.

Rajesh
