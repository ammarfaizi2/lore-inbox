Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264149AbUDOOln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUDOOln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:41:43 -0400
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:4758 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S264149AbUDOOlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:41:42 -0400
Date: Thu, 15 Apr 2004 10:41:28 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@blue.engin.umich.edu
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <20040415130028.GB2150@dualathlon.random>
Message-ID: <Pine.GSO.4.58.0404151037420.6707@blue.engin.umich.edu>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain>
 <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu> <69200000.1081804458@flay>
 <Pine.LNX.4.58.0404141616530.25848@rust.engin.umich.edu>
 <20040415000529.GX2150@dualathlon.random> <Pine.GSO.4.58.0404142323160.21462@sapphire.engin.umich.edu>
 <20040415130028.GB2150@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I don't know why bit_spin_lock with vma->vm_flags should be a problem
> > if it is used without mmap_sem. Can you explain ?
>
> you seem not to know all rules about the atomic operations in smp, you
> cannot just set_bit on one side and use non-atomic operations on the
> other side, and expect the set_bit not to invalidate the non-atomic
> operations.
>
> The effect of the mprotect may be deleted by your new concurrent
> set_bit and stuff like that.

Thank you very much for that. Stupid me. I didn't read the code in
page->flags properly. Thanks again.

Rajesh


