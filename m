Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265902AbSJVWhj>; Tue, 22 Oct 2002 18:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265903AbSJVWhj>; Tue, 22 Oct 2002 18:37:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57796 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265902AbSJVWhi>;
	Tue, 22 Oct 2002 18:37:38 -0400
Date: Wed, 23 Oct 2002 00:56:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@rth.ninka.net>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
In-Reply-To: <1035325675.16084.11.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.44.0210230055410.26602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Oct 2002, David S. Miller wrote:

> > -	flush_tlb_page(vma, addr);
> > +	if (flush)
> > +		flush_tlb_page(vma, addr);
> 
> You're still using page level flushes, even though we agreed that a
> range flush one level up was more appropriate.

yes - i wanted to keep the ->populate() functions as simple as possible.  
I hope to get there soon.

	Ingo


