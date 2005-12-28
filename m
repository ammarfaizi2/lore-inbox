Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVL1Ojp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVL1Ojp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVL1Ojo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:39:44 -0500
Received: from waste.org ([64.81.244.121]:35806 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964826AbVL1Ojo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:39:44 -0500
Date: Wed, 28 Dec 2005 08:36:10 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 01/2] allow gcc4 to control inlining
Message-ID: <20051228143610.GK3356@waste.org>
References: <20051228114653.GB3003@elte.hu> <20051228142621.GJ3356@waste.org> <20051228143442.GA14986@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228143442.GA14986@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 03:34:42PM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > On Wed, Dec 28, 2005 at 12:46:53PM +0100, Ingo Molnar wrote:
> > > allow gcc4 compilers to decide what to inline and what not - instead
> > > of the kernel forcing gcc to inline all the time.
> > > 
> > > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > > Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> > 
> > I'm ever so slightly wary of GCC 4's stack size logic for functions 
> > with nested scopes, but I think we'll have no trouble catching any 
> > trouble cases in 2.6.16-rc.
> > 
> > Acked-by: Matt Mackall <mpm@selenic.com>
> 
> FYI, the max function-frame size did not change, so there's no 
> outrageous frames like with gcc3, just a small shift upwards.

My point is more that I wouldn't be surprised if we found a corner
case for a particular .config. But even with GCC 3 and 4k stacks,
automatic inlining worked just fine for most configs after killing
just a few offenders.

-- 
Mathematics is the supreme nostalgia of our time.
