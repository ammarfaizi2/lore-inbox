Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314463AbSDRV3r>; Thu, 18 Apr 2002 17:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314464AbSDRV3q>; Thu, 18 Apr 2002 17:29:46 -0400
Received: from holomorphy.com ([66.224.33.161]:64926 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314463AbSDRV3q>;
	Thu, 18 Apr 2002 17:29:46 -0400
Date: Thu, 18 Apr 2002 14:28:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        torvalds@transmeta.com
Subject: Re: [PATCH] migration thread fix
Message-ID: <20020418212851.GW21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erich Focht <efocht@ess.nec.de>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.44.0204182043110.2453-100000@beast.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 10:08:55PM +0200, Erich Focht wrote:
> The patch below applies to the 2.5.8 kernel. It does two things:
> 1: Fixes a BUG in the migration threads: the interrupts MUST be disabled
> before the double runqueue lock is aquired, otherwise this thing will
> deadlock sometimes.
> 2: Streamlines the initialization of migration threads. Instead of
> fiddling around with cache_deccay_ticks, waiting for migration_mask bits
> and relying on the scheduler to distribute the tasks uniformly among
> processors, it starts the migration thread on the boot cpu and uses it to
> reliably distribute the other threads to their target cpus.
> Please consider applying it!

I have a patch to fix #2 as well. Did you see it? Did you try it?


Cheers,
Bill
