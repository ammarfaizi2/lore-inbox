Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSKTPkC>; Wed, 20 Nov 2002 10:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSKTPkC>; Wed, 20 Nov 2002 10:40:02 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:58531 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261321AbSKTPj6>; Wed, 20 Nov 2002 10:39:58 -0500
Date: Wed, 20 Nov 2002 09:46:57 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: kksymoops 
In-Reply-To: <20021120072654.15E932C079@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211200938240.24137-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Rusty Russell wrote:

> In message <3DD9AB88.4000102@pobox.com> you write:
> > I'm _not_ asking "when", just wondering what the plan is to resuscitate 
> > kksymoops.
> 
> Looks like someone pushed my patch.  Erm, OK, wonder if it works on
> x86? 8)

I think Linus himself did that ;)

> My mental TODO list looked something like this:
> 1) Drop the optimization which checks against addr between _stext and
>    _etext, as this skips __init functions on most archs.

Well, this was put in to avoid all kind of garbage in the traces, so it 
shouldn't just go without replacement. Probably one could even get it 
correct now, using ->module_init() and ->module_core() (just set them for 
the core kernel as well).

> 2) Only put in the symbols for functions (currently CONFIG_KALLSYMS=y
>    adds 400k on my laptop: ouch!).

I'm not to sure about this, I sometimes find it useful to have variables 
on the stack identified correctly.

> 3) Keith asked me to rename it, so as not to get confused with the
>    previous patches and kgdb support).  I guess it's too late for this
>    one.

Nothing wrong with a follow-up patch, is it?

> 5) See if Kai prefers the compile step inside the Makefile rather than
>    in the script.

I'll actually have to look into this. The script is probably fine.

> 6) It'd be nice if CONFIG_KALLSYMS=m worked.

Shouldn't be too hard.

Well, I know talk is cheap. I'll try to find some time to actually look
into some of these issues and come up with patches.

--Kai


