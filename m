Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271742AbTG2O3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271724AbTG2O3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:29:51 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:10430 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271742AbTG2O3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:29:48 -0400
Date: Tue, 29 Jul 2003 07:29:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mala Anand <manand@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case 
Message-ID: <3850000.1059488946@[10.10.2.4]>
In-Reply-To: <OF607D10C6.EC89E09C-ON87256D72.004CBCAE@us.ibm.com>
References: <OF607D10C6.EC89E09C-ON87256D72.004CBCAE@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> If you want data supporting my assumptions: Ted Ts'o's talk at OLS
>>> shows the necessity to rebalance ASAP (even in try_to_wake_up).
> 
>> If this is the patch I am thinking of, it was the (attached) one I sent
> them,
>> which did a light "push" rebalance at try_to_wake_up.  Calling
> load_balance
>> at try_to_wake_up seems very heavy-weight.  This patch only looks for an
> idle
>> cpu (within the same node) to wake up on before task activation, only if
> the
>> task_rq(p)->nr_running is too long.  So, yes, I do believe this can be
>> important, but I think it's only called for when we have an idle cpu.
> 
> The patch that you sent to Rajan didn't yield any improvement on
> specjappserver so we did not include that  in the ols paper. What
> is described in the ols paper is "calling load-balance" from
> try-to-wake-up. Both calling load-balance from try-to-wakeup and
> the "light push" rebalance at try_to_wake_up are already done in
> Andrea's 0(1) scheduler patch.

Are the balances you're doing on wakeup global or node-local?

M.

