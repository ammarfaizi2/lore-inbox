Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTBYANC>; Mon, 24 Feb 2003 19:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbTBYANC>; Mon, 24 Feb 2003 19:13:02 -0500
Received: from bitmover.com ([192.132.92.2]:54508 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264705AbTBYANB>;
	Mon, 24 Feb 2003 19:13:01 -0500
Date: Mon, 24 Feb 2003 16:23:09 -0800
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225002309.GA12146@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com> <20030224233638.GS10411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224233638.GS10411@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The changes are getting measured. By and large if it's slower on UP
> it's rejected. 

Suppose I have an application which has a working set which just exactly
fits in the I+D caches, including the related OS stuff.

Someone makes some change to the OS and the benchmark for that change is
smaller than the I+D caches but the change increased the I+D cache space
needed. 

The benchmark will not show any slowdown, correct?
My application no longer fits and will suffer, correct?

The point is that if you are putting SMP changes into the system, you
have to be held to a higher standard for measurement given the past
track record of SMP changes increasing code length and cache footprints.
So "measuring" doesn't mean "it's not slower on XYZ microbenchmark".
It means "under the following work loads the cache misses went down or
stayed the same for before and after tests".

And if you said that all changes should be held to this standard, not
just scaling changes, I'd agree with you.  But scaling changes are the
"bad guy" in my mind, they are not to be trusted, so they should be held
to this standard first.  If we can get everyone to step up to this bat,
that's all to the good.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
