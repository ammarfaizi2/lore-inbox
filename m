Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSL3VVq>; Mon, 30 Dec 2002 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSL3VVq>; Mon, 30 Dec 2002 16:21:46 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:25872 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262266AbSL3VVq>; Mon, 30 Dec 2002 16:21:46 -0500
Date: Mon, 30 Dec 2002 21:30:06 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 fix link with fbcon built-in
In-Reply-To: <1041282678.550.13.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0212302128160.9109-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is not correct.
> > 
> > The functions should either be removed completely (preferred, since they 
> > aren't even proper C syntax in the first place - since when do we put 
> > semicolons at the end of a function?) or the file should be taught to use 
> > proper "module_init()/module_exit()" semantics that work _correctly_ for 
> > both modules and built-in.
> > 
> > The patch just hides just _how_ crap this file is, and as such should not 
> > be applied. Crap doesn't get better from being hidden.
> 
> Right, though weren't those empty functions just workarounds for a time
> where new module stuff didn't grok modules without module init/exit ? Is
> this still the case ? If not, then we should indeed just remove the
> function completely.

Correct. I added them while the module code was in a state of flux so it 
would get it working. Now that the module code is stable what do we do?
I like to see those functions go away.

