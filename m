Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbVFXGRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbVFXGRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 02:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbVFXGRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 02:17:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40585
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263144AbVFXGRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 02:17:10 -0400
Date: Thu, 23 Jun 2005 23:16:55 -0700 (PDT)
Message-Id: <20050623.231655.68159153.davem@davemloft.net>
To: clameter@engr.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506232256360.17993@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0506232057340.29222@graphe.net>
	<20050623.211140.131918815.davem@davemloft.net>
	<Pine.LNX.4.62.0506232256360.17993@schroedinger.engr.sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <clameter@engr.sgi.com>
Date: Thu, 23 Jun 2005 23:03:45 -0700 (PDT)

> Ok. Then we are done. With 58 Itanium processors and 200G Ram I get 
> more than 10% improvement ;-). With 500 tasks we have 453 vs. 499 j/m/t.
> That is 9.21%. For 300 tasks we have 9.4% etc. I am sure that I can push 
> this some more with bigger counts of processors and also some other NUMA 
> related performance issues.

So it took 7 times more processors to increase the performance gain by
just over 3 on a microscopic synthetic benchmark.  That's not
impressive at all.

And you still haven't shown what happens for the workloads I
suggested.  A web benchmark, with say a thousand unique clients, would
be sufficient for one of those btw.  That case has very low dst
locality, yet dsts are useful because you'll have about 2 or 3
concurrent connections per dst.
