Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268560AbTCCQnL>; Mon, 3 Mar 2003 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268566AbTCCQnK>; Mon, 3 Mar 2003 11:43:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11017 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268560AbTCCQmx>; Mon, 3 Mar 2003 11:42:53 -0500
Date: Mon, 3 Mar 2003 08:50:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remap-file-pages-2.5.63-A0
In-Reply-To: <Pine.LNX.4.44.0303031142190.24967-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303030849050.11244-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Mar 2003, Ingo Molnar wrote:
> 
> the attached patch, against BK-curr, is a preparation to make
> remap_file_pages() usable on swappable vmas as well. When 'swapping out'
> shared-named mappings the page offset is written into the pte.
> 
> it takes one bit from the swap-type bits, otherwise it does not change the
> pte layout - so it should be easy to adapt any other architecture to this
> change as well. (this patch does not introduce the protection-bits-in-pte
> approach used in my previous patch.)

One question: Why?

What's wrong with just using the value we use now (0), and just 
calculating the page from the vma/offset information? Why hide the offset 
in the page tables, when there is no need for it?

		Linus

