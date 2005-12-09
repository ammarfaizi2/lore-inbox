Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVLISj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVLISj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVLISj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:39:59 -0500
Received: from waste.org ([64.81.244.121]:17063 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932513AbVLISj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:39:59 -0500
Date: Fri, 9 Dec 2005 10:34:20 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Reduce number of pointer derefs in various files (kernel/exit.c used as example)
Message-ID: <20051209183420.GR8637@waste.org>
References: <200512062302.06933.jesper.juhl@gmail.com> <20051206221528.GA12358@elte.hu> <20051209014658.GA11856@waste.org> <20051209102914.GA16164@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209102914.GA16164@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 11:29:14AM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > > > Ohh, and before I forget, besides the fact that this should speed 
> > > > things up a little bit it also has the added benefit of reducing the 
> > > > size of the generated code. The original kernel/exit.o file was 19604 
> > > > bytes in size, the patched one is 19508 bytes in size.
> > > 
> > > nice. Just to underline your point, on x86, with gcc 4.0.2, i'm getting 
> > > this with your patch:
> > > 
> > >    text    data     bss     dec     hex filename
> > >   11077       0       0   11077    2b45 exit.o.orig
> > >   10997       0       0   10997    2af5 exit.o
> > > 
> > > so 80 bytes shaved off. I think such patches also increase readability.
> > 
> > Readability improved: good.
> > 37 lines of patch for 80-100 bytes saved: not so good.
> 
> i'd take a 37 lines readability patch even if it didnt give us a byte of 
> text back. The fact that it also reduces text size on the latest gcc in 
> rawhide is an added bonus. (of course the patch is 2.6.16 material)

So long as we're primarily doing it for the former reason rather than
the latter.

> furthermore, i think that even if it's a small step, we should encourage 
> every effort that reduces the kernel's text size. The 2.4 -> 2.6 
> transition blew up the kernel by ~50%, and we've got to win back some of 
> that. (Kernel size is one of the main disadvantages of Linux in the 
> embedded market, compared to other OSs.)

Boggle. You're telling /me/ this? You're the one who's been adding all
the damn features!

-- 
Mathematics is the supreme nostalgia of our time.
