Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUFATaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUFATaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265160AbUFATaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:30:55 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5278 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265154AbUFATao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:30:44 -0400
Message-Id: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
To: Pavel Machek <pavel@suse.cz>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count 
In-Reply-To: Message from Pavel Machek <pavel@suse.cz> 
   of "Tue, 01 Jun 2004 14:20:13 +0200." <20040601122013.GA10233@elf.ucw.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 01 Jun 2004 15:29:45 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> said:
> =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> > > So effectively, it comes down to the recursive paths.  Unless someone
> > > comes up with a semantical parser that can figure out the maximum
> > > number of iterations, we have to look at them manually.

> > Linus, Andrew, would you accept patches like the one below?  With such
> > information and assuming that the comments will get maintained, it's
> > relatively simple to unroll recursions and measure stack comsumption
> > more accurately.
> 
> Perhaps some other format of comment should be introduced? Will not
> this interfere with linuxdoc?

If the comment gets out of sync, you are toast. Too easy for that to
happen, IMVHO.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
