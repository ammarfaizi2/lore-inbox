Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319118AbSHMVUE>; Tue, 13 Aug 2002 17:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319128AbSHMVUE>; Tue, 13 Aug 2002 17:20:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4875 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319118AbSHMVUB>; Tue, 13 Aug 2002 17:20:01 -0400
Date: Tue, 13 Aug 2002 14:24:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Theurer <habanero@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <2016010000.1029271332@flay>
Message-ID: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Martin J. Bligh wrote:
> 
> Was that before or after you changed HZ to 1000? I *think* that increased
> the frequency of IO-APIC reprogramming by a factor of 10, though I might
> be misreading the code. If it does depend on HZ, I think that's bad.

The 1000Hz thing came much later, and I never noticed any impact of that 
on my machines.

(Note that this is all entrely subjective. I was very disappointed in the
feel of the first HT P4 machine I had for the first few weeks, but apart
from running lmbench - which looked ok even though it shows that P4's are
bad at system calls - I've not actually put numbers on it. But my feeling
was that the irq thing made a noticeable difference. Caveat emptor -
subjective feelings are not good).

> People in our benchmarking group (Andrew, cc'ed) have told me that
> reducing the frequency of IO-APIC reprogramming by a factor of 20 or
> so improves performance greatly - don't know what HZ that was at, but
> the whole thing seems a little overenthusiastic to me.

The rebalancing was certainly done with a 100Hz clock, so yes, it might 
have become much worse lately.

		Linus

