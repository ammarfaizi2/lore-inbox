Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262253AbSIZIa5>; Thu, 26 Sep 2002 04:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262254AbSIZIa5>; Thu, 26 Sep 2002 04:30:57 -0400
Received: from holomorphy.com ([66.224.33.161]:21156 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262253AbSIZIa5>;
	Thu, 26 Sep 2002 04:30:57 -0400
Date: Thu, 26 Sep 2002 01:36:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: Useful fork info? WAS Re: [BENCHMARK] fork_load module tested for contest
Message-ID: <20020926083610.GM3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>
References: <1032964936.3d91cb48b1cca@kolivas.net> <1033009036.3d92778cee9b9@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1033009036.3d92778cee9b9@kolivas.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 12:57:16PM +1000, Con Kolivas wrote:
> fork_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  97.11           67%             1.33
> 2.4.19-ck7              72.34           92%             0.99
> 2.5.38                  75.32           92%             1.03
> 2.5.38-mm2              74.99           92%             1.03
> 2.4.19: Children forked: 32750
> 2.4.19-ck7: Children forked: 6477
> 2.5.38: Children forked: 5545
> 2.5.38-mm2: Children forked: 5351
> You can see clearly repeatedly forking a new process significantly slows down
> compile time for 2.4.19 but not the O(1) based kernels. However, the number of
> processes that are forked is significantly reduced.
> Is this information useful? 

Well, it means something. I should point out that the cost of pagetable
copying is increased by pte-based reverse mapping, and your "children
forked" throughput results reflect this. It's a known issue, and AFAIK
regarded as a reasonable tradeoff.

Cheers,
Bill
