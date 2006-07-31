Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWGaPmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWGaPmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWGaPmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:42:06 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45537 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030195AbWGaPmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:42:05 -0400
Message-Id: <200607311541.k6VFfmKQ007278@laptop13.inf.utfsm.cl>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
cc: "Paul Jackson" <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf 
In-Reply-To: Message from "Jesper Juhl" <jesper.juhl@gmail.com> 
   of "Sun, 30 Jul 2006 20:48:23 +0200." <9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 31 Jul 2006 11:41:48 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 31 Jul 2006 11:41:49 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 30/07/06, Paul Jackson <pj@sgi.com> wrote:
> > Jesper wrote:
> > > -             cprint("%s", filename);
> > > +             cprint("%s", config_filename);
> >
> > Something seems strange here to me.  It looks like you are sometimes
> > resolving the shadowed symbols by making the more local symbol have the
> > longer name.

[...]

> >     instr
> 
> I don't recall using that variable name - I believe you mean 'intr'
> for interrupt that I used in place of 'irq'.

Please don't. If people are accustomed to irq, they will start wondering
what intr is all about (or what the difference is, etc).

> >     up

> I'd *love* to change this one - and down() as well - to up_sem() &
> down_sem().

Just too bad that there aren't semaphores anymore... and I can't find up()
down() in the headers anyway?

>             But, making that change would be a pretty major and
> somewhat disruptive api change, so I opted instead to change the local
> variable names. I plan to introduce a sepperate patch set later on
> that adds up_sem()/down_sem() wrappers around up()/down(), deprecate
> the old names and add an entry to feature-removal.txt - but doing it
> now as part of the -Wshadow cleanup would be too much pain.

Why not leave them alone for the time being then, and clean up in one sweep
later on?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
