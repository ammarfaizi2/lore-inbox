Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318957AbSHSRkI>; Mon, 19 Aug 2002 13:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318958AbSHSRkI>; Mon, 19 Aug 2002 13:40:08 -0400
Received: from bitmover.com ([192.132.92.2]:28595 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318957AbSHSRkH>;
	Mon, 19 Aug 2002 13:40:07 -0400
Date: Mon, 19 Aug 2002 10:44:11 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <20020819104411.A29059@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208191254220.11609-100000@localhost.localdomain> <Pine.LNX.4.44.0208191036040.11842-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208191036040.11842-100000@home.transmeta.com>; from torvalds@transmeta.com on Mon, Aug 19, 2002 at 10:42:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 10:42:06AM -0700, Linus Torvalds wrote:
> We sh ould just have made a separate "tsk->tracer" pointer, instead of 
> continuing with the perverted "my parent is my tracer" logic. We shouldn't 
> really re-write the parent/child relationship just because we're being 
> traced.

I've always wondered if the process model shouldn't be virtualized much
like files are virtual.  One application of this could be for ptraced
processes, they have a different ops vector than non-traced processes.
Any chance that could work?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
