Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287109AbSA3AVn>; Tue, 29 Jan 2002 19:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSA3AVb>; Tue, 29 Jan 2002 19:21:31 -0500
Received: from waste.org ([209.173.204.2]:2277 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287401AbSA3AUz>;
	Tue, 29 Jan 2002 19:20:55 -0500
Date: Tue, 29 Jan 2002 18:20:44 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
In-Reply-To: <Pine.LNX.4.33.0201291535120.1747-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0201291813110.25443-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Linus Torvalds wrote:

> On Tue, 29 Jan 2002, Oliver Xymoron wrote:
> >
> > Seems like we could do slightly better to have these local areas mapped to
> > the same virtual address on each processor, which does away with the need
> > for an entire level of indirection.
>
> No no no.
>
> The reason it is a stupid idea is that if you do it, you can no longer
> share page tables between CPU's (unless all CPU's you support have TLB
> fill in software).

Yes, obviously.

Nearly as good would be replacing the current logic for figuring out the
current processor id through current with logic to access the per-cpu
data. The primary use of that id is indexing that data anyway.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

