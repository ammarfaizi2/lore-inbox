Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbRE3RlO>; Wed, 30 May 2001 13:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbRE3RlE>; Wed, 30 May 2001 13:41:04 -0400
Received: from chiara.elte.hu ([157.181.150.200]:24075 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261353AbRE3Rk5>;
	Wed, 30 May 2001 13:40:57 -0400
Date: Wed, 30 May 2001 19:39:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Pete Wyckoff <pw@osc.edu>
Cc: <mdaljeet@in.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: pte_page
In-Reply-To: <20010530130830.F14433@osc.edu>
Message-ID: <Pine.LNX.4.33.0105301937090.3379-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 May 2001, Pete Wyckoff wrote:

> > __pa(page_address(pte_page(pte))) is the address you want. [or
> > pte_val(*pte) & (PAGE_SIZE-1) on x86 but this is platform-dependent.]
>
> Does this work on x86 non-kmapped highmem user pages too?  (i.e. is
> page->virtual valid for every potential user page.)

you are right, the highmem-compatible solution is to use page-mem_map as
the physical page index.

	Ingo

