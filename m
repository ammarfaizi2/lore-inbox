Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbSJBVxV>; Wed, 2 Oct 2002 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbSJBVxV>; Wed, 2 Oct 2002 17:53:21 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1284 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262633AbSJBVvT>;
	Wed, 2 Oct 2002 17:51:19 -0400
Date: Wed, 2 Oct 2002 13:46:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: Anton Blanchard <anton@samba.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20021002134623.B61@toy.ucw.cz>
References: <20020929152731.GA10631@averell> <20020929235141.GA1090@krispykreme> <20020930003121.GB2805@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020930003121.GB2805@averell>; from ak@muc.de on Mon, Sep 30, 2002 at 02:31:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > may be useful to prevent some awful code generation for those misguided
> > > folks who use -O3 (gcc often screws up the register allocation of a 
> > > function completely when bigger functions are inlined). 
> > 
> > Could you also add an always inline? It would be useful for functions
> > like context_switch, where we require it to be inlined (otherwise it
> > falls outside scheduling_functions_{start,end}_here and wchan handling
> > fails).
> 
> Ok. gcc supports it with __attribute__((always_inline))
> 
> Suggestions for a name? alwaysinline would be a bit lengthy.

do_inline?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

