Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWAFTYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWAFTYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWAFTYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:24:13 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50137 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964838AbWAFTYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:24:10 -0500
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
From: Lee Revell <rlrevell@joe-job.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
In-Reply-To: <43BE43B6.3010105@cosmosbay.com>
References: <20060105235845.967478000@sorel.sous-sol.org>
	 <20060106004555.GD25207@sorel.sous-sol.org>
	 <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
	 <43BE43B6.3010105@cosmosbay.com>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 14:24:07 -0500
Message-Id: <1136575448.17979.55.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 11:17 +0100, Eric Dumazet wrote:
> I have some servers that once in a while crashes when the ip route
> cache is flushed. After
> raising /proc/sys/net/ipv4/route/secret_interval (so that *no* 
> flush is done), I got better uptime for these servers. 

Argh, where is that documented?  I have been banging my head against
this for weeks - how do I keep the kernel from flushing 4096 routes at
once in softirq context causing huge (~8-20ms) latency problems?

I tried all the route related sysctls I could find and nothing worked...

Lee

