Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbVFXEWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbVFXEWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVFXEVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:21:51 -0400
Received: from graphe.net ([209.204.138.32]:7363 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263115AbVFXEGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:06:33 -0400
Date: Thu, 23 Jun 2005 21:06:30 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
In-Reply-To: <20050623.205447.66178303.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0506232057340.29222@graphe.net>
References: <Pine.LNX.4.62.0506232037430.28814@graphe.net>
 <20050623.204702.26274560.davem@davemloft.net> <Pine.LNX.4.62.0506232047450.29103@graphe.net>
 <20050623.205447.66178303.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, David S. Miller wrote:

> Ok.  You're going to have to come up with something better
> than a %3 AIM benchmark increase with 5000 threads to justify
> those invasive NUMA changes, and thus this infrastructure for
> it.

I am sure one can do better than that. The x445 is the smallest NUMA box 
that I know of and the only one available in the context of that project. 
But I am also not sure that this will reach proportions  that will 
outweigh the complexity added by these patches. What would be 
the performance benefit that we would need to see to feel that is 
is right to get such a change in?

> I'm picking those examples, because I am rather certain your patches
> will hurt performance in those cases.  The data structure size
> expansion and extra memory allocations alone for the per-node dst
> stuff should be good about doing that.

Hmm. I like the idea of a separate routing cache per node. May actually 
reach higher performance than splitting the counters. Lets think a bit 
about that.
