Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVCRWfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVCRWfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVCRWbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:31:38 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:41735 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262436AbVCRWa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:30:26 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mingo@elte.hu (Ingo Molnar)
Subject: Re: Real-Time Preemption and RCU
Cc: bhuey@lnxw.com, paulmck@us.ibm.com, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20050318160229.GC25485@elte.hu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DCPut-0005XI-00@gondolin.me.apana.org.au>
Date: Sat, 19 Mar 2005 09:26:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> i really have no intention to allow multiple readers for rt-mutexes. We
> got away with that so far, and i'd like to keep it so. Imagine 100
> threads all blocked in the same critical section (holding the read-lock)
> when a highprio writer thread comes around: instant 100x latency to let
> all of them roll forward. The only sane solution is to not allow
> excessive concurrency. (That limits SMP scalability, but there's no
> other choice i can see.)

What about allowing only as many concurrent readers as there are CPUs?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
