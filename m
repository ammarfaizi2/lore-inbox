Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268562AbTBZB0F>; Tue, 25 Feb 2003 20:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268568AbTBZB0F>; Tue, 25 Feb 2003 20:26:05 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:10719 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S268562AbTBZB0E>; Tue, 25 Feb 2003 20:26:04 -0500
Date: Tue, 25 Feb 2003 19:36:10 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate warnings in generated module files 
In-Reply-To: <20030226012305.A31342C158@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302251930280.13501-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0302251546590.2185-100000@home.transmeta.com> you wri
> te:
> > 
> > On Tue, 25 Feb 2003, Rusty Russell wrote:
> > > 
> > > __optional should always be __attribute__((__unused__)), and
> > > __required should be your __attribute_used__.
> > 
> > But I think rth's point was that "__module_depends" should definitely 
> > _not_ be "optional", since that just means that the compiler can (and 
> > will) optimize away the whole thing.
> > 
> > So marking it optional is definitely the wrong thing to do.
> 
> This time for sure!

FWIW, I think it's not a good idea. Why call it 'required' in the kernel 
when the normal (gcc) expression for it is 'used'. - We didn't rename 
'deprecated' to 'obsolete', either ;)

Also, I don't really see any use for __optional at this point, so why add 
it at all?

So IMO, the only change which possibly makes sense is to rename
__attribute_used__ to __used, since it makes it more consistent with
similar things like __deprecated, __init, __exit etc.

--Kai


