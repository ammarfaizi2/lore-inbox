Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUBDX7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUBDX5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:57:51 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:43664 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S265102AbUBDXzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:55:11 -0500
Date: Wed, 4 Feb 2004 16:55:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040204235508.GB1086@smtp.west.cox.net>
References: <20040204230133.GA8702@elf.ucw.cz> <20040204152137.500e8319.akpm@osdl.org> <20040204232447.GC256@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204232447.GC256@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 12:24:47AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > It seems that some kgdb support is in 2.6.2-linus:
> > 
> > Lots of architectures have had in-kernel kgdb support for a long time. 
> > Just none of the three which I use :(
> > 
> > I wouldn't support inclusion of i386 kgdb until it has had a lot of
> > cleanup, possible de-featuritisification and some thought has been applied
> > to splitting it into arch and generic bits.  It's quite a lot of work.
> 
> What about Amit's kgdb?
> 
> It's a *lot* cleaner. It does not have all the features (kgdb-eth is
> not yet ready for prime time). Would you accept that?
> 
> Oh and it is already split into arch-dependend and arch-independend
> parts, plus it has cleanly separated i/o methods...

.. and it's supported on i386, x86_64 and PPC32 right now.

Andrew, what features of George's version don't you like?  Right now
I'm working on moving the kgdb-eth driver that uses netpoll over
into Amit's version, and thinking of a cleaner away to allow for both
early debugging and multiple drivers (eth or serial A or serial B).

-- 
Tom Rini
http://gate.crashing.org/~trini/
