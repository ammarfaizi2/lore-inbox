Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVAWFCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVAWFCr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 00:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVAWFCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 00:02:47 -0500
Received: from mail.dif.dk ([193.138.115.101]:26063 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261224AbVAWFCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 00:02:45 -0500
Date: Sun, 23 Jan 2005 06:05:47 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andi Kleen <ak@muc.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
In-Reply-To: <20050123044637.GA54433@muc.de>
Message-ID: <Pine.LNX.4.61.0501230600070.2748@dragon.hygekrogen.localhost>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de>
 <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
 <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de>
 <Pine.LNX.4.61.0501230357580.2748@dragon.hygekrogen.localhost>
 <20050123044637.GA54433@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2005, Andi Kleen wrote:

> > How about a shell sort?  if the data is mostly sorted shell sort beats 
> > qsort lots of times, and since the data sets are often small in-kernel, 
> > shell sorts O(n^2) behaviour won't harm it too much, shell sort is also 
> > faster if the data is already completely sorted. Shell sort is certainly 
> > not the simplest algorithm around, but I think (without having done any 
> > tests) that it would probably do pretty well for in-kernel use... Then 
> > again, I've known to be wrong :)
> 
> I like shell sort for small data sets too. And I agree it would be 
> appropiate for the kernel.
> 
Even with large data sets that are mostly unsorted shell sorts performance 
is close to qsort, and there's an optimization that gives it O(n^(3/2)) 
runtime (IIRC), and another nice property is that it's iterative so it 
doesn't eat up stack space (as oposed to qsort which is recursive and eats 
stack like ****)...
Yeah, I think shell sort would be good for the kernel.


-- 
Jesper Juhl



