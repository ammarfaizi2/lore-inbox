Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVC0CE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVC0CE5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 21:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVC0CE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 21:04:57 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30610 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261397AbVC0CEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 21:04:54 -0500
Message-Id: <200503270200.j2R20eM4006733@laptop11.inf.utfsm.cl>
To: Marcin Dalecki <martin@dalecki.de>
cc: linux-os@analogic.com, ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/ 
In-Reply-To: Message from Marcin Dalecki <martin@dalecki.de> 
   of "Sun, 27 Mar 2005 00:34:12 +0100." <7d96f2772f942f802890c50801c4f5f8@dalecki.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sat, 26 Mar 2005 22:00:40 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki <martin@dalecki.de> said:
> On 2005-03-27, at 00:21, linux-os wrote:
> > Always, always, a call will be more expensive than a branch
> > on condition.

Wrong.

> >               It's impossible to be otherwise.

Many, many counterexamples say otherwise...

> >                                                A call requires
> > that the return address be written to memory (the stack),

Not necesarily right now, it can be done at leisure later on while doing
other stuff.

> > using register indirection (the stack-pointer).

So what? The stack pointer is surely special. Modern programming languages
(and programming styles) encourage many calls, so this is very heavily
optimized.

> Needless to say that there are enough architectures out there, which
> don't even have something like an explicit call as separate assembler
> instruction...

The mechanism exists somehow.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
