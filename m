Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUDOALo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUDOALo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:11:44 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:64756 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262136AbUDOALb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:11:31 -0400
Date: Wed, 14 Apr 2004 17:22:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <170580000.1081988562@flay>
In-Reply-To: <20040415000529.GX2150@dualathlon.random>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain> <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu> <69200000.1081804458@flay> <Pine.LNX.4.58.0404141616530.25848@rust.engin.umich.edu> <20040415000529.GX2150@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Martin! When you get time to test your SDET with this patch, please
>> let me know whether this patch helps you at all. The patch applies
>> on top of 2.6.5-mjb1+anobjrmap9_prio_tree.
> 
> I considered converting it to a rwsem too, details are in the the email
> I posted while providing the rwspinlock solution to the parisc cache
> flushing code.

I will try it, but I'm not convinced it'll help. I profiled the takers
of i_shared_sem, and I think they're all writers (and I tried rwsem on
the simple linked list before with no benefit).

M.
