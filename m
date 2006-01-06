Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWAFNKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWAFNKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWAFNKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:10:15 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:22757 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932334AbWAFNKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:10:14 -0500
Message-ID: <43BE6C14.5080904@cosmosbay.com>
Date: Fri, 06 Jan 2006 14:09:40 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
References: <20060105235845.967478000@sorel.sous-sol.org> <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org> <43BE43B6.3010105@cosmosbay.com> <200601061358.42344.ak@suse.de>
In-Reply-To: <200601061358.42344.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 06 Jan 2006 14:09:44 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> On Friday 06 January 2006 11:17, Eric Dumazet wrote:
> 
>> I assume that if a CPU queued 10.000 items in its RCU queue, then the
>> oldest entry cannot still be in use by another CPU. This might sounds as a
>> violation of RCU rules, (I'm not an RCU expert) but seems quite reasonable.
> 
> I don't think it's a good assumption. Another CPU might be stuck in a long 
> running interrupt, and still have a reference in the code running below
> the interrupt handler.
> 
> And in general letting correctness depend on magic numbers like this is 
> very nasty.
> 

I agree Andi, I posted a 2nd version of the patch with no more assumptions.

Eric


