Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265394AbSJRVo1>; Fri, 18 Oct 2002 17:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbSJRVo1>; Fri, 18 Oct 2002 17:44:27 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:11947 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265394AbSJRVo0>; Fri, 18 Oct 2002 17:44:26 -0400
Date: Fri, 18 Oct 2002 16:50:17 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Daniel Phillips <phillips@arcor.de>, <S@samba.org>,
       Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail 
In-Reply-To: <20021018025633.1D4C72C0BF@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210181647410.10010-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Rusty Russell wrote:

> > I wonder if this new method is going to be mandatory (the only one
> > available) or optional. I think there's two different kind of users, for
> > one modules which use an API which provides its own infrastructure for
> > dealing with modules via ->owner, on the other hand things like netfilter
> > (that's probably where you are coming from) where calls into a module,
> > which need protection are really frequent.
> 
> Mandatory for interfaces where the function can sleep (or be preempted).

and is not protected by other means (try_inc_mod_count()), I presume.

> > I see that your approach makes frequent calls into the module cheaper, but
> > I'm not totally convinced that the current safe interfaces need to change
> > just to accomodate rare cases like netfilter (there's most likely some
> > more cases like it, but the majority of modules is not).
> 
> They're not changing.  The current users doing try_inc_mod_count() are
> fine.  It's the ones not doing it which are problematic.

Alright, so I'm fine with it ;) (not that makes a difference, but...)

--Kai


