Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUKPAfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUKPAfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 19:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUKPAfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 19:35:34 -0500
Received: from almesberger.net ([63.105.73.238]:39693 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261682AbUKPAf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 19:35:27 -0500
Date: Mon, 15 Nov 2004 21:35:15 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
Message-ID: <20041115213515.B28802@almesberger.net>
References: <20041114235646.K28802@almesberger.net> <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu> <20041115175415.X28802@almesberger.net> <Pine.LNX.4.58.0411151559070.30860@red.engin.umich.edu> <20041115184240.Y28802@almesberger.net> <Pine.GSO.4.58.0411151705260.6691@lazuli.engin.umich.edu> <20041115195946.Z28802@almesberger.net> <Pine.GSO.4.58.0411151814440.6691@lazuli.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0411151814440.6691@lazuli.engin.umich.edu>; from vrajesh@umich.edu on Mon, Nov 15, 2004 at 07:07:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian wrote:
> Yeap. That looks sane. However, if you are planning to produce
> a patch, please consider the following names:
> 
> 	struct prio_tree_node {
> 		unsigned long start, end;
> 		struct raw_prio_tree_node prio_tree_node;
> 	};

Okay. Any reason why you've put "start, end" before "prio_tree_node" ?
The other way around would seem to make things a lot easier.

> I think the r_index and h_index names are only meaningful in
> prio_tree.c. My guess is start and end will be more palatable
> to users of prio_tree.

Yes, they're a bit confusing :-) It would actually be nice if you
could write a little paper describing this particular type of radix
priority search tree, since it differs quite a bit from the original.
Also, the original paper is comparably difficult to obtain if you
don't have a university library at hand. Better documentation of how
prio_tree works might also encourage new uses of it.

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
