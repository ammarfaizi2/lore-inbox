Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269978AbUJWByu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269978AbUJWByu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269507AbUJWByj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:54:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:46524 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269803AbUJWBxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:53:16 -0400
Subject: Re: [PATCH] 8250: Let arch provide the list of leagacy
	ports	dynamically
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <E1CLAvB-00041B-00@gondolin.me.apana.org.au>
References: <E1CLAvB-00041B-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Message-Id: <1098496295.6008.129.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 11:51:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 11:42, Herbert Xu wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > a #define of an array. This finally allows to fix the problem of
> > platforms like ppc and ppc64 for which the same kernel can boot
> > machines with and without a 8250, and is necessary to properly deal
> 
> That sounds great because we're seeing the same problem with i8042
> on ppc/ppc64.  Do you have any plans for that driver?

There is a different patch "[PATCH] ppc64: Add mecanism to check existence
of legacy ISA devices" that I posted today that does that for ppc64,
however, Linus seem to prefer something different involving porting
the pnp core to ppc64 and adapting those drivers to rely on it, which
I don't have time to do at the moment.

Ben.


