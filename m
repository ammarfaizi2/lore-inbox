Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUDGXKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDGXKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:10:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18567 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261204AbUDGXKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:10:21 -0400
Date: Wed, 07 Apr 2004 16:21:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <29510000.1081380104@flay>
In-Reply-To: <20040407230140.GT26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree as well it solves a real problem (i.e. 4G userspace), though the
> userbase that needs it is extremely limited and they're sure ok to run
> slower than to change their application to use shmfs (a special 4:4
> kernel may be ok, just like a special 2.5:1.5 may be ok, just like
> 3.5:0.5 was ok for similar reasons too), but the mass market doesn't
> need 4:4 and it will never need it, so it's bad to have the masses pay
> for this relevant worthless runtime overhead in various common
> workloads.

Yeah, it needs to be a separate kernel for huge blobby machines. I think
that's exactly what RH does, IIRC (> 16GB ?)
 
> Of course above I'm talking about 2.6-aa or 2.6-mjb. Clearly with
> kernels including rmap like 2.6 mainline or 2.6-mm or 2.6-mc or the
> 2.4-rmap patches you need 4:4 everywhere, even on a 4/8G box to avoid
> running out of normal zone in some fairly common and important workload.

Speaking of which, pte_highmem is stinking expensive itself. There's
probably a large class of workloads that'd work with out pte_highmem
if we had 4/4 split (or shared pagetables. Grrr ;-))

M.

