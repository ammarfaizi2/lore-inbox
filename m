Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUI0Maa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUI0Maa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 08:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUI0Maa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 08:30:30 -0400
Received: from mail.dif.dk ([193.138.115.101]:42962 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266810AbUI0Ma1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 08:30:27 -0400
Date: Mon, 27 Sep 2004 14:27:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make make install install modules too
In-Reply-To: <20040927113727.GQ16153@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0409271413350.20693@jjulnx.backbone.dif.dk>
References: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk>
 <20040927072246.GA8613@mars.ravnborg.org> <20040927113727.GQ16153@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Matthew Wilcox wrote:

> Date: Mon, 27 Sep 2004 12:37:27 +0100
> From: Matthew Wilcox <matthew@wil.cx>
> To: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
>     Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] make make install install modules too
> 
> On Mon, Sep 27, 2004 at 09:22:46AM +0200, Sam Ravnborg wrote:
> > On Fri, Sep 17, 2004 at 06:00:51PM +0100, Matthew Wilcox wrote:
> > > 
> > > I keep forgetting to run 'make modules_install' after make install.  Since
> > > make now compiles modules too and there's no separate make modules step,
> > > it seems to make sense that make install should also install modules.
> > 
> > No, we do not want to change such basic behaviour.
> > So many poeple are used to current scheme with:
> > make modules_install && make install
> > 
> > that it would't be worth breaking their ways of working.
> 
> Ehm, this wouldn't _break_ them.  They'd just end up installing modules
> twice.
> 

And how about people who, for some reason, don't want the modules 
installed?
Sure, you can just copy the files you want by hand, which is what I do 
personally, but I find it nice that installing the kernel image and 
modules are two sepperate steps. If a user wants both done automagically, 
then that user could just create a 2 line shell script.

Or how about leaving "make install" and "make modules_install" as is and 
add a new target, say, "make install_all" or similar?


--
Jesper Juhl <juhl-lkml@dif.dk>
