Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSGTWnU>; Sat, 20 Jul 2002 18:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSGTWnU>; Sat, 20 Jul 2002 18:43:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38138 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317561AbSGTWnQ>; Sat, 20 Jul 2002 18:43:16 -0400
Subject: Re: [PATCH] generalized spin_lock_bit
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@conectiva.com.br, wli@holomorphy.com
In-Reply-To: <20020720.152703.102669295.davem@redhat.com>
References: <1027196511.1555.767.camel@sinai> 
	<20020720.152703.102669295.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 15:46:14 -0700
Message-Id: <1027205175.1116.830.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 15:27, David S. Miller wrote:
>    From: Robert Love <rml@tech9.net>
>    Date: 20 Jul 2002 13:21:51 -0700
>    
>    Thanks to Christoph Hellwig for prodding to make it per-architecture,
>    Ben LaHaise for the loop optimization, and William Irwin for the
>    original bit locking.
> 
> Just note that the implementation of these bit spinlocks will be
> extremely expensive on some platforms that lack "compare and swap"
> type instructions (or something similar like "load locked, store
> conditional" as per mips/alpha).

That is what they do use, but the code is pushed into the architecture
headers so you can do something else if you choose.

I originally just had a single generic version, but people representing
the greater good of SPARC and PA-RISC argued otherwise.  It should be
simple enough to just paste the generic implementations into your
asm/spinlock.h if you do not want to do any hand-tuning.

	Robert Love

