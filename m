Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUGaHjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUGaHjk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 03:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUGaHjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 03:39:40 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:41231 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S267873AbUGaHjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 03:39:39 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: hch@infradead.org (Christoph Hellwig)
Subject: Re: [PATCH 3/12 2.4] e1000 - use vmalloc for data structures not shared with h/w
Cc: ganesh.venkatesan@intel.com, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040729192519.A6235@infradead.org>
X-Newsgroups: apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1BqoRX-0004DH-00@gondolin.me.apana.org.au>
Date: Sat, 31 Jul 2004 17:38:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Jul 29, 2004 at 11:17:08AM -0700, Venkatesan, Ganesh wrote:
>> Vmalloc space is less scarce than kmalloc space. Am I right? This patch
>> trades kmalloc space for vmalloc space.
> 
> No, it's not.  vmalloc needs virtual space that's rather limited (e.g. 64MB
> on PAE x86) in addition to physical memory.  Unless you do really big
> allocations stay away from vmalloc.

How big is really big? 64K? 256K? 1M?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
