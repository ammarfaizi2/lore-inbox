Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbUDGXDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDGXDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:03:52 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19901
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264211AbUDGXBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:01:41 -0400
Date: Thu, 8 Apr 2004 01:01:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407230140.GT26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12640000.1081378705@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 03:58:25PM -0700, Martin J. Bligh wrote:
> so .... such microbenchmarks seems pointless. I'm not against 4/4G at all,
> I think it solves a real problem ... I just think latency numbers are a 

I agree as well it solves a real problem (i.e. 4G userspace), though the
userbase that needs it is extremely limited and they're sure ok to run
slower than to change their application to use shmfs (a special 4:4
kernel may be ok, just like a special 2.5:1.5 may be ok, just like
3.5:0.5 was ok for similar reasons too), but the mass market doesn't
need 4:4 and it will never need it, so it's bad to have the masses pay
for this relevant worthless runtime overhead in various common
workloads.

Of course above I'm talking about 2.6-aa or 2.6-mjb. Clearly with
kernels including rmap like 2.6 mainline or 2.6-mm or 2.6-mc or the
2.4-rmap patches you need 4:4 everywhere, even on a 4/8G box to avoid
running out of normal zone in some fairly common and important workload.
