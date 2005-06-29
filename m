Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVF2Wuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVF2Wuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVF2Wuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:50:51 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:22794 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262701AbVF2Wuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:50:44 -0400
Date: Wed, 29 Jun 2005 15:57:34 -0700
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050629225734.GA23793@nietzsche.lynx.com>
References: <42C320C4.9000302@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C320C4.9000302@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 06:29:24PM -0400, Kristian Benoit wrote:
> Overall analysis:
...
> We had not intended to redo a 3rd run so early, but we're happy we did
> given the doubts expressed by some on the LKML. And as we suspected, these
> new results very much corroborate what we had found earlier. As such, our
> conclusions remain mostly unchanged:

Did you compile your host Linux kernel with CONFIG_SMP in place ? That's
critical since a UP kernel removes both spinlock and blocking locks in
critical paths makes micro benchmarks sort of invalid.

The benchmark is sort of confusing two things and merging them into one.
Both the latency statistic and kernel performance must be kept seperate.
The overall kernel performance is a more complicate issue that has to be
analysize differently using a more complicated methodology. That because
an RTOS use of PREEMPT_RT is going to be under a different circumstance
than that of a pure dual kernel set up of some sort. The functionalities
aren't the same.

I suggest that you compile the dual kernel with SMP turned on and try it
again, otherwise it's not really testing the overhead of any of the locking
for either the PREEMPT_RT or dual kernel set ups. That's really the only
outstanding statistic that I've noticed in that benchmark.

bill

