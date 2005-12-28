Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVL1OfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVL1OfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVL1OfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:35:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38289 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964823AbVL1OfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:35:02 -0500
Date: Wed, 28 Dec 2005 15:34:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 01/2] allow gcc4 to control inlining
Message-ID: <20051228143442.GA14986@elte.hu>
References: <20051228114653.GB3003@elte.hu> <20051228142621.GJ3356@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228142621.GJ3356@waste.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> On Wed, Dec 28, 2005 at 12:46:53PM +0100, Ingo Molnar wrote:
> > allow gcc4 compilers to decide what to inline and what not - instead
> > of the kernel forcing gcc to inline all the time.
> > 
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> 
> I'm ever so slightly wary of GCC 4's stack size logic for functions 
> with nested scopes, but I think we'll have no trouble catching any 
> trouble cases in 2.6.16-rc.
> 
> Acked-by: Matt Mackall <mpm@selenic.com>

FYI, the max function-frame size did not change, so there's no 
outrageous frames like with gcc3, just a small shift upwards.

	Ingo
