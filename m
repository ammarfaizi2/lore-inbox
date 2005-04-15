Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVDOANz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVDOANz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVDOANy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:13:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:41091 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261672AbVDOALz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:11:55 -0400
Date: Fri, 15 Apr 2005 02:14:43 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: fix never executed code due to expression always
 false
In-Reply-To: <425F064E.8050003@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0504150213240.3466@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504150140250.3466@dragon.hyggekrogen.localhost>
 <425F064E.8050003@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Nick Piggin wrote:

> Jesper Juhl wrote:
> > There are two expressions in kernel/sched.c that are always false since they
> > test for <0 but the result of the expression is unsigned so they will never
> > be less than zero. This patch implement the logic that I believe is intended
> > without the signedness issue and without the nasty casts.
> > <disclaimer>patch is compile tested only</disclaimer>
> > 
> 
> This is not *quite* the intended behaviour. It is OK for prev->timestamp
> to be '0 - a bit' and now to be '0 + a bit' in the case of wrapping.
> 
> Although considering they're 64-bit values, I'm not sure how much we care.
> 
How do you propose to fix this then?  As the code is now the expressionsa 
are always false - should we just remove the them?  Or do you have a 
sensible definition of "a bit" ?  or ome other suggestion alltogether?


-- 
Jesper


