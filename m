Return-Path: <linux-kernel-owner+w=401wt.eu-S932903AbWL0Ezo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbWL0Ezo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 23:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932908AbWL0Ezo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 23:55:44 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43280
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932903AbWL0Ezo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 23:55:44 -0500
Date: Tue, 26 Dec 2006 20:55:18 -0800 (PST)
Message-Id: <20061226.205518.63739038.davem@davemloft.net>
To: ranma@tdiedrich.de
Cc: torvalds@osdl.org, gordonfarquharson@gmail.com, tbm@cyrius.com,
       a.p.zijlstra@chello.nl, andrei.popa@i-neo.ro, akpm@osdl.org,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061226161700.GA14128@yamamaya.is-a-geek.org>
References: <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	<Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	<20061226161700.GA14128@yamamaya.is-a-geek.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Diedrich <ranma@tdiedrich.de>
Date: Tue, 26 Dec 2006 17:17:00 +0100

> Linus Torvalds wrote:
> > I don't think it's a page table issue any more, it just doesn't look 
> > likely with the ARM UP corruption. It's also not apparently even on a 
> > cacheline boundary, so it probably is really a dirty bit that got cleared 
> > wrogn due to some race with IO.
> 
> So, until now it's only been reported for SMP on i386?
> I'm seeing the issue on my Pentium-M Notebook (Thinkpad R52) over
> here, UP kernel, no preempt.

I've seen it on sparc64, UP kernel, no preempt.
