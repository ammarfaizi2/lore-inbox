Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbULQEor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbULQEor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbULQEor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:44:47 -0500
Received: from almesberger.net ([63.105.73.238]:59153 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262741AbULQEop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:44:45 -0500
Date: Fri, 17 Dec 2004 01:44:17 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [RFC] Generalized prio_tree, revisited
Message-ID: <20041217014417.B2568@almesberger.net>
References: <20041216053118.M1229@almesberger.net> <41C1A3F4.2090707@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C1A3F4.2090707@umich.edu>; from vrajesh@umich.edu on Thu, Dec 16, 2004 at 10:04:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian wrote:
> prio_tree_replace should be static in prio_tree.c.

Actually, no - vma_prio_tree_remove uses it too. Reverted.

> Should we go with prio_tree_iter_init and remove prio_tree_first
> (similar to vma_prio_tree_next) ? I am not very particular about it,
> though.

So that's a change that ought to go in before the actual split,
along with changing vma_prio_tree_next to use only prio_tree_next.
Okay, it's in my patch set, which I'll post after a bit of testing.
(Three overlapping patches, *shiver*.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
