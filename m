Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUCPQ15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbUCPQUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:20:23 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53386 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263982AbUCPQSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:18:37 -0500
Message-Id: <200403161618.i2GGITKK004831@eeyore.valparaiso.cl>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs 
In-Reply-To: Your message of "Tue, 16 Mar 2004 00:52:43 +0100."
             <20040315235243.GA21416@wohnheim.fh-wedel.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 16 Mar 2004 12:18:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> Horst von Brand <vonbrand@inf.utfsm.cl> said:

[...]

> What looks like a promising idea for this problem and others is to
> have visible and invisible inodes.  All current filesystems know only
> visible inodes.  Invisible ones have no dentry linking to them
> directly, only indirectly through files/links with cow semantics.

But this is then _one_ filesystem, not a stack of them added/deleted in
random order while running. _So_ it is easy... and mostly useless.

[...]

> > IIRC, this has been discussed a couple of times before, and the consensus
> > each time was that it isn't /that hard/ to do, it is /hard or impossible/
> > to find a sensible, simple semantics for this. The idea was then dropped...

> Yeah, maybe.  My personal consensus right now is that this actually
> looks very simple.  Not sure how much time I will find, but it should
> definitely be finished for 2.8.

As I said: Not too hard, doable. But not sensibly. And needs to mess with
_all_ filesystems (on disk and kernel guts) if they want to someday perhaps
somewhere participate...  Besides, the people asking for this mostly really
want version control, or get what they want from symlink farms.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
