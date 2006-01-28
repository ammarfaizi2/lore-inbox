Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422782AbWA1BQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422782AbWA1BQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWA1BQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:16:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32158 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422682AbWA1BQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:16:30 -0500
Date: Fri, 27 Jan 2006 17:18:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: kiran@scalex86.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060127171818.365ef5fa.akpm@osdl.org>
In-Reply-To: <43DAC46B.3010200@cosmosbay.com>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
	<43DAA586.5050609@cosmosbay.com>
	<20060127151635.3a149fe2.akpm@osdl.org>
	<43DABAA4.8040208@cosmosbay.com>
	<20060127164308.1ea4c3e5.akpm@osdl.org>
	<43DAC46B.3010200@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> [PATCH] Add atomic_long_xchg() and atomic_long_cmpxchg() wrappers
> 
> ...
>  
> +static inline long atomic_long_xchg(atomic_long_t *l, long val)
> +{
> +	atomic64_t *v = (atomic64_t *)l;
> +	return atomic64_xchg(v, val);

All we need now is some implementations of atomic64_xchg()  ;)
