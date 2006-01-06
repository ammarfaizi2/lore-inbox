Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWAFWd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWAFWd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWAFWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:33:59 -0500
Received: from ns1.suse.de ([195.135.220.2]:20460 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750844AbWAFWd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:33:58 -0500
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
Date: Fri, 6 Jan 2006 23:18:34 +0100
User-Agent: KMail/1.8.2
Cc: Eric Dumazet <dada1@cosmosbay.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
References: <20060105235845.967478000@sorel.sous-sol.org> <200601061358.42344.ak@suse.de> <1136575600.17979.58.camel@mindpipe>
In-Reply-To: <1136575600.17979.58.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601062318.35464.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 20:26, Lee Revell wrote:
> On Fri, 2006-01-06 at 13:58 +0100, Andi Kleen wrote:
> > Another CPU might be stuck in a long 
> > running interrupt
> 
> Shouldn't a long running interrupt be considered a bug?

In normal operation yes, but there can be always exceptional
circumstances where it's unavoidable (e.g. during error handling) 
and in the name of defensive programming the rest of the system ought 
to tolerate it.

-Andi
