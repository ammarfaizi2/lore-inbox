Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752449AbWAFQ7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbWAFQ7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbWAFQ7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:59:41 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:32662 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1752449AbWAFQ7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:59:41 -0500
Message-ID: <43BEA1E7.5040607@cosmosbay.com>
Date: Fri, 06 Jan 2006 17:59:19 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] FRV: Export __rcuref_hash
References: <dhowells1136564974@warthog.cambridge.redhat.com> <200601061629.k06GTbNG011390@warthog.cambridge.redhat.com>
In-Reply-To: <200601061629.k06GTbNG011390@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 06 Jan 2006 17:59:19 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells a écrit :
> The attached patch exports __rcuref_hash which is required by some modules.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> warthog>diffstat -p1 rcu-export-2615.diff
>  kernel/rcupdate.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -uNrp /warthog/kernels/linux-2.6.15/kernel/rcupdate.c linux-2.6.15-frv/kernel/rcupdate.c
> --- /warthog/kernels/linux-2.6.15/kernel/rcupdate.c	2006-01-04 12:39:43.000000000 +0000
> +++ linux-2.6.15-frv/kernel/rcupdate.c	2006-01-06 14:43:43.000000000 +0000
> @@ -564,3 +564,4 @@ EXPORT_SYMBOL(call_rcu);  /* WARNING: GP
>  EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
>  EXPORT_SYMBOL_GPL(synchronize_rcu);
>  EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
> +EXPORT_SYMBOL_GPL(__rcuref_hash);

NACK

This break all platforms were __HAVE_ARCH_CMPXCHG is defined, since they have 
no __rcuref_hash

Eric
